From: Felipe Balbi <me@felipebalbi.com>
Subject: omap: update omap README
Date: Sat, 30 Aug 2008 22:33:35 +0300
Message-ID: <20080830193330.GA9887@frodo>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:55511 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755935AbYH3TeC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 30 Aug 2008 15:34:02 -0400
Received: from a91-154-115-238.elisa-laajakaista.fi ([91.154.115.238]:17786 helo=@)
	by serv01.siteground211.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <me@felipebalbi.com>)
	id 1KZWCg-0000vH-W9
	for linux-omap@vger.kernel.org; Sat, 30 Aug 2008 14:33:59 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

From: Felipe Balbi <felipe.balbi@nokia.com>

OMAP's README was a bit outdated making references to
__REG() macros and unexistent paths.

Trivial fix.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---

diff --git a/Documentation/arm/OMAP/README b/Documentation/arm/OMAP/README
index f8ffb68..54fa7d4 100644
--- a/Documentation/arm/OMAP/README
+++ b/Documentation/arm/OMAP/README
@@ -5,19 +5,19 @@
 This is the README for Linux 2.6 on ARM based TI OMAP processors.
 
 In the first section it gives some general hints how to start with OMAP Linux.
- 
-When successfully build a OMAP Linux kernel with help of first section and no 
+
+When successfully build a OMAP Linux kernel with help of first section and no
 bootloader is already on the board, section 2 gives some tips how to use
-commercial JTAG tools. 
+commercial JTAG tools.
 
 In March 2004 the Linux Kernel 2.6 for ARM based TI OMAP processors was cleaned.
-The goal was to send clean patches to RMK's official ARM tree and to make it 
+The goal was to send clean patches to RMK's official ARM tree and to make it
 easier to add new OMAP processors or boards to the kernel tree. To keep the
-kernel tree clean now, this document describes also some steps how 
-to add code for a new OMAP processor or OMAP based board to the OMAP Linux 2.6 
+kernel tree clean now, this document describes also some steps how
+to add code for a new OMAP processor or OMAP based board to the OMAP Linux 2.6
 kernel tree. This is what the third section of this document is about.
 
-Section 4 of this README reports some rules to be followed to write 
+Section 4 of this README reports some rules to be followed to write
 clean code to make it ready for easy inclusion into public OMAP Linux kernel.
 
 For more information also see TI's 'Linux Community for Texas Instruments OMAP
@@ -29,26 +29,27 @@ There, various downloads and resources can be found (e.g. documentation how
 to build the kernel, how to use u-boot with OMAP Linux, pre-built tool chain
 etc.).
 
-The mailing list for OMAP Linux is hosted there, too:
+The mailing list for OMAP Linux is hosted by vger.kernel.org. To subscribe
+send 'subscribe linux-omap' to majordomo@vger.kernel.org. For archives see:
 
-http://linux.omap.com/mailman/listinfo
+http://marc.info/?l=linux-omap
 
 
 1. General hints how to start with OMAP Linux
 --------------------------------------------------------------
 
-The minimal setup is a arm-linux-gcc cross compiler, make, and some editor.
+The minimal setup is an arm-linux-gcc cross compiler, make, and some editor.
 You will also most likely need a JTAG to flash the bootloader for the first
 time.
 
 The first step is to get a bootloader for your board, u-boot is the
 recommended one:
 
-http://www.denx.de/en/Software/GIT
+http://git.denx.de/?p=u-boot.git;a=summary
 
-Then you need to compile it with the same cross compiler as you would use
-for the Linux kernel. Then you need to flash it to the board either via the
-serial port, or by using a JTAG.
+You need to compile it with the same cross compiler as you would use
+for the Linux kernel and flash it to the board either via the serial
+port, or by using a JTAG.
 
 Once you have the bootloader running, you can compile the kernel.
 
@@ -60,9 +61,9 @@ and is the recommended one.
 
 http://www.muru.com/linux/omap/README_OMAP_GIT
 
-Hint: If you are sitting behind a firewall and have to use a proxy for 
+Hint: If you are sitting behind a firewall and have to use a proxy for
 internet access, you can access GIT by http by setting the
-http_proxy envirionment variable:
+http_proxy environment variable:
 
 http_proxy=http://proxy_username:proxy_password@proxy_name:proxy_port/
 
@@ -98,13 +99,13 @@ $ tar xjf linux-2.6.4.tar.bz2
 $ cd linux-2.6.4
 $ cat ../Linux-2.6.4-omap1 | patch -p1
 
