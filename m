From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V4 1/2] of: Add generic device tree DMA helpers
Date: Fri, 14 Sep 2012 09:03:18 -0500
Message-ID: <50533926.1070201@ti.com>
References: <1347573629-21299-1-git-send-email-jon-hunter@ti.com> <201209140943.49904.arnd@arndb.de> <505330B4.4070605@ti.com> <201209141332.42420.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50527 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756160Ab2INODo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Sep 2012 10:03:44 -0400
In-Reply-To: <201209141332.42420.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@nvidia.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, Rob Herring <rob.herring@calxeda.com>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <djbw@fb.com>


On 09/14/2012 08:32 AM, Arnd Bergmann wrote:
> On Friday 14 September 2012, Jon Hunter wrote:
>> On 09/14/2012 04:43 AM, Arnd Bergmann wrote:
>>>> +
>>>> +Client drivers should specify the DMA property using a phandle to the controller
>>>> +followed by DMA controller specific data.
>>>> +
>>>> +Required property:
>>>> +- dmas:			List of one or more DMA specifiers, each consisting of
>>>> +			- A phandle pointing to DMA controller node
>>>> +			- A single integer cell containing DMA controller
>>>> +			  specific information. This typically contains a dma
>>>> +			  request line number or a channel number, but can
>>>> +			  contain any data that is used required for configuring
>>>> +			  a channel.
>>>> +- dma-names: 		Contains one identifier string for each dma specifier in
>>>> +			the dmas property. The specific strings that can be used
>>>> +			are defined in the binding of the DMA client device.
>>>
>>> I think here we need to clarify that listing the same name multiple times implies
>>> having multiple alternatives for the same channel.
>>
>> Ok, however, the way it works right now is that we will use the first
>> specifier that matches the name. So if there are multiple with the same
>> name that would imply that someone will need call the
>> xxx_request_slave_channel() multiple times to extract these. Is that ok?
> 
> I would expect a driver to only call the function once, and get something
> back from the dmaengine layer that works. If there are two controllers
> to choose from and one is busy, then it should definitely give a channel
> from the non-busy one.
> 
> It's not much of an issue if the code doesn't handle all corner cases at
> first, but I would expect that the binding correctly describes how to write
> a device tree that will work once the code implements it correctly.

Gotcha, may be something like the following should work then ...

diff --git a/drivers/of/dma.c b/drivers/of/dma.c
index 4025f2f..de59611 100644
--- a/drivers/of/dma.c
+++ b/drivers/of/dma.c
@@ -127,13 +127,15 @@ static int of_dma_find_channel(struct device_node *np, char *name,
 		return count;
 
 	for (i = 0; i < count; i++) {
-		of_property_read_string_index(np, "dma-names", i, &s);
+		if (of_property_read_string_index(np, "dma-names", i, &s))
+			continue;
 
 		if (strcmp(name, s))
 			continue;
 
-		return of_parse_phandle_with_args(np, "dmas", "#dma-cells",
-							i, dma_spec);
+		if (!of_parse_phandle_with_args(np, "dmas", "#dma-cells", i,
+						dma_spec))
+			return 0;
 	}
 
 	return -ENODEV;
@@ -159,33 +161,34 @@ struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
 		return NULL;
 	}
 
-	r = of_dma_find_channel(np, name, &dma_spec);
-
-	if (r) {
-		pr_err("%s: can't find DMA channel\n", np->full_name);
-		return NULL;
-	}
+	do {
+		r = of_dma_find_channel(np, name, &dma_spec);
+		if (r) {
+			pr_err("%s: can't find DMA channel\n", np->full_name);
+			return NULL;
+		}
+
+		ofdma = of_dma_find_controller(dma_spec.np);
+		if (!ofdma) {
+			pr_debug("%s: can't find DMA controller %s\n",
+			       np->full_name, dma_spec.np->full_name);
+			continue;
+		}
 
-	ofdma = of_dma_find_controller(dma_spec.np);
-	if (!ofdma) {
-		pr_err("%s: can't find DMA controller %s\n", np->full_name,
-		       dma_spec.np->full_name);
-		return NULL;
-	}
+		if (dma_spec.args_count != ofdma->of_dma_nbcells) {
+			pr_debug("%s: wrong #dma-cells for %s\n", np->full_name,
+			       dma_spec.np->full_name);
+			continue;
+		}
 
-	if (dma_spec.args_count != ofdma->of_dma_nbcells) {
-		pr_err("%s: wrong #dma-cells for %s\n", np->full_name,
-		       dma_spec.np->full_name);
-		return NULL;
-	}
+		chan = ofdma->of_dma_xlate(&dma_spec, ofdma);
 
-	chan = ofdma->of_dma_xlate(&dma_spec, ofdma);
+		of_node_put(dma_spec.np);
 
-	of_node_put(dma_spec.np);
+	} while (!chan);
 
 	return chan;
 }
-EXPORT_SYMBOL_GPL(of_dma_request_slave_channel);
 
Cheers
Jon
