From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH 1/6] cbus/cbus.c : kmalloc + memset(0) to kzalloc
Date: Thu, 16 Mar 2006 00:55:57 -0800 (PST)
Message-ID: <20060316085557.12070.qmail@web32902.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-662472649-1142499357=:10839"
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

--0-662472649-1142499357=:10839
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Convert kmalloc + memset(0) to kzalloc

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-662472649-1142499357=:10839
Content-Type: text/x-patch; name="cbus01.patch"
Content-Description: 4060316779-cbus01.patch
Content-Disposition: inline; filename="cbus01.patch"

diff --git a/drivers/cbus/cbus.c b/drivers/cbus/cbus.c
index eff38be..081c647 100644
--- a/drivers/cbus/cbus.c
+++ b/drivers/cbus/cbus.c
@@ -222,12 +222,10 @@ int __init cbus_bus_init(void)
 	struct cbus_host *chost;
 	int ret;
 
-	chost = kmalloc(sizeof (*chost), GFP_KERNEL);
+	chost = kzalloc(sizeof (*chost), GFP_KERNEL);
 	if (chost == NULL)
 		return -ENOMEM;
 
-	memset(chost, 0, sizeof (*chost));
-
 	spin_lock_init(&chost->lock);
 
 	cbus_config = omap_get_config(OMAP_TAG_CBUS, struct omap_cbus_config);

--0-662472649-1142499357=:10839
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-662472649-1142499357=:10839--
