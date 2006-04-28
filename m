From: Jonathan McDowell <noodles@earth.li>
Subject: [PATCH] ARM: OMAP: Readd Amstrad Delta USB support.
Date: Fri, 28 Apr 2006 13:31:40 +0100
Message-ID: <20060428123140.GL7570@earth.li>
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

One of the recent merges from mainline removed the Amstrad Delta USB
support. This patch adds it back in; it's the same as was in
2.6.16-omap2.

Signed-Off-By: Jonathan McDowell <noodles@earth.li>

-----
diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 6178f04..664c3e2 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -80,8 +80,15 @@ static struct omap_uart_config ams_delta
 	.enabled_uarts = 1,
 };
 
+static struct omap_usb_config ams_delta_usb_config __initdata = {
+	.register_host	= 1,
+	.hmc_mode	= 16,
+	.pins[0]	= 2,
+};
+
 static struct omap_board_config_kernel ams_delta_config[] = {
 	{ OMAP_TAG_UART,	&ams_delta_uart_config },
+	{ OMAP_TAG_USB,		&ams_delta_usb_config },
 };
 
 static void __init ams_delta_init(void)
-----

J.

-- 
   101 things you can't have too   |  .''`.  Debian GNU/Linux Developer
        much of : 41 - Tea.        | : :' :  Happy to accept PGP signed
                                   | `. `'   or encrypted mail - RSA +
                                   |   `-    DSA keys on the keyservers.
