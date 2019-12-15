From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v3] ARM: bcm: Add missing sentinel to bcm2711_compat[]
Date: Sun, 15 Dec 2019 08:49:02 +0100
Message-ID: <b8f2060dacd4c4f27e0e1791cb12462ce740927d.1576396141.git.hns@goldelico.com>
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
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Wahren <wahrenst@gmx.net>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: letux-kernel@openphoenux.org, Tony Lindgren <tony@atomide.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, linux@armlinux.org.uk, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-rpi-kernel@lists.infradead.org, kernel@pyra-handheld.com, Linux-OMAP <linux-omap@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

commit 781fa0a95424 ("ARM: bcm: Add support for BCM2711 SoC")

breaks boot of many other platforms (e.g. OMAP or i.MX6) if
CONFIG_ARCH_BCM2835 is enabled in addition to some multiplatform
config (e.g. omap2plus_defconfig). The symptom is that the OMAP
based board does not show any activity beyond "Starting Kernel ..."
even with earlycon.

Reverting the mentioned commit makes it work again.

The real fix is to add the missing NULL sentinel to the
bcm2711_compat[] variable-length array.

Fixes: 781fa0a95424 ("ARM: bcm: Add support for BCM2711 SoC")
Acked-by: Stefan Wahren <wahrenst@gmx.net>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/mach-bcm/bcm2711.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-bcm/bcm2711.c b/arch/arm/mach-bcm/bcm2711.c
index dbe296798647..fa0300d8c79d 100644
--- a/arch/arm/mach-bcm/bcm2711.c
+++ b/arch/arm/mach-bcm/bcm2711.c
@@ -13,6 +13,7 @@ static const char * const bcm2711_compat[] = {
 #ifdef CONFIG_ARCH_MULTI_V7
 	"brcm,bcm2711",
 #endif
+	NULL
 };
 
 DT_MACHINE_START(BCM2711, "BCM2711")
-- 
2.23.0
