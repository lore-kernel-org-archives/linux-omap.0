From: Vikas C Sajjan <vikas.sajjan@linaro.org>
Subject: [PATCH 1/3] usb: dwc3: Add the suspend/resume functionality
Date: Wed, 10 Oct 2012 19:35:47 +0530
Message-ID: <1349877949-18872-2-git-send-email-vikas.sajjan@linaro.org>
References: <1349877949-18872-1-git-send-email-vikas.sajjan@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:45699 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756330Ab2JJOBn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Oct 2012 10:01:43 -0400
In-reply-to: <1349877949-18872-1-git-send-email-vikas.sajjan@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, sarah.a.sharp@linux.intel.com, balbi@ti.com, Vikas Sajjan <vikas.sajjan@linaro.org>, Abhilash Kesavan <a.kesavan@samsung.com>, Doug Anderson <dianders@chromium.org>

From: Vikas Sajjan <vikas.sajjan@linaro.org>

Adding the suspend and resume funtionality to DWC3 core.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Signed-off-by: Vikas C Sajjan <vikas.sajjan@linaro.org>
CC: Doug Anderson <dianders@chromium.org>
---
 drivers/usb/dwc3/core.c |  268 +++++++++++++++++++++++++++++-----------------
 1 files changed, 169 insertions(+), 99 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index b415c0c..58b51e1 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -70,51 +70,20 @@ MODULE_PARM_DESC(maximum_speed, "Maximum supported speed.");
 
 static DECLARE_BITMAP(dwc3_devs, DWC3_DEVS_POSSIBLE);
 
-int dwc3_get_device_id(void)
-{
-	int		id;
-
-again:
-	id = find_first_zero_bit(dwc3_devs, DWC3_DEVS_POSSIBLE);
-	if (id < DWC3_DEVS_POSSIBLE) {
-		int old;
-
-		old = test_and_set_bit(id, dwc3_devs);
-		if (old)
-			goto again;
-	} else {
-		pr_err("dwc3: no space for new device\n");
-		id = -ENOMEM;
-	}
-
-	return id;
-}
-EXPORT_SYMBOL_GPL(dwc3_get_device_id);
-
-void dwc3_put_device_id(int id)
-{
-	int			ret;
-
-	if (id < 0)
-		return;
-
-	ret = test_bit(id, dwc3_devs);
-	WARN(!ret, "dwc3: ID %d not in use\n", id);
-	smp_mb__before_clear_bit();
-	clear_bit(id, dwc3_devs);
-}
-EXPORT_SYMBOL_GPL(dwc3_put_device_id);
-
-void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
+static void __devinit dwc3_cache_hwparams(struct dwc3 *dwc)
 {
-	u32 reg;
+	struct dwc3_hwparams	*parms = &dwc->hwparams;
 
-	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
-	reg &= ~(DWC3_GCTL_PRTCAPDIR(DWC3_GCTL_PRTCAP_OTG));
-	reg |= DWC3_GCTL_PRTCAPDIR(mode);
-	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
+	parms->hwparams0 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS0);
+	parms->hwparams1 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS1);
+	parms->hwparams2 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS2);
+	parms->hwparams3 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS3);
+	parms->hwparams4 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS4);
+	parms->hwparams5 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS5);
+	parms->hwparams6 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS6);
+	parms->hwparams7 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS7);
+	parms->hwparams8 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS8);
 }
