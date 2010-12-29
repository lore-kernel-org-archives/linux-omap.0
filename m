From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/5] ASoC: DMIC: Adding the OMAP DMIC driver
Date: Wed, 29 Dec 2010 14:04:43 +0200
Message-ID: <20101229120443.GB2222@legolas.emea.dhcp.ti.com>
References: <1293509826-23253-1-git-send-email-dlambert@ti.com>
 <1293509826-23253-2-git-send-email-dlambert@ti.com>
 <20101228111424.GB2239@legolas.emea.dhcp.ti.com>
 <AANLkTi=6iWz0jdakBBgw2OEOjADvS2YmCN0ebKODQ7Ke@mail.gmail.com>
 <20101229094738.GA2254@legolas.emea.dhcp.ti.com>
 <1293618931.3451.17.camel@odin>
 <20101229104432.GB2254@legolas.emea.dhcp.ti.com>
 <1293623571.3451.51.camel@odin>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:33638 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752096Ab0L2MEs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Dec 2010 07:04:48 -0500
Received: by ewy8 with SMTP id 8so4938991ewy.3
        for <linux-omap@vger.kernel.org>; Wed, 29 Dec 2010 04:04:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1293623571.3451.51.camel@odin>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: balbi@ti.com, "Lambert, David" <dlambert@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

Hi,

On Wed, Dec 29, 2010 at 11:52:51AM +0000, Liam Girdwood wrote:
>I agree that drivers should be arch independent when possible, but in
>this case the OMAP DMIC DAI driver is coupled to the OMAP platform only.
>i.e. it performs IO directly on the OMAP DMIC IP. This IP is only found
>on OMAP silicon.

Let's imagine this IP is sourced from someone else and not created by
TI, what prevents company XYZ from sourcing the same IP and end up
re-using the driver ?

>I also agree it would be nice if it builds for PXA, MIPS, SuperH etc but
>what happens when the driver builds fine for OMAP but breaks the PXA,
>MIPS, SuperH build ? Who will spend time to fix and test it ?

You forgetting about other ARMs. This won't compile on DaVinci either.

>My main problem here is cost benefit. No one benefits directly by having
>this driver available for the above platforms but it costs me time
>fixing it when it breaks.

Of course there's people benefitting: OMAP audio driver writers would
know their driver is well written and doesn't break build for anybody.

Ok, let me put it this way:

What happens when you want have one kernel image for OMAP and DaVinci ?
Granted, that's not possible today anyway but e.g. Linaro is pushing for
it and IMO should be the way to go for us to be able to have a
distro-like kernel for ARM-based systems too.

>> >It also seems inconsistent with the other OMAP system headers in
>> >plat-omap too.
>>
>> Other than a few drivers which still need converting (and are on their
>> way) I can only see really arch-specific bits and pieces under plat/.
>>
>> Not sure what's your point here.
>>
>
>The point is that David had split the DMIC headers into two files, one
>for plat specific registers and bit definitions and the other for audio
>definitions (for the machine drivers) and is/was consistent with the
>current OMAP platform headers.

You forgot to mention that plat/ headers are supposed to be used by
plat-* and mach-* code only to setup the correct state for the driver.
Just recently one of the musb glue layers got broken because it was
mistakenly using <plat/control.h> and that got moved.

That's actually my point and why I think drivers should not touch plat/*
and mach/* headers.

-- 
balbi
