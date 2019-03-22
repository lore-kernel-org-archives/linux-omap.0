From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH 0/5]  AM437x: Add rtc-only + DDR mode support
Date: Fri, 22 Mar 2019 18:32:53 +0000
Message-ID: <20190322183253.w2uuhglttwmmxfnx@shell.armlinux.org.uk>
References: <20190322171619.4180-1-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190322171619.4180-1-j-keerthy@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Keerthy <j-keerthy@ti.com>
Cc: linux-rtc@vger.kernel.org, a.zummo@towertech.it, alexandre.belloni@bootlin.com, d-gerlach@ti.com, tony@atomide.com, t-kristo@ti.com, ssantosh@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Mar 22, 2019 at 10:46:14PM +0530, Keerthy wrote:
> RTC plus DDR in self-refresh is power a saving mode where in the entire
                                 "a power" ?

> system including the different voltage rails from PMIC are shutdown except
> the ones feeding on to RTC and DDR. DDR is kept in self-refresh hence the
> contents are preserved. RTC ALARM2 is connected to PMIC_EN line once
> we the ALARM2 is triggered we enter the mode with DDR in self-refresh

Doesn't make sense.

> and RTC Ticking. After a predetermined time an RTC ALARM1 triggers waking
> up the system.

Huh, you start off explaining the wiring above... how does RTC ALARM1
trigger waking up the system if RTC ALARM2 is connected to the PMIC
and all other power is shut down?

> The control goes to bootloader. The bootloader then checks
> RTC scratchpad registers to confirm it was an rtc_only wakeup and follows
> a different path, configure bare minimal clocks for ddr and then jumps to
> the resume address in another RTC scratchpad registers and transfers the
> control to Kernel. Kernel then restores the saved context.
> 
> The patch series adds rtc-only + DDR mode support am am437x
> Tested DS0, rtc+ddr back and forth on am437x-gp-evm board.
> 
> This mode works only with u-boot built with am43xx_evm_rtconly_defconfig
> 
> Additional patch is needed for omap-gpio save restore which will
> come as fixes later.
> 
> Keerthy (5):
>   rtc: OMAP: Add support for rtc-only mode
>   rtc: interface: Add power_off_program to rtc_class_ops
>   arm: mach-omap2: pm33xx: Add support for rtc+ddr in self refresh mode
>   soc: ti: pm33xx: Push the am33xx_push_sram_idle to the top
>   soc: ti: pm33xx: AM437X: Add rtc_only with ddr in self-refresh support
> 
>  arch/arm/mach-omap2/pm33xx-core.c    |  76 +++++++-
>  drivers/rtc/interface.c              |  12 ++
>  drivers/rtc/rtc-omap.c               |  49 ++++-
>  drivers/soc/ti/Kconfig               |   5 +-
>  drivers/soc/ti/pm33xx.c              | 272 ++++++++++++++++++++++-----
>  include/linux/platform_data/pm33xx.h |   5 +
>  include/linux/rtc.h                  |   2 +
>  7 files changed, 360 insertions(+), 61 deletions(-)
> 
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