-
 /**
  * dwc3_core_soft_reset - Issues core soft reset and PHY reset
  * @dwc: pointer to our context structure
@@ -160,6 +129,102 @@ static void dwc3_core_soft_reset(struct dwc3 *dwc)
 	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
 }
 
+static int dwc3_core_reset(struct dwc3 *dwc)
+{
+	unsigned long	timeout;
+	u32	reg;
+
+	/* issue device SoftReset too */
+	timeout = jiffies + msecs_to_jiffies(500);
+	dwc3_writel(dwc->regs, DWC3_DCTL, DWC3_DCTL_CSFTRST);
+	do {
+		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
+		if (!(reg & DWC3_DCTL_CSFTRST))
+			break;
+
+		if (time_after(jiffies, timeout)) {
+			dev_err(dwc->dev, "Reset Timed Out\n");
+			return -ETIMEDOUT;
+		}
+
+		cpu_relax();
+	} while (true);
+
+	dwc3_core_soft_reset(dwc);
+
+	dwc3_cache_hwparams(dwc);
+
+	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
+	reg &= ~DWC3_GCTL_SCALEDOWN_MASK;
+	reg &= ~DWC3_GCTL_DISSCRAMBLE;
+
+	switch (DWC3_GHWPARAMS1_EN_PWROPT(dwc->hwparams.hwparams1)) {
+	case DWC3_GHWPARAMS1_EN_PWROPT_CLK:
+		reg &= ~DWC3_GCTL_DSBLCLKGTNG;
+		break;
+	default:
+		dev_dbg(dwc->dev, "No power optimization available\n");
+	}
+
+	/*
+	 * WORKAROUND: DWC3 revisions <1.90a have a bug
+	 * where the device can fail to connect at SuperSpeed
+	 * and falls back to high-speed mode which causes
+	 * the device to enter a Connect/Disconnect loop
+	 */
+	if (dwc->revision < DWC3_REVISION_190A)
+		reg |= DWC3_GCTL_U2RSTECN;
+
+	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
+
+	return 0;
+}
+
+int dwc3_get_device_id(void)
+{
+	int		id;
+
+again:
+	id = find_first_zero_bit(dwc3_devs, DWC3_DEVS_POSSIBLE);
+	if (id < DWC3_DEVS_POSSIBLE) {
+		int old;
+
+		old = test_and_set_bit(id, dwc3_devs);
+		if (old)
+			goto again;
+	} else {
+		pr_err("dwc3: no space for new device\n");
+		id = -ENOMEM;
+	}
+
+	return id;
+}
+EXPORT_SYMBOL_GPL(dwc3_get_device_id);
+
+void dwc3_put_device_id(int id)
+{
+	int			ret;
+
+	if (id < 0)
+		return;
+
+	ret = test_bit(id, dwc3_devs);
+	WARN(!ret, "dwc3: ID %d not in use\n", id);
+	smp_mb__before_clear_bit();
+	clear_bit(id, dwc3_devs);
+}
+EXPORT_SYMBOL_GPL(dwc3_put_device_id);
+
+void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
+{
+	u32 reg;
+
+	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
+	reg &= ~(DWC3_GCTL_PRTCAPDIR(DWC3_GCTL_PRTCAP_OTG));
+	reg |= DWC3_GCTL_PRTCAPDIR(mode);
+	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
+}
+
 /**
  * dwc3_free_one_event_buffer - Frees one event buffer
  * @dwc: Pointer to our controller context structure
@@ -303,20 +368,7 @@ static void dwc3_event_buffers_cleanup(struct dwc3 *dwc)
 	}
 }
 
-static void __devinit dwc3_cache_hwparams(struct dwc3 *dwc)
-{
-	struct dwc3_hwparams	*parms = &dwc->hwparams;
 
-	parms->hwparams0 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS0);
-	parms->hwparams1 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS1);
-	parms->hwparams2 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS2);
-	parms->hwparams3 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS3);
-	parms->hwparams4 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS4);
-	parms->hwparams5 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS5);
-	parms->hwparams6 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS6);
-	parms->hwparams7 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS7);
-	parms->hwparams8 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS8);
-}
 
 /**
  * dwc3_core_init - Low-level initialization of DWC3 Core
@@ -326,7 +378,6 @@ static void __devinit dwc3_cache_hwparams(struct dwc3 *dwc)
  */
 static int __devinit dwc3_core_init(struct dwc3 *dwc)
 {
-	unsigned long		timeout;
 	u32			reg;
 	int			ret;
 
@@ -339,49 +390,9 @@ static int __devinit dwc3_core_init(struct dwc3 *dwc)
 	}
 	dwc->revision = reg;
 
