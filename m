From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PM-SR][PATCH 04/12] omap3: sr: device: cleanup pr_xxx
Date: Fri, 6 Aug 2010 12:41:56 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032401CE4F@dbde02.ent.ti.com>
References: <1281047052-21346-1-git-send-email-nm@ti.com>
 <1281047052-21346-5-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54952 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760528Ab0HFHMA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Aug 2010 03:12:00 -0400
In-Reply-To: <1281047052-21346-5-git-send-email-nm@ti.com>
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
>>Subject: [PM-SR][PATCH 04/12] omap3: sr: device: cleanup pr_xxx
>>
>>Strings in c dont need to be split accross multiple lines with \
>>. instead they can be put as "abc " "def " and it is equivalent to
>>"abc def".
>>
>>Cc: Kevin Hilman <khilman@deeprootsystems.com>
>>Cc: Thara Gopinath <thara@ti.com>
>>
>>Signed-off-by: Nishanth Menon <nm@ti.com>
>>---
>> arch/arm/mach-omap2/sr_device.c |    5 +++--
>> 1 files changed, 3 insertions(+), 2 deletions(-)
>>
>>diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
>>index dbf7603..7d13704 100644
>>--- a/arch/arm/mach-omap2/sr_device.c
>>+++ b/arch/arm/mach-omap2/sr_device.c
>>@@ -151,8 +151,9 @@ static int sr_dev_init(struct omap_hwmod *oh, void *user)
>> 	sr_dev_data->volts_supported = omap_get_voltage_table(i,
>> 				&sr_dev_data->volt_data);
>> 	if (!sr_dev_data->volts_supported) {
>>-		pr_warning("%s: No Voltage table registerd fo VDD%d.Something \
>>-				really wrong\n\n", __func__, i + 1);
>>+		pr_warning("%s: No Voltage table registerd fo VDD%d. "
>>+				"Something is really wrong\n",
>>+				__func__, i + 1);

Taken in.

Regards
Thara
>> 		i++;
>> 		kfree(sr_data);
>> 		return 0;
>>--
>>1.6.3.3

