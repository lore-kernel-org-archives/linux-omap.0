From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 04/12] USB: ehci-omap: Remove PHY reset handling code
Date: Tue, 12 Mar 2013 12:44:42 +0200
Message-ID: <1363085090-24676-5-git-send-email-rogerq@ti.com>
References: <1363085090-24676-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1363085090-24676-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Reset GPIO handling for the PHY must be done in the PHY
driver. We use the PHY helpers instead to reset the PHY.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Acked-by: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
---
 drivers/usb/host/ehci-omap.c |   72 ++++++------------------------------------
 1 files changed, 10 insertions(+), 62 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 6b8b7e5..0bbfdc1 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -86,79 +86,27 @@ static inline u32 ehci_read(void __iomem *base, u32 reg)
 	return __raw_readl(base + reg);
 }
 
-
-static void omap_ehci_soft_phy_reset(struct usb_hcd *hcd, u8 port)
-{
-	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
-	unsigned reg = 0;
-
-	reg = ULPI_FUNC_CTRL_RESET
-		/* FUNCTION_CTRL_SET register */
-		| (ULPI_SET(ULPI_FUNC_CTRL) << EHCI_INSNREG05_ULPI_REGADD_SHIFT)
-		/* Write */
-		| (2 << EHCI_INSNREG05_ULPI_OPSEL_SHIFT)
-		/* PORTn */
-		| ((port + 1) << EHCI_INSNREG05_ULPI_PORTSEL_SHIFT)
-		/* start ULPI access*/
-		| (1 << EHCI_INSNREG05_ULPI_CONTROL_SHIFT);
-
-	ehci_write(hcd->regs, EHCI_INSNREG05_ULPI, reg);
-
-	/* Wait for ULPI access completion */
-	while ((ehci_read(hcd->regs, EHCI_INSNREG05_ULPI)
-			& (1 << EHCI_INSNREG05_ULPI_CONTROL_SHIFT))) {
-		cpu_relax();
-
-		if (time_after(jiffies, timeout)) {
-			dev_dbg(hcd->self.controller,
-					"phy reset operation timed out\n");
-			break;
-		}
-	}
-}
-
 static int omap_ehci_init(struct usb_hcd *hcd)
 {
-	struct ehci_hcd		*ehci = hcd_to_ehci(hcd);
-	int			rc;
-	struct usbhs_omap_platform_data	*pdata;
-
-	pdata = hcd->self.controller->platform_data;
+	struct ehci_hcd	*ehci = hcd_to_ehci(hcd);
+	struct omap_hcd	*omap = (struct omap_hcd *)ehci->priv;
+	int rc, i;
 
 	/* Hold PHYs in reset while initializing EHCI controller */
-	if (pdata->phy_reset) {
-		if (gpio_is_valid(pdata->reset_gpio_port[0]))
-			gpio_set_value_cansleep(pdata->reset_gpio_port[0], 0);
-
-		if (gpio_is_valid(pdata->reset_gpio_port[1]))
-			gpio_set_value_cansleep(pdata->reset_gpio_port[1], 0);
-
-		/* Hold the PHY in RESET for enough time till DIR is high */
-		udelay(10);
+	for (i = 0; i < omap->nports; i++) {
+		if (omap->phy[i])
+			usb_phy_shutdown(omap->phy[i]);
 	}
 
-	/* Soft reset the PHY using PHY reset command over ULPI */
-	if (pdata->port_mode[0] == OMAP_EHCI_PORT_MODE_PHY)
-		omap_ehci_soft_phy_reset(hcd, 0);
-	if (pdata->port_mode[1] == OMAP_EHCI_PORT_MODE_PHY)
-		omap_ehci_soft_phy_reset(hcd, 1);
-
 	/* we know this is the memory we want, no need to ioremap again */
 	ehci->caps = hcd->regs;
 
 	rc = ehci_setup(hcd);
 
-	if (pdata->phy_reset) {
-		/* Hold the PHY in RESET for enough time till
-		 * PHY is settled and ready
-		 */
-		udelay(10);
-
-		if (gpio_is_valid(pdata->reset_gpio_port[0]))
-			gpio_set_value_cansleep(pdata->reset_gpio_port[0], 1);
-
-		if (gpio_is_valid(pdata->reset_gpio_port[1]))
-			gpio_set_value_cansleep(pdata->reset_gpio_port[1], 1);
+	/* Bring PHYs out of reset */
+	for (i = 0; i < omap->nports; i++) {
+		if (omap->phy[i])
+			usb_phy_init(omap->phy[i]);
 	}
 
 	return rc;
-- 
1.7.4.1
