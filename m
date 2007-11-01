From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] include/asm-arm/arch-omap/omap24xx.h
Date: Thu, 1 Nov 2007 01:29:44 -0700
Message-ID: <20071101082943.GA780@atomide.com>
References: <ae36f8040710240958l579ad5el16f17cb073e25387@mail.gmail.com>
	<471F868A.3060106@googlemail.com>
	<20071025053143.222542615@pwsan.com>
	<4720B62A.1010406@googlemail.com>
	<Pine.LNX.4.64.0710250955270.25986@utopia.booyaka.com>
	<20071031152230.GP32547@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="C7zPtVaVf+AK4Oqc"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20071031152230.GP32547@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [071031 08:22]:
> * Paul Walmsley <paul@pwsan.com> [071025 09:01]:
> 
> > Hello Dirk,
> >
> > On Thu, 25 Oct 2007, Dirk Behme wrote:
> >
> >> Mmh, I like to fix it in include/asm-arm/arch-omap/omap24xx.h, so I prefer 
> >> [1].
> >>
> >> With [1] we
> >>
> >> - fix it where it was introduced
> >> - have an additional #ifdef only in a header file instead of 
> >> plat-omap/devices.c, which is IMHO better
> >> - fix it for everybody now and in the future who directly or indirectly 
> >> includes omap24xx.h.
> >
> > Hopefully this is just a workaround until we can get rid of these 
> > conditional defines for multiboot kernels.  Generally speaking, would you 
> > propose doing the same thing for the other conditional defines in 
> > include/asm-arm/arch-omap/omap24xx.h, such as OMAP2_32KSYNCT_BASE, 
> > OMAP2_SDRC_BASE, etc.?
> 
> Sounds like the real fix is to set these addresses in the init code
> somewhere based on the omap type.

I'll push a temporary fix based on Luis' patch, see below.

Tony

--C7zPtVaVf+AK4Oqc
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="omap2-ctrl-base-fix.patch"

--- a/include/asm-arm/arch-omap/omap24xx.h
+++ b/include/asm-arm/arch-omap/omap24xx.h
@@ -101,6 +101,9 @@
 #define OMAP2_VA_IC_BASE	IO_ADDRESS(OMAP24XX_IC_BASE)
 #define OMAP2_CTRL_BASE		OMAP243X_CTRL_BASE
 
+#else
+/* FIXME: These will go away soon */
+#define OMAP2_CTRL_BASE		L4_24XX_BASE
 #endif
 
 /* Control module */

--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--C7zPtVaVf+AK4Oqc--
