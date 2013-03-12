From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 12/12] USB: ehci-omap: Fix detection in HSIC mode
Date: Tue, 12 Mar 2013 13:09:00 +0200
Message-ID: <1363086540-30567-1-git-send-email-rogerq@ti.com>
References: <1363085090-24676-13-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1363085090-24676-13-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
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
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The HSIC devices need to be kept in reset while the EHCI controller
is being initialized and only brought out of reset after the
initialization is complete, else HSIC devices will not be detected.

Also remove outdated TODO list from header.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
CC: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
---
 drivers/usb/host/ehci-omap.c |   38 +++++++++++++++-----------------------
 1 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 1ba1df8..dc2de47 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -29,12 +29,6 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  *
- * TODO (last updated Feb 27, 2010):
- *	- add kernel-doc
- *	- enable AUTOIDLE
- *	- add suspend/resume
- *	- add HSIC and TLL support
- *	- convert to use hwmod and runtime PM
  */
 
 #include <linux/kernel.h>
@@ -90,26 +84,13 @@ static inline u32 ehci_read(void __iomem *base, u32 reg)
 static int omap_ehci_init(struct usb_hcd *hcd)
 {
 	struct ehci_hcd	*ehci = hcd_to_ehci(hcd);
-	struct omap_hcd	*omap = (struct omap_hcd *)ehci->priv;
-	int rc, i;
-
-	/* Hold PHYs in reset while initializing EHCI controller */
-	for (i = 0; i < omap->nports; i++) {
-		if (omap->phy[i])
-			usb_phy_shutdown(omap->phy[i]);
-	}
+	int rc;
 
 	/* we know this is the memory we want, no need to ioremap again */
 	ehci->caps = hcd->regs;
 
 	rc = ehci_setup(hcd);
 
-	/* Bring PHYs out of reset */
-	for (i = 0; i < omap->nports; i++) {
-		if (omap->phy[i])
-			usb_phy_init(omap->phy[i]);
-	}
-
 	return rc;
 }
 
@@ -219,9 +200,6 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 		}
 
 		omap->phy[i] = phy;
-		usb_phy_init(omap->phy[i]);
-		/* bring PHY out of suspend */
-		usb_phy_set_suspend(omap->phy[i], 0);
 	}
 
 	pm_runtime_enable(dev);
@@ -245,6 +223,20 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 		goto err_pm_runtime;
 	}
 
+	/*
+	 * Bring PHYs out of reset.
+	 * Even though HSIC mode is a PHY-less mode, the reset
+	 * line exists between the chips and can be modelled
+	 * as a PHY device for reset control.
+	 */
+	for (i = 0; i < omap->nports; i++) {
+		if (!omap->phy[i])
+			continue;
+
+		usb_phy_init(omap->phy[i]);
+		/* bring PHY out of suspend */
+		usb_phy_set_suspend(omap->phy[i], 0);
+	}
 
 	return 0;
 
-- 
1.7.4.1
