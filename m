From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [patch 1/5] MMC BUGFIX TRIVIAL STUFFS
Date: Wed, 8 Mar 2006 10:27:13 +0200
Message-ID: <20060308102713.0d776969.Hiroshi.DOYU@nokia.com>
References: <20060307171122.002855000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060307171122.002855000@localhost.localdomain>
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

This includes small modifications as below.

     - kmalloc() & memset(0) was replaced by kzalloc()
     - bugfix for incorrect pointer argument

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

 drivers/mmc/mmc_sysfs.c |    4 +---
 drivers/mmc/omap.c      |    2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

Index: linux-omap/drivers/mmc/mmc_sysfs.c
===================================================================
--- linux-omap.orig/drivers/mmc/mmc_sysfs.c	2006-03-07 18:19:34.000000000 +0200
+++ linux-omap/drivers/mmc/mmc_sysfs.c	2006-03-07 18:19:37.000000000 +0200
@@ -262,10 +262,8 @@
 {
 	struct mmc_host *host;
 
-	host = kmalloc(sizeof(struct mmc_host) + extra, GFP_KERNEL);
+	host = kzalloc(sizeof(struct mmc_host) + extra, GFP_KERNEL);
 	if (host) {
-		memset(host, 0, sizeof(struct mmc_host) + extra);
-
 		host->dev = dev;
 		host->class_dev.dev = host->dev;
 		host->class_dev.class = &mmc_host_class;
Index: linux-omap/drivers/mmc/omap.c
===================================================================
--- linux-omap.orig/drivers/mmc/omap.c	2006-03-07 18:19:34.000000000 +0200
+++ linux-omap/drivers/mmc/omap.c	2006-03-07 18:19:37.000000000 +0200
@@ -1362,7 +1362,7 @@
 
 	if (omap_has_menelaus())
 		menelaus_mmc_register(mmc_omap_switch_callback,
-	  (unsigned long)&host);
+				      (unsigned long)host);
 
 no_switch:
 	return 0;

--

		Hiroshi DOYU
