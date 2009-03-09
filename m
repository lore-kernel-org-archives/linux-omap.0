From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] [OMAP850] Base support for omap850 cpu.
Date: Mon, 9 Mar 2009 16:41:07 -0700
Message-ID: <20090309234106.GJ7329@atomide.com>
References: <1232824512-17826-2-git-send-email-zmc@lurian.net> <20090126164834.GD7172@atomide.com> <20090128002513.GA13303@polaris.lurian.net> <20090304180532.GM6784@atomide.com> <20090308181236.GA9959@polaris.lurian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62336 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086AbZCIXlU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Mar 2009 19:41:20 -0400
Content-Disposition: inline
In-Reply-To: <20090308181236.GA9959@polaris.lurian.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: zmc@lurian.net
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

* zmc@lurian.net <zmc@lurian.net> [090308 11:12]:
> On Wed, Mar 04, 2009 at 10:05:32AM -0800, Tony Lindgren wrote:
> > * zmc@lurian.net <zmc@lurian.net> [090127 16:25]:
> > > On Mon, Jan 26, 2009 at 08:48:38AM -0800, Tony Lindgren wrote:
> > > > Hi,
> > > > 
> > > > * Zebediah C. McClure <zmc@lurian.net> [090124 11:27]:
> > > > > ---
> > > > >  arch/arm/mach-omap1/id.c                   |    4 +-
> > > > >  arch/arm/plat-omap/include/mach/cpu.h      |   35 +++++++++-
> > > > >  arch/arm/plat-omap/include/mach/hardware.h |    1 +
> > > > >  arch/arm/plat-omap/include/mach/omap850.h  |  102 ++++++++++++++++++++++++++++
> > > > >  4 files changed, 137 insertions(+), 5 deletions(-)
> > > > >  create mode 100644 arch/arm/plat-omap/include/mach/omap850.h
> > > > > 
> > > > 
> > > > <snip>
> > > > 
> > > > > diff --git a/arch/arm/plat-omap/include/mach/hardware.h b/arch/arm/plat-omap/include/mach/hardware.h
> > > > > index 6589ddb..8cffc07 100644
> > > > > --- a/arch/arm/plat-omap/include/mach/hardware.h
> > > > > +++ b/arch/arm/plat-omap/include/mach/hardware.h
> > > > > @@ -281,6 +281,7 @@
> > > > >   */
> > > > >  
> > > > >  #include "omap730.h"
> > > > > +#include "omap850.h"
> > > > >  #include "omap1510.h"
> > > > >  #include "omap16xx.h"
> > > > >  #include "omap24xx.h"
> > > > 
> > > > The patch looks good in general. However, can you please leave out the
> > > > include "omap850.h" above, and include omap850.h directly where needed?
> > > > 
> > > > I'm working on a set of patches to remove the inclusion of the
> > > > processor headers in hardware.h. These include will unecessarily 
> > > > force recompile of everything when changing processor type as noted by
> > > > Russell.
> > 
> > Zebediah, could you please repost the following patches one more time
> > with proper Signed-off-by?
> > 
> > [PATCH] [OMAP850] Base support for omap850 cpu
> > [PATCH] [OMAP850] Changes to base IO subsystems
> > [PATCH] [OMAP850] Changes to memory subsystems
> > [PATCH] [OMAP850] IRQ related changes
> > 
> > Then I'll add these to my for-next branch to be merged. We still need
> > to wait on the clock and PM changes, but at least that shrinks down your
> > patchset quite a bit.
> > 
> > Regards,
> > 
> > Tony
> > 
> 
> Here they are. I also have them available in git if you prefer.

Thanks. I've added them to my for-next branch except for the clock
patch [1]. So no git branch needed right now.

Note that I've made some cosmetic changes and fixed few whitespace
typos. Also changed the gpio.c void __iomem * casts into to use
IO_ADDRESS(). 

I suggest you refresh your clock patch once all the other pending
clock patches go into the mainline during the next merge window,
and then repost that here with linux-omap@vger.kernel.org Cc'd.

Then if everything looks good, hopefully we'll have enough time
to get that one in too during the merge window.

Regards,

Tony

[1] http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=shortlog;h=for-next
 
