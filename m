From: Jonathan McDowell <noodles@earth.li>
Subject: [PATCH] Fix USB host on 1510/5910?
Date: Tue, 28 Mar 2006 17:44:03 +0100
Message-ID: <20060328164403.GL26949@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
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

I'm not quite sure if this is necessary or not. I've found I need it to
get USB working correctly on the Amstrad E3, which is an OMAP5910. From
my reading of ohci-omap.c usb_dc_ck is requested for the 1510 as well,
and if it can't be obtained an error is returned.

Does anyone have USB working correctly on a 1510/5910 with latest git
without something like the below?

Signed-Off-By: Jonathan McDowell <noodles@earth.li>

-----
diff --git a/arch/arm/mach-omap1/clock.h b/arch/arm/mach-omap1/clock.h
index b7c6881..db48d73 100644
--- a/arch/arm/mach-omap1/clock.h
+++ b/arch/arm/mach-omap1/clock.h
@@ -633,7 +633,7 @@ static struct clk usb_dc_ck = {
 	.name		= "usb_dc_ck",
 	/* Direct from ULPD, no parent */
 	.rate		= 48000000,
-	.flags		= CLOCK_IN_OMAP16XX | RATE_FIXED,
+	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | RATE_FIXED,
 	.enable_reg	= (void __iomem *)SOFT_REQ_REG,
 	.enable_bit	= 4,
 	.enable		= &omap1_clk_enable_generic,
-----

J.

-- 
