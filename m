From: Dave Gerlach <d-gerlach@ti.com>
Subject: [RFC PATCH 0/3] Add ioremap_exec and extend drivers/misc/sram.c
Date: Mon, 9 May 2016 16:41:48 -0500
Message-ID: <1462830111-28172-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Russ Dill <russ.dill@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>, Tony Lindgren <tony@atomide.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Russell King <linux@arm.linux.org.uk>, Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,
There are several instances when one would want to execute out of on-chip
SRAM, such as PM code on ARM platforms, so once again revisiting this
series to allow that. Seems that having a solution for allowing SRAM to be
mapped as executable will help clean up PM code on several ARM platforms and
also open the door for others like TI AM335x and AM437x. This was first sent
here [1] but this is rebased and updated for v4.6-rc.

Many platforms have migrated to using the generic SRAM driver at
drivers/misc/sram.c but it doesn't seem like there is a clean solution
for the common problem of needing to map executable pages.

Currently I see several platforms (at-91, imx6, socfpga) taking the
address allocated by the genpool given by the SRAM driver and then calling
__arm_ioremap_exec on it again to get a new address that can be executed.
This doesn't seem like the cleanest solution, but maybe it works for code
that is under mach-xxx but what about code that migrates outside into the
drivers layer? Do any other architectures have a requirement for this?

I've converted omap3 PM code to use the generic SRAM driver which I'll send
in a series right after this one, and AM335x and AM437x can both make use of
this series as well and even go as far as to move a chunk of the PM
code into drivers (needs to be updated but sent long ago here [2]), but
that will be blocked if we don't have a generic way to ioremap memory as
exec, or at least a way to do it from drivers/.

If we don't want to go down this path, is there a better idea for how to
call ioremap_exec from drivers/ that we can all agree on?

Regards,
Dave

[1] https://lkml.org/lkml/2014/11/26/575
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/306534.html

Dave Gerlach (1):
  misc: SRAM: Add option to map SRAM to allow code execution

Russ Dill (2):
  asm-generic: io: Add exec versions of ioremap
  lib: devres: Add exec and exec_nocache versions of devm_ioremap

 Documentation/devicetree/bindings/sram/sram.txt |  2 +
 arch/arm/include/asm/io.h                       |  5 +++
 arch/arm/mm/ioremap.c                           | 14 ++++++
 arch/arm/mm/nommu.c                             | 14 ++++++
 drivers/misc/sram.c                             |  8 ++++
 include/asm-generic/iomap.h                     |  5 +++
 include/linux/io.h                              |  5 +++
 lib/devres.c                                    | 58 +++++++++++++++++++++++++
 8 files changed, 111 insertions(+)

-- 
2.7.3
