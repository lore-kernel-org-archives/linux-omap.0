From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 3/3] ARM: OMAP2+: AM43x: L2 cache support
Date: Thu, 10 Apr 2014 13:03:48 +0100
Message-ID: <20140410120348.GK27282@n2100.arm.linux.org.uk>
References: <cover.1396605300.git.nsekhar@ti.com> <efa5fda5ae625a43fac14bf173cbd96ad7b44e7a.1396605300.git.nsekhar@ti.com> <20140404101808.GG27282@n2100.arm.linux.org.uk> <53440D73.6060504@ti.com> <20140409162327.GH27282@n2100.arm.linux.org.uk> <534686DF.7070207@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:57005 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1030282AbaDJME1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Apr 2014 08:04:27 -0400
Content-Disposition: inline
In-Reply-To: <534686DF.7070207@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>

On Thu, Apr 10, 2014 at 05:26:15PM +0530, Sekhar Nori wrote:
> On Wednesday 09 April 2014 09:53 PM, Russell King - ARM Linux wrote:
> > That is required because as part of the enable sequence, we write to the
> > lockdown registers to clear out anything that may be there before we
> > enable the L2 cache.  If we didn't set the NS lockdown bit, then we
> > would need the secure monitor to do it for us.
> 
> And I realized yesterday that the only reason L2C is working on AM437x
> is because AM437x ROM is setting these bits up for us.
> 
> > Both of these bits should be managed within the L2C code rather than by
> > platforms.
> 
> The current L2C code is not managing the NS_LOCKDOWN bit. I can take a
> shot at adding this support unless you are already looking at it.

True, and I'm aware that it's missing.  So... how about this on top
of my series so far.  We can deal with L310_AUX_CTRL_NS_INT_CTRL when
the need to access those registers arises (if/when the edac driver
is submitted.)

diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index c0f9a81a2d32..4a494cde8367 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -213,8 +213,6 @@ static int __init omap_l2_cache_init(void)
 
 	/* 16-way associativity, parity disabled, way size - 64KB (es2.0 +) */
 	aux_ctrl = L310_AUX_CTRL_CACHE_REPLACE_RR |
-		   L310_AUX_CTRL_NS_LOCKDOWN |
-		   L310_AUX_CTRL_NS_INT_CTRL |
 		   L2C_AUX_CTRL_SHARED_OVERRIDE |
 		   L310_AUX_CTRL_DATA_PREFETCH |
 		   L310_AUX_CTRL_INSTR_PREFETCH;
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 98796b789eb9..837f384c1d51 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -776,6 +776,13 @@ static void __init l2c310_enable(void __iomem *base, u32 aux, unsigned num_lock)
 			power_ctrl & L310_STNDBY_MODE_EN ? "en" : "dis");
 	}
 
+	/*
+	 * Always enable non-secure access to the lockdown registers -
+	 * we write to them as part of the L2C enable sequence so they
+	 * need to be accessible.
+	 */
+	aux |= L310_AUX_CTRL_NS_LOCKDOWN;
+
 	l2c_enable(base, aux, num_lock);
 
 	if (aux & L310_AUX_CTRL_FULL_LINE_ZERO) {

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