-Note: If OMAP patch from muru.com is against a kernel release candidate, 
+Note: If OMAP patch from muru.com is against a kernel release candidate,
 marked by -rcX, then kernel can be found on kernel.org under v2.6/testing/
 
 Now, if you have a local kernel tree, either by GIT or by patch, you
 should look into arch/arm/configs/ to see which of the various omap_xxx
-configurations there you want to use. For example, if you have a OMAP1510
-based Innovator board, you select omap_innovator_1510_defconfig by 
+configurations there you want to use. For example, if you have an OMAP1510
+based Innovator board, you select omap_innovator_1510_defconfig by
 
 $ make omap_innovator_1510_defconfig
 
@@ -137,14 +138,14 @@ Examples are TI's Code Composer Studio (CCS) or Lauterbach's TRACE32 JTAG.
 
 - Linux kernel download with CCS
 
-You can use CCS to directly load an ELF file to your board. For example, use  
+You can use CCS to directly load an ELF file to your board. For example, use
 arch/arm/boot/compressed/vmlinux. zImage isn't suited because it is not an ELF
-file. CCS looks for .out files, so copy arch/arm/boot/compressed/vmlinux 
+file. CCS looks for .out files, so copy arch/arm/boot/compressed/vmlinux
 to vmlinux.out and load it using CCS. Or use the filter *.* to select
-vmlinux directly. Remember to run arm-linux-strip on ELF file first as CCS 
+vmlinux directly. Remember to run arm-linux-strip on ELF file first as CCS
 get stroppy about unstripped ELF files.
 
-If you want vmlinux to be linked to run at a specific address, you can use 
+If you want vmlinux to be linked to run at a specific address, you can use
 the CONFIG_ZBOOT options in the kernel build. But first try without
 CONFIG_ZBOOT as the compressed image should be able to run from address
 zero (if your CCS .gel files map address zero.)
@@ -169,61 +170,61 @@ To be done.
 3. How to add new processor or board to OMAP Linux kernel tree
 --------------------------------------------------------------
 
-It is assumed that the OMAP processor to be added is based on an already 
-supported ARM core (e.g. ARM925 or ARM926). How to add support for new ARM 
+It is assumed that the OMAP processor to be added is based on an already
+supported ARM core (e.g. ARM925 or ARM926). How to add support for new ARM
 processor core that is not supported by ARM Linux is not scope of this document.
 
