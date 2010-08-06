From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PM-SR][PATCH 09/12] omap3: sr: enable/disable sr only if
 required
Date: Fri, 6 Aug 2010 10:21:05 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032401CD1B@dbde02.ent.ti.com>
References: <1281047052-21346-1-git-send-email-nm@ti.com>
 <1281047052-21346-10-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43509 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932418Ab0HFEvL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Aug 2010 00:51:11 -0400
In-Reply-To: <1281047052-21346-10-git-send-email-nm@ti.com>
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
>>Subject: [PM-SR][PATCH 09/12] omap3: sr: enable/disable sr only if required
>>
>>We dont need to go down the path of enabling/disabling the SR
>>if we dont need to. do some sanity check and trigger if needed
>>
>>Cc: Kevin Hilman <khilman@deeprootsystems.com>
>>Cc: Thara Gopinath <thara@ti.com>
>>
>>Signed-off-by: Nishanth Menon <nm@ti.com>
>>---
>> arch/arm/mach-omap2/smartreflex.c |   19 +++++++++++++++----
>> 1 files changed, 15 insertions(+), 4 deletions(-)
>>
>>diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
>>index d63691b..9b5a10e 100644
>>--- a/arch/arm/mach-omap2/smartreflex.c
>>+++ b/arch/arm/mach-omap2/smartreflex.c
>>@@ -778,15 +778,26 @@ static int omap_sr_autocomp_show(void *data, u64 *val)
>> static int omap_sr_autocomp_store(void *data, u64 val)
>> {
>> 	struct omap_sr *sr_info = (struct omap_sr *) data;
>>+	u32 value = (u32) val;
>>
>> 	if (!sr_info) {
>> 		pr_warning("%s: omap_sr struct for SR not found\n", __func__);
>> 		return -EINVAL;
>> 	}
>>-	if (!val)
>>-		sr_stop_vddautocomp(sr_info);
>>-	else
>>-		sr_start_vddautocomp(sr_info);
>>+
>>+	/* Sanity check */
>>+	if (value && (value != 1)) {
>>+		pr_err("%s: invalid value %d\n", __func__, value);
>>+		return -EINVAL;
>>+	}
Will take this in.

>>+
>>+	/* change only if needed */
>>+	if (sr_info->is_autocomp_active ^ value) {

I do not think this is necessary. sr_start_vddautocomp and sr_stop_vddautocomp will take care of
enabling and disabling intelligently.

Regards
Thara

>>+		if (!val)
>>+			sr_stop_vddautocomp(sr_info);
>>+		else
>>+			sr_start_vddautocomp(sr_info);
>>+	}

>> 	return 0;
>> }
>>
>>--
>>1.6.3.3

