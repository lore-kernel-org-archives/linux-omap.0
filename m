From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: [PATCH] mtd/cmdlinepart.c: remove static declaration of
	mtdpart_setup
Date: Thu, 01 Feb 2007 11:09:58 +0100
Message-ID: <85odoenq89.fsf@orfeo.duckcorp.org>
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

The n770 (and maybe the n800 too) are using a tag for setting the
mtd partition layout and not the command line. The commit in linus tree
ddacff1f20fc5c96cc73e2975258e05d298c97cc is setting mtdpart_setup as
static, preventing its use in the omap-hw driver and thus, is breaking
the build.
So, here's a patch to revert it. imho we'll have to carry it in the omap
tree until the omap-hw driver is merged.

Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
---

--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline; filename=make_mtdpart_setup_not_static.patch

Revert the following commit :

commit ddacff1f20fc5c96cc73e2975258e05d298c97cc
Author: Adrian Bunk <bunk@stusta.de>
Date:   Sat Nov 25 20:15:41 2006 +0100

    [MTD] make drivers/mtd/cmdlinepart.c:mtdpart_setup() static
    
    This patch makes the needlessly global mtdpart_setup() static.
    
    Signed-off-by: Adrian Bunk <bunk@stusta.de>
    Signed-off-by: David Woodhouse <dwmw2@infradead.org>


Otherwise, the omap-hw can't work when the partition layout is in a TAG.
---
 drivers/mtd/cmdlinepart.c |    2 	1 +	1 -	0 !
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-omap-2.6/drivers/mtd/cmdlinepart.c
===================================================================
--- linux-omap-2.6.orig/drivers/mtd/cmdlinepart.c	2007-01-27 12:01:17.000000000 +0100
+++ linux-omap-2.6/drivers/mtd/cmdlinepart.c	2007-01-27 12:01:23.000000000 +0100
@@ -345,7 +345,7 @@ static int parse_cmdline_partitions(stru
  *
  * This function needs to be visible for bootloaders.
  */
-static int mtdpart_setup(char *s)
+int mtdpart_setup(char *s)
 {
 	cmdline = s;
 	return 1;

--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-=-=--
