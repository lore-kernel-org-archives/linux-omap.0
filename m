From: Jonathan McDowell <noodles@earth.li>
Subject: ARM: OMAP: Fix OMAP1 compilation after MPUIO check change.
Date: Wed, 9 Aug 2006 10:25:44 +0100
Message-ID: <20060809092544.GK27094@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

The recent MPUIO range change fix breaks compilation if
CONFIG_ARCH_OMAP24XX isn't defined; it should be OMAP_MAX_GPIO_LINES not
MAX_GPIO_LINES I believe. This one liner fixes it.

Signed-Off-By: Jonathan McDowell <noodles@earth.li>

-----
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index d5221b2..b27ba0e 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -216,7 +216,7 @@ static inline int gpio_valid(int gpio)
 		return -1;
 #ifndef CONFIG_ARCH_OMAP24XX
 	if (OMAP_GPIO_IS_MPUIO(gpio)) {
-		if (gpio >= MAX_GPIO_LINES + 16)
+		if (gpio >= OMAP_MAX_GPIO_LINES + 16)
 			return -1;
 		return 0;
 	}
-----

J.

-- 
noodles is not a sign of poor table manners
