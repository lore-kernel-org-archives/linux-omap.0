From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/5] ASoC: DMIC: Adding the OMAP DMIC driver
Date: Wed, 29 Dec 2010 11:52:51 +0000
Message-ID: <1293623571.3451.51.camel@odin>
References: <1293509826-23253-1-git-send-email-dlambert@ti.com>
	 <1293509826-23253-2-git-send-email-dlambert@ti.com>
	 <20101228111424.GB2239@legolas.emea.dhcp.ti.com>
	 <AANLkTi=6iWz0jdakBBgw2OEOjADvS2YmCN0ebKODQ7Ke@mail.gmail.com>
	 <20101229094738.GA2254@legolas.emea.dhcp.ti.com>
	 <1293618931.3451.17.camel@odin>
	 <20101229104432.GB2254@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58362 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255Ab0L2Lwz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Dec 2010 06:52:55 -0500
Received: by wyb28 with SMTP id 28so10033642wyb.19
        for <linux-omap@vger.kernel.org>; Wed, 29 Dec 2010 03:52:54 -0800 (PST)
In-Reply-To: <20101229104432.GB2254@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: "Lambert, David" <dlambert@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

On Wed, 2010-12-29 at 12:44 +0200, Felipe Balbi wrote:
> Hi,
> 
> On Wed, Dec 29, 2010 at 10:35:31AM +0000, Liam Girdwood wrote:
> >> Even though the driver will never work with those other archs, compile
> >> testing with several of them isn't bad at all.
> >
> >This seems unnecessary since this driver is for the OMAP platform only
> >and also means maintainers will have to waste time fixing any build
> >issues for this driver on irrelevant architectures. The costs here
> >outweigh any benefits....
> 
> If that's the case, what's the use for linux-next, then ? Drivers should
> be arch independent as much as possible, no ? Isn't that why we don't
> want drivers using branches to things such as machine_is_omap4_panda()
> or similar ?
> 

I agree that drivers should be arch independent when possible, but in
this case the OMAP DMIC DAI driver is coupled to the OMAP platform only.
i.e. it performs IO directly on the OMAP DMIC IP. This IP is only found
on OMAP silicon.

I also agree it would be nice if it builds for PXA, MIPS, SuperH etc but
what happens when the driver builds fine for OMAP but breaks the PXA,
MIPS, SuperH build ? Who will spend time to fix and test it ?

My main problem here is cost benefit. No one benefits directly by having
this driver available for the above platforms but it costs me time
fixing it when it breaks. 

> But the whole audio part on OMAP is still in a bad shape anyway, e.g.
> mcbsp exports omap-only functions for drivers to use, so this will only
> be yet another driver to the pile :-p
> 

In this case though the other McBSP user afaik is DaVinci, so in this
case it does make sense to make this driver support both.

> >It also seems inconsistent with the other OMAP system headers in
> >plat-omap too.
> 
> Other than a few drivers which still need converting (and are on their
> way) I can only see really arch-specific bits and pieces under plat/.
> 
> Not sure what's your point here.
> 

The point is that David had split the DMIC headers into two files, one
for plat specific registers and bit definitions and the other for audio
definitions (for the machine drivers) and is/was consistent with the
current OMAP platform headers. 

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk

