From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] mfd: omap-usb-host: Mark expected switch fall-throughs
Date: Sun, 28 Jul 2019 18:58:58 -0500
Message-ID: <20190728235858.GA23755@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Kees Cook <keescook@chromium.org>
List-Id: linux-omap@vger.kernel.org

Mark switch cases where we are expecting to fall through.

This patch fixes the following warnings:

drivers/mfd/omap-usb-host.c: In function 'usbhs_runtime_resume':
drivers/mfd/omap-usb-host.c:303:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
    if (!IS_ERR(omap->hsic480m_clk[i])) {
       ^
drivers/mfd/omap-usb-host.c:313:3: note: here
   case OMAP_EHCI_PORT_MODE_TLL:
   ^~~~
drivers/mfd/omap-usb-host.c: In function 'usbhs_runtime_suspend':
drivers/mfd/omap-usb-host.c:345:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
    if (!IS_ERR(omap->hsic480m_clk[i]))
       ^
drivers/mfd/omap-usb-host.c:349:3: note: here
   case OMAP_EHCI_PORT_MODE_TLL:
   ^~~~

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/mfd/omap-usb-host.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 792b855a9104..4798d9f3f9d5 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -308,7 +308,7 @@ static int usbhs_runtime_resume(struct device *dev)
 					 i, r);
 				}
 			}
-		/* Fall through as HSIC mode needs utmi_clk */
+		/* Fall through - as HSIC mode needs utmi_clk */
 
 		case OMAP_EHCI_PORT_MODE_TLL:
 			if (!IS_ERR(omap->utmi_clk[i])) {
@@ -344,7 +344,7 @@ static int usbhs_runtime_suspend(struct device *dev)
 
 			if (!IS_ERR(omap->hsic480m_clk[i]))
 				clk_disable_unprepare(omap->hsic480m_clk[i]);
-		/* Fall through as utmi_clks were used in HSIC mode */
+		/* Fall through - as utmi_clks were used in HSIC mode */
 
 		case OMAP_EHCI_PORT_MODE_TLL:
 			if (!IS_ERR(omap->utmi_clk[i]))
-- 
2.22.0
