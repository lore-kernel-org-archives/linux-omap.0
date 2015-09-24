From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 00/17] ARM: OMAP2+: reset controller support
Date: Thu, 24 Sep 2015 17:26:41 +0300
Message-ID: <1443104818-993-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, tony@atomide.com, s-anna@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

This series adds reset controller support on top of the existing PRM/PRCM
code. All the currently defined reset sources in hwmod databases are
moved over to DT, and all except OMAP3 hwmod resets are also removed.
OMAP3 hwmod reset data can be removed once OMAP3 is DT only.

Reboot support is also converted to use the new reset controller nodes,
and a new DT node is introduced for this purpose; system_reset.

I guess the main question regarding this series is whether the DT
changes are okay, I was forced to create a few top level ocp nodes
for IVA/DSP etc. which were missing, and a couple of peripheral nodes
for AMx3xx to host the reset data. DSP/IVA nodes should be created for
OMAP5+ also to support the resets for these, but currently these are
completely missing so I did not bother adding them.

One motivation for this series is to get rid of the hwmod database reset
info, which eventually allows getting rid of the hwmod data completely
(read: moved over to DT.)

Boot tested on omap3-beagle, omap4-panda-es, omap5-uevm, dra7-evm, beagle-x15,
sdp2430, sdp3430, beaglebone-white, beaglebone-black, am43xx-gp-evm.

Reboot tested on omap3-beagle, omap4-panda-es, omap5-uevm, beagle-x15. Reboot
on amx3xx does not seem functional in base 4.3-rc2 so wasn't able to test
this.

Testing branch pushed at:
tree: https://github.com/t-kristo/linux-pm.git
branch: 4.3-rc2-prcm-reset-fwk

Tero Kristo (17):
  ARM: OMAP2+: PRM: add support for reset controller
  ARM: OMAP2+: hwmod: parse also soc hierarchy for hwmod compatible
    nodes
  ARM: dts: omap3: add reset data
  ARM: dts: omap4: add reset data
  ARM: dts: omap5: add reset data
  ARM: dts: dra7: add reset data
  ARM: dts: am4372: add reset data
  ARM: dts: am33xx: add reset data
  ARM: dts: OMAP24xx: add reset data
  ARM: OMAP2+: hwmod: parse reset information from DT
  ARM: OMAP2+: use system reset info from device tree data
  ARM: OMAP4: hwmod_data: remove reset data
  ARM: OMAP5: hwmod_data: remove reset data
  ARM: OMAP2: hwmod: AMx3xx: remove redundant reset info
  ARM: OMAP24xx: hwmod: remove reset data from hwmod database
  ARM: OMAP2+: hwmod: remove obsolete support for some hardreset logic
  ARM: OMAP2+: PRM: remove redundant system reset code

 arch/arm/boot/dts/am33xx.dtsi                      |   24 +++
 arch/arm/boot/dts/am4372.dtsi                      |   24 +++
 arch/arm/boot/dts/dra7.dtsi                        |    7 +
 arch/arm/boot/dts/omap2420.dtsi                    |   24 +++
 arch/arm/boot/dts/omap2430.dtsi                    |   17 ++
 arch/arm/boot/dts/omap3.dtsi                       |   21 ++
 arch/arm/boot/dts/omap4.dtsi                       |   27 +++
 arch/arm/boot/dts/omap5.dtsi                       |   11 ++
 arch/arm/mach-omap2/Kconfig                        |    1 +
 arch/arm/mach-omap2/Makefile                       |    6 -
 arch/arm/mach-omap2/am33xx-restart.c               |   27 ---
 arch/arm/mach-omap2/board-generic.c                |   16 +-
 arch/arm/mach-omap2/common.c                       |   29 +++
 arch/arm/mach-omap2/common.h                       |    2 +
 arch/arm/mach-omap2/omap2-restart.c                |    2 +-
 arch/arm/mach-omap2/omap3-restart.c                |    2 +-
 arch/arm/mach-omap2/omap4-restart.c                |   27 ---
 arch/arm/mach-omap2/omap_hwmod.c                   |  203 ++++++++++----------
 arch/arm/mach-omap2/omap_hwmod.h                   |   12 +-
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   13 --
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |    7 -
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |   30 ---
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |    8 -
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |    8 -
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   48 +----
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |   14 --
 arch/arm/mach-omap2/prm2xxx.c                      |   15 --
 arch/arm/mach-omap2/prm33xx.c                      |   18 --
 arch/arm/mach-omap2/prm44xx.c                      |    1 -
 arch/arm/mach-omap2/prm_common.c                   |  167 ++++++++++++++++
 arch/arm/mach-omap2/prminst44xx.c                  |   20 --
 arch/arm/mach-omap2/ti81xx-restart.c               |   34 ----
 32 files changed, 476 insertions(+), 389 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/am33xx-restart.c
 delete mode 100644 arch/arm/mach-omap2/omap4-restart.c
 delete mode 100644 arch/arm/mach-omap2/ti81xx-restart.c

