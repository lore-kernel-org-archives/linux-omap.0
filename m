From: Adam Ford <aford173@gmail.com>
Subject: Re: [PATCHv2 15/15] clk: ti: convert to use proper register
 definition for all accesses
Date: Wed, 17 Jan 2018 09:15:01 -0600
Message-ID: <CAHCN7xLaP-th=vAzN8C1QXstf3c5SP4JADAZZXTb1Nd6N6QdsQ@mail.gmail.com>
References: <1489236606-24023-1-git-send-email-t-kristo@ti.com>
 <1489236606-24023-16-git-send-email-t-kristo@ti.com>
 <CAHCN7x+oKEmXBpogy4VOB8UgmTd6+X5fBiP66yzUqXmvDWdqaw@mail.gmail.com>
 <6b4c5bf2-1260-0e79-0414-9870f21e4a75@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <6b4c5bf2-1260-0e79-0414-9870f21e4a75@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 17, 2018 at 8:02 AM, Tero Kristo <t-kristo@ti.com> wrote:
> On 17/01/18 15:27, Adam Ford wrote:
>>
>> On Sat, Mar 11, 2017 at 6:50 AM, Tero Kristo <t-kristo@ti.com> wrote:
>>>
>>> Currently, TI clock driver uses an encapsulated struct that is cast into
>>> a void pointer to store all register addresses. This can be considered
>>> as rather nasty hackery, and prevents from expanding the register
>>> address field also. Instead, replace all the code to use proper struct
>>> in place for this, which contains all the previously used data.
>>>
>>> This patch is rather large as it is touching multiple files, but this
>>> can't be split up as we need to avoid any boot breakage.
>>>
>>
>> I know it's late coming, but according to git bisect, this patch is
>> causing some problems with Logic PD Torpedo 37xx Dev kit.
>
>
> Oh reporting bugs is never too late, thanks for posting this out.
>
>>
>> It it is a DM3730 that has a WL1283 chipset attached to the SDIO
>> interface on MMC3.  The driver seems to load properly, but when
>> loading wpa_supplicant to activate the WL1283, we get a giant crash.
>> I checked kernel revisions starting at 4.14 and working back to when
>> it worked, then used git bisect from there.
>>
>> I am hoping it might be a simple fix for something that just needs to
>> get added or tweaked in the device tree.
>
>
> I don't have access to the specific hw, but can you try to dig out which
> hwmod is causing the crash? Just print out the oh->name from the
> _wait_softreset_complete. That would help root causing the issue.
>

With one small patch, I was able to make it work again.

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 2dbd632..ed1f625 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -477,7 +477,7 @@ static int _wait_softreset_complete(struct omap_hwmod *oh)
        int c = 0;

        sysc = oh->class->sysc;
