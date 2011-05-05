From: srinath@mistralsolutions.com
Subject: [Patch v1] AM35xx-Craneboard:Update
Date: Thu,  5 May 2011 12:45:08 +0530
Message-ID: <1304579708-16018-1-git-send-email-srinath@mistralsolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: linux@arm.linux.org.uk, umeshk@mistralsolutions.com, tony@atomide.com, nagendra@mistralsolutions.com, "Srinath.R" <srinath@mistralsolutions.com>, linux-kernel@vger.kernel.org, khilman@deeprootsystems.com, jdk@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Srinath.R <srinath@mistralsolutions.com>

Replaced gpio_request()/gpio_direction_output() with gpio_request_one() in am3517_crane_init.

Signed-off-by: Srinath.R <srinath@mistralsolutions.com>
---
 arch/arm/mach-omap2/board-am3517crane.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-omap2/board-am3517crane.c
index a890d24..b8c7150 100644
--- a/arch/arm/mach-omap2/board-am3517crane.c
+++ b/arch/arm/mach-omap2/board-am3517crane.c
@@ -89,19 +89,13 @@ static void __init am3517_crane_init(void)
 		return;
 	}
 
-	ret = gpio_request(GPIO_USB_POWER, "usb_ehci_enable");
+	ret = gpio_request_one(GPIO_USB_POWER, GPIOF_OUT_INIT_HIGH,
+				"usb_ehci_enable");
 	if (ret < 0) {
 		pr_err("Can not request GPIO %d\n", GPIO_USB_POWER);
 		return;
 	}
 
-	ret = gpio_direction_output(GPIO_USB_POWER, 1);
-	if (ret < 0) {
-		gpio_free(GPIO_USB_POWER);
-		pr_err("Unable to initialize EHCI power\n");
-		return;
-	}
-
 	usbhs_init(&usbhs_bdata);
 }
 
-- 
1.5.3.4
