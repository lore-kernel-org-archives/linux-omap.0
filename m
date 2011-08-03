From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Shouldn't DT preserve pdev name and id to allow platform_match to
	work?
Date: Wed, 3 Aug 2011 17:04:01 +0200
Message-ID: <4E396361.3060307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "G,
	Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Nayak, Rajendra" <rnayak@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Grant,

Going further with the usage of OF_DEV_AUXDATA_ID, I realized that this is is not doing what I was expecting. My expectation might be silly, but in order to make platform_match to work without DT matching mechanism, you need to have the driver name in the pdev->name field:

	/* fall-back to driver name match */
	return (strcmp(pdev->name, drv->name) == 0);

Except that the of_device_add function is doing that:
	pdev->name = dev_name(&ofdev->dev);
	pdev->id = -1;

Thus overwriting the original pdev->name with the dev_name / bus_id in DT case.

Whereas the regular naming convention with pdev is to have dev_name = <name>.<id>".

Because of that, we cannot match the proper driver name with this entry: 

  OF_DEV_AUXDATA_ID("ti,omap-i2c", 0x48000100, "omap-i2c.1", 1, &i2c_pdata)

pdev->id will be properly overwritten after device creation, but not the pdev->name.
pdev->name will be "omap-i2c.1" instead of "omap-i2c".

By changing a little bit the format like that (removing the id from bus_id that is BTW redundant in that case):

  OF_DEV_AUXDATA_ID("ti,omap-i2c", 0x48000100, "omap-i2c", 1, &i2c_pdata)

We will be able to maintain the original driver name inside pdev->name and thus match correctly during probe with the legacy method.

Since DT is building a real platform_device, it seems to be reasonable to maintain the legacy name.

Moreover that will allow a basic driver to still probe correctly its devices.

Please find after a quick and dirty proof of concept.

Does that make sense to you?

Regards,
Benoit 


---
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 62b4b32..04727e4 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -51,11 +51,6 @@ int of_device_add(struct platform_device *ofdev)
 {
 	BUG_ON(ofdev->dev.of_node == NULL);
 
-	/* name and id have to be set so that the platform bus doesn't get
-	 * confused on matching */
-	ofdev->name = dev_name(&ofdev->dev);
-	ofdev->id = -1;
-
 	/* device_add will assume that this device is on the same node as
 	 * the parent. If there is no parent defined, set the node
 	 * explicitly */
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index ebbbf42..f7b6ec1 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -130,13 +130,14 @@ void of_device_make_bus_id(struct device *dev)
  */
 struct platform_device *of_device_alloc(struct device_node *np,
 				  const char *bus_id,
-				  struct device *parent)
+				  struct device *parent,
+				  int id)
 {
 	struct platform_device *dev;
 	int rc, i, num_reg = 0, num_irq;
 	struct resource *res, temp_res;
 
-	dev = platform_device_alloc("", -1);
+	dev = platform_device_alloc(bus_id ? bus_id : "", id);
 	if (!dev)
 		return NULL;
 
@@ -169,7 +170,10 @@ struct platform_device *of_device_alloc(struct device_node *np,
 	dev->dev.parent = parent;
 
 	if (bus_id)
-		dev_set_name(&dev->dev, "%s", bus_id);
+		if (id == -1)
+			dev_set_name(&dev->dev, "%s", bus_id);
+		else
+			dev_set_name(&dev->dev, "%s.%d", bus_id, id);
 	else
 		of_device_make_bus_id(&dev->dev);
 
@@ -191,14 +195,15 @@ struct platform_device *of_platform_device_create_pdata(
 					struct device_node *np,
 					const char *bus_id,
 					void *platform_data,
-					struct device *parent)
+					struct device *parent,
+					int id)
 {
 	struct platform_device *dev;
 
 	if (!of_device_is_available(np))
 		return NULL;
 
-	dev = of_device_alloc(np, bus_id, parent);
+	dev = of_device_alloc(np, bus_id, parent, id);
 	if (!dev)
 		return NULL;
 
@@ -235,7 +240,7 @@ struct platform_device *of_platform_device_create(struct device_node *np,
 					    const char *bus_id,
 					    struct device *parent)
 {
-	return of_platform_device_create_pdata(np, bus_id, NULL, parent);
+	return of_platform_device_create_pdata(np, bus_id, NULL, parent, -1);
 }
 EXPORT_SYMBOL(of_platform_device_create);
 
@@ -595,11 +600,7 @@ static int of_platform_bus_create(struct device_node *bus,
 		return 0;
 	}
 
-	dev = of_platform_device_create_pdata(bus, bus_id, platform_data, parent);
-
-	/* override the id if auxdata gives an id */
-	if (id != -1)
-		dev->id = id;
+	dev = of_platform_device_create_pdata(bus, bus_id, platform_data, parent, id);
 
 	if (!dev || !of_match_node(matches, bus))
 		return 0;
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index 252246c..9d3cbbe 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -84,7 +84,7 @@ extern const struct of_device_id of_default_bus_match_table[];
 /* Platform drivers register/unregister */
 extern struct platform_device *of_device_alloc(struct device_node *np,
 					 const char *bus_id,
-					 struct device *parent);
+					 struct device *parent, int id);
 extern struct platform_device *of_find_device_by_node(struct device_node *np);
 
 #if !defined(CONFIG_SPARC) /* SPARC has its own device registration method */