> Thanks again,
> 
> Zeb
>   
> > > > Regards,
> > > > 
> > > > Tony
> > > 
> > > Thanks,
> > > 
> > > 	Removed include.
> > > 
> > > zmc
> > 
> > > From 434fd1dafe3bdcd28d524f14cc107a29c3332700 Mon Sep 17 00:00:00 2001
> > > From: Zebediah C. McClure <zmc@lurian.net>
> > > Date: Tue, 27 Jan 2009 20:16:26 -0400
> > > Subject: [PATCH] [OMAP850] Base support for omap850 cpu.
> > > 
> > > ---
> > >  arch/arm/mach-omap1/id.c                  |    4 +-
> > >  arch/arm/plat-omap/include/mach/cpu.h     |   35 +++++++++-
> > >  arch/arm/plat-omap/include/mach/omap850.h |  102 +++++++++++++++++++++++++++++
> > >  3 files changed, 136 insertions(+), 5 deletions(-)
> > >  create mode 100644 arch/arm/plat-omap/include/mach/omap850.h
> > > 
> > > diff --git a/arch/arm/mach-omap1/id.c b/arch/arm/mach-omap1/id.c
> > > index 89bb875..4ef26fa 100644
> > > --- a/arch/arm/mach-omap1/id.c
> > > +++ b/arch/arm/mach-omap1/id.c
> > > @@ -38,6 +38,7 @@ static struct omap_id omap_ids[] __initdata = {
> > >  	{ .jtag_id = 0xb574, .die_rev = 0x2, .omap_id = 0x03310315, .type = 0x03100000},
> > >  	{ .jtag_id = 0x355f, .die_rev = 0x0, .omap_id = 0x03320000, .type = 0x07300100},
> > >  	{ .jtag_id = 0xb55f, .die_rev = 0x0, .omap_id = 0x03320000, .type = 0x07300300},
> > > +	{ .jtag_id = 0xb55f, .die_rev = 0x0, .omap_id = 0x03320500, .type = 0x08500000},
> > >  	{ .jtag_id = 0xb470, .die_rev = 0x0, .omap_id = 0x03310100, .type = 0x15100000},
> > >  	{ .jtag_id = 0xb576, .die_rev = 0x0, .omap_id = 0x03320000, .type = 0x16100000},
> > >  	{ .jtag_id = 0xb576, .die_rev = 0x2, .omap_id = 0x03320100, .type = 0x16110000},
> > > @@ -77,7 +78,7 @@ static u16 __init omap_get_jtag_id(void)
> > >  	prod_id = omap_readl(OMAP_PRODUCTION_ID_1);
> > >  	omap_id = omap_readl(OMAP32_ID_1);
> > >  
> > > -	/* Check for unusable OMAP_PRODUCTION_ID_1 on 1611B/5912 and 730 */
> > > +	/* Check for unusable OMAP_PRODUCTION_ID_1 on 1611B/5912 and 730/850 */
> > >  	if (((prod_id >> 20) == 0) || (prod_id == omap_id))
> > >  		prod_id = 0;
> > >  	else
> > > @@ -178,6 +179,7 @@ void __init omap_check_revision(void)
> > >  
> > >  	switch (cpu_type) {
> > >  	case 0x07:
> > > +	case 0x08:
> > >  		omap_revision |= 0x07;
> > >  		break;
> > >  	case 0x03:
> > > diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-omap/include/mach/cpu.h
> > > index b2062f1..ef399f4 100644
> > > --- a/arch/arm/plat-omap/include/mach/cpu.h
> > > +++ b/arch/arm/plat-omap/include/mach/cpu.h
> > > @@ -56,6 +56,14 @@ unsigned int omap_rev(void);
> > >  #  define OMAP_NAME omap730
> > >  # endif
> > >  #endif
> > > +#ifdef CONFIG_ARCH_OMAP850
> > > +# ifdef OMAP_NAME
> > > +#  undef  MULTI_OMAP1
> > > +#  define MULTI_OMAP1
> > > +# else
> > > +#  define OMAP_NAME omap850
> > > +# endif
> > > +#endif
> > >  #ifdef CONFIG_ARCH_OMAP15XX
> > >  # ifdef OMAP_NAME
> > >  #  undef  MULTI_OMAP1
> > > @@ -105,7 +113,7 @@ unsigned int omap_rev(void);
> > >  /*
> > >   * Macros to group OMAP into cpu classes.
> > >   * These can be used in most places.
> > > - * cpu_is_omap7xx():	True for OMAP730
> > > + * cpu_is_omap7xx():	True for OMAP730, OMAP850
> > >   * cpu_is_omap15xx():	True for OMAP1510, OMAP5910 and OMAP310
> > >   * cpu_is_omap16xx():	True for OMAP1610, OMAP5912 and OMAP1710
> > >   * cpu_is_omap24xx():	True for OMAP2420, OMAP2422, OMAP2423, OMAP2430
> > > @@ -153,6 +161,10 @@ IS_OMAP_SUBCLASS(343x, 0x343)
> > >  #  undef  cpu_is_omap7xx
> > >  #  define cpu_is_omap7xx()		is_omap7xx()
> > >  # endif
> > > +# if defined(CONFIG_ARCH_OMAP850)
> > > +#  undef  cpu_is_omap7xx
> > > +#  define cpu_is_omap7xx()		is_omap7xx()
> > > +# endif
> > >  # if defined(CONFIG_ARCH_OMAP15XX)
> > >  #  undef  cpu_is_omap15xx
> > >  #  define cpu_is_omap15xx()		is_omap15xx()
> > > @@ -166,6 +178,10 @@ IS_OMAP_SUBCLASS(343x, 0x343)
> > >  #  undef  cpu_is_omap7xx
> > >  #  define cpu_is_omap7xx()		1
> > >  # endif
> > > +# if defined(CONFIG_ARCH_OMAP850)
> > > +#  undef  cpu_is_omap7xx
> > > +#  define cpu_is_omap7xx()		1
> > > +# endif
> > >  # if defined(CONFIG_ARCH_OMAP15XX)
> > >  #  undef  cpu_is_omap15xx
> > >  #  define cpu_is_omap15xx()		1
> > > @@ -219,6 +235,7 @@ IS_OMAP_SUBCLASS(343x, 0x343)
> > >   * These are only rarely needed.
> > >   * cpu_is_omap330():	True for OMAP330
> > >   * cpu_is_omap730():	True for OMAP730
> > > + * cpu_is_omap850():	True for OMAP850
> > >   * cpu_is_omap1510():	True for OMAP1510
> > >   * cpu_is_omap1610():	True for OMAP1610
> > >   * cpu_is_omap1611():	True for OMAP1611
> > > @@ -241,6 +258,7 @@ static inline int is_omap ##type (void)			\
> > >  
> > >  IS_OMAP_TYPE(310, 0x0310)
> > >  IS_OMAP_TYPE(730, 0x0730)
> > > +IS_OMAP_TYPE(850, 0x0850)
> > >  IS_OMAP_TYPE(1510, 0x1510)
> > >  IS_OMAP_TYPE(1610, 0x1610)
> > >  IS_OMAP_TYPE(1611, 0x1611)
> > > @@ -255,6 +273,7 @@ IS_OMAP_TYPE(3430, 0x3430)
> > >  
> > >  #define cpu_is_omap310()		0
> > >  #define cpu_is_omap730()		0
> > > +#define cpu_is_omap850()		0
> > >  #define cpu_is_omap1510()		0
> > >  #define cpu_is_omap1610()		0
> > >  #define cpu_is_omap5912()		0
> > > @@ -272,12 +291,22 @@ IS_OMAP_TYPE(3430, 0x3430)
> > >  #  undef  cpu_is_omap730
> > >  #  define cpu_is_omap730()		is_omap730()
> > >  # endif
> > > +# if defined(CONFIG_ARCH_OMAP850)
> > > +#  undef  cpu_is_omap850
> > > +#  define cpu_is_omap850()		is_omap850()
> > > +# endif
> > >  #else
> > >  # if defined(CONFIG_ARCH_OMAP730)
> > >  #  undef  cpu_is_omap730
> > >  #  define cpu_is_omap730()		1
> > >  # endif
> > >  #endif
> > > +#else
> > > +# if defined(CONFIG_ARCH_OMAP850)
> > > +#  undef  cpu_is_omap850
> > > +#  define cpu_is_omap850()		1
> > > +# endif
> > > +#endif
> > >  
> > >  /*
> > >   * Whether we have MULTI_OMAP1 or not, we still need to distinguish
> > > @@ -320,7 +349,7 @@ IS_OMAP_TYPE(3430, 0x3430)
> > >  #endif
> > >  
> > >  /* Macros to detect if we have OMAP1 or OMAP2 */
> > > -#define cpu_class_is_omap1()	(cpu_is_omap730() || cpu_is_omap15xx() || \
> > > +#define cpu_class_is_omap1()	(cpu_is_omap7xx() || cpu_is_omap15xx() || \
> > >  				cpu_is_omap16xx())
> > >  #define cpu_class_is_omap2()	(cpu_is_omap24xx() || cpu_is_omap34xx())
> > >  
> > > @@ -377,5 +406,3 @@ int omap_type(void);
> > >  void omap2_check_revision(void);
> > >  
> > >  #endif    /* defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) */
> > > -
> > > -#endif
> > > diff --git a/arch/arm/plat-omap/include/mach/omap850.h b/arch/arm/plat-omap/include/mach/omap850.h
> > > new file mode 100644
> > > index 0000000..c33f679
> > > --- /dev/null
> > > +++ b/arch/arm/plat-omap/include/mach/omap850.h
> > > @@ -0,0 +1,102 @@
> > > +/* arch/arm/plat-omap/include/mach/omap850.h
> > > + *
> > > + * Hardware definitions for TI OMAP850 processor.
> > > + *
> > > + * Derived from omap730.h by Zebediah C. McClure <zmc@lurian.net>
> > > + *
> > > + * This program is free software; you can redistribute it and/or modify it
> > > + * under the terms of the GNU General Public License as published by the
> > > + * Free Software Foundation; either version 2 of the License, or (at your
> > > + * option) any later version.
> > > + *
> > > + * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
> > > + * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
> > > + * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
> > > + * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
> > > + * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> > > + * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
> > > + * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
> > > + * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> > > + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
> > > + * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> > > + *
> > > + * You should have received a copy of the  GNU General Public License along
> > > + * with this program; if not, write  to the Free Software Foundation, Inc.,
> > > + * 675 Mass Ave, Cambridge, MA 02139, USA.
> > > + */
> > > +
> > > +#ifndef __ASM_ARCH_OMAP850_H
> > > +#define __ASM_ARCH_OMAP850_H
> > > +
> > > +/*
> > > + * ----------------------------------------------------------------------------
> > > + * Base addresses
> > > + * ----------------------------------------------------------------------------
> > > + */
> > > +
> > > +/* Syntax: XX_BASE = Virtual base address, XX_START = Physical base address */
> > > +
> > > +#define OMAP850_DSP_BASE	0xE0000000
> > > +#define OMAP850_DSP_SIZE	0x50000
> > > +#define OMAP850_DSP_START	0xE0000000
> > > +
> > > +#define OMAP850_DSPREG_BASE	0xE1000000
> > > +#define OMAP850_DSPREG_SIZE	SZ_128K
> > > +#define OMAP850_DSPREG_START	0xE1000000
> > > +
> > > +/*
> > > + * ----------------------------------------------------------------------------
> > > + * OMAP850 specific configuration registers
> > > + * ----------------------------------------------------------------------------
> > > + */
> > > +#define OMAP850_CONFIG_BASE	0xfffe1000
> > > +#define OMAP850_IO_CONF_0	0xfffe1070
> > > +#define OMAP850_IO_CONF_1	0xfffe1074
> > > +#define OMAP850_IO_CONF_2	0xfffe1078
> > > +#define OMAP850_IO_CONF_3	0xfffe107c
> > > +#define OMAP850_IO_CONF_4	0xfffe1080
> > > +#define OMAP850_IO_CONF_5	0xfffe1084
> > > +#define OMAP850_IO_CONF_6	0xfffe1088
> > > +#define OMAP850_IO_CONF_7	0xfffe108c
> > > +#define OMAP850_IO_CONF_8	0xfffe1090
> > > +#define OMAP850_IO_CONF_9	0xfffe1094
> > > +#define OMAP850_IO_CONF_10	0xfffe1098
> > > +#define OMAP850_IO_CONF_11	0xfffe109c
> > > +#define OMAP850_IO_CONF_12	0xfffe10a0
> > > +#define OMAP850_IO_CONF_13	0xfffe10a4
> > > +
> > > +#define OMAP850_MODE_1		0xfffe1010
> > > +#define OMAP850_MODE_2		0xfffe1014
> > > +
> > > +/* CSMI specials: in terms of base + offset */
> > > +#define OMAP850_MODE2_OFFSET	0x14
> > > +
> > > +/*
> > > + * ----------------------------------------------------------------------------
> > > + * OMAP850 traffic controller configuration registers
> > > + * ----------------------------------------------------------------------------
> > > + */
> > > +#define OMAP850_FLASH_CFG_0	0xfffecc10
> > > +#define OMAP850_FLASH_ACFG_0	0xfffecc50
> > > +#define OMAP850_FLASH_CFG_1	0xfffecc14
> > > +#define OMAP850_FLASH_ACFG_1	0xfffecc54
> > > +
> > > +/*
> > > + * ----------------------------------------------------------------------------
> > > + * OMAP850 DSP control registers
> > > + * ----------------------------------------------------------------------------
> > > + */
> > > +#define OMAP850_ICR_BASE	0xfffbb800
> > > +#define OMAP850_DSP_M_CTL	0xfffbb804
> > > +#define OMAP850_DSP_MMU_BASE	0xfffed200
> > > +
> > > +/*
> > > + * ----------------------------------------------------------------------------
> > > + * OMAP850 PCC_UPLD configuration registers
> > > + * ----------------------------------------------------------------------------
> > > + */
> > > +#define OMAP850_PCC_UPLD_CTRL_BASE	(0xfffe0900)
> > > +#define OMAP850_PCC_UPLD_CTRL		(OMAP850_PCC_UPLD_CTRL_BASE + 0x00)
> > > +
> > > +#endif /*  __ASM_ARCH_OMAP850_H */
> > > +
> > > -- 
> > > 1.6.0.6
> > > 
> > 
> > 

> From 58cb409cee3d727e3c1768775af3664c7d3c8ca0 Mon Sep 17 00:00:00 2001
> From: Zebediah C. McClure <zmc@lurian.net>
> Date: Tue, 27 Jan 2009 20:16:26 -0400
> Subject: [PATCH] [OMAP850] Base support for omap850 cpu.
> 
> 
> Signed-off-by: Zebediah C. McClure <zmc@lurian.net>
> ---
>  arch/arm/mach-omap1/id.c                  |    4 +-
>  arch/arm/plat-omap/include/mach/cpu.h     |   35 +++++++++-
>  arch/arm/plat-omap/include/mach/omap850.h |  102 +++++++++++++++++++++++++++++
>  3 files changed, 136 insertions(+), 5 deletions(-)
>  create mode 100644 arch/arm/plat-omap/include/mach/omap850.h
> 
> diff --git a/arch/arm/mach-omap1/id.c b/arch/arm/mach-omap1/id.c
> index 89bb875..4ef26fa 100644
> --- a/arch/arm/mach-omap1/id.c
> +++ b/arch/arm/mach-omap1/id.c
> @@ -38,6 +38,7 @@ static struct omap_id omap_ids[] __initdata = {
>  	{ .jtag_id = 0xb574, .die_rev = 0x2, .omap_id = 0x03310315, .type = 0x03100000},
>  	{ .jtag_id = 0x355f, .die_rev = 0x0, .omap_id = 0x03320000, .type = 0x07300100},
>  	{ .jtag_id = 0xb55f, .die_rev = 0x0, .omap_id = 0x03320000, .type = 0x07300300},
> +	{ .jtag_id = 0xb55f, .die_rev = 0x0, .omap_id = 0x03320500, .type = 0x08500000},
>  	{ .jtag_id = 0xb470, .die_rev = 0x0, .omap_id = 0x03310100, .type = 0x15100000},
>  	{ .jtag_id = 0xb576, .die_rev = 0x0, .omap_id = 0x03320000, .type = 0x16100000},
>  	{ .jtag_id = 0xb576, .die_rev = 0x2, .omap_id = 0x03320100, .type = 0x16110000},
> @@ -77,7 +78,7 @@ static u16 __init omap_get_jtag_id(void)
>  	prod_id = omap_readl(OMAP_PRODUCTION_ID_1);
>  	omap_id = omap_readl(OMAP32_ID_1);
>  
> -	/* Check for unusable OMAP_PRODUCTION_ID_1 on 1611B/5912 and 730 */
> +	/* Check for unusable OMAP_PRODUCTION_ID_1 on 1611B/5912 and 730/850 */
>  	if (((prod_id >> 20) == 0) || (prod_id == omap_id))
>  		prod_id = 0;
>  	else
> @@ -178,6 +179,7 @@ void __init omap_check_revision(void)
>  
>  	switch (cpu_type) {
>  	case 0x07:
> +	case 0x08:
>  		omap_revision |= 0x07;
>  		break;
>  	case 0x03:
> diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-omap/include/mach/cpu.h
> index a8e1178..366f829 100644
> --- a/arch/arm/plat-omap/include/mach/cpu.h
> +++ b/arch/arm/plat-omap/include/mach/cpu.h
> @@ -56,6 +56,14 @@ unsigned int omap_rev(void);
>  #  define OMAP_NAME omap730
>  # endif
>  #endif
> +#ifdef CONFIG_ARCH_OMAP850
> +# ifdef OMAP_NAME
> +#  undef  MULTI_OMAP1
> +#  define MULTI_OMAP1
> +# else
> +#  define OMAP_NAME omap850
> +# endif
> +#endif
>  #ifdef CONFIG_ARCH_OMAP15XX
>  # ifdef OMAP_NAME
>  #  undef  MULTI_OMAP1
> @@ -105,7 +113,7 @@ unsigned int omap_rev(void);
>  /*
>   * Macros to group OMAP into cpu classes.
>   * These can be used in most places.
> - * cpu_is_omap7xx():	True for OMAP730
> + * cpu_is_omap7xx():	True for OMAP730, OMAP850
>   * cpu_is_omap15xx():	True for OMAP1510, OMAP5910 and OMAP310
>   * cpu_is_omap16xx():	True for OMAP1610, OMAP5912 and OMAP1710
>   * cpu_is_omap24xx():	True for OMAP2420, OMAP2422, OMAP2423, OMAP2430
> @@ -153,6 +161,10 @@ IS_OMAP_SUBCLASS(343x, 0x343)
>  #  undef  cpu_is_omap7xx
>  #  define cpu_is_omap7xx()		is_omap7xx()
>  # endif
> +# if defined(CONFIG_ARCH_OMAP850)
> +#  undef  cpu_is_omap7xx
> +#  define cpu_is_omap7xx()		is_omap7xx()
> +# endif
>  # if defined(CONFIG_ARCH_OMAP15XX)
>  #  undef  cpu_is_omap15xx
>  #  define cpu_is_omap15xx()		is_omap15xx()
> @@ -166,6 +178,10 @@ IS_OMAP_SUBCLASS(343x, 0x343)
>  #  undef  cpu_is_omap7xx
>  #  define cpu_is_omap7xx()		1
>  # endif
> +# if defined(CONFIG_ARCH_OMAP850)
> +#  undef  cpu_is_omap7xx
> +#  define cpu_is_omap7xx()		1
> +# endif
>  # if defined(CONFIG_ARCH_OMAP15XX)
>  #  undef  cpu_is_omap15xx
>  #  define cpu_is_omap15xx()		1
> @@ -219,6 +235,7 @@ IS_OMAP_SUBCLASS(343x, 0x343)
>   * These are only rarely needed.
>   * cpu_is_omap330():	True for OMAP330
>   * cpu_is_omap730():	True for OMAP730
> + * cpu_is_omap850():	True for OMAP850
>   * cpu_is_omap1510():	True for OMAP1510
>   * cpu_is_omap1610():	True for OMAP1610
>   * cpu_is_omap1611():	True for OMAP1611
> @@ -241,6 +258,7 @@ static inline int is_omap ##type (void)			\
>  
>  IS_OMAP_TYPE(310, 0x0310)
>  IS_OMAP_TYPE(730, 0x0730)
> +IS_OMAP_TYPE(850, 0x0850)
>  IS_OMAP_TYPE(1510, 0x1510)
>  IS_OMAP_TYPE(1610, 0x1610)
>  IS_OMAP_TYPE(1611, 0x1611)
> @@ -255,6 +273,7 @@ IS_OMAP_TYPE(3430, 0x3430)
>  
>  #define cpu_is_omap310()		0
>  #define cpu_is_omap730()		0
> +#define cpu_is_omap850()		0
>  #define cpu_is_omap1510()		0
>  #define cpu_is_omap1610()		0
>  #define cpu_is_omap5912()		0
> @@ -272,12 +291,22 @@ IS_OMAP_TYPE(3430, 0x3430)
>  #  undef  cpu_is_omap730
>  #  define cpu_is_omap730()		is_omap730()
>  # endif
> +# if defined(CONFIG_ARCH_OMAP850)
> +#  undef  cpu_is_omap850
> +#  define cpu_is_omap850()		is_omap850()
> +# endif
>  #else
>  # if defined(CONFIG_ARCH_OMAP730)
>  #  undef  cpu_is_omap730
>  #  define cpu_is_omap730()		1
>  # endif
>  #endif
> +#else
> +# if defined(CONFIG_ARCH_OMAP850)
> +#  undef  cpu_is_omap850
> +#  define cpu_is_omap850()		1
> +# endif
> +#endif
>  
>  /*
>   * Whether we have MULTI_OMAP1 or not, we still need to distinguish
> @@ -320,7 +349,7 @@ IS_OMAP_TYPE(3430, 0x3430)
>  #endif
>  
>  /* Macros to detect if we have OMAP1 or OMAP2 */
> -#define cpu_class_is_omap1()	(cpu_is_omap730() || cpu_is_omap15xx() || \
> +#define cpu_class_is_omap1()	(cpu_is_omap7xx() || cpu_is_omap15xx() || \
>  				cpu_is_omap16xx())
>  #define cpu_class_is_omap2()	(cpu_is_omap24xx() || cpu_is_omap34xx())
>  
> @@ -378,5 +407,3 @@ int omap_type(void);
>  void omap2_check_revision(void);
>  
>  #endif    /* defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) */
> -
> -#endif
> diff --git a/arch/arm/plat-omap/include/mach/omap850.h b/arch/arm/plat-omap/include/mach/omap850.h
> new file mode 100644
> index 0000000..c33f679
> --- /dev/null
> +++ b/arch/arm/plat-omap/include/mach/omap850.h
> @@ -0,0 +1,102 @@
> +/* arch/arm/plat-omap/include/mach/omap850.h
> + *
> + * Hardware definitions for TI OMAP850 processor.
> + *
> + * Derived from omap730.h by Zebediah C. McClure <zmc@lurian.net>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or (at your
> + * option) any later version.
> + *
> + * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
> + * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
> + * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
> + * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
> + * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> + * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
> + * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
> + * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
> + * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + *
> + * You should have received a copy of the  GNU General Public License along
> + * with this program; if not, write  to the Free Software Foundation, Inc.,
> + * 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#ifndef __ASM_ARCH_OMAP850_H
> +#define __ASM_ARCH_OMAP850_H
> +
> +/*
> + * ----------------------------------------------------------------------------
> + * Base addresses
> + * ----------------------------------------------------------------------------
> + */
> +
> +/* Syntax: XX_BASE = Virtual base address, XX_START = Physical base address */
> +
> +#define OMAP850_DSP_BASE	0xE0000000
> +#define OMAP850_DSP_SIZE	0x50000
> +#define OMAP850_DSP_START	0xE0000000
> +
> +#define OMAP850_DSPREG_BASE	0xE1000000
> +#define OMAP850_DSPREG_SIZE	SZ_128K
> +#define OMAP850_DSPREG_START	0xE1000000
> +
> +/*
> + * ----------------------------------------------------------------------------
> + * OMAP850 specific configuration registers
> + * ----------------------------------------------------------------------------
> + */
> +#define OMAP850_CONFIG_BASE	0xfffe1000
> +#define OMAP850_IO_CONF_0	0xfffe1070
> +#define OMAP850_IO_CONF_1	0xfffe1074
> +#define OMAP850_IO_CONF_2	0xfffe1078
> +#define OMAP850_IO_CONF_3	0xfffe107c
> +#define OMAP850_IO_CONF_4	0xfffe1080
> +#define OMAP850_IO_CONF_5	0xfffe1084
> +#define OMAP850_IO_CONF_6	0xfffe1088
> +#define OMAP850_IO_CONF_7	0xfffe108c
> +#define OMAP850_IO_CONF_8	0xfffe1090
> +#define OMAP850_IO_CONF_9	0xfffe1094
> +#define OMAP850_IO_CONF_10	0xfffe1098
> +#define OMAP850_IO_CONF_11	0xfffe109c
> +#define OMAP850_IO_CONF_12	0xfffe10a0
> +#define OMAP850_IO_CONF_13	0xfffe10a4
> +
> +#define OMAP850_MODE_1		0xfffe1010
> +#define OMAP850_MODE_2		0xfffe1014
> +
> +/* CSMI specials: in terms of base + offset */
> +#define OMAP850_MODE2_OFFSET	0x14
> +
> +/*
> + * ----------------------------------------------------------------------------
> + * OMAP850 traffic controller configuration registers
> + * ----------------------------------------------------------------------------
> + */
> +#define OMAP850_FLASH_CFG_0	0xfffecc10
> +#define OMAP850_FLASH_ACFG_0	0xfffecc50
> +#define OMAP850_FLASH_CFG_1	0xfffecc14
> +#define OMAP850_FLASH_ACFG_1	0xfffecc54
> +
> +/*
> + * ----------------------------------------------------------------------------
> + * OMAP850 DSP control registers
> + * ----------------------------------------------------------------------------
> + */
> +#define OMAP850_ICR_BASE	0xfffbb800
> +#define OMAP850_DSP_M_CTL	0xfffbb804
> +#define OMAP850_DSP_MMU_BASE	0xfffed200
> +
> +/*
> + * ----------------------------------------------------------------------------
> + * OMAP850 PCC_UPLD configuration registers
> + * ----------------------------------------------------------------------------
> + */
> +#define OMAP850_PCC_UPLD_CTRL_BASE	(0xfffe0900)
> +#define OMAP850_PCC_UPLD_CTRL		(OMAP850_PCC_UPLD_CTRL_BASE + 0x00)
> +
> +#endif /*  __ASM_ARCH_OMAP850_H */
> +
> -- 
> 1.6.0.6
> 

> From 431adabb83526da0d3e3e8e7a9ddf8a59209851b Mon Sep 17 00:00:00 2001
> From: Zebediah C. McClure <zmc@lurian.net>
> Date: Sat, 24 Jan 2009 14:25:11 -0400
> Subject: [PATCH] [OMAP850] Changes to clock framework.
> 
> 
> Signed-off-by: Zebediah C. McClure <zmc@lurian.net>
> ---
>  arch/arm/mach-omap1/clock.c             |   17 +++++++++++------
>  arch/arm/mach-omap1/clock.h             |   18 +++++++++++-------
>  arch/arm/plat-omap/common.c             |    2 +-
>  arch/arm/plat-omap/include/mach/clock.h |    1 +
>  4 files changed, 24 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
> index 5fba207..f2e1ee5 100644
> --- a/arch/arm/mach-omap1/clock.c
> +++ b/arch/arm/mach-omap1/clock.c
> @@ -281,9 +281,9 @@ static int omap1_select_table_rate(struct clk * clk, unsigned long rate)
>  	/*
>  	 * In most cases we should not need to reprogram DPLL.
>  	 * Reprogramming the DPLL is tricky, it must be done from SRAM.
> -	 * (on 730, bit 13 must always be 1)
> +	 * (on 730 and 850, bit 13 must always be 1)
>  	 */
> -	if (cpu_is_omap730())
> +	if (cpu_is_omap7xx())
>  		omap_sram_reprogram_clock(ptr->dpllctl_val, ptr->ckctl_val | 0x2000);
>  	else
>  		omap_sram_reprogram_clock(ptr->dpllctl_val, ptr->ckctl_val);
> @@ -716,6 +716,11 @@ int __init omap1_clk_init(void)
>  			continue;
>  		}
>  
> +		if (((*clkp)->flags &CLOCK_IN_OMAP850) && cpu_is_omap850()) {
> +			clk_register(*clkp);
> +			continue;
> +		}
> +
>  		if (((*clkp)->flags &CLOCK_IN_OMAP310) && cpu_is_omap310()) {
>  			clk_register(*clkp);
>  			continue;
> @@ -728,7 +733,7 @@ int __init omap1_clk_init(void)
>  			crystal_type = info->system_clock_type;
>  	}
>  
> -#if defined(CONFIG_ARCH_OMAP730)
> +#if (defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850))
>  	ck_ref.rate = 13000000;
>  #elif defined(CONFIG_ARCH_OMAP16XX)
>  	if (crystal_type == 2)
> @@ -776,7 +781,7 @@ int __init omap1_clk_init(void)
>  		printk(KERN_ERR "System frequencies not set. Check your config.\n");
>  		/* Guess sane values (60MHz) */
>  		omap_writew(0x2290, DPLL_CTL);
> -		omap_writew(cpu_is_omap730() ? 0x3005 : 0x1005, ARM_CKCTL);
> +		omap_writew((cpu_is_omap7xx()) ? 0x3005 : 0x1005, ARM_CKCTL);
>  		ck_dpll1.rate = 60000000;
>  		propagate_rate(&ck_dpll1);
>  	}
> @@ -801,8 +806,8 @@ int __init omap1_clk_init(void)
>  				ULPD_CLOCK_CTRL);
>  
>  	/* Turn off DSP and ARM_TIMXO. Make sure ARM_INTHCK is not divided */
> -	/* (on 730, bit 13 must not be cleared) */
> -	if (cpu_is_omap730())
> +	/* (on 730/850, bit 13 must not be cleared) */
> +	if (cpu_is_omap7xx())
>  		omap_writew(omap_readw(ARM_CKCTL) & 0x2fff, ARM_CKCTL);
>  	else
>  		omap_writew(omap_readw(ARM_CKCTL) & 0x0fff, ARM_CKCTL);
> diff --git a/arch/arm/mach-omap1/clock.h b/arch/arm/mach-omap1/clock.h
> index c1dcdf1..4da9b8e 100644
> --- a/arch/arm/mach-omap1/clock.h
> +++ b/arch/arm/mach-omap1/clock.h
> @@ -154,7 +154,7 @@ static struct clk ck_ref = {
>  	.name		= "ck_ref",
>  	.rate		= 12000000,
>  	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
> -			  CLOCK_IN_OMAP310 | ALWAYS_ENABLED,
> +			  CLOCK_IN_OMAP310 | CLOCK_IN_OMAP850 | ALWAYS_ENABLED,
>  	.enable		= &omap1_clk_enable_generic,
>  	.disable	= &omap1_clk_disable_generic,
>  };
> @@ -241,7 +241,8 @@ static struct arm_idlect1_clk armxor_ck = {
>  		.name		= "armxor_ck",
>  		.parent		= &ck_ref,
>  		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
> -				  CLOCK_IN_OMAP310 | CLOCK_IDLE_CONTROL,
> +				  CLOCK_IN_OMAP310 | CLOCK_IN_OMAP850 |
> +				  CLOCK_IDLE_CONTROL,
>  		.enable_reg	= (void __iomem *)ARM_IDLECT2,
>  		.enable_bit	= EN_XORPCK,
>  		.recalc		= &followparent_recalc,
> @@ -363,9 +364,10 @@ static struct arm_idlect1_clk tc_ck = {
>  		.name		= "tc_ck",
>  		.parent		= &ck_dpll1,
>  		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
> -				  CLOCK_IN_OMAP730 | CLOCK_IN_OMAP310 |
> -				  RATE_CKCTL | RATE_PROPAGATES |
> -				  ALWAYS_ENABLED | CLOCK_IDLE_CONTROL,
> +				  CLOCK_IN_OMAP730 | CLOCK_IN_OMAP850 |
> +				  CLOCK_IN_OMAP310 | RATE_CKCTL |
> +				  RATE_PROPAGATES | ALWAYS_ENABLED |
> +				  CLOCK_IDLE_CONTROL,
>  		.rate_offset	= CKCTL_TCDIV_OFFSET,
>  		.recalc		= &omap1_ckctl_recalc,
>  		.enable		= &omap1_clk_enable_generic,
> @@ -504,7 +506,8 @@ static struct clk rhea2_ck = {
>  static struct clk lcd_ck_16xx = {
>  	.name		= "lcd_ck",
>  	.parent		= &ck_dpll1,
> -	.flags		= CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP730 | RATE_CKCTL,
> +	.flags		= CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP730 |
> +			  CLOCK_IN_OMAP850 | RATE_CKCTL,
>  	.enable_reg	= (void __iomem *)ARM_IDLECT2,
>  	.enable_bit	= EN_LCDCK,
>  	.rate_offset	= CKCTL_LCDDIV_OFFSET,
> @@ -734,7 +737,8 @@ static struct clk mmc2_ck = {
>  static struct clk virtual_ck_mpu = {
>  	.name		= "mpu",
>  	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
> -			  CLOCK_IN_OMAP310 | VIRTUAL_CLOCK | ALWAYS_ENABLED,
> +			  CLOCK_IN_OMAP850 | CLOCK_IN_OMAP310 |
> +			  VIRTUAL_CLOCK | ALWAYS_ENABLED,
>  	.parent		= &arm_ck, /* Is smarter alias for */
>  	.recalc		= &followparent_recalc,
>  	.set_rate	= &omap1_select_table_rate,
> diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
> index 0843b88..39921d2 100644
> --- a/arch/arm/plat-omap/common.c
> +++ b/arch/arm/plat-omap/common.c
> @@ -170,7 +170,7 @@ console_initcall(omap_add_serial_console);
>  
>  /*
>   * 32KHz clocksource ... always available, on pretty most chips except
> - * OMAP 730 and 1510.  Other timers could be used as clocksources, with
> + * OMAP 730, 850 and 1510.  Other timers could be used as clocksources, with
>   * higher resolution in free-running counter modes (e.g. 12 MHz xtal),
>   * but systems won't necessarily want to spend resources that way.
>   */
> diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
> index 7192985..4fde485 100644
> --- a/arch/arm/plat-omap/include/mach/clock.h
> +++ b/arch/arm/plat-omap/include/mach/clock.h
> @@ -138,6 +138,7 @@ extern void clk_enable_init_clocks(void);
>  /* bits 13-20 are currently free */
>  #define CLOCK_IN_OMAP310	(1 << 21)
>  #define CLOCK_IN_OMAP730	(1 << 22)
> +#define CLOCK_IN_OMAP850	(1 << 22)
>  #define CLOCK_IN_OMAP1510	(1 << 23)
>  #define CLOCK_IN_OMAP16XX	(1 << 24)
>  #define CLOCK_IN_OMAP242X	(1 << 25)
> -- 
> 1.6.0.6
> 

> From a56a3f605e35d05f139be1940f6d22ecc46765e6 Mon Sep 17 00:00:00 2001
> From: Zebediah C. McClure <zmc@lurian.net>
> Date: Sat, 24 Jan 2009 14:26:01 -0400
> Subject: [PATCH] [OMAP850] Changes to base IO subsystems.
> 
> 
> Signed-off-by: Zebediah C. McClure <zmc@lurian.net>
> ---
>  arch/arm/mach-omap1/io.c               |   23 +++++++
>  arch/arm/mach-omap1/mux.c              |   24 +++++++
>  arch/arm/mach-omap1/serial.c           |    7 ++
>  arch/arm/plat-omap/gpio.c              |  109 ++++++++++++++++++++++++++++++--
>  arch/arm/plat-omap/include/mach/gpio.h |    3 +-
>  arch/arm/plat-omap/include/mach/mux.h  |   52 +++++++++++++++-
>  6 files changed, 211 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/io.c b/arch/arm/mach-omap1/io.c
> index 4c3e582..3afe540 100644
> --- a/arch/arm/mach-omap1/io.c
> +++ b/arch/arm/mach-omap1/io.c
> @@ -52,6 +52,22 @@ static struct map_desc omap730_io_desc[] __initdata = {
>  };
>  #endif
>  
> +#ifdef CONFIG_ARCH_OMAP850
> +static struct map_desc omap850_io_desc[] __initdata = {
> +	{
> +		.virtual	= OMAP850_DSP_BASE,
> +		.pfn		= __phys_to_pfn(OMAP850_DSP_START),
> +		.length		= OMAP850_DSP_SIZE,
> +		.type		= MT_DEVICE
> +	}, {
> +		.virtual	= OMAP850_DSPREG_BASE,
> +		.pfn		= __phys_to_pfn(OMAP850_DSPREG_START),
> +		.length		= OMAP850_DSPREG_SIZE,
> +		.type		= MT_DEVICE
> +	}
> +};
> +#endif
> +
>  #ifdef CONFIG_ARCH_OMAP15XX
>  static struct map_desc omap1510_io_desc[] __initdata = {
>  	{
> @@ -109,6 +125,13 @@ void __init omap1_map_common_io(void)
>  		iotable_init(omap730_io_desc, ARRAY_SIZE(omap730_io_desc));
>  	}
>  #endif
> +
> +#ifdef CONFIG_ARCH_OMAP850
> +	if (cpu_is_omap850()) {
> +		iotable_init(omap850_io_desc, ARRAY_SIZE(omap850_io_desc));
> +	}
> +#endif
> +
>  #ifdef CONFIG_ARCH_OMAP15XX
>  	if (cpu_is_omap15xx()) {
>  		iotable_init(omap1510_io_desc, ARRAY_SIZE(omap1510_io_desc));
> diff --git a/arch/arm/mach-omap1/mux.c b/arch/arm/mach-omap1/mux.c
> index 062c905..721e0d9 100644
> --- a/arch/arm/mach-omap1/mux.c
> +++ b/arch/arm/mach-omap1/mux.c
> @@ -58,6 +58,25 @@ MUX_CFG_730("W17_730_USB_VBUSI",   2,   29,    0,   28,   0, 0)
>  #define OMAP730_PINS_SZ		0
>  #endif	/* CONFIG_ARCH_OMAP730 */
>  
> +#ifdef CONFIG_ARCH_OMAP850
> +struct pin_config __initdata_or_module omap850_pins[] = {
> +MUX_CFG_850("E2_850_KBR0",        12,   21,    0,   20,   1, 0)
> +MUX_CFG_850("J7_850_KBR1",        12,   25,    0,   24,   1, 0)
> +MUX_CFG_850("E1_850_KBR2",        12,   29,    0,   28,   1, 0)
> +MUX_CFG_850("F3_850_KBR3",        13,    1,    0,    0,   1, 0)
> +MUX_CFG_850("D2_850_KBR4",        13,    5,    0,    4,   1, 0)
> +MUX_CFG_850("C2_850_KBC0",        13,    9,    0,    8,   1, 0)
> +MUX_CFG_850("D3_850_KBC1",        13,   13,    0,   12,   1, 0)
> +MUX_CFG_850("E4_850_KBC2",        13,   17,    0,   16,   1, 0)
> +MUX_CFG_850("F4_850_KBC3",        13,   21,    0,   20,   1, 0)
> +MUX_CFG_850("E3_850_KBC4",        13,   25,    0,   24,   1, 0)
> +
> +MUX_CFG_850("AA17_850_USB_DM",     2,   21,    0,   20,   0, 0)
> +MUX_CFG_850("W16_850_USB_PU_EN",   2,   25,    0,   24,   0, 0)
> +MUX_CFG_850("W17_850_USB_VBUSI",   2,   29,    0,   28,   0, 0)
> +};
> +#endif
> +
>  #if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX)
>  static struct pin_config __initdata_or_module omap1xxx_pins[] = {
>  /*
> @@ -419,6 +438,11 @@ int __init_or_module omap1_cfg_reg(const struct pin_config *cfg)
>  			printk("      %s (0x%08x) = 0x%08x -> 0x%08x\n",
>  			       cfg->pull_name, cfg->pull_reg, pull_orig, pull);
>  	}
> +
> +#ifdef CONFIG_ARCH_OMAP850
> +	omap_mux_register(omap850_pins, ARRAY_SIZE(omap850_pins));
> +#endif
> +
>  #endif
>  
>  #ifdef CONFIG_OMAP_MUX_ERRORS
> diff --git a/arch/arm/mach-omap1/serial.c b/arch/arm/mach-omap1/serial.c
> index 0002084..842090b 100644
> --- a/arch/arm/mach-omap1/serial.c
> +++ b/arch/arm/mach-omap1/serial.c
> @@ -121,6 +121,13 @@ void __init omap_serial_init(void)
>  		serial_platform_data[1].irq = INT_730_UART_MODEM_IRDA_2;
>  	}
>  
> +	if (cpu_is_omap850()) {
> +		serial_platform_data[0].regshift = 0;
> +		serial_platform_data[1].regshift = 0;
> +		serial_platform_data[0].irq = INT_850_UART_MODEM_1;
> +		serial_platform_data[1].irq = INT_850_UART_MODEM_IRDA_2;
> +	}
> +
>  	if (cpu_is_omap15xx()) {
>  		serial_platform_data[0].uartclk = OMAP1510_BASE_BAUD * 16;
>  		serial_platform_data[1].uartclk = OMAP1510_BASE_BAUD * 16;
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index f856a90..8bb9c8d 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -81,6 +81,22 @@
>  #define OMAP730_GPIO_INT_STATUS		0x14
>  
>  /*
> + * OMAP850 specific GPIO registers
> + */
> +#define OMAP850_GPIO1_BASE		(void __iomem *)0xfffbc000
> +#define OMAP850_GPIO2_BASE		(void __iomem *)0xfffbc800
> +#define OMAP850_GPIO3_BASE		(void __iomem *)0xfffbd000
> +#define OMAP850_GPIO4_BASE		(void __iomem *)0xfffbd800
> +#define OMAP850_GPIO5_BASE		(void __iomem *)0xfffbe000
> +#define OMAP850_GPIO6_BASE		(void __iomem *)0xfffbe800
> +#define OMAP850_GPIO_DATA_INPUT		0x00
> +#define OMAP850_GPIO_DATA_OUTPUT	0x04
> +#define OMAP850_GPIO_DIR_CONTROL	0x08
> +#define OMAP850_GPIO_INT_CONTROL	0x0c
> +#define OMAP850_GPIO_INT_MASK		0x10
> +#define OMAP850_GPIO_INT_STATUS		0x14
> +
> +/*
>   * omap24xx specific GPIO registers
>   */
>  #define OMAP242X_GPIO1_BASE		IO_ADDRESS(0x48018000)
> @@ -159,6 +175,7 @@ struct gpio_bank {
>  #define METHOD_GPIO_1510	1
>  #define METHOD_GPIO_1610	2
>  #define METHOD_GPIO_730		3
> +#define METHOD_GPIO_850		3
>  #define METHOD_GPIO_24XX	4
>  
>  #ifdef CONFIG_ARCH_OMAP16XX
> @@ -190,6 +207,19 @@ static struct gpio_bank gpio_bank_730[7] = {
>  };
>  #endif
>  
> +#ifdef CONFIG_ARCH_OMAP850
> +static struct gpio_bank gpio_bank_850[7] = {
> +	{ OMAP_MPUIO_BASE,     INT_850_MPUIO,	    IH_MPUIO_BASE,	METHOD_MPUIO },
> +	{ OMAP850_GPIO1_BASE,  INT_850_GPIO_BANK1,  IH_GPIO_BASE,	METHOD_GPIO_850 },
> +	{ OMAP850_GPIO2_BASE,  INT_850_GPIO_BANK2,  IH_GPIO_BASE + 32,	METHOD_GPIO_850 },
> +	{ OMAP850_GPIO3_BASE,  INT_850_GPIO_BANK3,  IH_GPIO_BASE + 64,	METHOD_GPIO_850 },
> +	{ OMAP850_GPIO4_BASE,  INT_850_GPIO_BANK4,  IH_GPIO_BASE + 96,	METHOD_GPIO_850 },
> +	{ OMAP850_GPIO5_BASE,  INT_850_GPIO_BANK5,  IH_GPIO_BASE + 128, METHOD_GPIO_850 },
> +	{ OMAP850_GPIO6_BASE,  INT_850_GPIO_BANK6,  IH_GPIO_BASE + 160, METHOD_GPIO_850 },
> +};
> +#endif
> +
> +
>  #ifdef CONFIG_ARCH_OMAP24XX
>  
>  static struct gpio_bank gpio_bank_242x[4] = {
> @@ -236,7 +266,7 @@ static inline struct gpio_bank *get_gpio_bank(int gpio)
>  			return &gpio_bank[0];
>  		return &gpio_bank[1 + (gpio >> 4)];
>  	}
> -	if (cpu_is_omap730()) {
> +	if (cpu_is_omap7xx()) {
>  		if (OMAP_GPIO_IS_MPUIO(gpio))
>  			return &gpio_bank[0];
>  		return &gpio_bank[1 + (gpio >> 5)];
> @@ -251,7 +281,7 @@ static inline struct gpio_bank *get_gpio_bank(int gpio)
>  
>  static inline int get_gpio_index(int gpio)
>  {
> -	if (cpu_is_omap730())
> +	if (cpu_is_omap7xx())
>  		return gpio & 0x1f;
>  	if (cpu_is_omap24xx())
>  		return gpio & 0x1f;
> @@ -273,7 +303,7 @@ static inline int gpio_valid(int gpio)
>  		return 0;
>  	if ((cpu_is_omap16xx()) && gpio < 64)
>  		return 0;
> -	if (cpu_is_omap730() && gpio < 192)
> +	if (cpu_is_omap7xx() && gpio < 192)
>  		return 0;
>  	if (cpu_is_omap24xx() && gpio < 128)
>  		return 0;
> @@ -318,6 +348,11 @@ static void _set_gpio_direction(struct gpio_bank *bank, int gpio, int is_input)
>  		reg += OMAP730_GPIO_DIR_CONTROL;
>  		break;
>  #endif
> +#ifdef CONFIG_ARCH_OMAP850
> +	case METHOD_GPIO_850:
> +		reg += OMAP850_GPIO_DIR_CONTROL;
> +		break;
> +#endif
>  #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
>  	case METHOD_GPIO_24XX:
>  		reg += OMAP24XX_GPIO_OE;
> @@ -380,6 +415,16 @@ static void _set_gpio_dataout(struct gpio_bank *bank, int gpio, int enable)
>  			l &= ~(1 << gpio);
>  		break;
>  #endif
> +#ifdef CONFIG_ARCH_OMAP850
> +	case METHOD_GPIO_850:
> +		reg += OMAP850_GPIO_DATA_OUTPUT;
> +		l = __raw_readl(reg);
> +		if (enable)
> +			l |= 1 << gpio;
> +		else
> +			l &= ~(1 << gpio);
> +		break;
> +#endif
>  #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
>  	case METHOD_GPIO_24XX:
>  		if (enable)
> @@ -426,6 +471,11 @@ static int __omap_get_gpio_datain(int gpio)
>  		reg += OMAP730_GPIO_DATA_INPUT;
>  		break;
>  #endif
> +#ifdef CONFIG_ARCH_OMAP850
> +	case METHOD_GPIO_850:
> +		reg += OMAP850_GPIO_DATA_INPUT;
> +		break;
> +#endif
>  #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
>  	case METHOD_GPIO_24XX:
>  		reg += OMAP24XX_GPIO_DATAIN;
> @@ -598,6 +648,18 @@ static int _set_gpio_triggering(struct gpio_bank *bank, int gpio, int trigger)
>  			goto bad;
>  		break;
>  #endif
> +#ifdef CONFIG_ARCH_OMAP850
> +	case METHOD_GPIO_850:
> +		reg += OMAP850_GPIO_INT_CONTROL;
> +		l = __raw_readl(reg);
> +		if (trigger & IRQ_TYPE_EDGE_RISING)
> +			l |= 1 << gpio;
> +		else if (trigger & IRQ_TYPE_EDGE_FALLING)
> +			l &= ~(1 << gpio);
> +		else
> +			goto bad;
> +		break;
> +#endif
>  #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
>  	case METHOD_GPIO_24XX:
>  		set_24xx_gpio_triggering(bank, gpio, trigger);
> @@ -678,6 +740,11 @@ static void _clear_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
>  		reg += OMAP730_GPIO_INT_STATUS;
>  		break;
>  #endif
> +#ifdef CONFIG_ARCH_OMAP850
> +	case METHOD_GPIO_850:
> +		reg += OMAP850_GPIO_INT_STATUS;
> +		break;
> +#endif
>  #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
>  	case METHOD_GPIO_24XX:
>  		reg += OMAP24XX_GPIO_IRQSTATUS1;
> @@ -736,6 +803,13 @@ static u32 _get_gpio_irqbank_mask(struct gpio_bank *bank)
>  		inv = 1;
>  		break;
>  #endif
> +#ifdef CONFIG_ARCH_OMAP850
> +	case METHOD_GPIO_850:
> +		reg += OMAP850_GPIO_INT_MASK;
> +		mask = 0xffffffff;
> +		inv = 1;
> +		break;
> +#endif
>  #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
>  	case METHOD_GPIO_24XX:
>  		reg += OMAP24XX_GPIO_IRQENABLE1;
> @@ -799,6 +873,16 @@ static void _enable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask, int enab
>  			l |= gpio_mask;
>  		break;
>  #endif
> +#ifdef CONFIG_ARCH_OMAP850
> +	case METHOD_GPIO_850:
> +		reg += OMAP850_GPIO_INT_MASK;
> +		l = __raw_readl(reg);
> +		if (enable)
> +			l &= ~(gpio_mask);
> +		else
> +			l |= gpio_mask;
> +		break;
> +#endif
>  #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
>  	case METHOD_GPIO_24XX:
>  		if (enable)
> @@ -983,6 +1067,10 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
>  	if (bank->method == METHOD_GPIO_730)
>  		isr_reg = bank->base + OMAP730_GPIO_INT_STATUS;
>  #endif
> +#ifdef CONFIG_ARCH_OMAP850
> +	if (bank->method == METHOD_GPIO_850)
> +		isr_reg = bank->base + OMAP850_GPIO_INT_STATUS;
> +#endif
>  #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
>  	if (bank->method == METHOD_GPIO_24XX)
>  		isr_reg = bank->base + OMAP24XX_GPIO_IRQSTATUS1;
> @@ -1372,6 +1460,13 @@ static int __init _omap_gpio_init(void)
>  		gpio_bank = gpio_bank_730;
>  	}
>  #endif
> +#ifdef CONFIG_ARCH_OMAP850
> +	if (cpu_is_omap850()) {
> +		printk(KERN_INFO "OMAP850 GPIO hardware\n");
> +		gpio_bank_count = 7;
> +		gpio_bank = gpio_bank_850;
> +	}
> +#endif
>  
>  #ifdef CONFIG_ARCH_OMAP24XX
>  	if (cpu_is_omap242x()) {
> @@ -1420,7 +1515,7 @@ static int __init _omap_gpio_init(void)
>  			__raw_writew(0xffff, bank->base + OMAP1610_GPIO_IRQSTATUS1);
>  			__raw_writew(0x0014, bank->base + OMAP1610_GPIO_SYSCONFIG);
>  		}
> -		if (cpu_is_omap730() && bank->method == METHOD_GPIO_730) {
> +		if (cpu_is_omap7xx() && bank->method == METHOD_GPIO_730) {
>  			__raw_writel(0xffffffff, bank->base + OMAP730_GPIO_INT_MASK);
>  			__raw_writel(0x00000000, bank->base + OMAP730_GPIO_INT_STATUS);
>  
> @@ -1743,6 +1838,9 @@ static int gpio_is_input(struct gpio_bank *bank, int mask)
>  	case METHOD_GPIO_730:
>  		reg += OMAP730_GPIO_DIR_CONTROL;
>  		break;
> +	case METHOD_GPIO_850:
> +		reg += OMAP850_GPIO_DIR_CONTROL;
> +		break;
>  	case METHOD_GPIO_24XX:
>  		reg += OMAP24XX_GPIO_OE;
>  		break;
> @@ -1762,7 +1860,8 @@ static int dbg_gpio_show(struct seq_file *s, void *unused)
>  
>  		if (bank_is_mpuio(bank))
>  			gpio = OMAP_MPUIO(0);
> -		else if (cpu_class_is_omap2() || cpu_is_omap730())
> +		else if (cpu_class_is_omap2() || cpu_is_omap730() ||\
> +			 cpu_is_omap850 ())
>  			bankwidth = 32;
>  
>  		for (j = 0; j < bankwidth; j++, gpio++, mask <<= 1) {
> diff --git a/arch/arm/plat-omap/include/mach/gpio.h b/arch/arm/plat-omap/include/mach/gpio.h
> index 8d9dfe3..2b22a87 100644
> --- a/arch/arm/plat-omap/include/mach/gpio.h
> +++ b/arch/arm/plat-omap/include/mach/gpio.h
> @@ -31,7 +31,8 @@
>  
>  #define OMAP_MPUIO_BASE			0xfffb5000
>  
> -#ifdef CONFIG_ARCH_OMAP730
> +#if (defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850))
> +
>  #define OMAP_MPUIO_INPUT_LATCH		0x00
>  #define OMAP_MPUIO_OUTPUT		0x02
>  #define OMAP_MPUIO_IO_CNTL		0x04
> diff --git a/arch/arm/plat-omap/include/mach/mux.h b/arch/arm/plat-omap/include/mach/mux.h
> index f4362b8..6a02f8f 100644
> --- a/arch/arm/plat-omap/include/mach/mux.h
> +++ b/arch/arm/plat-omap/include/mach/mux.h
> @@ -61,6 +61,16 @@
>  					.pull_bit = bit, \
>  					.pull_val = status,
>  
> +#define MUX_REG_850(reg, mode_offset, mode) .mux_reg_name = "OMAP850_IO_CONF_"#reg, \
> +					.mux_reg = OMAP850_IO_CONF_##reg, \
> +					.mask_offset = mode_offset, \
> +					.mask = mode,
> +
> +#define PULL_REG_850(reg, bit, status)	.pull_name = "OMAP850_IO_CONF_"#reg, \
> +					.pull_reg = OMAP850_IO_CONF_##reg, \
> +					.pull_bit = bit, \
> +					.pull_val = status,
> +
>  #else
>  
>  #define MUX_REG(reg, mode_offset, mode) .mux_reg = FUNC_MUX_CTRL_##reg, \
> @@ -83,6 +93,15 @@
>  					.pull_bit = bit, \
>  					.pull_val = status,
>  
> +#define MUX_REG_850(reg, mode_offset, mode) \
> +					.mux_reg = OMAP850_IO_CONF_##reg, \
> +					.mask_offset = mode_offset, \
> +					.mask = mode,
> +
> +#define PULL_REG_850(reg, bit, status)	.pull_reg = OMAP850_IO_CONF_##reg, \
> +					.pull_bit = bit, \
> +					.pull_val = status,
> +
>  #endif /* CONFIG_OMAP_MUX_DEBUG */
>  
>  #define MUX_CFG(desc, mux_reg, mode_offset, mode,	\
> @@ -98,7 +117,7 @@
>  
>  
>  /*
> - * OMAP730 has a slightly different config for the pin mux.
> + * OMAP730/850 has a slightly different config for the pin mux.
>   * - config regs are the OMAP730_IO_CONF_x regs (see omap730.h) regs and
>   *   not the FUNC_MUX_CTRL_x regs from hardware.h
>   * - for pull-up/down, only has one enable bit which is is in the same register
> @@ -114,6 +133,17 @@
>  	PU_PD_REG(NA, 0)		\
>  },
>  
> +#define MUX_CFG_850(desc, mux_reg, mode_offset, mode,	\
> +		   pull_bit, pull_status, debug_status)\
> +{							\
> +	.name =	 desc,					\
> +	.debug = debug_status,				\
> +	MUX_REG_850(mux_reg, mode_offset, mode)		\
> +	PULL_REG_850(mux_reg, pull_bit, pull_status)	\
> +	PU_PD_REG(NA, 0)		\
> +},
> +
> +
>  #define MUX_CFG_24XX(desc, reg_offset, mode,			\
>  				pull_en, pull_mode, dbg)	\
>  {								\
> @@ -221,6 +251,26 @@ enum omap730_index {
>  	W17_730_USB_VBUSI,
>  };
>  
> +enum omap850_index {
> +	/* OMAP 850 keyboard */
> +	E2_850_KBR0,
> +	J7_850_KBR1,
> +	E1_850_KBR2,
> +	F3_850_KBR3,
> +	D2_850_KBR4,
> +	C2_850_KBC0,
> +	D3_850_KBC1,
> +	E4_850_KBC2,
> +	F4_850_KBC3,
> +	E3_850_KBC4,
> +
> +	/* USB */
> +	AA17_850_USB_DM,
> +	W16_850_USB_PU_EN,
> +	W17_850_USB_VBUSI,
> +};
> +
> +
>  enum omap1xxx_index {
>  	/* UART1 (BT_UART_GATING)*/
>  	UART1_TX = 0,
> -- 
> 1.6.0.6
> 

> From 6b60e815d887367d47c66d9e31ed92fbaf007833 Mon Sep 17 00:00:00 2001
> From: Zebediah C. McClure <zmc@lurian.net>
> Date: Sat, 24 Jan 2009 14:27:33 -0400
> Subject: [PATCH] [OMAP850] Changes to memory subsystems.
> 
> 
> Signed-off-by: Zebediah C. McClure <zmc@lurian.net>
> ---
>  arch/arm/plat-omap/dma.c  |    4 ++--
>  arch/arm/plat-omap/sram.c |    2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index 47ec77a..dcc9e83 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -737,7 +737,7 @@ int omap_request_dma(int dev_id, const char *dev_name,
>  		 * id.
>  		 */
>  		dma_write(dev_id | (1 << 10), CCR(free_ch));
> -	} else if (cpu_is_omap730() || cpu_is_omap15xx()) {
> +	} else if (cpu_is_omap7xx() || cpu_is_omap15xx()) {
>  		dma_write(dev_id, CCR(free_ch));
>  	}
>  
> @@ -2339,7 +2339,7 @@ static int __init omap_init_dma(void)
>  		printk(KERN_INFO "DMA support for OMAP15xx initialized\n");
>  		dma_chan_count = 9;
>  		enable_1510_mode = 1;
> -	} else if (cpu_is_omap16xx() || cpu_is_omap730()) {
> +	} else if (cpu_is_omap16xx() || cpu_is_omap7xx()) {
>  		printk(KERN_INFO "OMAP DMA hardware version %d\n",
>  		       dma_read(HW_ID));
>  		printk(KERN_INFO "DMA capabilities: %08x:%08x:%04x:%04x:%04x\n",
> diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
> index be7bcaf..fa5297d 100644
> --- a/arch/arm/plat-omap/sram.c
> +++ b/arch/arm/plat-omap/sram.c
> @@ -148,7 +148,7 @@ void __init omap_detect_sram(void)
>  		omap_sram_base = OMAP1_SRAM_VA;
>  		omap_sram_start = OMAP1_SRAM_PA;
>  
> -		if (cpu_is_omap730())
> +		if (cpu_is_omap7xx())
>  			omap_sram_size = 0x32000;	/* 200K */
>  		else if (cpu_is_omap15xx())
>  			omap_sram_size = 0x30000;	/* 192K */
> -- 
> 1.6.0.6
> 

> From 990b098dde0e3fbd0df5acacb3f4859f602f72ba Mon Sep 17 00:00:00 2001
> From: Zebediah C. McClure <zmc@lurian.net>
> Date: Sat, 24 Jan 2009 14:28:53 -0400
> Subject: [PATCH] [OMAP850] IRQ related changes.
> 
> 
> Signed-off-by: Zebediah C. McClure <zmc@lurian.net>
> ---
>  arch/arm/mach-omap1/irq.c              |   18 +++++++-
>  arch/arm/plat-omap/include/mach/irqs.h |   83 +++++++++++++++++++++++++++++++-
>  2 files changed, 99 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/irq.c b/arch/arm/mach-omap1/irq.c
> index 9ad5197..b21e186 100644
> --- a/arch/arm/mach-omap1/irq.c
> +++ b/arch/arm/mach-omap1/irq.c
> @@ -145,6 +145,14 @@ static struct omap_irq_bank omap730_irq_banks[] = {
>  };
>  #endif
>  
> +#ifdef CONFIG_ARCH_OMAP850
> +static struct omap_irq_bank omap850_irq_banks[] = {
> +	{ .base_reg = OMAP_IH1_BASE,		.trigger_map = 0xb3f8e22f },
> +	{ .base_reg = OMAP_IH2_BASE,		.trigger_map = 0xfdb9c1f2 },
> +	{ .base_reg = OMAP_IH2_BASE + 0x100,	.trigger_map = 0x800040f3 },
> +};
> +#endif
> +
>  #ifdef CONFIG_ARCH_OMAP15XX
>  static struct omap_irq_bank omap1510_irq_banks[] = {
>  	{ .base_reg = OMAP_IH1_BASE,		.trigger_map = 0xb3febfff },
> @@ -184,6 +192,12 @@ void __init omap_init_irq(void)
>  		irq_bank_count = ARRAY_SIZE(omap730_irq_banks);
>  	}
>  #endif
> +#ifdef CONFIG_ARCH_OMAP850
> +	if (cpu_is_omap850()) {
> +		irq_banks = omap850_irq_banks;
> +		irq_bank_count = ARRAY_SIZE(omap850_irq_banks);
> +	}
> +#endif
>  #ifdef CONFIG_ARCH_OMAP15XX
>  	if (cpu_is_omap1510()) {
>  		irq_banks = omap1510_irq_banks;
> @@ -214,7 +228,7 @@ void __init omap_init_irq(void)
>  	irq_bank_writel(0x03, 1, IRQ_CONTROL_REG_OFFSET);
>  
>  	/* Enable interrupts in global mask */
> -	if (cpu_is_omap730()) {
> +	if (cpu_is_omap7xx()) {
>  		irq_bank_writel(0x0, 0, IRQ_GMR_REG_OFFSET);
>  	}
>  
> @@ -236,6 +250,8 @@ void __init omap_init_irq(void)
>  
>  	if (cpu_is_omap730())
>  		omap_unmask_irq(INT_730_IH2_IRQ);
> +	else if (cpu_is_omap850())
> +		omap_unmask_irq(INT_850_IH2_IRQ);
>  	else if (cpu_is_omap15xx())
>  		omap_unmask_irq(INT_1510_IH2_IRQ);
>  	else if (cpu_is_omap16xx())
> diff --git a/arch/arm/plat-omap/include/mach/irqs.h b/arch/arm/plat-omap/include/mach/irqs.h
> index bed5274..7f57ee6 100644
> --- a/arch/arm/plat-omap/include/mach/irqs.h
> +++ b/arch/arm/plat-omap/include/mach/irqs.h
> @@ -105,6 +105,29 @@
>  #define INT_730_SPGIO_WR	29
>  
>  /*
> + * OMAP-850 specific IRQ numbers for interrupt handler 1
> + */
> +#define INT_850_IH2_FIQ		0
> +#define INT_850_IH2_IRQ		1
> +#define INT_850_USB_NON_ISO	2
> +#define INT_850_USB_ISO		3
> +#define INT_850_ICR		4
> +#define INT_850_EAC		5
> +#define INT_850_GPIO_BANK1	6
> +#define INT_850_GPIO_BANK2	7
> +#define INT_850_GPIO_BANK3	8
> +#define INT_850_McBSP2TX	10
> +#define INT_850_McBSP2RX	11
> +#define INT_850_McBSP2RX_OVF	12
> +#define INT_850_LCD_LINE	14
> +#define INT_850_GSM_PROTECT	15
> +#define INT_850_TIMER3		16
> +#define INT_850_GPIO_BANK5	17
> +#define INT_850_GPIO_BANK6	18
> +#define INT_850_SPGIO_WR	29
> +
> +
> +/*
>   * IRQ numbers for interrupt handler 2
>   *
>   * NOTE: See also the OMAP-1510 and 1610 specific IRQ numbers below
> @@ -237,6 +260,64 @@
>  #define INT_730_DMA_CH15	(62 + IH2_BASE)
>  #define INT_730_NAND		(63 + IH2_BASE)
>  
> +/*
> + * OMAP-850 specific IRQ numbers for interrupt handler 2
> + */
> +#define INT_850_HW_ERRORS	(0 + IH2_BASE)
> +#define INT_850_NFIQ_PWR_FAIL	(1 + IH2_BASE)
> +#define INT_850_CFCD		(2 + IH2_BASE)
> +#define INT_850_CFIREQ		(3 + IH2_BASE)
> +#define INT_850_I2C		(4 + IH2_BASE)
> +#define INT_850_PCC		(5 + IH2_BASE)
> +#define INT_850_MPU_EXT_NIRQ	(6 + IH2_BASE)
> +#define INT_850_SPI_100K_1	(7 + IH2_BASE)
> +#define INT_850_SYREN_SPI	(8 + IH2_BASE)
> +#define INT_850_VLYNQ		(9 + IH2_BASE)
> +#define INT_850_GPIO_BANK4	(10 + IH2_BASE)
> +#define INT_850_McBSP1TX	(11 + IH2_BASE)
> +#define INT_850_McBSP1RX	(12 + IH2_BASE)
> +#define INT_850_McBSP1RX_OF	(13 + IH2_BASE)
> +#define INT_850_UART_MODEM_IRDA_2 (14 + IH2_BASE)
> +#define INT_850_UART_MODEM_1	(15 + IH2_BASE)
> +#define INT_850_MCSI		(16 + IH2_BASE)
> +#define INT_850_uWireTX		(17 + IH2_BASE)
> +#define INT_850_uWireRX		(18 + IH2_BASE)
> +#define INT_850_SMC_CD		(19 + IH2_BASE)
> +#define INT_850_SMC_IREQ	(20 + IH2_BASE)
> +#define INT_850_HDQ_1WIRE	(21 + IH2_BASE)
> +#define INT_850_TIMER32K	(22 + IH2_BASE)
> +#define INT_850_MMC_SDIO	(23 + IH2_BASE)
> +#define INT_850_UPLD		(24 + IH2_BASE)
> +#define INT_850_USB_HHC_1	(27 + IH2_BASE)
> +#define INT_850_USB_HHC_2	(28 + IH2_BASE)
> +#define INT_850_USB_GENI	(29 + IH2_BASE)
> +#define INT_850_USB_OTG		(30 + IH2_BASE)
> +#define INT_850_CAMERA_IF	(31 + IH2_BASE)
> +#define INT_850_RNG		(32 + IH2_BASE)
> +#define INT_850_DUAL_MODE_TIMER (33 + IH2_BASE)
> +#define INT_850_DBB_RF_EN	(34 + IH2_BASE)
> +#define INT_850_MPUIO_KEYPAD	(35 + IH2_BASE)
> +#define INT_850_SHA1_MD5	(36 + IH2_BASE)
> +#define INT_850_SPI_100K_2	(37 + IH2_BASE)
> +#define INT_850_RNG_IDLE	(38 + IH2_BASE)
> +#define INT_850_MPUIO		(39 + IH2_BASE)
> +#define INT_850_LLPC_LCD_CTRL_CAN_BE_OFF	(40 + IH2_BASE)
> +#define INT_850_LLPC_OE_FALLING (41 + IH2_BASE)
> +#define INT_850_LLPC_OE_RISING	(42 + IH2_BASE)
> +#define INT_850_LLPC_VSYNC	(43 + IH2_BASE)
> +#define INT_850_WAKE_UP_REQ	(46 + IH2_BASE)
> +#define INT_850_DMA_CH6		(53 + IH2_BASE)
> +#define INT_850_DMA_CH7		(54 + IH2_BASE)
> +#define INT_850_DMA_CH8		(55 + IH2_BASE)
> +#define INT_850_DMA_CH9		(56 + IH2_BASE)
> +#define INT_850_DMA_CH10	(57 + IH2_BASE)
> +#define INT_850_DMA_CH11	(58 + IH2_BASE)
> +#define INT_850_DMA_CH12	(59 + IH2_BASE)
> +#define INT_850_DMA_CH13	(60 + IH2_BASE)
> +#define INT_850_DMA_CH14	(61 + IH2_BASE)
> +#define INT_850_DMA_CH15	(62 + IH2_BASE)
> +#define INT_850_NAND		(63 + IH2_BASE)
> +
>  #define INT_24XX_SYS_NIRQ	7
>  #define INT_24XX_SDMA_IRQ0	12
>  #define INT_24XX_SDMA_IRQ1	13
> @@ -341,7 +422,7 @@
>  
>  #define	INT_34XX_BENCH_MPU_EMUL	3
>  
> -/* Max. 128 level 2 IRQs (OMAP1610), 192 GPIOs (OMAP730) and
> +/* Max. 128 level 2 IRQs (OMAP1610), 192 GPIOs (OMAP730/850) and
>   * 16 MPUIO lines */
>  #define OMAP_MAX_GPIO_LINES	192
>  #define IH_GPIO_BASE		(128 + IH2_BASE)
> -- 
> 1.6.0.6
> 

> From 846a949b0ac9153e9b03e4b7c2513ee98f2ab3f5 Mon Sep 17 00:00:00 2001
> From: Zebediah C. McClure <zmc@lurian.net>
> Date: Sat, 24 Jan 2009 16:59:43 -0400
> Subject: [PATCH] [OMAP850] Build system changes.
> 
> 
> Signed-off-by: Zebediah C. McClure <zmc@lurian.net>
> ---
>  arch/arm/mach-omap1/Kconfig |   23 +++++++++++++++++------
>  1 files changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfig
> index 10a301e..4842a3a 100644
> --- a/arch/arm/mach-omap1/Kconfig
> +++ b/arch/arm/mach-omap1/Kconfig
> @@ -7,6 +7,11 @@ config ARCH_OMAP730
>  	select CPU_ARM926T
>  	select ARCH_OMAP_OTG
>  
> +config ARCH_OMAP850
> +	depends on ARCH_OMAP1
> +	bool "OMAP850 Based System"
> +	select CPU_ARM926T
> +
>  config ARCH_OMAP15XX
>  	depends on ARCH_OMAP1
>  	default y
> @@ -46,6 +51,12 @@ config MACH_OMAP_H3
>  	  TI OMAP 1710 H3 board support. Say Y here if you have such
>  	  a board.
>  
> +config MACH_OMAP_HTCWIZARD
> +	bool "HTC Wizard"
> +	depends on ARCH_OMAP850
> +	help
> +	  HTC Wizard smartphone support (AKA QTEK 9100, ...)	
> +          
>  config MACH_OMAP_OSK
>  	bool "TI OSK Support"
>  	depends on ARCH_OMAP1 && ARCH_OMAP16XX
> @@ -163,7 +174,7 @@ config OMAP_ARM_216MHZ
>  
>  config OMAP_ARM_195MHZ
>  	bool "OMAP ARM 195 MHz CPU"
> -	depends on ARCH_OMAP1 && ARCH_OMAP730
> +	depends on ARCH_OMAP1 && (ARCH_OMAP730 || ARCH_OMAP850)
>  	help
>            Enable 195MHz clock for OMAP CPU. If unsure, say N.
>  
> @@ -175,13 +186,13 @@ config OMAP_ARM_192MHZ
>  
>  config OMAP_ARM_182MHZ
>  	bool "OMAP ARM 182 MHz CPU"
> -	depends on ARCH_OMAP1 && ARCH_OMAP730
> +	depends on ARCH_OMAP1 && (ARCH_OMAP730 || ARCH_OMAP850)
>  	help
>            Enable 182MHz clock for OMAP CPU. If unsure, say N.
>  
>  config OMAP_ARM_168MHZ
>  	bool "OMAP ARM 168 MHz CPU"
> -	depends on ARCH_OMAP1 && (ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP730)
> +	depends on ARCH_OMAP1 && (ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP730 || ARCH_OMAP850)
>  	help
>            Enable 168MHz clock for OMAP CPU. If unsure, say N.
>  
> @@ -193,20 +204,20 @@ config OMAP_ARM_150MHZ
>  
>  config OMAP_ARM_120MHZ
>  	bool "OMAP ARM 120 MHz CPU"
> -	depends on ARCH_OMAP1 && (ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP730)
> +	depends on ARCH_OMAP1 && (ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP730 || ARCH_OMAP850)
>  	help
>            Enable 120MHz clock for OMAP CPU. If unsure, say N.
>  
>  config OMAP_ARM_60MHZ
>  	bool "OMAP ARM 60 MHz CPU"
> -	depends on ARCH_OMAP1 && (ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP730)
> +	depends on ARCH_OMAP1 && (ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP730 || ARCH_OMAP850)
>          default y
>  	help
>            Enable 60MHz clock for OMAP CPU. If unsure, say Y.
>  
>  config OMAP_ARM_30MHZ
>  	bool "OMAP ARM 30 MHz CPU"
> -	depends on ARCH_OMAP1 && (ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP730)
> +	depends on ARCH_OMAP1 && (ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP730 || ARCH_OMAP850)
>  	help
>            Enable 30MHz clock for OMAP CPU. If unsure, say N.
>  
> -- 
> 1.6.0.6
> 



