From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v2 1/8] OMAP: hwmod: Fix the addr spaces, irq, dma count
 APIs.
Date: Sat, 24 Sep 2011 13:23:19 +0530
Message-ID: <4E7D8C6F.3070700@ti.com>
References: <1315584134-3869-1-git-send-email-r.sricharan@ti.com> <4E736DDE.9090300@ti.com> <4E75B2C2.6070904@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090704080903030704000103"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:41856 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751031Ab1IXHx0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 24 Sep 2011 03:53:26 -0400
Received: by yxl11 with SMTP id 11so4863335yxl.32
        for <linux-omap@vger.kernel.org>; Sat, 24 Sep 2011 00:53:25 -0700 (PDT)
In-Reply-To: <4E75B2C2.6070904@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "paul@pswan.com" <paul@pswan.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "R, Sricharan" <r.sricharan@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This is a multi-part message in MIME format.
--------------090704080903030704000103
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Paul,

On Sunday 18 September 2011 02:28 PM, Santosh wrote:
> On Friday 16 September 2011 09:10 PM, Cousson, Benoit wrote:
>> Hi Sricharan,
>>
>> On 9/9/2011 6:02 PM, R, Sricharan wrote:
>>> The address spaces, irqs and dma reqs count API returns the
>>> number of corresponding entries in a hwmod including a additional
>>> null value or a -1 terminator in the structure introduced
>>> recently. More information here:
>>>
>>>     212738a4 (omap_hwmod: use a terminator record with
>>> omap_hwmod_mpu_irqs arrays)
>>>     78183f3f (omap_hwmod: use a null structure record to terminate
>>> omap_hwmod_addr_space arrays)
>>>     bc614958 (omap_hwmod: use a terminator record with
>>> omap_hwmod_dma_info arrays)
>>>
>>> The devices which have multiple hwmods and use device_build_ss are
>>> broken with this, as their resources are populated with a
>>> extra null value, subsequently the probe fails. So fix the API not to
>>> include the array terminator in the count.
>>>
>>> Signed-off-by: sricharan<r.sricharan@ti.com>
>>> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>>> Cc: Benoit Cousson<b-cousson@ti.com>
>>> Cc: Paul Walmsley<paul@pwsan.com>
>>> Cc: Kevin Hilman<khilman@ti.com>
>>
>> It would have been nice to give me the credit for the bug report on the
>> other functions, but otherwise:
>>
> Sure. Will add reported-by of yours.
> 
>> Acked-by: Benoit Cousson <b-cousson@ti.com>
>>
> Thanks
> 
>> And I still prefer the return i - 1 :-)
>>
> Let's do "i-1" as you prefer. Maintainer
> always have final say !!
> 
Here is the updated patch with i-1 as agreed
with Benoit. Also attaching it in case mailer
eats spaces.

>From c55f38512e1471b8a9405c2cb45d9377e0c45999 Mon Sep 17 00:00:00 2001
From: sricharan <r.sricharan@ti.com>
Date: Wed, 21 Sep 2011 16:08:46 +0530
Subject: [PATCH 1/8] OMAP: hwmod: Fix the addr space, irq, dma count APIs

The address spaces, irqs and dma reqs count API returns the
number of corresponding entries in a hwmod including a additional
null value or a -1 terminator in the structure introduced
recently. More information here:

- 212738a4 (omap_hwmod: use a terminator record with omap_hwmod_mpu_irqs
arrays)

- 78183f3f (omap_hwmod: use a null structure record to terminate
omap_hwmod_addr_space arrays)

- bc614958 (omap_hwmod: use a terminator record with omap_hwmod_dma_info
arrays)

The issue with irqs and dma info was originally reported by Benoit Cousson.

The devices which have multiple hwmods and use device_build_ss are
broken with this, as their resources are populated with a
extra null value, subsequently the probe fails. So fix the API not to
include the array terminator in the count.

Reported-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: sricharan <r.sricharan@ti.com>
Acked: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c
b/arch/arm/mach-omap2/omap_hwmod.c
index 84cc0bd..f396c83 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -749,7 +749,7 @@ static int _count_mpu_irqs(struct omap_hwmod *oh)
 		ohii = &oh->mpu_irqs[i++];
 	} while (ohii->irq != -1);

-	return i;
+	return i-1;
 }

 /**
@@ -772,7 +772,7 @@ static int _count_sdma_reqs(struct omap_hwmod *oh)
 		ohdi = &oh->sdma_reqs[i++];
 	} while (ohdi->dma_req != -1);

-	return i;
+	return i-1;
 }

 /**
@@ -795,7 +795,7 @@ static int _count_ocp_if_addr_spaces(struct
omap_hwmod_ocp_if *os)
 		mem = &os->addr[i++];
 	} while (mem->pa_start != mem->pa_end);

-	return i;
+	return i-1;
 }

 /**
-- 
1.7.4.1


--------------090704080903030704000103
Content-Type: text/x-patch;
 name="0001-OMAP-hwmod-Fix-the-addr-space-irq-dma-count-APIs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-OMAP-hwmod-Fix-the-addr-space-irq-dma-count-APIs.patch"

>From c55f38512e1471b8a9405c2cb45d9377e0c45999 Mon Sep 17 00:00:00 2001
From: sricharan <r.sricharan@ti.com>
Date: Wed, 21 Sep 2011 16:08:46 +0530
Subject: [PATCH 1/8] OMAP: hwmod: Fix the addr space, irq, dma count APIs

The address spaces, irqs and dma reqs count API returns the
number of corresponding entries in a hwmod including a additional
null value or a -1 terminator in the structure introduced
recently. More information here:

- 212738a4 (omap_hwmod: use a terminator record with omap_hwmod_mpu_irqs arrays)

- 78183f3f (omap_hwmod: use a null structure record to terminate omap_hwmod_addr_space arrays)

- bc614958 (omap_hwmod: use a terminator record with omap_hwmod_dma_info arrays)

The issue with irqs and dma info was originally reported by Benoit Cousson.

The devices which have multiple hwmods and use device_build_ss are
broken with this, as their resources are populated with a
extra null value, subsequently the probe fails. So fix the API not to
include the array terminator in the count.

Reported-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: sricharan <r.sricharan@ti.com>
Acked: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 84cc0bd..f396c83 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -749,7 +749,7 @@ static int _count_mpu_irqs(struct omap_hwmod *oh)
 		ohii = &oh->mpu_irqs[i++];
 	} while (ohii->irq != -1);
 
-	return i;
+	return i-1;
 }
 
 /**
@@ -772,7 +772,7 @@ static int _count_sdma_reqs(struct omap_hwmod *oh)
 		ohdi = &oh->sdma_reqs[i++];
 	} while (ohdi->dma_req != -1);
 
-	return i;
+	return i-1;
 }
 
 /**
@@ -795,7 +795,7 @@ static int _count_ocp_if_addr_spaces(struct omap_hwmod_ocp_if *os)
 		mem = &os->addr[i++];
 	} while (mem->pa_start != mem->pa_end);
 
-	return i;
+	return i-1;
 }
 
 /**
-- 
1.7.4.1


--------------090704080903030704000103--
