From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: Re: [PATCH] OMAP3:devices.c: Enabling 4-bit for SD card
Date: Mon, 11 Aug 2008 10:44:22 +0530
Message-ID: <013401c8fb71$21e4d420$LocalHost@wipultra1303>
References: <200806161302.m5GD2Xg4007641@india.ti.com> <B85A65D85D7EB246BE421B3FB0FBB59301118F2774@dbde02.ent.ti.com> <B85A65D85D7EB246BE421B3FB0FBB5930111B215C5@dbde02.ent.ti.com> <200808050010.15117.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:58524 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750761AbYHKFOi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Aug 2008 01:14:38 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, "Kumar, Purushotam" <purushotam@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Purushotam Kumar <a0876542@india.ti.com>, linux-omap@vger.kernel.org, "Gole, Anant" <anantgole@ti.com>


----- Original Message ----- 
From: "David Brownell" <david-b@pacbell.net>
To: "Kumar, Purushotam" <purushotam@ti.com>
Cc: "Tony Lindgren" <tony@atomide.com>; "Purushotam Kumar" <a0876542@india.ti.com>; <linux-omap@vger.kernel.org>; "Gole, Anant" <anantgole@ti.com>
Sent: Tuesday, August 05, 2008 12:40 PM
Subject: Re: [PATCH] OMAP3:devices.c: Enabling 4-bit for SD card


> On Monday 14 July 2008, Kumar, Purushotam wrote:
>> > > > if (cpu_is_omap2430() || cpu_is_omap34xx()) {
>> > > > - if (mmc->enabled)
>> > > > + if (mmc->enabled) {
>> > > > + mmc1_data.conf = *mmc;
>> > > > (void) platform_device_register(&mmc_omap_device1);
>> > > > + }
> 
> I don't get it.  OMAP3 uses the hsmmc code, which uses
> a "struct omap_mmc_platform_data" to configure itself.
> 
> But this patch updates a "struct omap_mmc_conf" as used
> by the non-hsmmc code.
> 
> So ... it's a NOP, at least for OMAP3.  Right?

Hi Dave,
I think there is no difference between hsmmc code vs non-hsmmc code with respect to platform specific structure initializations.
Both of them use "omap_mmc_platform_data" as well as "omap_mmc_config" structures. I had a quick look at board-h4-mmc.c
and board-h4.c to verify this.

What this patch does is to add the missing initializtion line "mmc1_data.conf = *mmc;" for 2430 or 3430 which was present for platforms other 
than these. Without this line the below condition in the hsmmc driver will not evaluate to true.

if (pdata->conf.wire4)
                mmc->caps |= MMC_CAP_4_BIT_DATA;

The header "include/asm-arm/arch-omap/mmc.h" is used by both hsmmc and non-hsmmc code.

Regards,
Madhu
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
