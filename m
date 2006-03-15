From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH] Documentation/arm/OMAP/README update
Date: Wed, 15 Mar 2006 06:05:26 -0800 (PST)
Message-ID: <20060315140526.97321.qmail@web32904.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-669669662-1142431526=:97310"
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

--0-669669662-1142431526=:97310
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Tony,

Attached patch removes bk references and few changes to directory paths
for because of mach-omap2.

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-669669662-1142431526=:97310
Content-Type: text/x-patch; name="omap-readme.patch"
Content-Description: 3051579438-omap-readme.patch
Content-Disposition: inline; filename="omap-readme.patch"

diff --git a/Documentation/arm/OMAP/README b/Documentation/arm/OMAP/README
index e002e32..7e185e0 100644
--- a/Documentation/arm/OMAP/README
+++ b/Documentation/arm/OMAP/README
@@ -44,7 +44,7 @@ time.
 The first step is to get a bootloader for your board, u-boot is the
 recommended one:
 
-http://sourceforge.net/projects/uboot/
+http://www.denx.de/en/Software/GIT
 
 Then you need to compile it with the same cross compiler as you would use
 for the Linux kernel. Then you need to flash it to the board either via the
@@ -52,40 +52,16 @@ serial port, or by using a JTAG.
 
 Once you have the bootloader running, you can compile the kernel.
 
-You can get the OMAP sources either from the BitKeeper tree, or by
-applying patches. The BitKeeper tree has the most up to date sources
+You can get the OMAP sources either from the OMAP GIT tree, or by
+applying patches. The OMAP GIT tree has the most up to date sources
 and is the recommended one.
 
-- Using BitKeeper:
- 
-You need to download the bk tool from:
+- Using GIT and cloning OMAP GIT tree please follow the README at:
 
-http://www.bitmover.com/
-
-Download the dynamic one (x86-glibc22-linux) instead of the static 
-(x86-static-linux). Some users reported problems with the static version.
-
-After bk tool is installed, to learn more about bitkeeper you can follow the
-tutorial at:
-
-http://www.bitkeeper.com/UG/
-
-Then you can clone OMAP Linux by:
-
-bk clone http://linux-omap.bkbits.net/main
-
-Now, you have a copy (clone) of the reprository. To work with it and to
-compile the kernel you have to check out the files from your local 
-repository by:
-
-bk -r get (or: bk -r edit)
-
-For kernel related BitKeeper information see also kernel documentation in:
-
-Documentation/BK-usage/bk-kernel-howto.txt
+http://www.muru.com/linux/omap/README_OMAP_GIT
 
 Hint: If you are sitting behind a firewall and have to use a proxy for 
-internet access, you can access BitKeeper by http by setting the 
+internet access, you can access GIT by http by setting the 
 http_proxy envirionment variable:
 
 http_proxy=http://proxy_username:proxy_password@proxy_name:proxy_port/
@@ -104,7 +80,7 @@ abc.host.com: The name of your proxy you
 
 - Using Patches:
 
-If you don't want to use BitKeeper, then you can do the same thing with patch.
+If you don't want to use GIT, then you can do the same thing with patch.
 
 Download the latest OMAP Linux patch from:
 
@@ -125,8 +101,8 @@ $ cat ../Linux-2.6.4-omap1 | patch -p1
 Note: If OMAP patch from muru.com is against a kernel release candidate, 
 marked by -rcX, then kernel can be found on kernel.org under v2.6/testing/
 
-Now, if you have a local kernel tree, either by BitKeeper or by patch, you 
-should look into arch/arm/config/ to see which of the various omap_xxx
+Now, if you have a local kernel tree, either by GIT or by patch, you 
+should look into arch/arm/configs/ to see which of the various omap_xxx
 configurations there you want to use. For example, if you have a OMAP1510
 based Innovator board, you select omap_innovator_1510_defconfig by 
 