bloat-o-meter:
add/remove: 13/24 grow/shrink: 20/579 up/down: 1732/-3020 (-1288)
function                                     old     new   delta
ti_reset_xlate                                 -     456    +456
_init                                       1012    1380    +368
_dt_assert_hardreset                           -     128    +128
omap2_prm_reset_controller_register            -     108    +108
__omap_init_restart                            -     100    +100
__func__                                   23717   23805     +88
_dt_is_hardreset_asserted                      -      64     +64
_dt_deassert_hardreset                         -      64     +64
ti_reset_deassert                              -      60     +60
omap_restart                                   -      32     +32
ti_reset_status                                -      28     +28
ti_reset_assert                                -      28     +28
omap4_prminst_rmw_inst_reg_bits               76     100     +24
omap_prcm_init                               120     140     +20
_lookup_hardreset                            124     144     +20
ti_reset_ops                                   -      16     +16
omap2xxx_restart                              40      56     +16
vermagic                                      49      64     +15
omap3xxx_restart                              28      40     +12
omap3xxx_iva_resets                           24      36     +12
_setup                                      1016    1028     +12
omap3xxx_sad2d_resets                         16      24      +8
_shutdown                                    548     556      +8
_omap4_disable_module                        252     260      +8
_are_all_hardreset_lines_asserted.part        88      96      +8
prm_was_any_context_lost_old                 108     112      +4
omap_reset_control                             -       4      +4
omap_prm_vp_clear_txdone                     100     104      +4
omap_hwmod_disable_wakeup                    248     252      +4
omap3xxx_mmu_iva_resets                        8      12      +4
_set_master_standbymode                      144     148      +4
__initcall___omap_init_restart7                -       4      +4
__warned                                    2006    2007      +1
omap_prm_deassert_hardreset                  136     132      -4
omap54xx_wd_timer2_hwmod                     168     164      -4
omap54xx_usb_tll_hs_hwmod                    168     164      -4
omap54xx_usb_otg_ss_hwmod                    168     164      -4
omap54xx_usb_host_hs_hwmod                   168     164      -4
omap54xx_uart6_hwmod                         168     164      -4
...<snip>...
am33xx_aes0_hwmod                            168     164      -4
am33xx_adc_tsc_hwmod                         168     164      -4
_write_sysconfig                             164     160      -4
_enable_wakeup                               256     252      -4
_enable_sysc                                 576     572      -4
_clear_softreset                             128     124      -4
omap54xx_mmu_ipu_resets                        8       -      -8
omap54xx_mmu_dsp_resets                        8       -      -8
omap44xx_mmu_ipu_resets                        8       -      -8
omap44xx_mmu_dsp_resets                        8       -      -8
omap44xx_dsp_resets                            8       -      -8
omap2420_iva_resets                            8       -      -8
am33xx_pruss_resets                            8       -      -8
am33xx_gfx_resets                              8       -      -8
omap44xx_prm_resets                           16       -     -16
omap44xx_ipu_resets                           16       -     -16
omap2430_iva_resets                           16       -     -16
omap2420_dsp_resets                           16       -     -16
am33xx_wkup_m3_resets                         16       -     -16
omap_hwmod_init                              492     468     -24
omap_hwmod_am33xx_reg                        664     640     -24
omap44xx_iva_resets                           24       -     -24
ti81xx_restart                                28       -     -28
omap2xxx_prm_dpll_reset                       32       -     -32
am33xx_prm_global_warm_sw_reset               32       -     -32
omap_hwmod_am43xx_reg                        680     644     -36
_omap4_is_hardreset_asserted                  48       -     -48
_omap4_assert_hardreset                       48       -     -48
_am33xx_deassert_hardreset                    64       -     -64
omap4_prminst_global_warm_sw_reset            84       -     -84
_omap4_deassert_hardreset                    120       -    -120



-- 
1.7.9.5
