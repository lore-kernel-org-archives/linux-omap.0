From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: [PATCH] omap-hw: Fix build
Date: Thu, 01 Feb 2007 11:05:23 +0100
Message-ID: <85sldqnqfw.fsf@orfeo.duckcorp.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
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

--=-=-=

Hi,

The n800 patches are renaming a struct and a atag name which is used in
the omap-hw driver without updating it. This patch does it.


Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
---

--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline; filename=tag_flash_rename.patch

---
 drivers/mtd/nand/omap-hw.c |    4 	2 +	2 -	0 !
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-omap-2.6/drivers/mtd/nand/omap-hw.c
===================================================================
--- linux-omap-2.6.orig/drivers/mtd/nand/omap-hw.c	2007-01-27 12:00:20.000000000 +0100
+++ linux-omap-2.6/drivers/mtd/nand/omap-hw.c	2007-01-27 12:00:55.000000000 +0100
@@ -669,12 +669,12 @@ static int __init add_dynamic_parts(stru
 {
 	static const char *part_parsers[] = { "cmdlinepart", NULL };
 	struct mtd_partition *parts;
-	const struct omap_flash_part_config *cfg;
+	const struct omap_flash_part_str_config *cfg;
 	char *part_str = NULL;
 	size_t part_str_len;
 	int c;
 
-	cfg = omap_get_var_config(OMAP_TAG_FLASH_PART, &part_str_len);
+	cfg = omap_get_var_config(OMAP_TAG_FLASH_PART_STR, &part_str_len);
 	if (cfg != NULL) {
 		part_str = kmalloc(part_str_len + 1, GFP_KERNEL);
 		if (part_str == NULL)

--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-=-=--
