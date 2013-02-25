From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 8/8] ARM: dts: OMAP5: Add ocp address space for all hwmods
Date: Mon, 25 Feb 2013 11:56:28 +0100
Message-ID: <512B435C.20803@ti.com>
References: <1361374735-22018-1-git-send-email-santosh.shilimkar@ti.com> <1361374735-22018-9-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50615 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751372Ab3BYK4i (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Feb 2013 05:56:38 -0500
In-Reply-To: <1361374735-22018-9-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

Hi Santosh,


On 02/20/2013 04:38 PM, Santosh Shilimkar wrote:
> Patch adds the OCP address space for all missing hwmod from existing
> DT file. Note that the compatible isn't added by purpose to ensure that for
> these hwmod, devices are not getting created.

Mmm, that will make the DTS a little bit weird and non-standard.
You'd better use the status=disabled flag for that.

> Cc: Benoit Cousson <b-cousson@ti.com>
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/boot/dts/omap5.dtsi |  238 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 238 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index 269a328..915fd11 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -500,5 +500,243 @@
>  			hw-caps-ll-interface;
>  			hw-caps-temp-alert;
>  		};
> +
> +		l4_emif_ocp_fw: l4_emif_ocp_fw@4a20c000 {
> +			reg = <0x4a20c000 0x100>;
> +			ti,hwmods = "emif_ocp_fw";
> +		};

Are we doing anything useful with this entry, and potentially all the
other non-regular entries like that.

> +
> +		mpu_l3_main_1: mpu_l3_main_1@44000000 {
> +			reg = <0x44000000 0x2000>;
> +			ti,hwmods = "l3_main_1";
> +		};
> +
> +		mpu_l3_main_2: mpu_l3_main_2@44800000 {
> +			reg = <0x44800000 0x3000>;
> +			ti,hwmods = "l3_main_2";
> +		};
> +
> +		mpu_l3_main_3: mpu_l3_main_3@45000000 {
> +			reg = <0x44800000 0x4000>;
> +			ti,hwmods = "l3_main_3";
> +		};

The slit is due to PM partitioning, but that should be represented as an
unique device.

> +
> +		l4_ocp_wp_noc: l4_ocp_wp_noc@4a102000 {
> +			reg = <0x44800000 0x80>;
> +			ti,hwmods = "ocp_wp_noc";
> +		};
> +
> +		abe_aess: abe_aess@401f1000 {
> +			reg = <0x44800000 0x400>;
> +			ti,hwmods = "aess";
> +		};
> +
> +		c2c: c2c@5c000000 {
> +			reg = <0x5c000000 0x100>;
> +			ti,hwmods = "c2c";
> +		};
> +
> +		ctrl_module_core: ctrl_module_core@4a002000 {
> +			reg = <0x4a002000 0x800>,
> +			      <0x4a002800 0x1000>;
> +			ti,hwmods = "ctrl_module_core";
> +		};
> +
> +		ctrl_module_wkup: ctrl_module_wkup@4a002000 {
> +			reg = <0x4ae0c000 0x800>,
> +			      <0x4ae0c800 0x800>;
> +			ti,hwmods = "ctrl_module_wkup";
> +		};

Should probably be one device as well.

> +
> +		dss: dss@58000000 {
> +			reg = <0x58000000 0x80>;
> +			ti,hwmods = "dss_core";
> +		};
> +
> +		dss_dispc: dss_dispc@58001000 {
> +			reg = <0x58001000 0x1000>;
> +			ti,hwmods = "dss_dispc";
> +		};
> +
> +		dss_dsi1_a: dss_dsi1_a@58004000 {
> +			reg = <0x58004000 0x200>;
> +			ti,hwmods = "dss_dsi1_a";
> +		};
> +
> +		dss_dsi1_b: dss_dsi1_b@58005000 {
> +			reg = <0x58005000 0x200>;
> +			ti,hwmods = "dss_dsi1_b";
> +		};
> +
> +		dss_dsi1_c: dss_dsi1_c@58009000 {
> +			reg = <0x58009000 0x200>;
> +			ti,hwmods = "dss_dsi1_c";
> +		};
> +
> +		dss_hdmi: dss_hdmi@58060000 {
> +			reg = <0x58060000 0x19000>;
> +			ti,hwmods = "dss_hdmi";
> +		};
> +
> +		dss_rfbi: dss_rfbi@580020000 {
> +			reg = <0x58002000 0x100>;
> +			ti,hwmods = "dss_rfbi";
> +		};

For the DSS, you do have to respect the HW hierarchy. hwmod was flat,
and it was the source of a lot of PM dependency issue.

> +
> +		elm: elm@48078000 {
> +			reg = <0x48078000 0x1000>;
> +			ti,hwmods = "elm";
> +		};
> +
> +		fdif: elm@4a10a000 {
> +			reg = <0x4a10a000 0x200>;
> +			ti,hwmods = "fdif";
> +		};

Same issue than DSS. FDIF, ISS are somehow related.

