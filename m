From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [RFC] omap3: Fix incorrect restore pointer
Date: Mon, 22 Mar 2010 14:42:37 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03220FBE22@dbde02.ent.ti.com>
References: <1268994180-25170-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39291 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752459Ab0CVJMp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Mar 2010 05:12:45 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o2M9Cg1u007697
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 22 Mar 2010 04:12:44 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o2M9Cf6b017652
	for <linux-omap@vger.kernel.org>; Mon, 22 Mar 2010 14:42:41 +0530 (IST)
In-Reply-To: <1268994180-25170-1-git-send-email-premi@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



>>-----Original Message-----
>>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Premi,
>>Sanjeev
>>Sent: Friday, March 19, 2010 3:53 PM
>>To: linux-omap@vger.kernel.org
>>Cc: Premi, Sanjeev
>>Subject: [RFC] omap3: Fix incorrect restore pointer
>>
>>Due to check for absolute omap_rev() values against
>>ES3.0 and ES3.1, the restore pointer for OMAP3630 is
>>incorrectly assigned.
>>
>>The problem may be observed with OMAP3430 ES3.1.1
>>as well.
>>
>>Submitting this as RFC because I have only compiled
>>with changes. Haven't yet tried on EVM. Will submit
>>formal patch after testing.
>>
>>Signed-off-by: Sanjeev Premi <premi@ti.com>
>>---
>> arch/arm/mach-omap2/control.c |    7 +++++--
>> 1 files changed, 5 insertions(+), 2 deletions(-)
>>
>>diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
>>index 43f8a33..575593b 100644
>>--- a/arch/arm/mach-omap2/control.c
>>+++ b/arch/arm/mach-omap2/control.c
>>@@ -213,13 +213,16 @@ void omap3_save_scratchpad_contents(void)
>>
>> 	/* Populate the Scratchpad contents */
>> 	scratchpad_contents.boot_config_ptr = 0x0;
>>-	if (omap_rev() != OMAP3430_REV_ES3_0 &&
>>-					omap_rev() != OMAP3430_REV_ES3_1)
>>+
>>+	if (!cpu_is_omap3630() &&
>>+		(cpu_is_34xx() &&
>>+			(omap_rev() < OMAP3430_REV_ES3_0)))
>> 		scratchpad_contents.public_restore_ptr =
>> 			virt_to_phys(get_restore_pointer());

Hi Sanjeev,

Different restore pointer is required for ES3.0 and ES3.1 due to a silicon errata. I do not think the same silicon errata is applicable to 3630. At least I see it removed from the 3630 errata list. So the checks were fine. If ES3.1.1 is impacted you might need to add a ES3.1.1 check. But 3630 need not have this workaround.

Regards
Thara
>> 	else
>> 		scratchpad_contents.public_restore_ptr =
>> 			virt_to_phys(get_es3_restore_pointer());
>>+
>> 	if (omap_type() == OMAP2_DEVICE_TYPE_GP)
>> 		scratchpad_contents.secure_ram_restore_ptr = 0x0;
>> 	else
>>--
>>1.6.6.1
>>
>>--
>>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
