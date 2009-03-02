From: david.hagood@gmail.com
Subject: Anyone built the kernel drivers for the PowerVR under
     linux-omap-2.6?
Date: Mon, 2 Mar 2009 14:56:40 -0600 (CST)
Message-ID: <c6ef7709f9373651496b2a32ca42f571.squirrel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f176.google.com ([209.85.220.176]:61859 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474AbZCBU4t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Mar 2009 15:56:49 -0500
Received: by fxm24 with SMTP id 24so2166769fxm.37
        for <linux-omap@vger.kernel.org>; Mon, 02 Mar 2009 12:56:45 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by Deathwish.hagood.sktc.net (Postfix) with ESMTP id BB5EEC7B806F
	for <linux-omap@vger.kernel.org>; Mon,  2 Mar 2009 14:56:40 -0600 (CST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I'm trying to build the TI supplied Linux kernel driver modules for the
PowerVR accelerator chip in the OMAP3. I have a GIT tree pulled from the
linux-omap-2.6 tree, and a set of cross-compiler tools built and
installed.

I can build the kernel itself, but when I try to build the TI supplied code:
1) It references "asm/semaphore.h" rather than "linux/semaphore.h" - as
asm/semaphore no longer exists in the code the build fails. I can work
around that by creating a symlink to linux/semaphore.h.
2) It then references "asm/resources.h", which is ALSO gone. I'm guessing
it needs "asm-generic/resources.h".
3) However, at that point the compile REALLY dies, with the code looking
for "asm/arch/resources.h". If I link "arch/arm/include/asm" to
"asm/arch", then I get a large number of errors:

  CC [M] 
/space/src/OMAP35x_Graphics_SDC_3_00_00_06/GFX_Linux_KM/services4/srvkm/env/linux/kbuild/../../../../../services4/system/omap3430/sysconfig.o
  CC [M] 
/space/src/OMAP35x_Graphics_SDC_3_00_00_06/GFX_Linux_KM/services4/srvkm/env/linux/kbuild/../../../../../services4/system/omap3430/sysutils.o
In file included from
/space/src/OMAP35x_Graphics_SDC_3_00_00_06/GFX_Linux_KM/services4/srvkm/env/linux/kbuild/../../../../../services4/system/omap3430/sysutils.c:28:
/space/src/OMAP35x_Graphics_SDC_3_00_00_06/GFX_Linux_KM/services4/srvkm/env/linux/kbuild/../../../../../services4/system/omap3430/sysutils_linux.c:154:
error: variable 'cnstr_id_vdd2' has initializer but incomplete type
/space/src/OMAP35x_Graphics_SDC_3_00_00_06/GFX_Linux_KM/services4/srvkm/env/linux/kbuild/../../../../../services4/system/omap3430/sysutils_linux.c:155:
error: unknown field 'type' specified in initializer
/space/src/OMAP35x_Graphics_SDC_3_00_00_06/GFX_Linux_KM/services4/srvkm/env/linux/kbuild/../../../../../services4/system/omap3430/sysutils_linux.c:155:
error: 'RES_OPP_CO' undeclared here (not in a function)

So does anybody have an good advice on this?