-1. If a new OMAP processor should be added, identify the ARM core of this 
-processor. E.g. at time of writing this document in March 2004 OMAP730 (ARM926 
+1. If a new OMAP processor should be added, identify the ARM core of this
+processor. E.g. at time of writing this document in March 2004 OMAP730 (ARM926
 core), OMAP1510 (ARM925 core) and OMAP1610 (ARM926 core) are supported.
 
-For a new board or device, identify the OMAP processor on the board. E.g. at 
-time of writing this document in March 2004 four boards are supported: 
-Innovator1510 (OMAP1510 processor), Innovator1610 (OMAP1610 processor), 
+For a new board or device, identify the OMAP processor on the board. E.g. at
+time of writing this document in March 2004 four boards are supported:
+Innovator1510 (OMAP1510 processor), Innovator1610 (OMAP1610 processor),
 Perseus2 (OMAP730 processor) and H2 (OMAP1610 processor).
 
 Please refer http://www.muru.com/linux/omap/ to get latest information on the
 list of boards supported.
 
-/* Discussion needed: How to handle the tons of compatible processors? 
+/* Discussion needed: How to handle the tons of compatible processors?
 E.g. what to do if OMAP16xx is mainly identical with OMAP16yy? */
 
 2. Start with arch/arm/mach-omap[1/2]/Kconfig and add a new processor or board
 option.
 
-To add a new processor add a new config option to the "OMAP Core Type" choice. 
-See examples for the syntax. The config option has to be called "ARCH_OMAPxxxx" 
+To add a new processor add a new config option to the "OMAP Core Type" choice.
+See examples for the syntax. The config option has to be called "ARCH_OMAPxxxx"
 where xxxx is the number of OMAP processor. Don't forget to select a existing
 clock frequency or to add a new one in "OMAP Feature Selections" section for
-your new processor. 
+your new processor.
 
-To add a new board or device, add a new config option to the "OMAP Board Type" 
-choice. See examples for the syntax. The config option for boards has to be 
-called "MACH_OMAP_yyyy" where yyyy is the board name. Don't forget to add a 
+To add a new board or device, add a new config option to the "OMAP Board Type"
+choice. See examples for the syntax. The config option for boards has to be
+called "MACH_OMAP_yyyy" where yyyy is the board name. Don't forget to add a
 short help.
 
-Note: Kernel 2.6 Kconfig system will automatically expand the configuration 
-names with a leading "CONFIG_". So "ARCH_OMAPxxxx" will be expanded to 
-"CONFIG_ARCH_OMAPxxxx" and "MACH_OMAP_yyy" will expand to 
-"CONFIG_MACH_OMAP_yyyy". In code this can then be used by macros like 
+Note: Kernel 2.6 Kconfig system will automatically expand the configuration
+names with a leading "CONFIG_". So "ARCH_OMAPxxxx" will be expanded to
+"CONFIG_ARCH_OMAPxxxx" and "MACH_OMAP_yyy" will expand to
+"CONFIG_MACH_OMAP_yyyy". In code this can then be used by macros like
 "#ifdef CONFIG_ARCH_OMAPxxxx" and "#ifdef CONFIG_MACH_OMAP_yyyy".
 
-Note: How to handle boards which are compatible or extensions of other boards? 
-See MACH_OMAP_H2 for example. The H2 depends on MACH_OMAP_INNOVATOR and expands 
+Note: How to handle boards which are compatible or extensions of other boards?
+See MACH_OMAP_H2 for example. The H2 depends on MACH_OMAP_INNOVATOR and expands
 it. This is done by an additional select MACH_OMAP_INNOVATOR in MACH_OMAP_H2
 configuration option. With this the whole MACH_OMAP_INNOVATOR configuration is
 selected and an additional symbol CONFIG_MACH_OMAP_H2 is available to
-distinguish between INNOVATOR and H2 where necessary. 
+distinguish between INNOVATOR and H2 where necessary.
 
-3a. Only for new processors: Add the ARCH_OMAPxxxx to the correct ARM core in 
+3a. Only for new processors: Add the ARCH_OMAPxxxx to the correct ARM core in
 arch/arm/mm/Kconfig. E.g. ARCH_OMAP730 in CPU_ARM926T configuration.
 
-3b. Only for new boards: Register the board within ARM Linux machine 
-registration system from RMK. For the CONFIG_ section use the same name like 
+3b. Only for new boards: Register the board within ARM Linux machine
+registration system from RMK. For the CONFIG_ section use the same name like
 in arch/arm/mach-omap[1/2]/Kconfig. E.g. MACH_OMAP_yyyy. For MACH_TYPE_ section use
 OMAP_yyyy where yyyy is the board name like above.
 
-Note: The elements of RMKs machine registration are used in 
+Note: The elements of RMKs machine registration are used in
 arch/arm/tools/mach-types. While kernel compilation
 include/asm-arm/mach-types.h is generated automagically from this file. The
 content of mach-types.h then is used for machine identification by kernel
@@ -236,37 +237,37 @@ www.arm.linux.org.uk/developer/machines/
 Note: Only OMAP based boards should be registered to RMKs registration
 system. Not processors.
 
-4. Add a processor or board specific header file in include/asm-arm/arch-omap/. 
+4. Add a processor or board specific header file in arch/arm/plat-omap/include/mach/.
 Use board-yyyy.h with yyyy board name or omapxxxx.h with xxxx processor number.
 
-5. Add a processor or board specific section into include/asm-arm/arch-omap/
-hardware.h. Use examples for syntax and use CONFIG_ names as defined in 
+5. Add a processor or board specific section into arch/arm/plat-omap/include/mach/
+hardware.h. Use examples for syntax and use CONFIG_ names as defined in
 arch/arm/mach-omap[1/2]/Kconfig.
 
 6. Add processor or board specific macros to board-yyyy.h or omapxxxx.h. The
 macros to these specific files have to be named OMAPxxxx_ with xxxx processor
 number to make them unique.
 
-7a. Only for new boards: Add a file board-yyyy.c with yyyy board name to 
+7a. Only for new boards: Add a file board-yyyy.c with yyyy board name to
 arch/arm/mach-omap[1/2]/. Put board specific initialization code and resource
-description into this file. The first element of MACHINE_START must be equal to 
-MACH_TYPE_ section of machine registration (see arch/arm/tools/mach-types after 
+description into this file. The first element of MACHINE_START must be equal to
+MACH_TYPE_ section of machine registration (see arch/arm/tools/mach-types after
 machine registration at RMKs registration system).
 
-Put only code into this file that is board specific and not common. See other 
+Put only code into this file that is board specific and not common. See other
 board files for examples.
 
 7b. Only for new processors: Add processor specific IO description and
 iotable_init() to arch/arm/mach-omap[1/2]/io.c. See examples for the syntax.
 
 If you have introduced new clock definition in 2., add support for this new
-clock in include/asm-arm/arch-omap/clocks.h and arch/arm/mach-omap[1/2]/clocks.c.
+clock in arch/arm/plat-omap/include/mach/clocks.h and arch/arm/mach-omap[1/2]/clocks.c.
 
-8. Only for new boards: Add "obj-$(CONFIG_MACH_OMAP_yyyy) += board-yyyy.o" with 
+8. Only for new boards: Add "obj-$(CONFIG_MACH_OMAP_yyyy) += board-yyyy.o" with
 yyyy board name to arch/arm/mach-omap[1/2]/Makefile. This is used to compile your new
 board specific initialization code from 7a.
 
-9. Check if other of the existing files have to be adjusted for the new 
+9. Check if other of the existing files have to be adjusted for the new
 processor or board. Things to check:
 
 - Pin multiplexing
@@ -276,32 +277,32 @@ processor or board. Things to check:
 - Interrupt controller and interrupt configuration
 - Additional board specific things (e.g. FPGAs)
 
-If other existing files or device drivers have to be changed, use the following 
+If other existing files or device drivers have to be changed, use the following
 mechanism for processor specific things:
 
 #ifdef CONFIG_ARCH_OMAPxxxx
- 	if (cpu_is_omapxxxx()) {
- 		/* Do the OMAPxxxx processor specific magic */
- 	}
+	if (cpu_is_omapxxxx()) {
+		/* Do the OMAPxxxx processor specific magic */
+	}
 #endif
 
-Note: cpu_is_omapxxxx() macro is defined in include/asm-arm/arch-omap/hardware.h
-and uses OMAP_ID_REG for runtime processor identifcation.
+Note: cpu_is_omapxxxx() macro is defined in arch/arm/plat-omap/include/mach/
+hardware.h and uses OMAP_ID_REG for runtime processor identifcation.
 
 For board differentiation use board macro from include/asm-arm/mach-types.h:
 
 #ifdef CONFIG_MACH_OMAP_yyyy
- 	if (machine_is_omap_yyyy()) {
- 		/* Do the board specific magic */
- 	}
+	if (machine_is_omap_yyyy()) {
+		/* Do the board specific magic */
+	}
 #endif
 
 Note: If technically possible and already implemented the OMAP Linux kernel
 has support for a "one binary fits all" machanism. That is, the goal is to be
 able to enable support for multiple OMAP processors and/or boards in Kconfig
-system. Then it is decided by bootparameters and at runtime on which processor 
-and/or board the kernel is actually running on. With this machanism it is 
-possible to use the same kernel binary on different OMAP processors or boards 
+system. Then it is decided by bootparameters and at runtime on which processor
+and/or board the kernel is actually running on. With this machanism it is
+possible to use the same kernel binary on different OMAP processors or boards
 without recompiling. This is achived by the cpu_is_omapxxxx() and
 machine_is_omap_yyyy() macros.
 
@@ -315,11 +316,11 @@ cpu_is_omapxxxx() and machine_is_omap_yyyy() selection.
 At the moment, the price for this flexibility is a increased number of #ifdef's
 throughout the code.
 
-10. Configure the kernel by make menuconfig or make xconfig and select the new 
+10. Configure the kernel by make menuconfig or make xconfig and select the new
 processor or board.
 
 11. Compile the kernel by an appropriate cross compilation toolchain. Make this
-until the code compiles error and warning free. The kernel should also be 
+until the code compiles error and warning free. The kernel should also be
 compiled with the various debug checking thingies enabled (e.g.
 CONFIG_DEBUG_SPINLOCK,  CONFIG_DEBUG_PAGEALLOC etc.).
 
@@ -327,7 +328,7 @@ CONFIG_DEBUG_SPINLOCK,  CONFIG_DEBUG_PAGEALLOC etc.).
 
 12. Download the kernel image to the board and test it until it works ;-)
 
