From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH v4] OMAP3: DSS: Kconfig changes to enable display
 options on OMAP3
Date: Wed, 17 Nov 2010 14:28:11 +0200
Message-ID: <1289996891.26444.16.camel@tubuntu>
References: <1288063074-8879-1-git-send-email-samreen@ti.com>
	 <FCCFB4CDC6E5564B9182F639FC356087034C101F0B@dbde02.ent.ti.com>
	 <1289915437.2668.107.camel@tubuntu> <20101116193843.GZ9264@atomide.com>
	 <8762vxcaco.fsf@deeprootsystems.com>  <20101116201054.GC9264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:46544 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933291Ab0KQM2X (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Nov 2010 07:28:23 -0500
In-Reply-To: <20101116201054.GC9264@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "ext Nilofer, Samreen" <samreen@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Quadros Roger (Nokia-MS/Helsinki)" <roger.quadros@nokia.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Tue, 2010-11-16 at 21:10 +0100, ext Tony Lindgren wrote:
> * Kevin Hilman <khilman@deeprootsystems.com> [101116 11:45]:
> > Tony Lindgren <tony@atomide.com> writes:
> > 
> > > * Tomi Valkeinen <tomi.valkeinen@nokia.com> [101116 05:41]:
> > >> On Tue, 2010-11-16 at 07:09 +0100, ext Nilofer, Samreen wrote:
> > >> > Hi,
> > >> >   Any more comments on this patch?
> > >> 
> > >> I'm not sure if enabling kernel options by default is a good thing.
> > >> Somehow I remember that enabling things by default is not looked kindly
> > >> at. Shouldn't they be enabled in the arch/arm/configs config file, if
> > >> they are wanted?
> > >> 
> > >> Tony, do you have opinnion on this? Should DSS features be enabled by
> > >> default in the Kconfig files, or only in the board config file?
> > >
> > > The best thing would be to have DSS y if ARCH_OMAP2PLUS or similar,
> > > then have all the features built in and pass the configuration options
> > > in platform_data. That still allows disabling certain features with
> > > Kconfig if needed for memory consumption etc. But the omap2plus_defconfig
> > > should "just work" on all the boards.
> > 
> > Personally, I'd much rather see DSS core and optional features default
> > to being built as a module.
> > 
> > Other than a splash screen, there's no reason DSS is needed for a
> > minimal boot.
> 
> Sure a module would be even better. My point is that the selection of
> all the features should be enabled by default and the board options come
> from platform_data.

Ok, let's build DSS & all panel drivers as modules by default.

Somehow I've gotten the impression from linux ml that enabling features
by default is bad. But perhaps it's more about intervening features than
normal drivers.

Samreen, will you change the patch to set DSS & panel drivers to be
built as modules by default? Optimally all display interfaces should be
enabled, but I believe at least SDI and DSI are currently slightly
broken, because they prevent DSS from initializing if SDI/DSI regulator
is not defined in the board file. So perhaps we should start with only
DPI and VENC enabled (plus all the DPI panels).

Also, this patch could be based on top of Bryan Wu's new generic panel
patch set, which I'll perhaps apply today to my tree if I find no more
to comment about.

 Tomi


