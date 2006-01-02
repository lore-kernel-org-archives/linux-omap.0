From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH] gpio expander debug cleanup
Date: Mon, 2 Jan 2006 08:29:34 -0800 (PST)
Message-ID: <20060102162934.50310.qmail@web32913.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1350299462-1136219374=:49497"
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

--0-1350299462-1136219374=:49497
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Tony,

Do we really need this debug macros? If not, I have removed it in this
patch.

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---Komal Shah
http://komalshah.blogspot.com/


	
		
__________________________________ 
Yahoo! for Good - Make a difference this year. 
http://brand.yahoo.com/cybergivingweek2005/
--0-1350299462-1136219374=:49497
Content-Type: text/plain; name="gpio-expa-cleanup.patch"
Content-Description: 1819432133-gpio-expa-cleanup.patch
Content-Disposition: inline; filename="gpio-expa-cleanup.patch"

diff --git a/drivers/i2c/chips/gpio_expander_omap.c b/drivers/i2c/chips/gpio_expander_omap.c
index 7f42864..d63a6ee 100644
--- a/drivers/i2c/chips/gpio_expander_omap.c
+++ b/drivers/i2c/chips/gpio_expander_omap.c
@@ -19,16 +19,6 @@
 int read_gpio_expa(u8 * val, int addr);
 int write_gpio_expa(u8 val, int addr);
 
-#define OMAP_IRDA_DEBUG	0	
-
-#if (OMAP_IRDA_DEBUG > 0)
-#define DBG(format, args...) printk(KERN_ERR "%s(): " format, __FUNCTION__, ## args);
-#define DBG_IRQ(format, args...) printk(KERN_ERR "%s(): " format, __FUNCTION__, ## args);
-#else
-#define DBG(format, args...)
-#define DBG_IRQ(format, args...)
-#endif
-
 int write_gpio_expa(u8 val, int addr)
 {
 	struct i2c_adapter *adap;
@@ -71,7 +61,6 @@ int read_gpio_expa(u8 * val, int addr)
 	err = i2c_transfer(adap, msg, 1);
 	*val = data[0];
 
-	DBG("I2C: Read data is %x\n", (u8) * data);
 	if (err >= 0)
 		return 0;
 	return err;

--0-1350299462-1136219374=:49497
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-1350299462-1136219374=:49497--
