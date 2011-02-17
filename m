From: Hema Kalliguddi <hemahk@ti.com>
Subject: RE: [PATCH 5/6 v8] OMAP2+: musb: hwmod adaptation for musb registration
Date: Thu, 17 Feb 2011 17:41:06 +0530
Message-ID: <3aacb3eae994f733d29f751223f05242@mail.gmail.com>
References: <1297924642-3791-1-git-send-email-hemahk@ti.com>
 <1297924642-3791-6-git-send-email-hemahk@ti.com> <20110217113321.GA22356@legolas.emea.dhcp.ti.com>
 <20110217115332.GB22356@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:60587 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755844Ab1BQMLI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 07:11:08 -0500
In-Reply-To: <20110217115332.GB22356@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Hi Felipe,

>-----Original Message-----
>From: Felipe Balbi [mailto:balbi@ti.com]
>Sent: Thursday, February 17, 2011 5:24 PM
>To: Felipe Balbi
>Cc: Hema HK; linux-usb@vger.kernel.org;
>linux-omap@vger.kernel.org; Tony Lindgren; Kevin Hilman;
>Cousson, Benoit; Paul Walmsley
>Subject: Re: [PATCH 5/6 v8] OMAP2+: musb: hwmod adaptation for
>musb registration
>
>Hi,
>
>On Thu, Feb 17, 2011 at 01:33:21PM +0200, Felipe Balbi wrote:
>> On Thu, Feb 17, 2011 at 12:07:21PM +0530, Hema HK wrote:
>> > Using omap_device_build API instead of platform_device_register for
>> > OMAP2430,OMAP3xxx, OMAP4430 and AM35x musb device registration.
>> > The device specific resources defined in centralized
>> > database will be used.
>> >
>> > Signed-off-by: Hema HK <hemahk@ti.com>
>> > Cc: Felipe Balbi <balbi@ti.com>
>> > Cc: Tony Lindgren <tony@atomide.com>
>> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
>> > Cc: Cousson, Benoit <b-cousson@ti.com>
>> > Cc: Paul Walmsley <paul@pwsan.com>
>>
>> doesn't apply:
>>
>> OMAP2+: musb: hwmod adaptation for musb registration
>>
>> Using omap_device_build API instead of platform_device_register for
>> OMAP2430,OMAP3xxx, OMAP4430 and AM35x musb device registration.
>> The device specific resources defined in centralized
>> database will be used.
>>
>> Signed-off-by: Hema HK <hemahk@ti.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>> Cc: Cousson, Benoit <b-cousson@ti.com>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>> --------------------------
>> Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all y
>> Applying: OMAP2+: musb: hwmod adaptation for musb registration
>> error: patch failed: arch/arm/mach-omap2/usb-musb.c:30
>> error: arch/arm/mach-omap2/usb-musb.c: patch does not apply
>> Patch failed at 0005 OMAP2+: musb: hwmod adaptation for musb
>registration
>> When you have resolved this problem run "git am --resolved".
>> If you would prefer to skip this patch, instead run "git am --skip".
>> To restore the original branch and stop patching run "git am
>--abort".
>
>I fixed this one by hand, patch attached. Check if I fixed correctly.
>Patch attached.

Yes. The fix is correct. Thanks for that.

Regards,
Hema
>
>--
>balbi
>
