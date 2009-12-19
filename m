From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/5] arm: Fix init_atags_procfs() to check tag->hdr.size
Date: Fri, 18 Dec 2009 19:46:30 -0800
Message-ID: <20091219034630.26198.35713.stgit@localhost>
References: <20091219034151.26198.26570.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59080 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754822AbZLSDqf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 22:46:35 -0500
In-Reply-To: <20091219034151.26198.26570.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

The tag->hdr.size cannot be larger than XXX.
Otherwise we can getsomething similar during boot:

Unable to handle kernel paging request at virtual address 61a05020
...

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/include/asm/setup.h   |   12 +++++++++---
 arch/arm/kernel/atags.c        |    2 +-
 arch/arm/kernel/compat.c       |    2 +-
 arch/arm/kernel/setup.c        |    4 ++--
 arch/arm/mach-orion5x/common.c |    2 +-
 5 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/setup.h b/arch/arm/include/asm/setup.h
index 5ccce0a..3ca36bb 100644
--- a/arch/arm/include/asm/setup.h
+++ b/arch/arm/include/asm/setup.h
@@ -21,6 +21,11 @@
 /* The list ends with an ATAG_NONE node. */
 #define ATAG_NONE	0x00000000
 
+/* Some sanity checks are needed */
+#define ATAG_MAX_SZ	PAGE_SIZE
+#define atag_valid(tag)							\
+	((tag)->hdr.size && ((tag)->hdr.size <= ATAG_MAX_SZ))
+
 struct tag_header {
 	__u32 size;
 	__u32 tag;
@@ -173,9 +178,10 @@ struct tagtable {
 	int (*parse)(const struct tag *);
 };
 
-#define tag_member_present(tag,member)				\
-	((unsigned long)(&((struct tag *)0L)->member + 1)	\
-		<= (tag)->hdr.size * 4)
+#define tag_member_present(tag,member)					\
+	(atag_valid(tag) &&						\
+		(((unsigned long)(&((struct tag *)0L)->member + 1)	\
+			<= (tag)->hdr.size * 4))
 
 #define tag_next(t)	((struct tag *)((__u32 *)(t) + (t)->hdr.size))
 #define tag_size(type)	((sizeof(struct tag_header) + sizeof(struct type)) >> 2)
diff --git a/arch/arm/kernel/atags.c b/arch/arm/kernel/atags.c
index 42a1a14..14d0993 100644
--- a/arch/arm/kernel/atags.c
+++ b/arch/arm/kernel/atags.c
@@ -51,7 +51,7 @@ static int __init init_atags_procfs(void)
 		return -EINVAL;
 	}
 
-	for (; tag->hdr.size; tag = tag_next(tag))
+	for (; atag_valid(tag); tag = tag_next(tag))
 		;
 
 	/* include the terminating ATAG_NONE */
diff --git a/arch/arm/kernel/compat.c b/arch/arm/kernel/compat.c
index 0a13854..3e63ee1 100644
--- a/arch/arm/kernel/compat.c
+++ b/arch/arm/kernel/compat.c
@@ -220,7 +220,7 @@ void __init convert_to_tag_list(struct tag *tags)
 
 void __init squash_mem_tags(struct tag *tag)
 {
-	for (; tag->hdr.size; tag = tag_next(tag))
+	for (; atag_valid(tag); tag = tag_next(tag))
 		if (tag->hdr.tag == ATAG_MEM)
 			tag->hdr.tag = ATAG_NONE;
 }
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index c6c57b6..53d7181 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -556,7 +556,7 @@ request_standard_resources(struct meminfo *mi, struct machine_desc *mdesc)
  */
 static int __init parse_tag_core(const struct tag *tag)
 {
-	if (tag->hdr.size > 2) {
+	if ((atag_valid(tag) && (tag->hdr.size > 2))) {
 		if ((tag->u.core.flags & 1) == 0)
 			root_mountflags &= ~MS_RDONLY;
 		ROOT_DEV = old_decode_dev(tag->u.core.rootdev);
@@ -660,7 +660,7 @@ static int __init parse_tag(const struct tag *tag)
  */
 static void __init parse_tags(const struct tag *t)
 {
-	for (; t->hdr.size; t = tag_next(t))
+	for (; atag_valid(t); t = tag_next(t))
 		if (!parse_tag(t))
 			printk(KERN_WARNING
 				"Ignoring unrecognised tag 0x%08x\n",
diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
index f87fa12..8afee34 100644
--- a/arch/arm/mach-orion5x/common.c
+++ b/arch/arm/mach-orion5x/common.c
@@ -717,7 +717,7 @@ void __init orion5x_init(void)
 void __init tag_fixup_mem32(struct machine_desc *mdesc, struct tag *t,
 			    char **from, struct meminfo *meminfo)
 {
-	for (; t->hdr.size; t = tag_next(t))
+	for (; atag_valid(t); t = tag_next(t))
 		if (t->hdr.tag == ATAG_MEM &&
 		    (!t->u.mem.size || t->u.mem.size & ~PAGE_MASK ||
 		     t->u.mem.start & ~PAGE_MASK)) {

