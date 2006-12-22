From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Convert SLAB_KERNEL to GFP_KERNEL in omap_uwire.c
Date: Fri, 22 Dec 2006 11:11:14 +0100
Message-ID: <458BAF42.4000009@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060405050801060101000004"
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

This is a multi-part message in MIME format.
--------------060405050801060101000004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


ARM: OMAP: Convert SLAB_KERNEL to GFP_KERNEL in omap_uwire.c

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>

--------------060405050801060101000004
Content-Type: text/plain;
 name="omap_uwire_fixes.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="omap_uwire_fixes.txt"

Index: linux-osk/drivers/spi/omap_uwire.c
===================================================================
--- linux-osk.orig/drivers/spi/omap_uwire.c
+++ linux-osk/drivers/spi/omap_uwire.c
@@ -446,7 +446,7 @@ static int uwire_setup(struct spi_device
 	struct uwire_state *ust = spi->controller_state;
 
 	if (ust == NULL) {
-		ust = kzalloc(sizeof(*ust), SLAB_KERNEL);
+		ust = kzalloc(sizeof(*ust), GFP_KERNEL);
 		if (ust == NULL)
 			return -ENOMEM;
 		spi->controller_state = ust;



--------------060405050801060101000004
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------060405050801060101000004--
