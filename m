From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH 1/2] usb: rename 'phy' field of 'struct usb_hcd' to 'transceiver'
Date: Wed, 9 Apr 2014 17:57:15 +0400
Message-ID: <201404091757.16574.sergei.shtylyov@cogentembedded.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Cc: Peter.Chen@freescale.com, stern@rowland.harvard.edu, swarren@wwwdotorg.org, thierry.reding@gmail.com, balbi@ti.com, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, magnus.damm@gmail.com
List-Id: linux-omap@vger.kernel.org

Return to the 'phy' field of 'struct usb_hcd' its historic name 'transceiver'. 
This is in preparation to adding the generic PHY support.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against the 'usb-next' branch of Greg KH's 'usb.git' repo.

 drivers/usb/chipidea/host.c   |    2 +-
 drivers/usb/core/hcd.c        |   20 ++++++++++----------
 drivers/usb/core/hub.c        |    9 +++++----
 drivers/usb/host/ehci-fsl.c   |   16 ++++++++--------
 drivers/usb/host/ehci-hub.c   |    2 +-
 drivers/usb/host/ehci-msm.c   |    4 ++--
 drivers/usb/host/ehci-tegra.c |   16 ++++++++--------
 drivers/usb/host/ohci-omap.c  |   20 ++++++++++----------
 include/linux/usb/hcd.h       |    6 +++---
 9 files changed, 48 insertions(+), 47 deletions(-)

