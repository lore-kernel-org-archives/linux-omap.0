From: Jonathan McDowell <noodles@earth.li>
Subject: [PATCH] ARM: OMAP: OMAP_GPIO_SWITCH doesn't need OMAP_BOOT_TAG
Date: Wed, 17 May 2006 18:25:47 +0100
Message-ID: <20060517172547.GA3778@earth.li>
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

I can't see any reason why OMAP_GPIO_SWITCH depends on OMAP_BOOT_TAG;
it compiles fine without it. This patch removes the Kconfig dependency.

Also the description is wrong; it doesn't hook into the input layer at
all from what I can tell. Are there patches around that add this? The
Amstrad Delta has a phone hook on a GPIO that I plan to support with
this driver and being able to produce a keypress would be nice.

Signed-off-by: Jonathan McDowell <noodles@earth.li>

-----
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 28ca5ad..762d417 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -57,13 +57,12 @@ config OMAP_COMPONENT_VERSION
 
 config OMAP_GPIO_SWITCH
 	bool "GPIO switch support"
-        depends on OMAP_BOOT_TAG
         default n
         help
           Say Y, if you want to have support for input layer reporting
           of GPIO switches (e.g. cover switches). Your bootloader has to
           provide information about the switches to the kernel via the
-          ATAG_BOARD mechanism.
+          ATAG_BOARD mechanism if they're not defined by the board config.
 
 config OMAP_MUX
 	bool "OMAP multiplexing support"
-----

J.

-- 
Web [    I'd love to but... I'm having all my plants neutered.     ]
site: http:// [                                          ]       Made by
www.earth.li/~noodles/  [                      ]         HuggieTag 0.0.23
