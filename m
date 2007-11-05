From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] include/asm-arm/arch-omap/omap24xx.h
Date: Mon, 5 Nov 2007 00:57:40 -0700 (MST)
Message-ID: <Pine.LNX.4.64.0711050052050.7016@utopia.booyaka.com>
References: <ae36f8040710240958l579ad5el16f17cb073e25387@mail.gmail.com>
	<471F868A.3060106@googlemail.com> <20071025053143.222542615@pwsan.com>
	<4720B62A.1010406@googlemail.com>
	<Pine.LNX.4.64.0710250955270.25986@utopia.booyaka.com>
	<20071031152230.GP32547@atomide.com> <20071101082943.GA780@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20071101082943.GA780@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Thu, 1 Nov 2007, Tony Lindgren wrote:

> * Tony Lindgren <tony@atomide.com> [071031 08:22]:
> > * Paul Walmsley <paul@pwsan.com> [071025 09:01]:
> > 
> > > Hello Dirk,
> > >
> > > On Thu, 25 Oct 2007, Dirk Behme wrote:
> > >
> > >> Mmh, I like to fix it in include/asm-arm/arch-omap/omap24xx.h, so I prefer 
> > >> [1].
> > >>
> > >> With [1] we
> > >>
> > >> - fix it where it was introduced
> > >> - have an additional #ifdef only in a header file instead of 
> > >> plat-omap/devices.c, which is IMHO better
> > >> - fix it for everybody now and in the future who directly or indirectly 
> > >> includes omap24xx.h.
> > >
> > > Hopefully this is just a workaround until we can get rid of these 
> > > conditional defines for multiboot kernels.  Generally speaking, would you 
> > > propose doing the same thing for the other conditional defines in 
> > > include/asm-arm/arch-omap/omap24xx.h, such as OMAP2_32KSYNCT_BASE, 
> > > OMAP2_SDRC_BASE, etc.?
> > 
> > Sounds like the real fix is to set these addresses in the init code
> > somewhere based on the omap type.

Yeah, agreed.

> I'll push a temporary fix based on Luis' patch, see below.

OMAP3430 builds now generate redefinition warnings for OMAP2_CTRL_BASE; 
patch to work around is below.

In file included from include/asm/arch/hardware.h:288,
                 from include/asm/hardware.h:16,
                 from include/asm/arch/irqs.h:341,
                 from include/asm/irq.h:4,
                 from include/asm/hardirq.h:6,
                 from include/linux/hardirq.h:7,
                 from include/asm-generic/local.h:5,
                 from include/asm/local.h:1,
                 from include/linux/module.h:19,
                 from init/main.c:13:
include/asm/arch/omap34xx.h:71:1: warning: "OMAP2_CTRL_BASE" redefined
In file included from include/asm/arch/hardware.h:287,
                 from include/asm/hardware.h:16,
                 from include/asm/arch/irqs.h:341,
                 from include/asm/irq.h:4,
                 from include/asm/hardirq.h:6,
                 from include/linux/hardirq.h:7,
                 from include/asm-generic/local.h:5,
                 from include/asm/local.h:1,
                 from include/linux/module.h:19,
                 from init/main.c:13:
include/asm/arch/omap24xx.h:106:1: warning: this is the location of the 
previous definition


- Paul

From: Paul Walmsley <paul@pwsan.com>
Subject: Work around OMAP2_CTRL_BASE warnings in 3430 build

Work around OMAP2_CTRL_BASE redefinition warnings for OMAP3430 builds. 

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 include/asm/arch/omap24xx.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-omap/include/asm/arch/omap24xx.h
===================================================================
--- linux-omap.orig/include/asm/arch/omap24xx.h	2007-11-04 20:55:00.000000000 -0700
+++ linux-omap/include/asm/arch/omap24xx.h	2007-11-04 21:32:31.000000000 -0700
@@ -101,7 +101,7 @@
 #define OMAP2_VA_IC_BASE	IO_ADDRESS(OMAP24XX_IC_BASE)
 #define OMAP2_CTRL_BASE		OMAP243X_CTRL_BASE
 
-#else
+#elif !defined(CONFIG_ARCH_OMAP34XX)
 /* FIXME: These will go away soon */
 #define OMAP2_CTRL_BASE		L4_24XX_BASE
 #endif
