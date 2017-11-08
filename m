From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] Kernel debugging: omap: print warning if CONFIG_DEBUG_LL
 is enabled
Date: Wed, 8 Nov 2017 22:36:04 +0000
Message-ID: <20171108223604.GG28231@n2100.armlinux.org.uk>
References: <b80b85cd6f26d02d698463b3dd5e9783081aa780.1510176592.git.hns@goldelico.com>
 <20171108222755.GW28152@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171108222755.GW28152@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 08, 2017 at 02:27:55PM -0800, Tony Lindgren wrote:
> * H. Nikolaus Schaller <hns@goldelico.com> [171108 21:32]:
> > commit d2b310b0234c ("ARM: debug: Use generic 8250 debug_ll for omap2 and omap3/4/5 common uarts")
> > commit fc23beb8a577 ("ARM: debug: Use generic 8250 debug_ll for omap3/4/5")
> > 
> > switched to generic 8250 debug_ll code which seems to be incompatible
> > with at least OMAP5 boards (OMAP5EVM, Pyra) if CONFIG_DEBUG_LL is
> > still enabled in some legacy defconfig. Since this is very hard to
> > relate to these patches and difficult to identify, let's have the
> > compiler emit a warning.
> 
> Hmm the issue is the existing values in .config as Kconfig.debug
> does default XXX if DEBUG_XXX, right?
> 
> I think we have this issue in general if you enable DEBUG_LL for
> a SoC, then enable it for another SoC using the same .config?

As I keep saying, DEBUG_LL is the low level debugging code, which is
there to support people trying to debug the early bringup.  It can
only be configured for use with one particular port.  If that doesn't
match the SoC, then, if you make use of the DEBUG_LL code, it will
fail to boot.

Unfortunately, if you use early_printk rather than earlycon, as
early_printk uses the DEBUG_LL bits, it means that your early_printk
kernel is tied to the selected platform.

All well known issues.  early_printk should not be used in a multi-
platform kernel for this very reason.

We don't need a compiler warning there, we probably need better help
text against DEBUG_LL and against EARLY_PRINTK.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
