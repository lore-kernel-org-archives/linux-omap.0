From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PM-SR][PATCH 08/12] omap3: sr: cleanup pr_xxx
Date: Fri, 6 Aug 2010 10:08:00 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032401CCFD@dbde02.ent.ti.com>
References: <1281047052-21346-1-git-send-email-nm@ti.com>
 <1281047052-21346-9-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49606 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932137Ab0HFEiG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Aug 2010 00:38:06 -0400
In-Reply-To: <1281047052-21346-9-git-send-email-nm@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>



>>-----Original Message-----
>>From: Menon, Nishanth
>>Sent: Friday, August 06, 2010 3:54 AM
>>To: linux-omap
>>Cc: Menon, Nishanth; Kevin Hilman; Gopinath, Thara
>>Subject: [PM-SR][PATCH 08/12] omap3: sr: cleanup pr_xxx
>>
>>pr_xxx family is not informative for debug unless one decides
>>to grep the code, instead print the function to help debug
>>easier on the field.
>>
>>Cc: Kevin Hilman <khilman@deeprootsystems.com>
>>Cc: Thara Gopinath <thara@ti.com>
>>
>>Signed-off-by: Nishanth Menon <nm@ti.com>
>>---
>> arch/arm/mach-omap2/smartreflex.c |    5 +++--
>> 1 files changed, 3 insertions(+), 2 deletions(-)
>>
>>diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
>>index 57fc9b2..d63691b 100644
>>--- a/arch/arm/mach-omap2/smartreflex.c
>>+++ b/arch/arm/mach-omap2/smartreflex.c
>>@@ -804,8 +804,9 @@ static int omap_sr_params_store(void *data, u64 val)
>> 		u32 *option = data;
>> 		*option = val;
>> 	} else {
>>-		pr_notice("DEBUG option not enabled!\n	\
>>-			echo 1 > pm_debug/enable_sr_vp_debug - to enable\n");
>>+		pr_notice("%s: DEBUG option not enabled! "
>>+			"echo 1 > pm_debug/enable_sr_vp_debug to enable\n",
>>+			__func__);
>> 	}

Accepted and will be collated with rest of the patches.
>> 	return 0;
>> }
>>--
>>1.6.3.3

