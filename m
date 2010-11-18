From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH v4] OMAP3: DSS: Kconfig changes to enable display options on OMAP3
Date: Fri, 19 Nov 2010 03:38:57 +0900
Message-ID: <20101118183856.GA24547@linux-sh.org>
References: <1288063074-8879-1-git-send-email-samreen@ti.com> <FCCFB4CDC6E5564B9182F639FC356087034C101F0B@dbde02.ent.ti.com> <1289915437.2668.107.camel@tubuntu> <20101116193843.GZ9264@atomide.com> <8762vxcaco.fsf@deeprootsystems.com> <20101116201054.GC9264@atomide.com> <1289996891.26444.16.camel@tubuntu> <20101118061850.GB17539@linux-sh.org> <20101118164414.GC9264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:56639 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755829Ab0KRSjf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Nov 2010 13:39:35 -0500
Content-Disposition: inline
In-Reply-To: <20101118164414.GC9264@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "ext Nilofer, Samreen" <samreen@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Quadros Roger (Nokia-MS/Helsinki)" <roger.quadros@nokia.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Thu, Nov 18, 2010 at 08:44:14AM -0800, Tony Lindgren wrote:
> * Paul Mundt <lethal@linux-sh.org> [101117 22:09]:
> > Unless you can say with certainty that all OMAP3 boards are going to want
> > DSS enabled or modular by default, it's almost always better to just
> > leave it up to the defconfigs.
> 
> I wish we could just do "default m if ARCH_OMAP2PLUS_TYPICAL"..
> But meanwhile setting it as a module in omap2plus_defconfig does
> the trick though like you say.
> 
Something like this should be quite doable if the Kconfig fragments work
is ever completed. If this is something that interests you you may wish
to give it a bit of a nudge :-)
