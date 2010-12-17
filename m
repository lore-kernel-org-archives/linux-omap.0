From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCHv5 00/10] OMAP: Adding Smartreflex and Voltage driver
 support
Date: Fri, 17 Dec 2010 17:06:38 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0373A9376A@dbde02.ent.ti.com>
References: <1292004181-4804-1-git-send-email-thara@ti.com>
 <8739px9oe8.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34292 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751501Ab0LQLgt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 06:36:49 -0500
In-Reply-To: <8739px9oe8.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Menon, Nishanth" <nm@ti.com>



>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>Sent: Friday, December 17, 2010 7:01 AM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Cousson, Benoit; Sripathy,
>>Vishwanath; Sawant, Anand; Menon, Nishanth
>>Subject: Re: [PATCHv5 00/10] OMAP: Adding Smartreflex and Voltage driver
>>support
>>
>>Hi Thara,
>>
>>Thara Gopinath <thara@ti.com> writes:
>>
>>> This patch series introduces smartreflex and voltage driver support
>>> for OMAP3430 and OMAP3630. SmartReflex modules do adaptive voltage
>>> control for real-time voltage adjustments.
>>
>>
>>[...]
>>
>>> This patch series has been tested on OMAP3430 SDP with
>>omap2plus_defconfig
>>> with the following menuconfig options enabled.
>>
>>Any testing on 3630?
>>
>>> System type -> TI OMAP Implementations -> Smartreflex Support
>>> System type -> TI OMAP Implementations ->
>>>                 Class 3 mode of Smartreflex Implementation
>>>
>>> Major Changes in v5
>>>
>>> 	- Rebased to k.org 2.6.37-rc3
>>> 	- Rebased to Nishant Menon's latest opp patches
>>> 	- Voltage pmic info structure extended to include a
>>> 		vast set of PMIC dependent parameters.
>>> 	- Smartreflex software n-target values support
>>> 		removed from the kernel. Instead n-target
>>> 		values are exposed as debugfs entries which can
>>> 		be written into by the user if needed.
>>> 	- Introduced a new file arch/arm/mach-omap2/omap_twl.c
>>> 		for specifying OMAP and TWL related info for
>>> 		the voltage layer.
>>> 	- Remove default enabling of smartreflex autocompensation
>>> 		during boot on OMAP3430 ES3.1 chips. Instead
>>> 		an API is provided that can be called from
>>> 		board files in case autocompensation needs
>>> 		to be enabled during boot up itself.
>>> 	- Other review comments on v4
>>>
>>>
>>
>>This series is looking good.  I have a couple minor comments on specific
>>patches.
Hello Kevin,

Thanks for the review!

>>
>>Also, it needs (hopefully only) one more rebase/repost.
>>
>>First, a few things have changed at the PRCM API level that need to be
>>updated.  I have a untested patch (below) that should fix this for you,
>>that you'll need to split and apply to the OMAP3 and OMAP4 voltage
>>driver patches.

You have forgotten to attach the patch! Can you please share it.

>>
>>To test with those changes, you can rebase onto my pm-core branch, which
>>contains not only the PRCM API changes, but also Nishanth's latest OPP
>>branch, and several other clock, hwmod, PM core changes queued for
>>2.6.38
>>
>>Second, please also Cc the linux-arm-kernel mailing list, so if/when we
>>merge this into linux-omap, it doesn't need a last minute repost.

I will CC linux-arm when I am posting the next version

Regards
Thaa
