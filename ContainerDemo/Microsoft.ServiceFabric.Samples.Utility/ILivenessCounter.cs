// ------------------------------------------------------------------
// Copyright (c) Microsoft.  All Rights Reserved.
// ------------------------------------------------------------------

using System.Collections.Generic;

namespace Microsoft.ServiceFabric.Samples.Utility
{
    public interface ILivenessCounter<T>
    {
        void ReportAlive(T group, long numberOfAliveItems = 1);

        long GetLivingCount();

        ICollection<KeyValuePair<T, long>> GetKeyValues();
    }
}