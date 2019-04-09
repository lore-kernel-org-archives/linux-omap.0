From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 3/3] ARM: omap2: move platform-specific asm-offset.h to arch/arm/mach-omap2
Date: Tue, 9 Apr 2019 14:07:43 +0900
Message-ID: <CAK7LNASYqkhW_W6K5Y9NvmqnZ2aSCbGZNw0ZFrBB3Dd2FRN8yg@mail.gmail.com>
References: <20190408075427.6052-1-yamada.masahiro@socionext.com>
 <20190408075427.6052-3-yamada.masahiro@socionext.com> <20190408161802.GI49658@atomide.com>
 <6308904e-443a-46ff-9633-2ccb3b03bef9@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6308904e-443a-46ff-9633-2ccb3b03bef9@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>, Tony Lindgren <tony@atomide.com>, arm-soc <arm@kernel.org>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 9, 2019 at 2:00 PM Keerthy <j-keerthy@ti.com> wrote:
>
>
>
> On 08/04/19 9:48 PM, Tony Lindgren wrote:
> > Hi,
> >
> > * Masahiro Yamada <yamada.masahiro@socionext.com> [190408 07:56]:
> >> <generated/ti-pm-asm-offsets.h> is only generated and included
> >> by arch/arm/mach-omap2/, so it does not need to reside in the
> >> globally visible include/generated/.
> >>
> >> I moved and renamed it to arch/arm/mach-omap2/pm-asm-offsets.h
> >> since the prefix 'omap2-' is just redundant in mach-omap2/.
> >>
> >> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> >> ---
> >>
> >> Can this be applied to ARM-SOC tree in a series?
> >> (with Ack from the platform sub-maintainer.)
> >>
> >> ti-pm-asm-offsets.h does not need to reside in include/generated/,
> >> but you may ask "Why must it get out of include/generated/?"
> >>
> >> My main motivation is to avoid a race condition in the currently
> >> proposed patch:
> >>
> >> https://lore.kernel.org/patchwork/patch/1052763/
> >>
> >> This patch tries to embed some build artifacts into the kernel.
> >>
> >> If arch/arm/mach-omap2/ and kernel/ are built at the same time,
> >> it may embed a truncated file.
> >
> > Looks like a nice improvment to me, adding Keerthy and Dave to Cc.
> >
> > Keerthy and Dave, can you please test this series with am3 and am4
> > PM code?
>
> Tested for Deep Sleep0 on AM33xx Beaglebone-black.
> Tested for Deep Sleep0 on AM437x-gp-evm.
>
> Applied this on top of Tony's for-next with the gpio patch
> required for RTC+DDR mode on am437x-gp-evm.

Was it applied to TI tree?

If so ...

Arnd, Olof,
Please just ignore this patch
since it looks it was already applied to TI tree.

Thanks.
Masahiro Yamada




> Tested-by: Keerthy <j-keerthy@ti.com>
>
> >
> > Regards,
> >
> > Tony
> >
> >>   arch/arm/mach-omap2/.gitignore  | 1 +
> >>   arch/arm/mach-omap2/Makefile    | 5 +++--
> >>   arch/arm/mach-omap2/sleep33xx.S | 2 +-
> >>   arch/arm/mach-omap2/sleep43xx.S | 2 +-
> >>   4 files changed, 6 insertions(+), 4 deletions(-)
> >>   create mode 100644 arch/arm/mach-omap2/.gitignore
> >>
> >> diff --git a/arch/arm/mach-omap2/.gitignore b/arch/arm/mach-omap2/.gitignore
> >> new file mode 100644
> >> index 000000000000..79a8d6ea7152
> >> --- /dev/null
> >> +++ b/arch/arm/mach-omap2/.gitignore
> >> @@ -0,0 +1 @@
> >> +pm-asm-offsets.h
> >> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> >> index 85d1b13c9215..26baeb6477af 100644
> >> --- a/arch/arm/mach-omap2/Makefile
> >> +++ b/arch/arm/mach-omap2/Makefile
> >> @@ -236,9 +236,10 @@ obj-y                                   += omap_phy_internal.o
> >>
> >>   obj-$(CONFIG_MACH_OMAP2_TUSB6010)  += usb-tusb6010.o
> >>
> >> -include/generated/ti-pm-asm-offsets.h: arch/arm/mach-omap2/pm-asm-offsets.s FORCE
> >> +$(obj)/pm-asm-offsets.h: $(obj)/pm-asm-offsets.s FORCE
> >>      $(call filechk,offsets,__TI_PM_ASM_OFFSETS_H__)
> >>
> >> -$(obj)/sleep33xx.o $(obj)/sleep43xx.o: include/generated/ti-pm-asm-offsets.h
> >> +$(obj)/sleep33xx.o $(obj)/sleep43xx.o: $(obj)/pm-asm-offsets.h
> >>
> >>   targets += pm-asm-offsets.s
> >> +clean-files += pm-asm-offsets.h
> >> diff --git a/arch/arm/mach-omap2/sleep33xx.S b/arch/arm/mach-omap2/sleep33xx.S
> >> index 47a816468cdb..a003769121aa 100644
> >> --- a/arch/arm/mach-omap2/sleep33xx.S
> >> +++ b/arch/arm/mach-omap2/sleep33xx.S
> >> @@ -6,7 +6,6 @@
> >>    * Dave Gerlach, Vaibhav Bedia
> >>    */
> >>
> >> -#include <generated/ti-pm-asm-offsets.h>
> >>   #include <linux/linkage.h>
> >>   #include <linux/platform_data/pm33xx.h>
> >>   #include <linux/ti-emif-sram.h>
> >> @@ -15,6 +14,7 @@
> >>
> >>   #include "iomap.h"
> >>   #include "cm33xx.h"
> >> +#include "pm-asm-offsets.h"
> >>
> >>   #define AM33XX_CM_CLKCTRL_MODULESTATE_DISABLED                     0x00030000
> >>   #define AM33XX_CM_CLKCTRL_MODULEMODE_DISABLE                       0x0003
> >> diff --git a/arch/arm/mach-omap2/sleep43xx.S b/arch/arm/mach-omap2/sleep43xx.S
> >> index 5b9343b58fc7..aa288f361c5e 100644
> >> --- a/arch/arm/mach-omap2/sleep43xx.S
> >> +++ b/arch/arm/mach-omap2/sleep43xx.S
> >> @@ -6,7 +6,6 @@
> >>    * Dave Gerlach, Vaibhav Bedia
> >>    */
> >>
> >> -#include <generated/ti-pm-asm-offsets.h>
> >>   #include <linux/linkage.h>
> >>   #include <linux/ti-emif-sram.h>
> >>   #include <linux/platform_data/pm33xx.h>
> >> @@ -19,6 +18,7 @@
> >>   #include "iomap.h"
> >>   #include "omap-secure.h"
> >>   #include "omap44xx.h"
> >> +#include "pm-asm-offsets.h"
> >>   #include "prm33xx.h"
> >>   #include "prcm43xx.h"
> >>
> >> --
> >> 2.17.1
> >>



--
Best Regards
Masahiro Yamada