-It's not in the scope of this document how to do this (use a appropriate 
+It's not in the scope of this document how to do this (use a appropriate
 bootloader or JTAG download).
 
 Note: The kernel initialization code expects some special values in the
@@ -337,16 +338,16 @@ zero, R1 has to contain the machine number from machine registration in
 arch/arm/tools/mach-types. R2 points to the physical address of tagged list
 in system RAM. For more information see Documentation/arm/Booting.
 
-While testing a new processor or board configuration, it is recommended to 
+While testing a new processor or board configuration, it is recommended to
 enable low level debugging. This uses low level output functions to print kernel
-messages on serial line before console is working. Enable it by 
+messages on serial line before console is working. Enable it by
 
 Kernel hacking -> Kernel debugging -> Kernel low-level debugging functions
 
 in kernel configuration system.
 
 13. Check that no other processors or boards are broken by the new code. A first
-test is to successful compile the other omap_xxx configurations from 
+test is to successful compile the other omap_xxx configurations from
 arch/arm/configs/. Do this by e.g.
 
 cd linux
@@ -356,52 +357,44 @@ Compile the kernel
 Even better: Enable support for several processors and boards in Kconfig
 system and compile kernel successfully.
 
-14. Only for new boards: Add a new default board configuration to 
-arch/arm/configs. Use omap_yyyy_xxxx_defconfig with yyyy boardname and xxxx 
+14. Only for new boards: Add a new default board configuration to
+arch/arm/configs. Use omap_yyyy_xxxx_defconfig with yyyy boardname and xxxx
 processornumber as filename.
 
 15. If the new code works, compiles without warnings and seems to break no other
