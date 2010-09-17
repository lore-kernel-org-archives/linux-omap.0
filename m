From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: [PATCH 00/14] omap sram, omap4 control module and es2.0 support
Date: Fri, 17 Sep 2010 23:06:11 +0800
Message-ID: <AANLkTi=z+FE14Uacfhuuk_U_g-9taMsN9tL4VW-j5qt0@mail.gmail.com>
References: <1284716878-27667-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:42478 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753908Ab0IQPGM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Sep 2010 11:06:12 -0400
Received: by vws3 with SMTP id 3so1550871vws.19
        for <linux-omap@vger.kernel.org>; Fri, 17 Sep 2010 08:06:11 -0700 (PDT)
In-Reply-To: <1284716878-27667-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Santosh,

Unfortunately, the kernel still cannot find MMC device and mount the
root file system on my Panda ES2.0 8 layers board.
Did we miss some patches? The Ubuntu 2.6.35 kernel boots fine.

-Bryan

On Fri, Sep 17, 2010 at 5:47 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> This is consolidated patch series targetted for 2.6.37 merge window.
> All of these patches have been already posted/reviewed on the list.
>
> The series contains
> =A0 =A0 =A0 =A0- SRAM mapping fixes to avoid speculative aborts
> =A0 =A0 =A0 =A0- omap4 control module support
> =A0 =A0 =A0 =A0- Fixes for omap4 HS/GP detection
> =A0 =A0 =A0 =A0- omap4 es2.0 fixes. MMC and ethernet fixes are queued=
 in respective
> =A0 =A0 =A0 =A0 =A0trees
>
> Boot tested with omap3_defconfig on
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0- OMAP4430 SPP
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0- OMAP4 Panda
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0- OMAP4 Blaze
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0- OMAP3430 SDP
>
> The following changes since commit 03a7ab083e4d619136d6f07ce70fa9de0b=
c436fc:
> =A0Linus Torvalds (1):
> =A0 =A0 =A0 =A0Merge git://git.kernel.org/.../sfrench/cifs-2.6
>
> are available in the git repository at:
>
> =A0git://dev.omapzoom.org/pub/scm/santosh/kernel-omap4-base.git omap_=
for_2.6.37
>
> David Anders (1):
> =A0 =A0 =A0omap4: Panda: Add DEBUG_LL support
>
> Santosh Shilimkar (11):
> =A0 =A0 =A0ARM: mmu: Setup MT_MEMORY and MT_MEMORY_NONCACHED L1 entri=
es
> =A0 =A0 =A0omap: Map only available sram memory
> =A0 =A0 =A0davinci: map sram using MT_MEMORY_NONCACHED instead of MT_=
DEVICE
> =A0 =A0 =A0omap4: control: Add ctrl_pad_base to omap_globals
> =A0 =A0 =A0omap4: control: Add accessor api's for pad control module
> =A0 =A0 =A0omap4: control: Add the register definition headers
> =A0 =A0 =A0omap4: control: Fix the control module register accesses
> =A0 =A0 =A0omap4: Update id.c and cpu.h for es2.0
> =A0 =A0 =A0omap4: Fix silicon version detection for early samples
> =A0 =A0 =A0omap4: l2x0: Fix init parameter for es2.0
> =A0 =A0 =A0omap4: Fix bootup crash observed with higher CPU clocks
>
> Vikram Pandita (2):
> =A0 =A0 =A0omap: sram: fix is_sram_locked check
> =A0 =A0 =A0omap4: sram: Fix start address
>
> =A0arch/arm/mach-davinci/dm355.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 =A03 +-
> =A0arch/arm/mach-davinci/dm365.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 =A03 +-
> =A0arch/arm/mach-davinci/dm644x.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 =A03 +-
> =A0arch/arm/mach-davinci/dm646x.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 =A03 +-
> =A0arch/arm/mach-omap2/control.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 25 +
> =A0arch/arm/mach-omap2/hsmmc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| =A0 67 +-
> =A0arch/arm/mach-omap2/id.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 40 +-
> =A0.../include/mach/ctrl_module_core_44xx.h =A0 =A0 =A0 =A0 =A0 | =A0=
391 ++++++
> =A0.../include/mach/ctrl_module_pad_core_44xx.h =A0 =A0 =A0 | 1409 ++=
++++++++++++++++++
> =A0.../include/mach/ctrl_module_pad_wkup_44xx.h =A0 =A0 =A0 | =A0236 =
++++
> =A0.../include/mach/ctrl_module_wkup_44xx.h =A0 =A0 =A0 =A0 =A0 | =A0=
 92 ++
> =A0arch/arm/mach-omap2/omap4-common.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 10 +-
> =A0arch/arm/mm/mmu.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0| =A0 17 +-
> =A0arch/arm/plat-omap/common.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| =A0 =A03 +-
> =A0arch/arm/plat-omap/dmtimer.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 =A02 +-
> =A0arch/arm/plat-omap/include/plat/common.h =A0 =A0 =A0 =A0 =A0 | =A0=
 =A01 +
> =A0arch/arm/plat-omap/include/plat/control.h =A0 =A0 =A0 =A0 =A0| =A0=
 31 +-
> =A0arch/arm/plat-omap/include/plat/cpu.h =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A05 +-
> =A0arch/arm/plat-omap/include/plat/uncompress.h =A0 =A0 =A0 | =A0 =A0=
1 +
> =A0arch/arm/plat-omap/sram.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| =A0 38 +-
> =A020 files changed, 2271 insertions(+), 109 deletions(-)
> =A0create mode 100644 arch/arm/mach-omap2/include/mach/ctrl_module_co=
re_44xx.h
> =A0create mode 100644 arch/arm/mach-omap2/include/mach/ctrl_module_pa=
d_core_44xx.h
> =A0create mode 100644 arch/arm/mach-omap2/include/mach/ctrl_module_pa=
d_wkup_44xx.h
> =A0create mode 100644 arch/arm/mach-omap2/include/mach/ctrl_module_wk=
up_44xx.h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