-	/* issue device SoftReset too */
-	timeout = jiffies + msecs_to_jiffies(500);
-	dwc3_writel(dwc->regs, DWC3_DCTL, DWC3_DCTL_CSFTRST);
-	do {
-		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
-		if (!(reg & DWC3_DCTL_CSFTRST))
-			break;
-
-		if (time_after(jiffies, timeout)) {
-			dev_err(dwc->dev, "Reset Timed Out\n");
-			ret = -ETIMEDOUT;
-			goto err0;
-		}
-
-		cpu_relax();
-	} while (true);
-
-	dwc3_core_soft_reset(dwc);
-
-	dwc3_cache_hwparams(dwc);
-
-	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
-	reg &= ~DWC3_GCTL_SCALEDOWN_MASK;
-	reg &= ~DWC3_GCTL_DISSCRAMBLE;
-
-	switch (DWC3_GHWPARAMS1_EN_PWROPT(dwc->hwparams.hwparams1)) {
-	case DWC3_GHWPARAMS1_EN_PWROPT_CLK:
-		reg &= ~DWC3_GCTL_DSBLCLKGTNG;
-		break;
-	default:
-		dev_dbg(dwc->dev, "No power optimization available\n");
-	}
-
-	/*
-	 * WORKAROUND: DWC3 revisions <1.90a have a bug
-	 * where the device can fail to connect at SuperSpeed
-	 * and falls back to high-speed mode which causes
-	 * the device to enter a Connect/Disconnect loop
-	 */
-	if (dwc->revision < DWC3_REVISION_190A)
-		reg |= DWC3_GCTL_U2RSTECN;
-
-	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
+	ret = dwc3_core_reset(dwc);
+	if (ret < 0)
+		goto err0;
 
 	ret = dwc3_alloc_event_buffers(dwc, DWC3_EVENT_BUFFERS_SIZE);
 	if (ret) {
@@ -622,11 +633,70 @@ static int __devexit dwc3_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int dwc3_core_resume(struct device *dev)
+{
+	struct dwc3	*dwc;
+	int	ret;
+
+	dwc = dev_get_drvdata(dev);
+	if (!dwc)
+		return -EINVAL;
+
+	ret = dwc3_core_reset(dwc);
+	if (ret < 0)
+		return ret;
+
+	ret = dwc3_event_buffers_setup(dwc);
+	if (ret < 0)
+		return ret;
+
+	switch (dwc->mode) {
+	case DWC3_MODE_DEVICE:
+		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
+		break;
+	case DWC3_MODE_HOST:
+		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
+		break;
+	case DWC3_MODE_DRD:
+		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
+	}
+
+	/* runtime set active to reflect active state. */
+	pm_runtime_disable(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	return 0;
+}
+
+static int dwc3_core_suspend(struct device *dev)
+{
+	struct dwc3	*dwc;
+
+	dwc = dev_get_drvdata(dev);
+	if (!dwc)
+		return -EINVAL;
+
+	dwc3_event_buffers_cleanup(dwc);
+
+	return 0;
+}
+
+static const struct dev_pm_ops dwc3_core_pm_ops = {
+	.suspend		= dwc3_core_suspend,
+	.resume			= dwc3_core_resume,
+};
+#endif /* CONFIG_PM */
+
 static struct platform_driver dwc3_driver = {
 	.probe		= dwc3_probe,
 	.remove		= __devexit_p(dwc3_remove),
 	.driver		= {
 		.name	= "dwc3",
+#ifdef CONFIG_PM
+		.pm = &dwc3_core_pm_ops,
+#endif
 	},
 };
 
-- 
1.7.6.5

