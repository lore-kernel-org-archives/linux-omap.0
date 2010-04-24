From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 4/4][v4] OMAP:iommu- add TLB preservation support
Date: Sat, 24 Apr 2010 09:44:33 +0300 (EEST)
Message-ID: <20100424.094433.258130456.Hiroshi.DOYU@nokia.com>
References: <1271978196-26792-5-git-send-email-h-kanigeri2@ti.com>
	<20100423.153411.116357255.Hiroshi.DOYU@nokia.com>
	<8F7AF80515AF0D4D93307E594F3CB40E4B4C368D@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:64379 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646Ab0DXGor (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Apr 2010 02:44:47 -0400
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E4B4C368D@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: h-kanigeri2@ti.com
Cc: grgupta@ti.com, linux-omap@vger.kernel.org

From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 4/4][v4] OMAP:iommu- add TLB preservation support
Date: Sat, 24 Apr 2010 01:43:19 +0200

> Hi Hiroshi,
> 
>> 
>> diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
>> index 1e83fac..d09a0a1 100644
>> --- a/arch/arm/plat-omap/iommu.c
>> +++ b/arch/arm/plat-omap/iommu.c
>> @@ -25,6 +25,9 @@
>> 
>>  #include "iopgtable.h"
>> 
>> +#define for_each_iotlb_cr(obj, n, i, cr)				\
>> +	for (i = 0; (i < n) && (cr = get_iotlb_cr(obj, i)); i++)
>> +
> -- This code is giving compilation error. 

Should be like:

+#define for_each_iotlb_cr(obj, n, __i, cr)				\
+	for (__i = 0;							\
+	     (__i < (n)) && (cr = __iotlb_read_cr((obj), __i), true);	\
+	     __i++)
+