-
+pr_warn("_wait_softreset_complete: %s\n", oh->name);
        if (sysc->sysc_flags & SYSS_HAS_RESET_STATUS)
                omap_test_timeout((omap_hwmod_read(oh, sysc->syss_offs)
                                   & SYSS_RESETDONE_MASK),


This leads me to believe that the omap_test_timeout functions might
not be working quite right.

Here is the working log with the above patch:

# wpa_supplicant -Dnl80211 -iwlan0 -c/etc/wpa_supplicant.conf -B
[   17.992858] _wait_softreset_complete: mmc1
Successfully initialized wpa_supplicant
rfkill: Cannot open RFKILL control device
[   18.239746] _wait_softreset_complete: mmc3
[   18.638580] _wait_softreset_complete: mmc3
[   18.657562] _wait_softreset_complete: mmc1
[   18.833374] wlcore: firmware booted (Rev 7.3.10.0.141)
[   18.878326] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
# [   19.526275] _wait_softreset_complete: mmc3
[   19.787322] _wait_softreset_complete: mmc3
[   20.544830] _wait_softreset_complete: mmc3
[   21.600433] _wait_softreset_complete: mmc1
[   21.619293] _wait_softreset_complete: i2c1
[   21.893341] _wait_softreset_complete: mmc3
[   22.362091] wlan0: authenticate with 70:3a:cb:5e:14:62
[   22.437713] wlan0: send auth to 70:3a:cb:5e:14:62 (try 1/3)
[   22.455139] wlan0: authenticated
[   22.471710] wlan0: associate with 70:3a:cb:5e:14:62 (try 1/3)
[   22.486206] wlan0: RX AssocResp from 70:3a:cb:5e:14:62 (capab=0x11 status=0 a
id=3)
[   22.517303] wlan0: associated
[   22.521728] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready

I doubled checked again without the patch and it crashes like shown
below, so the debug is definately make something better.

I haven't checked the 4.15-RC candidate yet, so I'll see if that's
changed, and I'll let you know what I find.

> -Tero
>

adam
>
>>
>>
>>
>> # wpa_supplicant -Dnl80211 -iwlan0 -c/etc/wpa_supplicant.conf -B
>> Successfully initialized wpa_supplicant
>> rfkill: Cannot open RFKILL control device
>> [   14.674011] Unhandled fault: external abort on non-linefetch (0x1028)
>> at 0xfa
>> 0ad014
>> [   14.682708] pgd = cc2ac000
>> [   14.685607] [fa0ad014] *pgd=48011452(bad)
>> [   14.689941] Internal error: : 1028 [#1] SMP ARM
>> [   14.694732] Modules linked in: arc4 wl12xx wlcore mac80211 cfg80211
>> evdev joy
>> dev snd_soc_omap_twl4030 omapfb cfbfillrect cfbimgblt leds_gpio cpufreq_dt
>> cfbco
>> pyarea led_class thermal_sys panel_dpi pwm_omap_dmtimer gpio_keys hwmon
>> pwm_bl o
>> map3_isp videobuf2_dma_contig videobuf2_memops videobuf2_v4l2
>> videobuf2_core v4l
>> 2_common snd_soc_omap_mcbsp snd_soc_omap omap_wdt videodev media omap_hdq
>> wlcore
>> _sdio wire cn phy_twl4030_usb omap2430 musb_hdrc udc_core twl4030_wdt
>> rtc_twl sn
>> d_soc_twl4030 ehci_omap snd_soc_core snd_pcm_dmaengine snd_pcm ehci_hcd
>> snd_time
>> r twl4030_pwrbutton ohci_omap3 twl4030_charger pwm_twl_led snd
>> twl4030_keypad so
>> undcore pwm_twl industrialio matrix_keymap ohci_hcd usbcore usb_common
>> at24 tsc2
>> 004 omap_ssi tsc200x_core nvmem_core hsi omapdss
>> [   14.766357] CPU: 0 PID: 174 Comm: wpa_supplicant Not tainted
>> 4.11.0-rc1-00015
>> -g6c0afb5 #1
>> [   14.774993] Hardware name: Generic OMAP36xx (Flattened Device Tree)
>> [   14.781646] task: cc8a8000 task.stack: cc8bc000
>> [   14.786468] PC is at _wait_softreset_complete+0x70/0x114
>> [   14.792083] LR is at _enable_sysc+0x30/0x238
>> [   14.796630] pc : [<c011fe00>]    lr : [<c0120ce0>]    psr: 40010093
>> [   14.796630] sp : cc8bdbd0  ip : c01288fc  fp : 00000000
>> [   14.808715] r10: cc8bc000  r9 : c0b0225c  r8 : 00002710
>> [   14.814239] r7 : 000346dc  r6 : c0d20644  r5 : c0d202ac  r4 : 00000000
>> [   14.821136] r3 : fa0ad014  r2 : fa0ad000  r1 : 00000000  r0 : c0d202ac
>> [   14.828033] Flags: nZcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
>> Segment non
>> e
>> [   14.835662] Control: 10c5387d  Table: 8c2ac019  DAC: 00000051
>> [   14.841735] Process wpa_supplicant (pid: 174, stack limit = 0xcc8bc218)
>>
>> [snip what appears to be just memory dump or a bunch of numbers]
>>
>>
>> [   15.147277] [<c011fe00>] (_wait_softreset_complete) from [<c0120ce0>]
>> (_enabl
>> e_sysc+0x30/0x238)
>> [   15.156463] [<c0120ce0>] (_enable_sysc) from [<c012101c>]
>> (_enable+0x134/0x25
>> 8)
>> [   15.164215] [<c012101c>] (_enable) from [<c012172c>]
>> (omap_hwmod_enable+0x28/
>> 0x48)
>> [   15.172210] [<c012172c>] (omap_hwmod_enable) from [<c0122700>]
>> (omap_device_e
>> nable+0x3c/0x90)
>> [   15.181213] [<c0122700>] (omap_device_enable) from [<c0122764>]
>> (_od_runtime_
>> resume+0x10/0x38)
>> [   15.190338] [<c0122764>] (_od_runtime_resume) from [<c057fd24>]
>> (__rpm_callba
>> ck+0xc0/0x214)
>> [   15.199157] [<c057fd24>] (__rpm_callback) from [<c057fec8>]
>> (rpm_callback+0x5
>> 0/0x80)
>> [   15.207366] [<c057fec8>] (rpm_callback) from [<c057f980>]
>> (rpm_resume+0x4b8/0
>> x738)
>> [   15.215362] [<c057f980>] (rpm_resume) from [<c057fc4c>]
>> (__pm_runtime_resume+
>> 0x4c/0x64)
>> [   15.223846] [<c057fc4c>] (__pm_runtime_resume) from [<c065f538>]
>> (__mmc_claim
>> _host+0x174/0x1b8)
>> [   15.233062] [<c065f538>] (__mmc_claim_host) from [<bf2ce1e8>]
>> (wl12xx_sdio_ra
>> w_write+0x34/0x130 [wlcore_sdio])
>> [   15.243927] [<bf2ce1e8>] (wl12xx_sdio_raw_write [wlcore_sdio]) from
>> [<bf604db
>> 0>] (wlcore_set_partition+0xc4/0x4b0 [wlcore])
>> [   15.256042] [<bf604db0>] (wlcore_set_partition [wlcore]) from
>> [<bf5fb840>] (w
>> l12xx_set_power_on+0x80/0x144 [wlcore])
>> [   15.267517] [<bf5fb840>] (wl12xx_set_power_on [wlcore]) from
>> [<bf5fed6c>] (wl
>> 1271_op_add_interface+0x6ac/0x9c0 [wlcore])
>> [   15.280303] [<bf5fed6c>] (wl1271_op_add_interface [wlcore]) from
>> [<bf518cd0>]
>>   (drv_add_interface+0x80/0x31c [mac80211])
>> [   15.293121] [<bf518cd0>] (drv_add_interface [mac80211]) from
>> [<bf537690>] (ie
>> ee80211_do_open+0x474/0x8d4 [mac80211])
>> [   15.304931] [<bf537690>] (ieee80211_do_open [mac80211]) from
>> [<c06b8124>] (__
>> dev_open+0xa8/0x110)
>> [   15.314300] [<c06b8124>] (__dev_open) from [<c06b83a8>]
>> (__dev_change_flags+0
>> x88/0x14c)
>> [   15.322784] [<c06b83a8>] (__dev_change_flags) from [<c06b8484>]
>> (dev_change_f
>> lags+0x18/0x48)
>> [   15.331695] [<c06b8484>] (dev_change_flags) from [<c07334f4>]
>> (devinet_ioctl+
>> 0x720/0x824)
>> [   15.340362] [<c07334f4>] (devinet_ioctl) from [<c0692d24>]
>> (sock_ioctl+0x160/
>> 0x318)
>> [   15.348449] [<c0692d24>] (sock_ioctl) from [<c02c7d8c>]
>> (do_vfs_ioctl+0x90/0x
>> a10)
>> [   15.356384] [<c02c7d8c>] (do_vfs_ioctl) from [<c02c8778>]
>> (SyS_ioctl+0x6c/0x7
>> c)
>> [   15.364105] [<c02c8778>] (SyS_ioctl) from [<c0107840>]
>> (ret_fast_syscall+0x0/
>> 0x1c)
>> [   15.372131] Code: e3120c01 e595205c e6f23073 1affffef (e5933000)
>> [   15.378601] ---[ end trace 6966c05397661217 ]---
>> [   15.383544] In-band Error seen by MPU  at address 0
>>
>> [snip]
>>
>>
>> There is much more data to dump after this, but I don't want to dump a
>> bunch of noise if it isn't helpful.
>>
>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>> Acked-by: Tony Lindgren <tony@atomide.com>
>>> ---
>>>   arch/arm/mach-omap2/clkt2xxx_dpllcore.c |  3 +-
>>>   arch/arm/mach-omap2/clock.c             |  2 +-
>>>   arch/arm/mach-omap2/clock.h             |  2 ++
>>>   arch/arm/mach-omap2/cm.h                |  5 +--
>>>   arch/arm/mach-omap2/cm2xxx.c            |  9 ++---
>>>   arch/arm/mach-omap2/cm3xxx.c            | 10 ++----
>>>   arch/arm/mach-omap2/cm_common.c         |  2 +-
>>>   drivers/clk/ti/apll.c                   | 47 ++++++++++++-------------
>>>   drivers/clk/ti/autoidle.c               | 18 +++++-----
>>>   drivers/clk/ti/clk-3xxx.c               | 55
>>> +++++++++++++++--------------
>>>   drivers/clk/ti/clk.c                    | 47 ++++++++++++-------------
>>>   drivers/clk/ti/clkt_dflt.c              | 61
>>> ++++++++++++---------------------
>>>   drivers/clk/ti/clkt_dpll.c              |  6 ++--
>>>   drivers/clk/ti/clkt_iclk.c              | 29 ++++++++--------
>>>   drivers/clk/ti/clock.h                  | 11 +++---
>>>   drivers/clk/ti/clockdomain.c            |  8 -----
>>>   drivers/clk/ti/divider.c                | 24 +++++++------
>>>   drivers/clk/ti/dpll.c                   | 48 ++++++++++----------------
>>>   drivers/clk/ti/dpll3xxx.c               | 38 ++++++++++----------
>>>   drivers/clk/ti/dpll44xx.c               | 14 ++++----
>>>   drivers/clk/ti/gate.c                   | 32 ++++++++---------
>>>   drivers/clk/ti/interface.c              | 22 ++++++------
>>>   drivers/clk/ti/mux.c                    | 41 +++++++++-------------
>>>   include/linux/clk/ti.h                  | 46 +++++++++++++------------
>>>   24 files changed, 264 insertions(+), 316 deletions(-)
>>>
>>
>> [ snip]
>>
>>
>>> +                                      s16 *prcm_inst, u8
>>> *idlest_reg_id);
>>>   };
>>>
>>>   #define to_clk_hw_omap(_hw) container_of(_hw, struct clk_hw_omap, hw)
>>> --
>>> 1.9.1
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> --
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
