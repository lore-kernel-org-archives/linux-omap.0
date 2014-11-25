From: George Cherian <george.cherian@ti.com>
Subject: [PATCH 03/19] usb: host: xhci-plat: Add support to pass
 XHCI_DRD_SUPPORT quirk
Date: Tue, 25 Nov 2014 18:41:39 +0530
Message-ID: <1416921115-10467-4-git-send-email-george.cherian@ti.com>
References: <1416921115-10467-1-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1416921115-10467-1-git-send-email-george.cherian@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org
Cc: mark.rutland@arm.com, George Cherian <george.cherian@ti.com>, kgene.kim@samsung.com, linux@arm.linux.org.uk, ben-linux@fluff.org, mathias.nyman@intel.com, ijc+devicetree@hellion.org.uk, tony@atomide.com, gregkh@linuxfoundation.org, sojka@merica.cz, balbi@ti.com, robh+dt@kernel.org, pawel.moll@arm.com, peter.chen@freescale.com, bcousson@baylibre.com, galak@codeaurora.org
List-Id: linux-omap@vger.kernel.org

Extend the platform data to pass XHCI_DRD_SUPPORT quirk to the xhci driver.

Signed-off-by: George Cherian <george.cherian@ti.com>
---
 drivers/usb/host/xhci-plat.c     | 4 ++++
 include/linux/usb/xhci_pdriver.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 3d78b0c..2c42273 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -27,6 +27,10 @@ static struct hc_driver __read_mostly xhci_plat_hc_driver;
 
 static void xhci_plat_quirks(struct device *dev, struct xhci_hcd *xhci)
 {
+	struct usb_xhci_pdata   *pdata = dev_get_platdata(dev);
+
+	if (pdata->usb_drd_support)
+		xhci->quirks |= XHCI_DRD_SUPPORT;
 	/*
 	 * As of now platform drivers don't provide MSI support so we ensure
 	 * here that the generic code does not try to make a pci_dev from our
diff --git a/include/linux/usb/xhci_pdriver.h b/include/linux/usb/xhci_pdriver.h
index 376654b..539c2d8 100644
--- a/include/linux/usb/xhci_pdriver.h
+++ b/include/linux/usb/xhci_pdriver.h
@@ -22,6 +22,7 @@
  */
 struct usb_xhci_pdata {
 	unsigned	usb3_lpm_capable:1;
+	unsigned	usb_drd_support:1;
 };
 
 #endif /* __USB_CORE_XHCI_PDRIVER_H */
-- 
1.8.3.1
