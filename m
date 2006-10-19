From: Jonathan McDowell <noodles@earth.li>
Subject: Re: [PATCH] ARM: OMAP: Fix 1510 compilation with DSP != m
Date: Thu, 19 Oct 2006 16:15:54 +0100
Message-ID: <20061019151553.GX20039@earth.li>
References: <20061008190831.GC21713@earth.li>
	<20061018193251.GC4669@atomide.com>
	<20061018211035.GO20039@earth.li>
	<20061019133241.GC9983@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20061019133241.GC9983@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 19, 2006 at 04:32:43PM +0300, Tony Lindgren wrote:
> * Jonathan McDowell <noodles@earth.li> [061019 00:17]:
> > On Wed, Oct 18, 2006 at 10:32:53PM +0300, Tony Lindgren wrote:
> > > Hi,
> > > 
> > > * Jonathan McDowell <noodles@earth.li> [061008 22:09]:
> > > > Looks like recent changes have broken OMAP1510 compilation; I hit this
> > > > because I'm not using the DSP at present but during testing my fix
> > > > discovered that setting CONFIG_OMAP_DSP to Y didn't compile either; only
> > > > M worked. Patch below makes all 3 compile.
> > > > 
> > > > Signed-Off-By: Jonathan McDowell <noodles@earth.li>
> > > > 
> > > > -----
> > > > diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
> > > > index 992a17d..adae4f8 100644
> > > > --- a/arch/arm/mach-omap1/devices.c
> > > > +++ b/arch/arm/mach-omap1/devices.c
> > > > @@ -63,7 +63,7 @@ #endif
> > > >  
> > > >  #if defined(CONFIG_OMAP_DSP)
> > > >  
> > > > -#if defined(CONFIG_ARCH_OMAP1510)
> > > > +#if defined(CONFIG_ARCH_OMAP15XX)
> > > >  #  define OMAP1_MBOX_SIZE	0x23
> > > >  #  define INT_DSP_MAILBOX1	INT_1510_DSP_MAILBOX1
> > > >  #elif defined(CONFIG_ARCH_OMAP16XX)
...
> > > I guess originally the idea was that McBSP would work even without
> > > CONFIG_OMAP_DSP.
> > > 
> > > Note that arch/arm/plat_omap/dsp/dsp_common.c is compiled even without
> > > CONFIG_OMAP_DSP.
> > 
> > dsp_common.c will always be compiled if dsp/ is entered.
> > 
> > However arch/arm/plat-omap/dsp is only entered when CONFIG_OMAP_DSP is
> > set; arch/arm/plat-omap/Makefile has:
> > 
> > # DSP subsystem
> > obj-$(CONFIG_OMAP_DSP) += dsp/ mailbox.o
> 
> Oh yeah, that's true. Does the attached patch work for you?

Confirmed as compiling and booting on the Amstrad Delta (OMAP1510) with
CONFIG_OMAP_DSP=n.

The first part of my patch (against arch/arm/mach-omap1/devices.c) is
still needed for CONFIG_OMAP_DSP=y to compile.

J.

-- 
"Bother," said Pooh, as Piglet stamped on his bollocks.
