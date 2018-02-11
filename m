From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: [PATCH usb-next v9 2/8] usb: add a flag to skip PHY initialization to struct usb_hcd
Date: Sun, 11 Feb 2018 22:06:45 +0100
Message-ID: <20180211210651.2046-3-martin.blumenstingl@googlemail.com>
References: <20180211210651.2046-1-martin.blumenstingl@googlemail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180211210651.2046-1-martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org, Peter.Chen-3arQi8VN3Tc@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, yixun.lan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org, Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The USB HCD core driver parses the device-tree node for "phys" and
"usb-phys" properties. It also manages the power state of these PHYs
automatically.
However, drivers may opt-out of this behavior by setting "phy" or
"usb_phy" in struct usb_hcd to a non-null value. An example where this
is required is the "Qualcomm USB2 controller", implemented by the
chipidea driver. The hardware requires that the PHY is only powered on
after the "reset completed" event from the controller is received.

A follow-up patch will allow the USB HCD core driver to manage more than
one PHY. Add a new "bool skip_phy_initialization" field to struct
usb_hcd so drivers can opt-out of any PHY management provided by the USB
HCD core driver. The new field will be used in that patch as well.

This also updates the existing drivers so they use the new flag if they
want to opt out of the PHY management provided by the USB HCD core
driver. This means that for these drivers the new "multiple PHY"
handling (which will be added in a follow-up patch) will be disabled as
well.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
---
 drivers/usb/chipidea/host.c      | 5 +----
 drivers/usb/core/hcd.c           | 4 ++--
 drivers/usb/host/ehci-fsl.c      | 2 ++
 drivers/usb/host/ehci-platform.c | 4 ++--
 drivers/usb/host/ehci-tegra.c    | 1 +
 drivers/usb/host/ohci-omap.c     | 1 +
 drivers/usb/host/ohci-platform.c | 4 ++--
 drivers/usb/host/xhci-plat.c     | 1 +
 include/linux/usb/hcd.h          | 6 ++++++
 9 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
index 19d60ed7e41f..493ef826ef4c 100644
--- a/drivers/usb/chipidea/host.c
+++ b/drivers/usb/chipidea/host.c
@@ -124,10 +124,7 @@ static int host_start(struct ci_hdrc *ci)
 
 	hcd->power_budget = ci->platdata->power_budget;
 	hcd->tpl_support = ci->platdata->tpl_support;
-	if (ci->phy)
-		hcd->phy = ci->phy;
-	else
-		hcd->usb_phy = ci->usb_phy;
+	hcd->skip_phy_initialization = ci->phy || ci->usb_phy;
 
 	ehci = hcd_to_ehci(hcd);
 	ehci->caps = ci->hw_bank.cap;
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index fc32391a34d5..f2307470a31e 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2727,7 +2727,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
 	int retval;
 	struct usb_device *rhdev;
 
-	if (IS_ENABLED(CONFIG_USB_PHY) && !hcd->usb_phy) {
+	if (IS_ENABLED(CONFIG_USB_PHY) && !hcd->skip_phy_initialization) {
 		struct usb_phy *phy = usb_get_phy_dev(hcd->self.sysdev, 0);
 
 		if (IS_ERR(phy)) {
@@ -2745,7 +2745,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
 		}
 	}
 
-	if (IS_ENABLED(CONFIG_GENERIC_PHY) && !hcd->phy) {
+	if (IS_ENABLED(CONFIG_GENERIC_PHY) && !hcd->skip_phy_initialization) {
 		struct phy *phy = phy_get(hcd->self.sysdev, "usb");
 
 		if (IS_ERR(phy)) {
diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index c5094cb88cd5..009de5e4e136 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -155,6 +155,8 @@ static int fsl_ehci_drv_probe(struct platform_device *pdev)
 			retval = -ENODEV;
 			goto err2;
 		}
+
+		hcd->skip_phy_initialization = true;
 	}
 #endif
 	return retval;
diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index b065a960adc2..40fbc4925378 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -219,9 +219,9 @@ static int ehci_platform_probe(struct platform_device *dev)
 			if (IS_ERR(priv->phys[phy_num])) {
 				err = PTR_ERR(priv->phys[phy_num]);
 					goto err_put_hcd;
-			} else if (!hcd->phy) {
+			} else {
 				/* Avoiding phy_get() in usb_add_hcd() */
-				hcd->phy = priv->phys[phy_num];
+				hcd->skip_phy_initialization = true;
 			}
 		}
 
diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/ehci-tegra.c
index c809f7d2f08f..9a8442a66b14 100644
--- a/drivers/usb/host/ehci-tegra.c
+++ b/drivers/usb/host/ehci-tegra.c
@@ -461,6 +461,7 @@ static int tegra_ehci_probe(struct platform_device *pdev)
 		goto cleanup_clk_en;
 	}
 	hcd->usb_phy = u_phy;
+	hcd->skip_phy_initialization = true;
 
 	tegra->needs_double_reset = of_property_read_bool(pdev->dev.of_node,
 		"nvidia,needs-double-reset");
diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
index 0201c49bc4fc..2255cbd73fb5 100644
--- a/drivers/usb/host/ohci-omap.c
+++ b/drivers/usb/host/ohci-omap.c
@@ -230,6 +230,7 @@ static int ohci_omap_reset(struct usb_hcd *hcd)
 		} else {
 			return -EPROBE_DEFER;
 		}
+		hcd->skip_phy_initialization = true;
 		ohci->start_hnp = start_hnp;
 	}
 #endif
diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
index 1e6c954f4b3f..bd605e79ae7d 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -186,9 +186,9 @@ static int ohci_platform_probe(struct platform_device *dev)
 			if (IS_ERR(priv->phys[phy_num])) {
 				err = PTR_ERR(priv->phys[phy_num]);
 				goto err_put_hcd;
-			} else if (!hcd->phy) {
+			} else {
 				/* Avoiding phy_get() in usb_add_hcd() */
-				hcd->phy = priv->phys[phy_num];
+				hcd->skip_phy_initialization = true;
 			}
 		}
 
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 6f038306c14d..ef01bc18bcf3 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -284,6 +284,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
 		ret = usb_phy_init(hcd->usb_phy);
 		if (ret)
 			goto put_usb3_hcd;
+		hcd->skip_phy_initialization = true;
 	}
 
 	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index 176900528822..b46fb6dd43ab 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -98,6 +98,12 @@ struct usb_hcd {
 	 */
 	const struct hc_driver	*driver;	/* hw-specific hooks */
 
+	/*
+	 * do not manage the PHY state in the HCD core, instead let the driver
+	 * handle this (for example if the PHY can only be turned on after a
+	 * specific event)
+	 */
+	bool skip_phy_initialization;
 	/*
 	 * OTG and some Host controllers need software interaction with phys;
 	 * other external phys should be software-transparent
-- 
2.16.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
