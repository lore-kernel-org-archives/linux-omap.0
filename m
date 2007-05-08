From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] fix sti-netlink.c compilation failure
Date: Tue, 08 May 2007 14:01:10 -0600
Message-ID: <20070508200138.420874830@pwsan.com>
References: <20070508200109.272063491@pwsan.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline; filename=sti-netlink-compilation-fix.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Fix this compilation error in current linux-omap-2.6 git head:

  CC      arch/arm/plat-omap/sti/sti-netlink.o
arch/arm/plat-omap/sti/sti-netlink.c: In function 'sti_netlink_init':
arch/arm/plat-omap/sti/sti-netlink.c:145: warning: passing argument 4 of 'netlink_kernel_create' from incompatible pointer type
arch/arm/plat-omap/sti/sti-netlink.c:145: error: too few arguments to function 'netlink_kernel_create'
make[2]: *** [arch/arm/plat-omap/sti/sti-netlink.o] Error 1
make[1]: *** [arch/arm/plat-omap/sti] Error 2
make: *** [arch/arm/plat-omap] Error 2

Compile-tested only. 

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/plat-omap/sti/sti-netlink.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-omap-2.6/arch/arm/plat-omap/sti/sti-netlink.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/sti/sti-netlink.c
+++ linux-omap-2.6/arch/arm/plat-omap/sti/sti-netlink.c
@@ -142,7 +142,8 @@ static void sti_netlink_receive(struct s
 static int __init sti_netlink_init(void)
 {
 	sti_sock = netlink_kernel_create(NETLINK_USERSOCK, 0,
-					 sti_netlink_receive, THIS_MODULE);
+					 sti_netlink_receive, NULL,
+					 THIS_MODULE);
 	if (!sti_sock) {
 		printk(KERN_ERR "STI: Failed to create netlink socket\n");
 		return -ENODEV;

-- 
