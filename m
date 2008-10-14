From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP: Revert omap3 WDT changes to avoid merge
	conflict (Re: linux-next: manual merge of the arm tree)
Date: Tue, 14 Oct 2008 13:30:24 -0700
Message-ID: <20081014203017.GH8150@atomide.com>
References: <20081014132745.051f6418.sfr@canb.auug.org.au> <20081014075950.GA22855@flint.arm.linux.org.uk> <200810140107.14647.david-b@pacbell.net> <20081014200805.GF8150@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="kVXhAStRUZ/+rrGn"
Content-Transfer-Encoding: 8bit
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20081014200805.GF8150@atomide.com>
Sender: linux-next-owner@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-omap@vger.kernel.org, Richard Woodruff <r-woodruff2@ti.com>, linux-next@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>, Wim Van Sebroeck <wim@iguana.be>, Syed Mohammed Khasim <khasim@ti.com>, David Brownell <david-b@pacbell.net>
List-Id: linux-omap@vger.kernel.org


--kVXhAStRUZ/+rrGn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

* Tony Lindgren <tony@atomide.com> [081014 13:09]:
> * David Brownell <david-b@pacbell.net> [081014 11:53]:
> > On Tuesday 14 October 2008, Russell King wrote:
> > > Since the OMAP updates I merged from Tony are already broken due to
> > > missing definitions, and I'm not getting any response from Tony on
> > > fixing those,
> 
> I just sent you a fix for that few hours ago.
> 
> > Probably has to do with his travel plans, which he mentioned
> > last week (Thursday?).  I think he's back online in the next
> > day or two.
> > 
> > 
> > > I will be dropping the problematical updates so we can 
> > > at least keep mainline OMAP in a buildable state.  That seems to mean
> > > dropping the new OMAP3 support.
> 
> Yes, I'm back online. And please don't drop these patches, sounds
> like this is a trivial merge issue.

And here's the patch for Russell to avoid the merge conflict.
Also in Russell's patch tracking system as patch 5302/1.

> 
> Regards,
> 
> Tony

--kVXhAStRUZ/+rrGn
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="wdt.patch"

From: Tony Lindgren <tony@atomide.com>
Date: Tue, 14 Oct 2008 13:25:20 -0700
Subject: [PATCH] ARM: OMAP: Revert omap3 WDT changes to avoid merge conflict

With the upcoming WDT patches OMAP_WDT_BASE is no longer needed
in devices.c. Revert some earlier omap3 changes to avoid merge
conflicts with the WDT patches.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -399,17 +399,8 @@ static inline void omap_init_uwire(void) {}
 
 #if	defined(CONFIG_OMAP_WATCHDOG) || defined(CONFIG_OMAP_WATCHDOG_MODULE)
 
-#if defined(CONFIG_ARCH_OMAP34XX)
-#define	OMAP_WDT_BASE		0x48314000
-#elif defined(CONFIG_ARCH_OMAP24XX)
-
-#ifdef CONFIG_ARCH_OMAP2430
-/* WDT2 */
-#define	OMAP_WDT_BASE		0x49016000
-#else
+#ifdef CONFIG_ARCH_OMAP24XX
 #define	OMAP_WDT_BASE		0x48022000
-#endif
-
 #else
 #define	OMAP_WDT_BASE		0xfffeb000
 #endif

--kVXhAStRUZ/+rrGn--
