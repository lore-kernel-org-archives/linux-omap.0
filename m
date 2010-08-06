From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PM-SR][PATCH 01/12] omap3: voltage: cleanup pr_xxxx
Date: Fri, 6 Aug 2010 13:12:49 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032401CE69@dbde02.ent.ti.com>
References: <1281047052-21346-1-git-send-email-nm@ti.com>
 <1281047052-21346-2-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58952 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933570Ab0HFHmy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Aug 2010 03:42:54 -0400
In-Reply-To: <1281047052-21346-2-git-send-email-nm@ti.com>
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
>>Subject: [PM-SR][PATCH 01/12] omap3: voltage: cleanup pr_xxxx
>>
>>Few more pr_xxxx need cleanup for printing the function name and
>>not using multiline prints when c allows us to do "".
>>
>>Cc: Kevin Hilman <khilman@deeprootsystems.com>
>>Cc: Thara Gopinath <thara@ti.com>
>>
>>Signed-off-by: Nishanth Menon <nm@ti.com>
>>---
>> arch/arm/mach-omap2/voltage.c |    7 ++++---
>> 1 files changed, 4 insertions(+), 3 deletions(-)
>>
>>diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
>>index 148e4d4..3431fa3 100644
>>--- a/arch/arm/mach-omap2/voltage.c
>>+++ b/arch/arm/mach-omap2/voltage.c
>>@@ -253,8 +253,9 @@ static int vp_debug_set(void *data, u64 val)
>> 		u32 *option = data;
>> 		*option = val;
>> 	} else {
>>-		pr_notice("DEBUG option not enabled!\n	\
>>-			echo 1 > pm_debug/enable_sr_vp_debug - to enable\n");
>>+		pr_notice("%s: DEBUG option not enabled! "
>>+			"echo 1 > pm_debug/enable_sr_vp_debug - to enable\n",
>>+			__func__);
>> 	}

I do not think this is needed as these fns get called only from user space.

Regards
Thara

>> 	return 0;
>> }
>>@@ -265,7 +266,7 @@ static int vp_volt_debug_get(void *data, u64 *val)
>> 	u8 vsel;
>>
>> 	vsel = voltage_read_reg(info->vp_offs.voltage_reg);
>>-	pr_notice("curr_vsel = %x\n", vsel);
>>+	pr_notice("%s: curr_vsel = %x\n", __func__, vsel);
>> 	*val = vsel * 12500 + 600000;
>>
>> 	return 0;
>>--
>>1.6.3.3

