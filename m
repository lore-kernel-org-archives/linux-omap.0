From: Hebbar Gururaja <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
Subject: [Patch V2 2/4] ARM: Davinci: da8xx/omap-l1: Remove hard coding of rtc
	device wakeup
Date: Wed, 3 Jul 2013 14:17:03 +0530
Message-ID: <1372841225-18813-3-git-send-email-gururaja.hebbar@ti.com>
References: <1372841225-18813-1-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1372841225-18813-1-git-send-email-gururaja.hebbar-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, benoit.cousson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Since now rtc-omap driver itself calls deice_init_wakeup(dev, true),
duplicate call from the rtc device registration can be removed.

This is basically a partial revert of the prev commit

commit 75c99bb0006ee065b4e2995078d779418b0fab54
Author: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>

    davinci: da8xx/omap-l1: mark RTC as a wakeup source

Signed-off-by: Hebbar Gururaja <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
Acked-by: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Acked-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
---
Changes in V2:
	- Coding style corrections (remove extra space)
	- use prefix ARM: for commit subject keeping with arch/arm convention

:100644 100644 bf57252... 9140b1c... M	arch/arm/mach-davinci/devices-da8xx.c
 arch/arm/mach-davinci/devices-da8xx.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index bf57252..9140b1c 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -827,14 +827,7 @@ static struct platform_device da8xx_rtc_device = {
 
 int da8xx_register_rtc(void)
 {
-	int ret;
-
-	ret = platform_device_register(&da8xx_rtc_device);
-	if (!ret)
-		/* Atleast on DA850, RTC is a wakeup source */
-		device_init_wakeup(&da8xx_rtc_device.dev, true);
-
-	return ret;
+	return platform_device_register(&da8xx_rtc_device);
 }
 
 static void __iomem *da8xx_ddr2_ctlr_base;
-- 
1.7.9.5
