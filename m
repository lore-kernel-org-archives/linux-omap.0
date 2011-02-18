From: Hema Kalliguddi <hemahk@ti.com>
Subject: RE: [patch-v2.6.39 5/7] AM35xx: hwmod data: Add USBOTG
Date: Fri, 18 Feb 2011 18:37:03 +0530
Message-ID: <0387bf9911e20f7d6fa56aeb8ded4071@mail.gmail.com>
References: <1297946466-9565-1-git-send-email-balbi@ti.com>
 <1297946466-9565-6-git-send-email-balbi@ti.com> <B85A65D85D7EB246BE421B3FB0FBB593024B83BED5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:39059 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750775Ab1BRNHG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Feb 2011 08:07:06 -0500
Received: by mail-fx0-f48.google.com with SMTP id 2so3919620fxm.7
        for <linux-omap@vger.kernel.org>; Fri, 18 Feb 2011 05:07:04 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024B83BED5@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@deeprootsystems.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Hi Premi,

>-----Original Message-----
>From: Premi, Sanjeev [mailto:premi@ti.com]
>Sent: Friday, February 18, 2011 4:59 PM
>To: Balbi, Felipe; Tony Lindgren
>Cc: Linux OMAP Mailing List; Linux ARM Kernel Mailing List;
>Kalliguddi, Hema; Kevin Hilman; Cousson, Benoit; Paul Walmsley
>Subject: RE: [patch-v2.6.39 5/7] AM35xx: hwmod data: Add USBOTG
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Balbi, Felipe
>> Sent: Thursday, February 17, 2011 6:11 PM
>> To: Tony Lindgren
>> Cc: Linux OMAP Mailing List; Linux ARM Kernel Mailing List;
>Kalliguddi,
>> Hema; Kevin Hilman; Cousson, Benoit; Paul Walmsley; Balbi, Felipe
>> Subject: [patch-v2.6.39 5/7] AM35xx: hwmod data: Add USBOTG
>>
>> From: Hema HK <hemahk@ti.com>
>>
>> AM35xx hwmod data structures are populated for USBOTG with
>base address,
>> L3 and L4 interface clocks and IRQ.
>>
>> Signed-off-by: Hema HK <hemahk@ti.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>> Cc: Cousson, Benoit <b-cousson@ti.com>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>> ---
>>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   65
>> ++++++++++++++++++++++++++++
>>  1 files changed, 65 insertions(+), 0 deletions(-)
>>
>[snip]
>>
>> +	/* usbotg for am35x */
>> +	&am35xx_usbhsotg_hwmod,
>> +
>>  	NULL,
>
>Felipe, Hema,
>
>This patch will break all existing OMAP35x (and I believe
>OMAP3430 - since there is no difference - unless there is
>some trick in the USB driver code).
>

I agree that this will break the AM35x because there is no
separate CHIP_IS* defined for AM35x.
AM35x is treated as one of the version of OMAP3430.

>I have seen similar problems with smart reflex included in
>the AM35x hwmod data.

Unless the new CHIP_IS_* introduced for AM35x this problem will
still exists.

I thought you are already working on this because you were
asking the questions in the list.

>
>In this case accessing "unknown" registers corresponding to
>SmartReflex in _setup() causes crash.
>(http://marc.info/?l=linux-omap&m=129777408503329&w=2)
>
>I expect similar to be happening on OMAP35x with inclusion
>of am35xx_usbhsotg_hwmod. If you don't see any crash, there
>would be side-effects - and _setup() would be initializing
>non-existent OTG registers on OMAP35x.
>
This will not impact for OMAP3 as the IDCODE is different AM35x and
OMAP3, so passing the right chip version in the HWMOD database for AM35x
will avoid the hwod init incase of OMAP3.

>Did you see any problems while testing?
>
I tested with OMAP3430SDP and OMAP3630Zoom3 and did not see
the problem.

Regards,
Hema

>~sanjeev
>
>PS: Sending mail via webmailer. Formatting may break
>
>>  };
>>
>> --
>> 1.7.4.rc2
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe
>linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
