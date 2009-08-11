From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/9] OMAP: Remove omap boot parsing code
Date: Tue, 11 Aug 2009 12:49:15 +0300
Message-ID: <20090811094914.32577.90182.stgit@localhost>
References: <20090811094348.32577.81307.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <20090811094348.32577.81307.stgit@localhost>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Roger Quadros <ext-roger.quadros@nokia.com>
List-Id: linux-omap@vger.kernel.org

From: Roger Quadros <ext-roger.quadros@nokia.com>

Remove left over code for parsing omap boot tags. This is
no longer used.
see commit fc0ef1bfa1353e048e055374a09c75320d22231b

Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/common.c |   44 -------------------------------------------
 1 files changed, 0 insertions(+), 44 deletions(-)

diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index f37a29a..a6fa786 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -54,50 +54,6 @@ static const void *get_config(u16 tag, size_t len, int skip, size_t *len_out)
 	struct omap_board_config_kernel *kinfo = NULL;
 	int i;
 
-#ifdef CONFIG_OMAP_BOOT_TAG
-	struct omap_board_config_entry *info = NULL;
-
-	if (omap_bootloader_tag_len > 4)
-		info = (struct omap_board_config_entry *) omap_bootloader_tag;
-	while (info != NULL) {
-		u8 *next;
-
-		if (info->tag == tag) {
-			if (skip == 0)
-				break;
-			skip--;
-		}
-
-		if ((info->len & 0x03) != 0) {
-			/* We bail out to avoid an alignment fault */
-			printk(KERN_ERR "OMAP peripheral config: Length (%d) not word-aligned (tag %04x)\n",
-			       info->len, info->tag);
-			return NULL;
-		}
-		next = (u8 *) info + sizeof(*info) + info->len;
-		if (next >= omap_bootloader_tag + omap_bootloader_tag_len)
-			info = NULL;
-		else
-			info = (struct omap_board_config_entry *) next;
-	}
-	if (info != NULL) {
-		/* Check the length as a lame attempt to check for
-		 * binary inconsistency. */
-		if (len != NO_LENGTH_CHECK) {
-			/* Word-align len */
-			if (len & 0x03)
-				len = (len + 3) & ~0x03;
-			if (info->len != len) {
-				printk(KERN_ERR "OMAP peripheral config: Length mismatch with tag %x (want %d, got %d)\n",
-				       tag, len, info->len);
-				return NULL;
-			}
-		}
-		if (len_out != NULL)
-			*len_out = info->len;
-		return info->data;
-	}
-#endif
 	/* Try to find the config from the board-specific structures
 	 * in the kernel. */
 	for (i = 0; i < omap_board_config_size; i++) {


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
