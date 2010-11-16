From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4] OMAP3: DSS: Kconfig changes to enable display
 options on OMAP3
Date: Tue, 16 Nov 2010 12:10:54 -0800
Message-ID: <20101116201054.GC9264@atomide.com>
References: <1288063074-8879-1-git-send-email-samreen@ti.com>
 <FCCFB4CDC6E5564B9182F639FC356087034C101F0B@dbde02.ent.ti.com>
 <1289915437.2668.107.camel@tubuntu>
 <20101116193843.GZ9264@atomide.com>
 <8762vxcaco.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:41172 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932248Ab0KPULI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 15:11:08 -0500
Content-Disposition: inline
In-Reply-To: <8762vxcaco.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, "ext Nilofer, Samreen" <samreen@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Quadros Roger (Nokia-MS/Helsinki)" <roger.quadros@nokia.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

* Kevin Hilman <khilman@deeprootsystems.com> [101116 11:45]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > * Tomi Valkeinen <tomi.valkeinen@nokia.com> [101116 05:41]:
> >> On Tue, 2010-11-16 at 07:09 +0100, ext Nilofer, Samreen wrote:
> >> > Hi,
> >> >   Any more comments on this patch?
> >> 
> >> I'm not sure if enabling kernel options by default is a good thing.
> >> Somehow I remember that enabling things by default is not looked kindly
> >> at. Shouldn't they be enabled in the arch/arm/configs config file, if
> >> they are wanted?
> >> 
> >> Tony, do you have opinnion on this? Should DSS features be enabled by
> >> default in the Kconfig files, or only in the board config file?
> >
> > The best thing would be to have DSS y if ARCH_OMAP2PLUS or similar,
> > then have all the features built in and pass the configuration options
> > in platform_data. That still allows disabling certain features with
> > Kconfig if needed for memory consumption etc. But the omap2plus_defconfig
> > should "just work" on all the boards.
> 
> Personally, I'd much rather see DSS core and optional features default
> to being built as a module.
> 
> Other than a splash screen, there's no reason DSS is needed for a
> minimal boot.

Sure a module would be even better. My point is that the selection of
all the features should be enabled by default and the board options come
from platform_data.

Tony
