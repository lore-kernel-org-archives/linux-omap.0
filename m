From: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] of: dma: fix potential deadlock when requesting a slave
 channel
Date: Tue, 25 Sep 2012 13:59:31 -0500
Message-ID: <1348599571-29546-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
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
To: Vinod Koul <vinod.koul-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, device-tree <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

In the latest version of the OF dma handlers I added support (rather hastily)
to exhaustively search for an available dma slave channel, for the use-case
where we have alternative slave channels that can be used. In the current
implementation a deadlock scenario can occur causing the CPU to loop forever.
The scenario is as follows ...

1. There are alternative channels avaialble
2. The first channel that is found by calling of_dma_find_channel() is not
   available and so the call to the xlate function returns NULL. In this case
   we will call of_dma_find_channel() again but we will return the same channel
   that we found the first time and hence, again the xlate will return NULL and
   we will loop here forever.

Fix this potential deadlock by just using a single for-loop and not a for-loop
nested in a do-while loop. This change also replaces the function
of_dma_find_channel() with of_dma_match_channel() which performs a simple check
to see if a DMA channel matches the name specified.

I have tested this implementation on an OMAP4 panda board by adding a dummy
DMA specifier, that will cause the xlate function to return NULL, to the
beginning of a list of DMA specifiers for a DMA client.

Cc: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>

Signed-off-by: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
---
 drivers/of/dma.c |   60 +++++++++++++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/of/dma.c b/drivers/of/dma.c
index 19ad37c..4bed490 100644
--- a/drivers/of/dma.c
+++ b/drivers/of/dma.c
@@ -108,37 +108,32 @@ void of_dma_controller_free(struct device_node *np)
 EXPORT_SYMBOL_GPL(of_dma_controller_free);
 
 /**
- * of_dma_find_channel - Find a DMA channel by name
+ * of_dma_match_channel - Check if a DMA specifier matches name
  * @np:		device node to look for DMA channels
- * @name:	name of desired channel
+ * @name:	channel name to be matched
+ * @index:	index of DMA specifier in list of DMA specifiers
  * @dma_spec:	pointer to DMA specifier as found in the device tree
  *
- * Find a DMA channel by the name. Returns 0 on success or appropriate
- * errno value on error.
+ * Check if the DMA specifier pointed to by the index in a list of DMA
+ * specifiers, matches the name provided. Returns 0 if the name matches and
+ * a valid pointer to the DMA specifier is found. Otherwise returns -ENODEV.
  */
-static int of_dma_find_channel(struct device_node *np, char *name,
-			       struct of_phandle_args *dma_spec)
+static int of_dma_match_channel(struct device_node *np, char *name, int index,
+				struct of_phandle_args *dma_spec)
 {
-	int count, i;
 	const char *s;
 
-	count = of_property_count_strings(np, "dma-names");
-	if (count < 0)
-		return count;
+	if (of_property_read_string_index(np, "dma-names", index, &s))
+		return -ENODEV;
 
-	for (i = 0; i < count; i++) {
-		if (of_property_read_string_index(np, "dma-names", i, &s))
-			continue;
+	if (strcmp(name, s))
+		return -ENODEV;
 
-		if (strcmp(name, s))
-			continue;
+	if (of_parse_phandle_with_args(np, "dmas", "#dma-cells", index,
+				       dma_spec))
+		return -ENODEV;
 
-		if (!of_parse_phandle_with_args(np, "dmas", "#dma-cells", i,
-						dma_spec))
-			return 0;
-	}
-
-	return -ENODEV;
+	return 0;
 }
 
 /**
@@ -154,19 +149,22 @@ struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
 	struct of_phandle_args	dma_spec;
 	struct of_dma		*ofdma;
 	struct dma_chan		*chan;
-	int			r;
+	int			count, i;
 
 	if (!np || !name) {
 		pr_err("%s: not enough information provided\n", __func__);
 		return NULL;
 	}
 
-	do {
-		r = of_dma_find_channel(np, name, &dma_spec);
-		if (r) {
-			pr_err("%s: can't find DMA channel\n", np->full_name);
-			return NULL;
-		}
+	count = of_property_count_strings(np, "dma-names");
+	if (count < 0) {
+		pr_err("%s: dma-names property missing or empty\n", __func__);
+		return NULL;
+	}
+
+	for (i = 0; i < count; i++) {
+		if (of_dma_match_channel(np, name, i, &dma_spec))
+			continue;
 
 		ofdma = of_dma_find_controller(dma_spec.np);
 		if (!ofdma) {
@@ -185,9 +183,11 @@ struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
 
 		of_node_put(dma_spec.np);
 
-	} while (!chan);
+		if (chan)
+			return chan;
+	}
 
-	return chan;
+	return NULL;
 }
 
 /**
-- 
1.7.9.5
