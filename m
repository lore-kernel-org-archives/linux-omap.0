From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH 6/6] cbus/retu.c : Use platform_driver
Date: Thu, 16 Mar 2006 01:10:13 -0800 (PST)
Message-ID: <20060316091013.73389.qmail@web32901.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-449579309-1142500213=:67061"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--0-449579309-1142500213=:67061
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Use platform_driver

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-449579309-1142500213=:67061
Content-Type: text/x-patch; name="cbus06.patch"
Content-Description: 2052049283-cbus06.patch
Content-Disposition: inline; filename="cbus06.patch"

diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index 87ab216..9c93f4e 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -293,7 +293,7 @@ static void retu_power_off(void)
  * Probe for the Retu ASIC and allocate memory
  * for its device-struct if found
  */
-static int __devinit retu_probe(struct device *dev)
+static int __devinit retu_probe(struct platform_driver *pdev)
 {
 	const struct omap_em_asic_bb5_config * em_asic_config;
 	int rev, ret;
@@ -358,7 +358,7 @@ static int __devinit retu_probe(struct d
 	return 0;
 }
 
-static int retu_remove(struct device *dev)
+static int retu_remove(struct platform_driver *pdev)
 {
 #ifdef CONFIG_CBUS_RETU_USER
 	retu_user_cleanup();
@@ -377,11 +377,12 @@ static void retu_device_release(struct d
 	complete(&device_release);
 }
 
-static struct device_driver retu_driver = {
-	.name		= "retu",
-	.bus		= &platform_bus_type,
+static struct platform_driver retu_driver = {
 	.probe		= retu_probe,
 	.remove		= retu_remove,
+	.driver		= {
+		.name	= "retu",
+	},
 };
 
 static struct platform_device retu_device = {
@@ -392,6 +393,8 @@ static struct platform_device retu_devic
 	}
 };
 
+static char banner[] __initdata = KERN_INFO "Retu/Vilma driver initialising\n";
+
 /**
  * retu_init - initialise Retu driver
  *
@@ -401,15 +404,15 @@ static int __init retu_init(void)
 {
 	int ret = 0;
 
-	printk(KERN_INFO "Retu/Vilma driver initialising\n");
-
+	printk(banner);
+	
 	init_completion(&device_release);
 
-	if ((ret = driver_register(&retu_driver)) < 0)
+	if ((ret = platform_driver_register(&retu_driver)) < 0)
 		return ret;
 
 	if ((ret = platform_device_register(&retu_device)) < 0) {
-		driver_unregister(&retu_driver);
+		platform_driver_unregister(&retu_driver);
 		return ret;
 	}
 	return 0;
@@ -421,7 +424,7 @@ static int __init retu_init(void)
 static void __exit retu_exit(void)
 {
 	platform_device_unregister(&retu_device);
-	driver_unregister(&retu_driver);
+	platform_driver_unregister(&retu_driver);
 	wait_for_completion(&device_release);
 }
 

--0-449579309-1142500213=:67061
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-449579309-1142500213=:67061--
