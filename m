From: Gururaja Hebbar <gururaja.hebbar@ti.com>
Subject: Re: [PATCHv3 0/9] ARM: OMAP2+: AM33XX: Add suspend-resume support
Date: Mon, 19 Aug 2013 14:53:02 +0530
Message-ID: <5211E3F6.6090108@ti.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40350 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141Ab3HSJXd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Aug 2013 05:23:33 -0400
In-Reply-To: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>

On 8/6/2013 11:19 PM, Dave Gerlach wrote:
> Hi,
> 
> This is the third version of the patch series for adding basic suspend-resume
> support for AM33XX, previously submitted by Vaibhav Bedia. This patchset 
> is based on 3.11-rc4 and depends on a forthcoming patchset from Suman Anna
> that adds mailbox support for the wkup_m3. The patches at [1], [2], and [3] are 
> required for the pm code to properly suspend and resume.
> 
> The PM code uses the firmware interface and expects the userspace to load 
> the WKUP_M3 binary before the suspend-resume functionality is made available.
> The binary file (and the source-code for WKUP_M3) can be obtained from the 
> 'next2' branch at [4]. The WKUP_M3 binary can either be loaded post bootup 
> via the sysfs entry './sys/devices/ocp.2/wkup_m3.4/firmware' or it can be 
> included in the kernel image as part of the build process.
> 
> Suspend to mem is tested on am335x-bone and am335x-evm.
> 
> More details on AM335x suspend-resume are provided within the commit logs
> for each patch.

can you share the working repo which has all these patches applied?

Thanks & Regards
Gururaja

> 
> Changes in v3:
> - Moved wkup_m3 code into separate driver
> - Split up ti_emif header move
> - Addressed clean-up comments
> - Removed mailbox patches
> - v2-v3 Discussion:
> http://marc.info/?l=linux-arm-kernel&m=135698501821090&w=4
> 
> Changes in v2:
> - Broke patches up to isolate assembly code and build hookup.
> - Moved control module code to separate module
> - v1->v2 Discussion:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-November/129508.html
> 
> Regards,
> Dave
> 
> [1] http://marc.info/?l=linux-arm-kernel&m=137303736714638&w=4
> [2] http://marc.info/?l=linux-omap&m=137303723114610&w=4
> [3] http://marc.info/?l=linux-omap&m=137401384611934&w=4
> [4] http://arago-project.org/git/projects/?p=am33x-cm3.git;a=shortlog;h=refs/heads/next2
> 
> 
> Dave Gerlach (1):
>   memory: emif: Move EMIF register defines to include/linux/
> 
> Vaibhav Bedia (8):
>   ARM: OMAP2+: AM33XX: control: Add some control module registers and
>     APIs
>   ARM: OMAP: DTB: Update IRQ data for WKUP_M3
>   ARM: OMAP2+: AM33XX: Reserve memory to comply with EMIF spec
>   ARM: OMAP2+: AM33XX: Add assembly code for PM operations
>   ARM: OMAP2+: timer: Add suspend-resume callbacks for clkevent device
>   ARM: OMAP: omap_device: Add APIs to enable and idle hwmods
>   ARM: OMAP2+: AM33XX: Basic suspend resume support
>   ARM: OMAP2+: AM33XX: Hookup AM33XX PM code into OMAP builds
> 
>  arch/arm/boot/dts/am33xx.dtsi       |    1 +
>  arch/arm/mach-omap2/Kconfig         |    7 +-
>  arch/arm/mach-omap2/Makefile        |    2 +
>  arch/arm/mach-omap2/board-generic.c |    3 +-
>  arch/arm/mach-omap2/common.c        |   28 ++
>  arch/arm/mach-omap2/common.h        |   14 +
>  arch/arm/mach-omap2/control.c       |   57 ++++
>  arch/arm/mach-omap2/control.h       |   54 ++++
>  arch/arm/mach-omap2/io.c            |    6 +
>  arch/arm/mach-omap2/omap_device.c   |    8 +
>  arch/arm/mach-omap2/omap_device.h   |    2 +
>  arch/arm/mach-omap2/pm.c            |    3 +-
>  arch/arm/mach-omap2/pm.h            |    5 +
>  arch/arm/mach-omap2/pm33xx.c        |  474 +++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/pm33xx.h        |   77 +++++
>  arch/arm/mach-omap2/sleep33xx.S     |  350 ++++++++++++++++++++++
>  arch/arm/mach-omap2/sram.c          |   10 +-
>  arch/arm/mach-omap2/sram.h          |    2 +
>  arch/arm/mach-omap2/timer.c         |   32 ++
>  arch/arm/mach-omap2/wkup_m3.c       |  183 ++++++++++++
>  drivers/memory/emif.h               |  543 +---------------------------------
>  include/linux/ti_emif.h             |  558 +++++++++++++++++++++++++++++++++++
>  22 files changed, 1872 insertions(+), 547 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/pm33xx.c
>  create mode 100644 arch/arm/mach-omap2/pm33xx.h
>  create mode 100644 arch/arm/mach-omap2/sleep33xx.S
>  create mode 100644 arch/arm/mach-omap2/wkup_m3.c
>  create mode 100644 include/linux/ti_emif.h
> 