Index: usb/drivers/usb/chipidea/host.c
===================================================================
--- usb.orig/drivers/usb/chipidea/host.c
+++ usb/drivers/usb/chipidea/host.c
@@ -59,7 +59,7 @@ static int host_start(struct ci_hdrc *ci
 	hcd->has_tt = 1;
 
 	hcd->power_budget = ci->platdata->power_budget;
-	hcd->phy = ci->transceiver;
+	hcd->transceiver = ci->transceiver;
 
 	ehci = hcd_to_ehci(hcd);
 	ehci->caps = ci->hw_bank.cap;
Index: usb/drivers/usb/core/hcd.c
===================================================================
--- usb.orig/drivers/usb/core/hcd.c
+++ usb/drivers/usb/core/hcd.c
@@ -2605,7 +2605,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
 	int retval;
 	struct usb_device *rhdev;
 
-	if (IS_ENABLED(CONFIG_USB_PHY) && !hcd->phy) {
+	if (IS_ENABLED(CONFIG_USB_PHY) && !hcd->transceiver) {
 		struct usb_phy *phy = usb_get_phy_dev(hcd->self.controller, 0);
 
 		if (IS_ERR(phy)) {
@@ -2618,7 +2618,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
 				usb_put_phy(phy);
 				return retval;
 			}
-			hcd->phy = phy;
+			hcd->transceiver = phy;
 			hcd->remove_phy = 1;
 		}
 	}
@@ -2764,10 +2764,10 @@ err_allocate_root_hub:
 err_register_bus:
 	hcd_buffer_destroy(hcd);
 err_remove_phy:
-	if (hcd->remove_phy && hcd->phy) {
-		usb_phy_shutdown(hcd->phy);
-		usb_put_phy(hcd->phy);
-		hcd->phy = NULL;
+	if (hcd->remove_phy && hcd->transceiver) {
+		usb_phy_shutdown(hcd->transceiver);
+		usb_put_phy(hcd->transceiver);
+		hcd->transceiver = NULL;
 	}
 	return retval;
 }
@@ -2841,10 +2841,10 @@ void usb_remove_hcd(struct usb_hcd *hcd)
 	usb_put_dev(hcd->self.root_hub);
 	usb_deregister_bus(&hcd->self);
 	hcd_buffer_destroy(hcd);
-	if (hcd->remove_phy && hcd->phy) {
-		usb_phy_shutdown(hcd->phy);
-		usb_put_phy(hcd->phy);
-		hcd->phy = NULL;
+	if (hcd->remove_phy && hcd->transceiver) {
+		usb_phy_shutdown(hcd->transceiver);
+		usb_put_phy(hcd->transceiver);
+		hcd->transceiver = NULL;
 	}
 }
 EXPORT_SYMBOL_GPL(usb_remove_hcd);
Index: usb/drivers/usb/core/hub.c
===================================================================
--- usb.orig/drivers/usb/core/hub.c
+++ usb/drivers/usb/core/hub.c
@@ -4250,8 +4250,8 @@ hub_port_init (struct usb_hub *hub, stru
 	if (retval)
 		goto fail;
 
-	if (hcd->phy && !hdev->parent)
-		usb_phy_notify_connect(hcd->phy, udev->speed);
+	if (hcd->transceiver && !hdev->parent)
+		usb_phy_notify_connect(hcd->transceiver, udev->speed);
 
 	/*
 	 * Some superspeed devices have finished the link training process
@@ -4459,9 +4459,10 @@ static void hub_port_connect_change(stru
 
 	/* Disconnect any existing devices under this port */
 	if (udev) {
-		if (hcd->phy && !hdev->parent &&
+		if (hcd->transceiver && !hdev->parent &&
 				!(portstatus & USB_PORT_STAT_CONNECTION))
-			usb_phy_notify_disconnect(hcd->phy, udev->speed);
+			usb_phy_notify_disconnect(hcd->transceiver,
+						  udev->speed);
 		usb_disconnect(&hub->ports[port1 - 1]->child);
 	}
 	clear_bit(port1, hub->change_bits);
Index: usb/drivers/usb/host/ehci-fsl.c
===================================================================
--- usb.orig/drivers/usb/host/ehci-fsl.c
+++ usb/drivers/usb/host/ehci-fsl.c
@@ -136,15 +136,15 @@ static int usb_hcd_fsl_probe(const struc
 	if (pdata->operating_mode == FSL_USB2_DR_OTG) {
 		struct ehci_hcd *ehci = hcd_to_ehci(hcd);
 
-		hcd->phy = usb_get_phy(USB_PHY_TYPE_USB2);
+		hcd->transceiver = usb_get_phy(USB_PHY_TYPE_USB2);
 		dev_dbg(&pdev->dev, "hcd=0x%p  ehci=0x%p, phy=0x%p\n",
-			hcd, ehci, hcd->phy);
+			hcd, ehci, hcd->transceiver);
 
-		if (!IS_ERR_OR_NULL(hcd->phy)) {
-			retval = otg_set_host(hcd->phy->otg,
+		if (!IS_ERR_OR_NULL(hcd->transceiver)) {
+			retval = otg_set_host(hcd->transceiver->otg,
 					      &ehci_to_hcd(ehci)->self);
 			if (retval) {
-				usb_put_phy(hcd->phy);
+				usb_put_phy(hcd->transceiver);
 				goto err2;
 			}
 		} else {
@@ -181,9 +181,9 @@ static void usb_hcd_fsl_remove(struct us
 {
 	struct fsl_usb2_platform_data *pdata = dev_get_platdata(&pdev->dev);
 
-	if (!IS_ERR_OR_NULL(hcd->phy)) {
-		otg_set_host(hcd->phy->otg, NULL);
-		usb_put_phy(hcd->phy);
+	if (!IS_ERR_OR_NULL(hcd->transceiver)) {
+		otg_set_host(hcd->transceiver->otg, NULL);
+		usb_put_phy(hcd->transceiver);
 	}
 
 	usb_remove_hcd(hcd);
Index: usb/drivers/usb/host/ehci-hub.c
===================================================================
--- usb.orig/drivers/usb/host/ehci-hub.c
+++ usb/drivers/usb/host/ehci-hub.c
@@ -931,7 +931,7 @@ static int ehci_hub_control (
 #ifdef CONFIG_USB_OTG
 			if ((hcd->self.otg_port == (wIndex + 1))
 			    && hcd->self.b_hnp_enable) {
-				otg_start_hnp(hcd->phy->otg);
+				otg_start_hnp(hcd->transceiver->otg);
 				break;
 			}
 #endif
Index: usb/drivers/usb/host/ehci-msm.c
===================================================================
--- usb.orig/drivers/usb/host/ehci-msm.c
+++ usb/drivers/usb/host/ehci-msm.c
@@ -125,7 +125,7 @@ static int ehci_msm_probe(struct platfor
 		goto put_hcd;
 	}
 
-	hcd->phy = phy;
+	hcd->transceiver = phy;
 	device_init_wakeup(&pdev->dev, 1);
 	/*
 	 * OTG device parent of HCD takes care of putting
@@ -152,7 +152,7 @@ static int ehci_msm_remove(struct platfo
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 
-	otg_set_host(hcd->phy->otg, NULL);
+	otg_set_host(hcd->transceiver->otg, NULL);
 
 	/* FIXME: need to call usb_remove_hcd() here? */
 
Index: usb/drivers/usb/host/ehci-tegra.c
===================================================================
--- usb.orig/drivers/usb/host/ehci-tegra.c
+++ usb/drivers/usb/host/ehci-tegra.c
@@ -154,7 +154,7 @@ static int tegra_ehci_hub_control(
 		if (tegra->port_resuming && !(temp & PORT_SUSPEND)) {
 			/* Resume completed, re-enable disconnect detection */
 			tegra->port_resuming = 0;
-			tegra_usb_phy_postresume(hcd->phy);
+			tegra_usb_phy_postresume(hcd->transceiver);
 		}
 	}
 
@@ -207,7 +207,7 @@ static int tegra_ehci_hub_control(
 			goto done;
 
 		/* Disable disconnect detection during port resume */
-		tegra_usb_phy_preresume(hcd->phy);
+		tegra_usb_phy_preresume(hcd->transceiver);
 
 		ehci->reset_done[wIndex-1] = jiffies + msecs_to_jiffies(25);
 
@@ -402,7 +402,7 @@ static int tegra_ehci_probe(struct platf
 		err = PTR_ERR(u_phy);
 		goto cleanup_clk_en;
 	}
-	hcd->phy = u_phy;
+	hcd->transceiver = u_phy;
 
 	tegra->needs_double_reset = of_property_read_bool(pdev->dev.of_node,
 		"nvidia,needs-double-reset");
@@ -424,7 +424,7 @@ static int tegra_ehci_probe(struct platf
 	ehci->caps = hcd->regs + 0x100;
 	ehci->has_hostpc = soc_config->has_hostpc;
 
-	err = usb_phy_init(hcd->phy);
+	err = usb_phy_init(hcd->transceiver);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to initialize phy\n");
 		goto cleanup_clk_en;
@@ -439,7 +439,7 @@ static int tegra_ehci_probe(struct platf
 	}
 	u_phy->otg->host = hcd_to_bus(hcd);
 
-	err = usb_phy_set_suspend(hcd->phy, 0);
+	err = usb_phy_set_suspend(hcd->transceiver, 0);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to power on the phy\n");
 		goto cleanup_phy;
@@ -466,7 +466,7 @@ static int tegra_ehci_probe(struct platf
 cleanup_otg_set_host:
 	otg_set_host(u_phy->otg, NULL);
 cleanup_phy:
-	usb_phy_shutdown(hcd->phy);
+	usb_phy_shutdown(hcd->transceiver);
 cleanup_clk_en:
 	clk_disable_unprepare(tegra->clk);
 cleanup_hcd_create:
@@ -480,9 +480,9 @@ static int tegra_ehci_remove(struct plat
 	struct tegra_ehci_hcd *tegra =
 		(struct tegra_ehci_hcd *)hcd_to_ehci(hcd)->priv;
 
-	otg_set_host(hcd->phy->otg, NULL);
+	otg_set_host(hcd->transceiver->otg, NULL);
 
-	usb_phy_shutdown(hcd->phy);
+	usb_phy_shutdown(hcd->transceiver);
 	usb_remove_hcd(hcd);
 	usb_put_hcd(hcd);
 
Index: usb/drivers/usb/host/ohci-omap.c
===================================================================
--- usb.orig/drivers/usb/host/ohci-omap.c
+++ usb/drivers/usb/host/ohci-omap.c
@@ -180,10 +180,10 @@ static void start_hnp(struct ohci_hcd *o
 	unsigned long	flags;
 	u32 l;
 
-	otg_start_hnp(hcd->phy->otg);
+	otg_start_hnp(hcd->transceiver->otg);
 
 	local_irq_save(flags);
-	hcd->phy->state = OTG_STATE_A_SUSPEND;
+	hcd->transceiver->state = OTG_STATE_A_SUSPEND;
 	writel (RH_PS_PSS, &ohci->regs->roothub.portstatus [port]);
 	l = omap_readl(OTG_CTRL);
 	l &= ~OTG_A_BUSREQ;
@@ -220,14 +220,14 @@ static int ohci_omap_reset(struct usb_hc
 
 #ifdef	CONFIG_USB_OTG
 	if (need_transceiver) {
-		hcd->phy = usb_get_phy(USB_PHY_TYPE_USB2);
-		if (!IS_ERR_OR_NULL(hcd->phy)) {
-			int	status = otg_set_host(hcd->phy->otg,
+		hcd->transceiver = usb_get_phy(USB_PHY_TYPE_USB2);
+		if (!IS_ERR_OR_NULL(hcd->transceiver)) {
+			int	status = otg_set_host(hcd->transceiver->otg,
 						&ohci_to_hcd(ohci)->self);
 			dev_dbg(hcd->self.controller, "init %s phy, status %d\n",
-					hcd->phy->label, status);
+					hcd->transceiver->label, status);
 			if (status) {
-				usb_put_phy(hcd->phy);
+				usb_put_phy(hcd->transceiver);
 				return status;
 			}
 		} else {
@@ -399,9 +399,9 @@ usb_hcd_omap_remove (struct usb_hcd *hcd
 	dev_dbg(hcd->self.controller, "stopping USB Controller\n");
 	usb_remove_hcd(hcd);
 	omap_ohci_clock_power(0);
-	if (!IS_ERR_OR_NULL(hcd->phy)) {
-		(void) otg_set_host(hcd->phy->otg, 0);
-		usb_put_phy(hcd->phy);
+	if (!IS_ERR_OR_NULL(hcd->transceiver)) {
+		(void) otg_set_host(hcd->transceiver->otg, 0);
+		usb_put_phy(hcd->transceiver);
 	}
 	if (machine_is_omap_osk())
 		gpio_free(9);
Index: usb/include/linux/usb/hcd.h
===================================================================
--- usb.orig/include/linux/usb/hcd.h
+++ usb/include/linux/usb/hcd.h
@@ -103,10 +103,10 @@ struct usb_hcd {
 	const struct hc_driver	*driver;	/* hw-specific hooks */
 
 	/*
-	 * OTG and some Host controllers need software interaction with phys;
-	 * other external phys should be software-transparent
+	 * OTG and some host controllers need software interaction with PHYs;
+	 * other external PHYs should be software-transparent
 	 */
-	struct usb_phy	*phy;
+	struct usb_phy		*transceiver;
 
 	/* Flags that need to be manipulated atomically because they can
 	 * change while the host controller is running.  Always use
