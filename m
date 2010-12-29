From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/5] ASoC: DMIC: Adding the OMAP DMIC driver
Date: Wed, 29 Dec 2010 10:35:31 +0000
Message-ID: <1293618931.3451.17.camel@odin>
References: <1293509826-23253-1-git-send-email-dlambert@ti.com>
	 <1293509826-23253-2-git-send-email-dlambert@ti.com>
	 <20101228111424.GB2239@legolas.emea.dhcp.ti.com>
	 <AANLkTi=6iWz0jdakBBgw2OEOjADvS2YmCN0ebKODQ7Ke@mail.gmail.com>
	 <20101229094738.GA2254@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55854 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021Ab0L2Kfg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Dec 2010 05:35:36 -0500
Received: by wyb28 with SMTP id 28so9986466wyb.19
        for <linux-omap@vger.kernel.org>; Wed, 29 Dec 2010 02:35:35 -0800 (PST)
In-Reply-To: <20101229094738.GA2254@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: "Lambert, David" <dlambert@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

On Wed, 2010-12-29 at 11:47 +0200, Felipe Balbi wrote:
> Hi,
> 
> On Tue, Dec 28, 2010 at 07:13:58PM -0600, Lambert, David wrote:
> >> one blank line only. BTW, are these used anywwhere outside the dmic.c
> >> driver ? If not, it's better to move the definitions there.
> >>
> >
> >They were originally in the omap-dmic.h header, but it was suggested
> >that we move
> >them to a platform header so that the driver could be more
> >architecture independent
> >and we could put the platform specific details here.  I'm OK putting
> >them just about
> >anywhere, as long as we have consensus.
> 
> The thing I don't like about putting register definitions under
> <plat/*.h> is that it creates the need for making the driver "depends on
> ARCH_OMAP" because it's the only architecture which has that file. If
> you put under <linux/*> or directly on the .c source file, you can have
> a much needed compile test with several architectures.
> 
> Even though the driver will never work with those other archs, compile
> testing with several of them isn't bad at all.

This seems unnecessary since this driver is for the OMAP platform only
and also means maintainers will have to waste time fixing any build
issues for this driver on irrelevant architectures. The costs here
outweigh any benefits....

It also seems inconsistent with the other OMAP system headers in
plat-omap too.

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk

