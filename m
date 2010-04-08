From: Rabin Vincent <rabin@rab.in>
Subject: Re: [RFC] Initial attempt to make ARM use LMB
Date: Thu, 8 Apr 2010 21:02:56 +0530
Message-ID: <20100408153111.GA2598@debian>
References: <20100325233248.GM24984@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20100325233248.GM24984@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 25, 2010 at 11:32:48PM +0000, Russell King - ARM Linux wrote:
> The patch below is the combined patch; individual patches can be found
> in the arm:lmb patches on the website or the lmb branch of my git tree;
> this should be considered unstable.

Something like the following is needed to make initrds work after this
patch:

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 8b2853a..8c12214 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -11,6 +11,7 @@
 #include <linux/errno.h>
 #include <linux/swap.h>
 #include <linux/init.h>
+#include <linux/initrd.h>
 #include <linux/bootmem.h>
 #include <linux/mman.h>
 #include <linux/nodemask.h>
@@ -32,9 +33,6 @@
 
 #include "mm.h"
 
-static unsigned long phys_initrd_start __initdata = 0;
-static unsigned long phys_initrd_size __initdata = 0;
-
 static int __init early_initrd(char *p)
 {
 	unsigned long start, size;
@@ -44,8 +42,8 @@ static int __init early_initrd(char *p)
 	if (*endp == ',') {
 		size = memparse(endp + 1, NULL);
 
-		phys_initrd_start = start;
-		phys_initrd_size = size;
+		initrd_start = __phys_to_virt(start);
+		initrd_end = initrd_start + size;
 	}
 	return 0;
 }
@@ -55,8 +53,8 @@ static int __init parse_tag_initrd(const struct tag *tag)
 {
 	printk(KERN_WARNING "ATAG_INITRD is deprecated; "
 		"please update your bootloader.\n");
-	phys_initrd_start = __virt_to_phys(tag->u.initrd.start);
-	phys_initrd_size = tag->u.initrd.size;
+	initrd_start = tag->u.initrd.start;
+	initrd_end = initrd_start + tag->u.initrd.size;
 	return 0;
 }
 
@@ -64,8 +62,8 @@ __tagtable(ATAG_INITRD, parse_tag_initrd);
 
 static int __init parse_tag_initrd2(const struct tag *tag)
 {
-	phys_initrd_start = tag->u.initrd.start;
-	phys_initrd_size = tag->u.initrd.size;
+	initrd_start = __phys_to_virt(tag->u.initrd.start);
+	initrd_end = initrd_start + tag->u.initrd.size;
 	return 0;
 }
 
@@ -284,7 +282,7 @@ void __init arm_lmb_reserve(void)
 #else
 	lmb_reserve(__pa(_stext), _end - _stext);
 #endif
-	lmb_reserve(phys_initrd_start, phys_initrd_size);
+	lmb_reserve(__pa(initrd_start), initrd_end - initrd_start);
 	arm_mm_lmb_reserve();
 }