-configurations, post a patch to linux-omap-open-source@list.ti.com.
+configurations, post a patch to linux-omap@vger.kernel.org.
 
 With sending a patch to the community, it is reviewed, can be used and tested by
-other users. It then can be included into the public OMAP kernel tree. 
+other users. It then can be included into the public OMAP kernel tree.
 
-16. Then adapt device drivers or write additional drivers for non-existing 
-processor peripherals or board devices. Improve and maintain the code for your 
+16. Then adapt device drivers or write additional drivers for non-existing
+processor peripherals or board devices. Improve and maintain the code for your
 new processor or board.
 
 
 4. General guidelines to write clean and OMAP Linux compatible code
 -------------------------------------------------------------------
 
-- For register access use the __REG8/16/32() macros. At the moment, see first
-example in include/asm-arm/arch-omap/hardware.h.
-
-Allegedly __REG() makes at least some versions of GCC emit tighter code
-than the more direct wrappers. Presumably by making it easier to use certain 
-addressing modes. 
+- For register access use the __raw_{read,write}[bwl]() functions. At the
+moment, see first example in arch/arm/plat-omap/include/mach/hardware.h.
 
 Make sure that the registers names are clearly marked as being registers
 (and not addresses of registers). This has to be done by adding a '_REG'
 suffix. E.g.
 
-#define OMAP_ID_REG  (__REG32(0xfffed400))
-#define DPLL_CTL_REG (__REG16(0xfffecf00))
-
-__raw_read[bwl] and __raw_write[bwl] are deprecated. They will converted to
-__REG8/16/32() syntax, soon. Don't use anything else like own pointer
-definitions or in[bwl]/out[bwl] etc., too.
+#define OMAP_ID_REG  0xfffed400
+#define DPLL_CTL_REG 0xfffecf00
 
-- Make read-modify-write register access preemption save. Use spin_lock() and 
-spin_unlock() where necessary. If an IRQ handler can access the registers, 
-use spin_lock_irqsave(), too. 
+- Make read-modify-write register access preemption save. Use spin_lock() and
+spin_unlock() where necessary. If an IRQ handler can access the registers,
+use spin_lock_irqsave(), too.
 
-- Functions declared as __init shouldn't have any references after the kernel 
+- Functions declared as __init shouldn't have any references after the kernel
 initialization phase is complete. Usually they should be static as well.
 
 - Don't use return statements at end of void functions.
 
-- Use consistent indentation style. Don't use space indentations. Use tab 
+- Use consistent indentation style. Don't use space indentations. Use tab
 indentations.
 
 - In general use Linux formatting style. See Documentation/CodingStyle for more
@@ -410,6 +403,6 @@ add a linux-c-mode to emacs.
 
 
 ------------------------------------------------------------------
-Last modified 15. March 2006
+Last modified 30. August 2008
 The OMAP Linux Kernel Team
 Dirk Behme <dirk.behme@de.bosch.com>


-- 
balbi
