From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/5] ASoC: DMIC: Adding the OMAP DMIC driver
Date: Wed, 29 Dec 2010 12:44:32 +0200
Message-ID: <20101229104432.GB2254@legolas.emea.dhcp.ti.com>
References: <1293509826-23253-1-git-send-email-dlambert@ti.com>
 <1293509826-23253-2-git-send-email-dlambert@ti.com>
 <20101228111424.GB2239@legolas.emea.dhcp.ti.com>
 <AANLkTi=6iWz0jdakBBgw2OEOjADvS2YmCN0ebKODQ7Ke@mail.gmail.com>
 <20101229094738.GA2254@legolas.emea.dhcp.ti.com>
 <1293618931.3451.17.camel@odin>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:47149 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751390Ab0L2Koj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Dec 2010 05:44:39 -0500
Received: by ewy22 with SMTP id 22so6147695ewy.30
        for <linux-omap@vger.kernel.org>; Wed, 29 Dec 2010 02:44:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1293618931.3451.17.camel@odin>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: balbi@ti.com, "Lambert, David" <dlambert@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

Hi,

On Wed, Dec 29, 2010 at 10:35:31AM +0000, Liam Girdwood wrote:
>> Even though the driver will never work with those other archs, compile
>> testing with several of them isn't bad at all.
>
>This seems unnecessary since this driver is for the OMAP platform only
>and also means maintainers will have to waste time fixing any build
>issues for this driver on irrelevant architectures. The costs here
>outweigh any benefits....

If that's the case, what's the use for linux-next, then ? Drivers should
be arch independent as much as possible, no ? Isn't that why we don't
want drivers using branches to things such as machine_is_omap4_panda()
or similar ?

But the whole audio part on OMAP is still in a bad shape anyway, e.g.
mcbsp exports omap-only functions for drivers to use, so this will only
be yet another driver to the pile :-p

>It also seems inconsistent with the other OMAP system headers in
>plat-omap too.

Other than a few drivers which still need converting (and are on their
way) I can only see really arch-specific bits and pieces under plat/.

Not sure what's your point here.

-- 
balbi
