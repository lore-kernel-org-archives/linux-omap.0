From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Add ARM subarch and cross-compile again
Date: Fri, 22 Dec 2006 11:00:40 +0100
Message-ID: <458BACC8.3060104@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070703040505040302090904"
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
--------------070703040505040302090904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


ARM: OMAP: For convenience, switch subarch and cross-compile
of top level Makefile to ARM again. Seems to be lost
somewhere while merge.

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>

--------------070703040505040302090904
Content-Type: text/plain;
 name="omap_makefile_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="omap_makefile_patch.txt"

Index: linux-osk/Makefile
===================================================================
--- linux-osk.orig/Makefile
+++ linux-osk/Makefile
@@ -166,6 +166,8 @@ SUBARCH := $(shell uname -m | sed -e s/i
 				  -e s/s390x/s390/ -e s/parisc64/parisc/ \
 				  -e s/ppc.*/powerpc/ -e s/mips.*/mips/ )
 
+SUBARCH := arm
+
 # Cross compiling and selecting different set of gcc/bin-utils
 # ---------------------------------------------------------------------------
 #
@@ -186,7 +188,7 @@ SUBARCH := $(shell uname -m | sed -e s/i
 # Note: Some architectures assign CROSS_COMPILE in their arch/*/Makefile
 
 ARCH		?= $(SUBARCH)
-CROSS_COMPILE	?=
+CROSS_COMPILE	?= arm-linux-
 
 # Architecture as present in compile.h
 UTS_MACHINE := $(ARCH)


--------------070703040505040302090904
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------070703040505040302090904--