@@ -206,10 +182,13 @@ time of writing this document in March 2
 Innovator1510 (OMAP1510 processor), Innovator1610 (OMAP1610 processor), 
 Perseus2 (OMAP730 processor) and H2 (OMAP1610 processor).
 
+Please refer http://www.muru.com/linux/omap/ to get latest information on the
+list of boards supported.
+
 /* Discussion needed: How to handle the tons of compatible processors? 
 E.g. what to do if OMAP16xx is mainly identical with OMAP16yy? */
 
-2. Start with arch/arm/mach-omap/Kconfig and add a new processor or board 
+2. Start with arch/arm/mach-omap[1/2]/Kconfig and add a new processor or board 
 option.
 
 To add a new processor add a new config option to the "OMAP Core Type" choice. 
@@ -241,7 +220,7 @@ arch/arm/mm/Kconfig. E.g. ARCH_OMAP730 i
 
 3b. Only for new boards: Register the board within ARM Linux machine 
 registration system from RMK. For the CONFIG_ section use the same name like 
-in arch/arm/mach-omap/Kconfig. E.g. MACH_OMAP_yyyy. For MACH_TYPE_ section use 
+in arch/arm/mach-omap[1/2]/Kconfig. E.g. MACH_OMAP_yyyy. For MACH_TYPE_ section use 
 OMAP_yyyy where yyyy is the board name like above.
 
 Note: The elements of RMKs machine registration are used in 
@@ -262,14 +241,14 @@ Use board-yyyy.h with yyyy board name or
 
 5. Add a processor or board specific section into include/asm-arm/arch-omap/
 hardware.h. Use examples for syntax and use CONFIG_ names as defined in 
-arch/arm/mach-omap/Kconfig.
+arch/arm/mach-omap[1/2]/Kconfig.
 
 6. Add processor or board specific macros to board-yyyy.h or omapxxxx.h. The
 macros to these specific files have to be named OMAPxxxx_ with xxxx processor
 number to make them unique.
 
 7a. Only for new boards: Add a file board-yyyy.c with yyyy board name to 
-arch/arm/mach-omap/. Put board specific initialization code and resource 
+arch/arm/mach-omap[1/2]/. Put board specific initialization code and resource 
 description into this file. The first element of MACHINE_START must be equal to 
 MACH_TYPE_ section of machine registration (see arch/arm/tools/mach-types after 
 machine registration at RMKs registration system).
@@ -278,13 +257,13 @@ Put only code into this file that is boa
 board files for examples.
 
 7b. Only for new processors: Add processor specific IO description and
-iotable_init() to arch/arm/mach-omap/common.c. See examples for the syntax.
+iotable_init() to arch/arm/mach-omap[1/2]/io.c. See examples for the syntax.
 
 If you have introduced new clock definition in 2., add support for this new
-clock in include/asm-arm/arch-omap/clocks.h and arch/arm/mach-omap/clocks.c.
+clock in include/asm-arm/arch-omap/clocks.h and arch/arm/mach-omap[1/2]/clocks.c.
 
 8. Only for new boards: Add "obj-$(CONFIG_MACH_OMAP_yyyy) += board-yyyy.o" with 
-yyyy board name to arch/arm/mach-omap/Makefile. This is used to compile your new
+yyyy board name to arch/arm/mach-omap[1/2]/Makefile. This is used to compile your new
 board specific initialization code from 7a.
 
 9. Check if other of the existing files have to be adjusted for the new 
@@ -292,7 +271,7 @@ processor or board. Things to check:
 
 - Pin multiplexing
 - GPIO configuration
-- Powermanagement
+- Power Management
 - Clocking
 - Interrupt controller and interrupt configuration
 - Additional board specific things (e.g. FPGAs)
@@ -431,6 +410,6 @@ add a linux-c-mode to emacs.
 
 
 ------------------------------------------------------------------
-Last modified 13. June 2004
+Last modified 15. March 2006
 The OMAP Linux Kernel Team
 Dirk Behme <dirk.behme@de.bosch.com>

--0-669669662-1142431526=:97310
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-669669662-1142431526=:97310--
