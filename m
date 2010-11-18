From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4] OMAP3: DSS: Kconfig changes to enable display
 options on OMAP3
Date: Thu, 18 Nov 2010 08:44:14 -0800
Message-ID: <20101118164414.GC9264@atomide.com>
References: <1288063074-8879-1-git-send-email-samreen@ti.com>
 <FCCFB4CDC6E5564B9182F639FC356087034C101F0B@dbde02.ent.ti.com>
 <1289915437.2668.107.camel@tubuntu>
 <20101116193843.GZ9264@atomide.com>
 <8762vxcaco.fsf@deeprootsystems.com>
 <20101116201054.GC9264@atomide.com>
 <1289996891.26444.16.camel@tubuntu>
 <20101118061850.GB17539@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53279 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759428Ab0KRQof (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Nov 2010 11:44:35 -0500
Content-Disposition: inline
In-Reply-To: <20101118061850.GB17539@linux-sh.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "ext Nilofer, Samreen" <samreen@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Quadros Roger (Nokia-MS/Helsinki)" <roger.quadros@nokia.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

* Paul Mundt <lethal@linux-sh.org> [101117 22:09]:
> On Wed, Nov 17, 2010 at 02:28:11PM +0200, Tomi Valkeinen wrote:
> > On Tue, 2010-11-16 at 21:10 +0100, ext Tony Lindgren wrote:
> > > Sure a module would be even better. My point is that the selection of
> > > all the features should be enabled by default and the board options come
> > > from platform_data.
> > 
> > Ok, let's build DSS & all panel drivers as modules by default.
> > 
> > Somehow I've gotten the impression from linux ml that enabling features
> > by default is bad. But perhaps it's more about intervening features than
> > normal drivers.
> > 
> The general rule is to avoid default enabling unless you really need it,
> but it still remains optional (which is why it's not being selected,
> instead). Some, like gpiolib, have come up with WANT/NEED options for the
> platform code to select in order to work out the desired behaviour, and
> you may benefit from a similar approach for your subsystem if it's really
> that integral for some parts.
> 
> The flip side of course is that if you expect your users to primarily be
> using the defconfigs provided, you can simply leave it default disabled
> in the Kconfig and set the options you want in the defconfigs.
> 
> Unless you can say with certainty that all OMAP3 boards are going to want
> DSS enabled or modular by default, it's almost always better to just
> leave it up to the defconfigs.

I wish we could just do "default m if ARCH_OMAP2PLUS_TYPICAL"..
But meanwhile setting it as a module in omap2plus_defconfig does
the trick though like you say.

Regards,

Tony
