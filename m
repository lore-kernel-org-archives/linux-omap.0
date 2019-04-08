From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 0/4] AM437x: Add rtc-only + DDR mode support
Date: Mon, 8 Apr 2019 10:26:54 -0700
Message-ID: <20190408172654.GL49658@atomide.com>
References: <20190403045742.2243-1-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190403045742.2243-1-j-keerthy@ti.com>
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
Cc: linux-rtc@vger.kernel.org, a.zummo@towertech.it, alexandre.belloni@bootlin.com, d-gerlach@ti.com, t-kristo@ti.com, ssantosh@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [190402 21:57]:
> RTC plus DDR in self-refresh is a power saving mode where in the entire
> system including the different voltage rails from PMIC are shutdown except
> the ones feeding on to RTC and DDR. DDR is kept in self-refresh hence the
> contents are preserved.
> 
> RTC ALARM2 is connected to PMIC_EN line. TPS65218 PMIC has granular voltage rail
> control. The voltage rail feeding RTC is kept on while the rest of the PMIC
> regulators are powered off.
> 
> Once the ALARM2 is triggered we enter the mode with DDR in self-refresh
> and RTC Ticking. After a predetermined time an RTC ALARM1 triggers
> waking up the system. The control goes to bootloader. The bootloader then checks
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
> Hardware Description of this mode can be found here: 
> 
> http://www.ti.com/lit/ug/spruhl7h/spruhl7h.pdf Page 2884.
>
> Changes in v3:
> 
>   * Exported out omap_rtc_poweroff_program function & removed
>     the patch to add a generic rtc interface as it is specific
>     to am43 at the moment.

Thanks I'll be applying this series into omap-for-v5.2/am4-pm
today.

Regards,

Tony
