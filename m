From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: Re: [GIT PULL 6/6] am33xx changes for v3.6 merge window
Date: Tue, 3 Jul 2012 17:02:12 +0530
Message-ID: <4FF2D83C.7060409@ti.com>
References: <E1SlGLI-0004Vt-0L@merlin.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57896 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750735Ab2GCLc3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Jul 2012 07:32:29 -0400
In-Reply-To: <E1SlGLI-0004Vt-0L@merlin.infradead.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org



On 7/1/2012 2:31 PM, Tony Lindgren wrote:
> The following changes since commit f8f5701bdaf9134b1f90e5044a82c66324d2073f:
> 
>   Linux 3.5-rc1 (2012-06-02 18:29:26 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-devel-am33xx-for-v3.6
> 
> for you to fetch changes up to 6fd8246b1c1167c983b089f9eaafa13ef9ca7adf:
> 
>   Merge tag 'omap-devel-a-for-3.6' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into devel-am33xx (2012-06-22 01:50:22 -0700)
> 
> ----------------------------------------------------------------
> 
> Here are changes to add support for am33xx processors for the
> clock, power, and voltagedomains.
> 
> ----------------------------------------------------------------
> Afzal Mohammed (2):
>       ARM: OMAP2+: am33xx: Add low level debugging support
>       ARM: OMAP2+: am33xx: Add AM335XEVM machine support
> 
> Tony Lindgren (1):
>       Merge tag 'omap-devel-a-for-3.6' of git://git.kernel.org/.../pjw/omap-pending into devel-am33xx
> 
> Vaibhav Hiremath (6):
>       ARM: OMAP2+: control: Add AM33XX control reg & sec clkctrl offset
>       ARM: OMAP AM33xx: voltagedomain: Add voltage domain data
>       ARM: OMAP AM33xx: PRM: add PRM support
>       ARM: OMAP AM33xx: CM: Introduce AM33xx CM APIs and register level details
>       ARM: OMAP AM33xx: powerdomains: add AM335x support
>       ARM: OMAP AM33xx: clockdomains: Add clockdomain data and respective operations
> 

Hi Tony,

Few patches got missed in this pull request,

ARM: OMAP2+: am33xx: Make am33xx as a separate class
ARM: OMAP2+: am33xx: Change cpu_is_am33xx to soc_is_am33xx

Thanks,
Vaibhav

>  arch/arm/mach-omap2/Makefile                   |    6 +
>  arch/arm/mach-omap2/board-generic.c            |   18 +
>  arch/arm/mach-omap2/clockdomain.h              |    2 +
>  arch/arm/mach-omap2/clockdomain33xx.c          |   74 +++
>  arch/arm/mach-omap2/clockdomains33xx_data.c    |  196 +++++++
>  arch/arm/mach-omap2/cm-regbits-33xx.h          |  687 ++++++++++++++++++++++++
>  arch/arm/mach-omap2/cm33xx.c                   |  313 +++++++++++
>  arch/arm/mach-omap2/cm33xx.h                   |  420 +++++++++++++++
>  arch/arm/mach-omap2/common.h                   |    3 +
>  arch/arm/mach-omap2/control.h                  |   39 +-
>  arch/arm/mach-omap2/include/mach/debug-macro.S |   17 +-
>  arch/arm/mach-omap2/io.c                       |   13 +
>  arch/arm/mach-omap2/irq.c                      |    2 +-
>  arch/arm/mach-omap2/powerdomain.h              |   23 +-
>  arch/arm/mach-omap2/powerdomain33xx.c          |  229 ++++++++
>  arch/arm/mach-omap2/powerdomains33xx_data.c    |  185 +++++++
>  arch/arm/mach-omap2/prm-regbits-33xx.h         |  357 ++++++++++++
>  arch/arm/mach-omap2/prm33xx.c                  |  135 +++++
>  arch/arm/mach-omap2/prm33xx.h                  |  129 +++++
>  arch/arm/mach-omap2/timer.c                    |    5 +
>  arch/arm/mach-omap2/voltage.h                  |    1 +
>  arch/arm/mach-omap2/voltagedomains33xx_data.c  |   43 ++
>  arch/arm/plat-omap/include/plat/serial.h       |    4 +
>  arch/arm/plat-omap/include/plat/uncompress.h   |    6 +
>  24 files changed, 2887 insertions(+), 20 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/clockdomain33xx.c
>  create mode 100644 arch/arm/mach-omap2/clockdomains33xx_data.c
>  create mode 100644 arch/arm/mach-omap2/cm-regbits-33xx.h
>  create mode 100644 arch/arm/mach-omap2/cm33xx.c
>  create mode 100644 arch/arm/mach-omap2/cm33xx.h
>  create mode 100644 arch/arm/mach-omap2/powerdomain33xx.c
>  create mode 100644 arch/arm/mach-omap2/powerdomains33xx_data.c
>  create mode 100644 arch/arm/mach-omap2/prm-regbits-33xx.h
>  create mode 100644 arch/arm/mach-omap2/prm33xx.c
>  create mode 100644 arch/arm/mach-omap2/prm33xx.h
>  create mode 100644 arch/arm/mach-omap2/voltagedomains33xx_data.c
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