> +
> +		gpmc: gpmc@50000000 {
> +			reg = <0x50000000 0x400>;
> +			ti,hwmods = "gpmc";
> +		};
> +
> +		gpu: gpu@5600fe00 {
> +			reg = <0x5600fe00 0x2000>;
> +			ti,hwmods = "gpu";
> +		};
> +
> +
> +		hdq1w: hdq1w@480b2000 {
> +			reg = <0x480b2000 0x20>;
> +			ti,hwmods = "hdq1w";
> +		};
> +
> +		hsi: hsi@4a05a000 {
> +			reg = <0x4a05a000 0x2000>;
> +			ti,hwmods = "hsi";
> +		};
> +
> +		ipu: ipu@55082000 {
> +			reg = <0x55082000 0x100>;
> +			ti,hwmods = "ipu";
> +		};
> +
> +		intc_ipu_c0: intc_ipu_c0@48211000 {
> +			reg = <0x48211000 0x2000>;
> +			ti,hwmods = "intc_ipu_c0";
> +		};
> +
> +		intc_ipu_c1: intc_ipu_c1@48211000 {
> +			reg = <0x48211000 0x2000>;
> +			ti,hwmods = "intc_ipu_c1";
> +		};

Do we need such entries?

> +
> +		mmu_ipu: mmu_ipu@55080800 {
> +			reg = <0x55080800 0x1000>;
> +			ti,hwmods = "mmu_ipu";
> +		};
> +
> +		iss: iss@52000000 {
> +			reg = <0x52000000 0x20>;
> +			ti,hwmods = "iss";
> +		};
> +
> +		iva: iva@5a05a400 {
> +			reg = <0x5a05a400 0x80>;
> +			ti,hwmods = "iva";
> +		};
> +
> +		mailbox: mailbox@4a0f4000 {
> +			reg = <0x4a0f4000 0x200>;
> +			ti,hwmods = "mailbox";
> +		};
> +
> +		mcasp: mcasp@40128000 {
> +			reg = <0x40128000 0x400>;
> +			ti,hwmods = "mcasp";
> +		};
> +
> +		mcspi1: mcspi1@48098000 {
> +			reg = <0x48098000 0x200>;
> +			ti,hwmods = "mcspi1";
> +		};
> +
> +		mcspi2: mcspi2@4809a000 {
> +			reg = <0x4809a000 0x200>;
> +			ti,hwmods = "mcspi2";
> +		};
> +
> +		mcspi3: mcspi3@480b8000 {
> +			reg = <0x480b8000 0x200>;
> +			ti,hwmods = "mcspi3";
> +		};
> +
> +		mcspi4: mcspi4@480ba000 {
> +			reg = <0x480ba000 0x200>;
> +			ti,hwmods = "mcspi4";
> +		};
> +
> +		ocp2scp1: ocp2scp1@4a080000 {
> +			reg = <0x4a080000 0x20>;
> +			ti,hwmods = "ocp2scp1";
> +		};
> +
> +		sata: sata@4a141100 {
> +			reg = <0x4a141100 0x08>;
> +			ti,hwmods = "sata";
> +		};
> +
> +		scrm: scrm@4ae0a000 {
> +			reg = <0x4ae0a000 0x800>;
> +			ti,hwmods = "scrm";
> +		};
> +
> +		slimbus1: slimbus1@4012c000 {
> +			reg = <0x4012c000 0x400>;
> +			ti,hwmods = "slimbus1";
> +		};
> +
> +		smartreflex_core: smartreflex_core@4a0dd000 {
> +			reg = <0x4a0dd000 0x40>;
> +			ti,hwmods = "smartreflex_core";
> +		};
> +
> +		smartreflex_mm: smartreflex_mm@4a0db000 {
> +			reg = <0x4a0db000 0x40>;
> +			ti,hwmods = "smartreflex_mm";
> +		};
> +
> +		smartreflex_mpu: smartreflex_mpu@4a0d9000 {
> +			reg = <0x4a0d9000 0x40>;
> +			ti,hwmods = "smartreflex_mpu";
> +		};
> +
> +		spinlock: spinlock@4a0f6000 {
> +			reg = <0x4a0f6000 0x1000>;
> +			ti,hwmods = "spinlock";
> +		};
> +
> +		usb_host_hs: usb_host_hs@4a064c00 {
> +			reg = <0x4a064c00 0x100>;
> +			ti,hwmods = "usb_host_hs";
> +		};
> +
> +		usb_otg_ss: usb_otg_ss@4a030000 {
> +			reg = <0x4a030000 0x100>;
> +			ti,hwmods = "usb_otg_ss";
> +		};
> +
> +		usb_tll_hs: usb_tll_hs@4a062800 {
> +			reg = <0x4a062800 0x400>;
> +			ti,hwmods = "usb_tll_hs";
> +		};
> +
> +		wd_timer2: wd_timer2@4ae14000 {
> +			reg = <0x4ae14000 0x80>;
> +			ti,hwmods = "wd_timer2";
> +		};
> +
> +		wd_timer3: wd_timer3@40130000 {
> +			reg = <0x40130000 0x80>;
> +			ti,hwmods = "wd_timer3";
> +		};

In case of real device and existing binding, you must populate every
entries (IRQ, DMA...).

Regards,
Benoit


