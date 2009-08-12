From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCHv2 08/20] OMAP: McBSP: Add link DMA mode selection
Date: Wed, 12 Aug 2009 14:51:26 +0300
Message-ID: <20090812145126.bd028e6f.jhnikula@gmail.com>
References: <1249995931-26015-1-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-2-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-3-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-4-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-5-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-6-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-7-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-8-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-9-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:62292 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752599AbZHLLuC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Aug 2009 07:50:02 -0400
In-Reply-To: <1249995931-26015-9-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "\\\"Ujfalusi Peter (Nokia-D/Tampere)\\\"" <peter.ujfalusi@nokia.com>

On Tue, 11 Aug 2009 16:05:19 +0300
Eduardo Valentin <eduardo.valentin@nokia.com> wrote:

> From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> 
> It adds a new sysfs file, where the user can configure the mcbsp mode to use.
> If the mcbsp channel is in use, it does not allow the change.
> Than in omap_pcm_open we can call the omap_mcbsp_get_opmode to get the mode,
> store it, than use it to implement the different modes.

...
> +static ssize_t dma_op_mode_show(struct device *dev,
> +			struct device_attribute *attr, char *buf)
> +{
> +	struct omap_mcbsp *mcbsp = dev_get_drvdata(dev);
> +	int dma_op_mode;
> +
> +	spin_lock_irq(&mcbsp->lock);
> +	dma_op_mode = mcbsp->dma_op_mode;
> +	spin_unlock_irq(&mcbsp->lock);
> +
> +	return sprintf(buf, "current mode: %d\n"
> +			"possible mode values are:\n"
> +			"%d - %s\n"
> +			"%d - %s\n"
> +			"%d - %s\n",
> +			dma_op_mode,
> +			MCBSP_DMA_MODE_ELEMENT, "element mode",
> +			MCBSP_DMA_MODE_THRESHOLD, "threshold mode",
> +			MCBSP_DMA_MODE_FRAME, "frame mode");
> +}
> +

Btw: I hacked a patch below on top of the set for setting and reading the
operating mode in ascii. Freely usable, no guarantee :-)


-- 
Jarkko

--- 
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 50a9fea..e637a28 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -1147,6 +1147,10 @@ static DEVICE_ATTR(prop, 0644, prop##_show, prop##_store);
 THRESHOLD_PROP_BUILDER(max_tx_thres);
 THRESHOLD_PROP_BUILDER(max_rx_thres);
 
+static const char *dma_op_modes[] = {
+	"element", "threshold", "frame",
+};
+
 static ssize_t dma_op_mode_show(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
@@ -1157,15 +1161,7 @@ static ssize_t dma_op_mode_show(struct device *dev,
 	dma_op_mode = mcbsp->dma_op_mode;
 	spin_unlock_irq(&mcbsp->lock);
 
-	return sprintf(buf, "current mode: %d\n"
-			"possible mode values are:\n"
-			"%d - %s\n"
-			"%d - %s\n"
-			"%d - %s\n",
-			dma_op_mode,
-			MCBSP_DMA_MODE_ELEMENT, "element mode",
-			MCBSP_DMA_MODE_THRESHOLD, "threshold mode",
-			MCBSP_DMA_MODE_FRAME, "frame mode");
+	return sprintf(buf, "%s\n", dma_op_modes[dma_op_mode]);
 }
 
 static ssize_t dma_op_mode_store(struct device *dev,
@@ -1173,12 +1169,19 @@ static ssize_t dma_op_mode_store(struct device *dev,
 				const char *buf, size_t size)
 {
 	struct omap_mcbsp *mcbsp = dev_get_drvdata(dev);
-	unsigned long val;
-	int status;
-
-	status = strict_strtoul(buf, 0, &val);
-	if (status)
-		return status;
+	const char * const *s;
+	char *p;
+	int len, mode = 0;
+
+	p = memchr(buf, '\n', size);
+	len = p ? p - buf : size;
+
+	for (s = &dma_op_modes[mode];
+	     mode < ARRAY_SIZE(dma_op_modes); s++, mode++)
+		if (*s && len == strlen(*s) && !strncmp(buf, *s, len))
+			break;
+	if (mode == ARRAY_SIZE(dma_op_modes))
+		return -EINVAL;
 
 	spin_lock_irq(&mcbsp->lock);
 
@@ -1187,12 +1190,7 @@ static ssize_t dma_op_mode_store(struct device *dev,
 		goto unlock;
 	}
 
-	if (val > MCBSP_DMA_MODE_FRAME || val < MCBSP_DMA_MODE_ELEMENT) {
-		size = -EINVAL;
-		goto unlock;
-	}
-
-	mcbsp->dma_op_mode = val;
+	mcbsp->dma_op_mode = mode;
 
 unlock:
 	spin_unlock_irq(&mcbsp->lock);

