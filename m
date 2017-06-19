From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 2/2] soc changes for omaps for v4.13
Date: Sun, 18 Jun 2017 20:47:06 -0700
Message-ID: <20170619034706.GX30022@localhost>
References: <pull-1497505275-391662>
 <59421e32.86e1540a.1a7d5.12e5SMTPIN_ADDED_BROKEN@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <59421e32.86e1540a.1a7d5.12e5SMTPIN_ADDED_BROKEN@mx.google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 14, 2017 at 10:42:03PM -0700, Tony Lindgren wrote:
> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
> 
>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.13/soc-v4-signed
> 
> for you to fetch changes up to 1df5eaa6bced2d8a9de305d4a5f587adf57ddf35:
> 
>   ARM: OMAP4: hwmod_data: add SHAM crypto accelerator (2017-06-14 00:53:51 -0700)
> 
> ----------------------------------------------------------------
> SoC changes for omap variants for v4.13 merge window:
> 
> - PM clean-up in preparation of adding am335x/am437x PM support
> 
> - Fixes for issues found by Coccinelle
> 
> - Legacy code removal now that everything boots in device
>   tree only mode
> 
> - Interconnect changes in preparation of moving clkctrl clocks
>   to be managed by clkctrl clock driver
> 
> - Interconnect changes to add omap4 crypto acceclerator
>   support
> 
> ----------------------------------------------------------------
> Dave Gerlach (3):
>       ARM: OMAP: Wakeupgen: Add context save/restore for AM43XX
>       ARM: OMAP2+: timer: Add suspend-resume callbacks for clkevent device
>       ARM: OMAP2+: pm: Remove __init from omap_pm_clkdms_setup
> 
> Markus Elfring (4):
>       ARM: OMAP2+: Delete an error message for a failed memory allocation in two functions
>       ARM: OMAP2+: Improve a size determination in sr_dev_init()
>       ARM: OMAP2+: Use kcalloc() in sr_set_nvalues()
>       ARM: OMAP2+: SmartReflex: Delete an error message for a failed memory allocation in two functions
> 
> Sebastian Reichel (3):
>       ARM: OMAP4: hwmod data: add aes1
>       ARM: OMAP4: hwmod data: add aes2
>       ARM: OMAP4: hwmod data: add des
> 
> Tero Kristo (7):
>       ARM: OMAP2+: timer: add support for fetching fck handle from DT
>       ARM: OMAP4: hwmod_data: add opt clks for dss_hdmi and dss_venc
>       ARM: OMAP2+: PRCM: store also physical addresses for instances
>       ARM: omap2+: clockdomain: add clkdm_xlate_address
>       ARM: OMAP4: cminst: add support for clkdm_xlate_address
>       ARM: OMAP2+: hwmod: populate clkctrl clocks for hwmods if available
>       ARM: OMAP4: hwmod_data: add SHAM crypto accelerator
> 
> Tony Lindgren (12):
>       ARM: OMAP2+: Remove unused legacy code for timer
>       ARM: OMAP2+: Remove unused legacy code for opp
>       ARM: OMAP2+: Remove unused legacy code for PMU
>       ARM: OMAP2+: Remove unused legacy code for device init
>       ARM: OMAP2+: Remove unused legacy code for McBSP
>       ARM: OMAP2+: Remove unused legacy code for io.c
>       ARM: OMAP2+: Remove unused legacy code for PRM
>       ARM: OMAP2+: Remove unused legacy code for interconnects
>       ARM: OMAP2+: Remove unused legacy code for watchdog
>       ARM: OMAP2+: Remove unused legacy code for n8x0
>       Merge branch 'omap-for-v4.13/legacy-v2' into omap-for-v4.13/soc-v3
>       Merge branch 'omap-for-v4.13/clkctrl' into omap-for-v4.13/soc-v4
> 
>  arch/arm/mach-omap2/Makefile               |   4 -
>  arch/arm/mach-omap2/board-n8x0.c           |  14 +-
>  arch/arm/mach-omap2/clockdomain.c          |   8 ++
>  arch/arm/mach-omap2/clockdomain.h          |   2 +
>  arch/arm/mach-omap2/cm.h                   |   7 +-
>  arch/arm/mach-omap2/cm2xxx_3xxx.h          |   4 +-
>  arch/arm/mach-omap2/cm33xx.c               |   4 +-
>  arch/arm/mach-omap2/cm3xxx.c               |   3 +-
>  arch/arm/mach-omap2/cm_common.c            |  31 +++--
>  arch/arm/mach-omap2/cminst44xx.c           |  29 +++--
>  arch/arm/mach-omap2/devices.c              | 175 -------------------------
>  arch/arm/mach-omap2/hsmmc.c                |   5 +-
>  arch/arm/mach-omap2/io.c                   |  59 ++-------
>  arch/arm/mach-omap2/mcbsp.c                |  70 ----------
>  arch/arm/mach-omap2/omap-wakeupgen.c       |  68 +++++++++-
>  arch/arm/mach-omap2/omap_device.c          |   5 +-
>  arch/arm/mach-omap2/omap_hwmod.c           | 168 ++++++++++++++++++++----
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   3 +-
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 146 ++++++++++++++++++++-
>  arch/arm/mach-omap2/opp.c                  | 104 ---------------
>  arch/arm/mach-omap2/opp3xxx_data.c         |  86 -------------
>  arch/arm/mach-omap2/opp4xxx_data.c         |  79 ------------
>  arch/arm/mach-omap2/pm.c                   |   2 +-
>  arch/arm/mach-omap2/pmu.c                  |  97 --------------
>  arch/arm/mach-omap2/prcm-common.h          |   7 +
>  arch/arm/mach-omap2/prcm_mpu44xx.c         |   4 +-
>  arch/arm/mach-omap2/prcm_mpu_44xx_54xx.h   |   4 +-
>  arch/arm/mach-omap2/prm.h                  |   2 +-
>  arch/arm/mach-omap2/prm2xxx_3xxx.h         |   4 +-
>  arch/arm/mach-omap2/prm33xx.c              |   4 +-
>  arch/arm/mach-omap2/prm3xxx.c              |  19 ++-
>  arch/arm/mach-omap2/prm44xx.c              |  63 +--------
>  arch/arm/mach-omap2/prm_common.c           |  32 ++---
>  arch/arm/mach-omap2/prminst44xx.c          |  16 ++-
>  arch/arm/mach-omap2/sr_device.c            |  15 +--
>  arch/arm/mach-omap2/timer.c                | 200 ++++++++---------------------
>  arch/arm/mach-omap2/wd_timer.c             |  28 ----
>  37 files changed, 537 insertions(+), 1034 deletions(-)
>  delete mode 100644 arch/arm/mach-omap2/opp.c
>  delete mode 100644 arch/arm/mach-omap2/pmu.c

Merged, thanks. Nice cleanup!


-Olof
