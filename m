From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/3] ARM: OMAP2+: USB Host bug fixes for 3.13 rc
Date: Thu, 5 Dec 2013 10:48:32 -0800
Message-ID: <20131205184832.GG26766@atomide.com>
References: <1386080748-17005-1-git-send-email-rogerq@ti.com>
 <529EFD42.9070507@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <529EFD42.9070507@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Roger Quadros <rogerq@ti.com>, bcousson@baylibre.com, paul@pwsan.com, balbi@ti.com, sr@denx.de, David.Laight@ACULAB.COM, michael@amarulasolutions.com, bigeasy@linutronix.de, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [131204 02:01]:
> On 2013-12-03 16:25, Roger Quadros wrote:
> > Hi,
> > 
> > This is a follow up solution to the original series in [1]
> > 
> > The first patch fixes the OMAP4 Panda USB detection problems on 3.13-rc1
> > with u-boot v2013.10.
> > 
> > The remaining 2 patches are required if SOFTRESET needs to be done for the
> > USB Host module on OMAP3 platforms.
> > 
> > Patch 2 fixes the hwmod RESET logic to prevent multiple SOFTRESETs
> > being issued to the modules. This multiple SOFTRESET was causing problems
> > with OMAP3 USB Host module. On Beagleboard C4 this is seen as failure to
> > mount NFS root over external USB to Ethernet device.
> > 
> > This might be the reason why HWMOD_INIT_NO_RESET was used for the OMAP
> > USB host module in OMAP3 hwmod data and just carried forward in OMAP4
> > and OMAP5 hwmod data as well.
> > 
> > cheers,
> > -roger
> 
> Tested on Panda and Beagle xM. Works fine for me.

Looks like we should merge these as regression fixes during the -rc
cycle. Paul should take a look at these first though.

Regards,

Tony
