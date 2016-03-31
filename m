From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] extcon: palmas: Drop stray IRQF_EARLY_RESUME flag
Date: Thu, 31 Mar 2016 16:15:51 -0500
Message-ID: <1459458951-4882-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Palams extcon IRQs are nested threaded and wired to the Palmas
inerrupt controller. So, this flag is not required for nested
irqs anymore, since commit 3c646f2c6aa9 ("genirq: Don't suspend
nested_thread irqs over system suspend") was merged. However, the
fix missed a stray flag causing the following crash on resume on
BeagleBoard-X15 platform:
[   53.670141] Unhandled fault: imprecise external abort (0x1406) at 0x00000000
[   53.670141] pgd = ecd30000
[   53.670141] [00000000] *pgd=fe3c1835
[   53.670141] Internal error: : 1406 [#1] SMP ARM
[   53.670141] Modules linked in: xhci_plat_hcd xhci_hcd usbcore encoder_tpd12s015 connector_hdmi omapfb cfbcopyarea c
fbimgblt cfbfillrect evdev dwc3 snd_soc_simple_card udc_core leds_gpio gpio_fan cpufreq_dt omapdss snd_soc_davinci_mca
sp snd_soc_omap snd_soc_edma snd_soc_tlv320aic3x omap_wdt extcon_usb_gpio led_class rtc_omap snd_soc_core snd_pcm_dmae
ngine extcon_palmas ti_soc_thermal dwc3_omap palmas_pwrbutton phy_omap_usb2 tmp102 snd_pcm thermal_sys rtc_palmas snd_
timer at24 extcon rtc_ds1307 hwmon snd soundcore nvmem_core
[   53.670141] CPU: 0 PID: 2297 Comm: rtcwake Not tainted 4.6.0-rc1-00004-g7b08b6942309-dirty #6
[   53.670141] Hardware name: Generic DRA74X (Flattened Device Tree)
[   53.670141] task: ed3ab280 ti: ecb28000 task.ti: ecb28000
[   53.670141] PC is at omap_set_gpio_triggering+0x44/0x23c
[   53.670141] LR is at 0xfa059140
[   53.670141] pc : [<c04ae734>]    lr : [<fa059140>]    psr: 60070093
[   53.670141] sp : ecb29db8  ip : fa059000  fp : c09d3fd4
[   53.670141] r10: 60070093  r9 : ee143660  r8 : 60070093
[   53.670141] r7 : ee13bc64  r6 : 00000003  r5 : ee13bc10  r4 : 00000000
[   53.670141] r3 : c10821cc  r2 : 00000003  r1 : 00200000  r0 : ee13bc10
[   53.670141] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   53.670141] Control: 10c5387d  Table: acd3006a  DAC: 00000051
[   53.670141] Process rtcwake (pid: 2297, stack limit = 0xecb28218)
[   53.670141] Stack: (0xecb29db8 to 0xecb2a000)
[   53.670141] 9da0:                                                       00000015 ee13bc10
[   53.670141] 9dc0: 00000003 c04aeb94 ee143600 ee143600 c1043dd0 00000001 c099c354 c01a0b88
[   53.670141] 9de0: ee143600 c019ebd8 00000099 c01a4e60 c1044100 c108baf8 c10c6020 c10c20e0
[   53.670141] 9e00: c10029cc c10c169f c09d3fa8 c0514840 c100409c 00000003 c1851644 00000000
[   53.670141] 9e20: c1851628 00000000 00000000 c10c20e0 00000000 c01981cc c1851650 00000000
[   53.670141] 9e40: c099b204 ecb29f88 0000000c c019bd04 c099b1c8 ecb29e74 c10029cc 00000003
[   53.670141] 9e60: c10029cc c10c20e0 c1851650 00000000 c099b204 ecb29f88 0000000c c0198a60
[   53.670141] 9e80: 0000006d 00000003 c0995434 00000003 c1851654 00000004 ecaddc80 ecb29f88
[   53.670141] 9ea0: 00000051 c0196bec ecb13500 00000000 00000004 ecaddc80 00000000 00000000
[   53.670141] 9ec0: ecb29f88 c0307944 00000000 00000000 00000001 ecb1350c ecb28000 ecc5d280
[   53.670141] 9ee0: c0307884 b6f8f000 ecb29f88 c01079e4 ecb28000 00000000 bedaab3b c028acb0
[   53.670141] 9f00: 00000003 00000000 bedaae72 ee6f023c ee6f023c 00000001 00000000 c018abc0
[   53.670141] 9f20: ee6f023c 00000001 00000000 c018ac5c 00000001 00000000 c028ec60 c028b940
[   53.670141] 9f40: 00001000 00000001 00000004 ecc5d280 00000004 b6f8f000 ecb29f88 c01079e4
[   53.670141] 9f60: ecb28000 c028bba0 b6f8f000 c024c784 ecc5d280 ecc5d280 b6f8f000 00000004
[   53.670141] 9f80: c01079e4 c028c8c0 00000000 00000000 000277b8 00000004 b6f8f000 000277b8
[   53.670141] 9fa0: 00000004 c0107840 00000004 b6f8f000 00000004 b6f8f000 00000004 00000000
[   53.670141] 9fc0: 00000004 b6f8f000 000277b8 00000004 00000004 00000000 bedaae65 bedaab3b
[   53.670141] 9fe0: 00000000 bedaaa3c b6ebac85 b6ef6026 400d0030 00000004 00000000 00000000
[   53.670141] [<c04ae734>] (omap_set_gpio_triggering) from [<c04aeb94>] (omap_gpio_unmask_irq+0xc0/0xc4)
[   53.670141] [<c04aeb94>] (omap_gpio_unmask_irq) from [<c01a0b88>] (irq_enable+0x30/0x44)
[   53.670141] [<c01a0b88>] (irq_enable) from [<c019ebd8>] (__enable_irq+0x54/0x78)
[   53.670141] [<c019ebd8>] (__enable_irq) from [<c01a4e60>] (resume_irqs+0xe8/0x100)
[   53.670141] [<c01a4e60>] (resume_irqs) from [<c0514840>] (syscore_resume+0x94/0x298)
[   53.670141] [<c0514840>] (syscore_resume) from [<c01981cc>] (suspend_devices_and_enter+0x790/0x9e4)
[   53.670141] [<c01981cc>] (suspend_devices_and_enter) from [<c0198a60>] (pm_suspend+0x640/0x75c)
[   53.670141] [<c0198a60>] (pm_suspend) from [<c0196bec>] (state_store+0x64/0xb8)
[   53.670141] [<c0196bec>] (state_store) from [<c0307944>] (kernfs_fop_write+0xc0/0x1bc)
[   53.670141] [<c0307944>] (kernfs_fop_write) from [<c028acb0>] (__vfs_write+0x1c/0xd8)
[   53.670141] [<c028acb0>] (__vfs_write) from [<c028bba0>] (vfs_write+0x90/0x16c)
[   53.670141] [<c028bba0>] (vfs_write) from [<c028c8c0>] (SyS_write+0x44/0x9c)
[   53.670141] [<c028c8c0>] (SyS_write) from [<c0107840>] (ret_fast_syscall+0x0/0x1c)
[   53.670141] Code: e3120008 11814004 01c44001 e58e4000 (e1d342b6)

Fixes: ae64e42cc2b3 ("extcon: palmas: Drop IRQF_EARLY_RESUME flag")
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Roger Quadros <rogerq@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/extcon/extcon-palmas.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/extcon/extcon-palmas.c b/drivers/extcon/extcon-palmas.c
index 841a4b586395..8b3226dca1d9 100644
--- a/drivers/extcon/extcon-palmas.c
+++ b/drivers/extcon/extcon-palmas.c
@@ -348,8 +348,7 @@ static int palmas_usb_probe(struct platform_device *pdev)
 						palmas_vbus_irq_handler,
 						IRQF_TRIGGER_FALLING |
 						IRQF_TRIGGER_RISING |
-						IRQF_ONESHOT |
-						IRQF_EARLY_RESUME,
+						IRQF_ONESHOT,
 						"palmas_usb_vbus",
 						palmas_usb);
 		if (status < 0) {
-- 
2.8.0
