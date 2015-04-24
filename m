From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] bus: omap_l3_noc: Fix master id address decoding for
 OMAP5
Date: Fri, 24 Apr 2015 13:33:12 -0500
Message-ID: <553A8C68.5080903@ti.com>
References: <1429898060-51944-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43331 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751181AbbDXSdk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Apr 2015 14:33:40 -0400
In-Reply-To: <1429898060-51944-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 04/24/2015 12:54 PM, Suman Anna wrote:
> The L3 Error handling on OMAP5 for the most part is very similar
> to that of OMAP4, and had leveraged common data structures and
> register layout definitions so far. Upon closer inspection, there
> are a few minor differences causing an incorrect decoding and
> reporting of the master NIU upon an error:
> 
>   1. The L3_TARG_STDERRLOG_MSTADDR.STDERRLOG_MSTADDR occupies
>      11 bits on OMAP5 as against 8 bits on OMAP4, with the master
>      NIU connID encoded in the 6 MSBs of the STDERRLOG_MSTADDR
>      field.
>   2. The CLK3 FlagMux component has 1 input source on OMAP4 and 3
>      input sources on OMAP5. The common DEBUGSS source is at a
>      different input on each SoC.
> 
> Fix the above issues by using a OMAP5-specific compatible property
> and using SoC-specific data where there are differences.
> 
> Cc: Nishanth Menon <nm@ti.com>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
> 
> Some validation traces by adding couple of traces and intentionally
> creating L3 errors from DSP & IPU by accessing invalid Timers
> 
> Before Patch:
> OMAP4 [Correct]
> IPU accessing Timer4
> [   46.548095] flagmux = 1, err_reg = 0x8000 err_src = 0xf
> [   46.553344] mstaddr = 0x44 mask = 0xfc masterid = 0x11
> [   46.553955] ------------[ cut here ]------------
> [   46.563171] WARNING: CPU: 0 PID: 4 at drivers/bus/omap_l3_noc.c:149 l3_interrupt_handler+0x280/0x388()
> [   46.564941] 44000000.ocp:L3 Custom Error: MASTER DucatiM3 TARGET L4PER3 (Idle): Data Access in User mode during 
> Functional access
> 
> DSP accessing Timer5:
> [  114.018524] flagmux = 0, err_reg = 0x4 err_src = 0x2
> [  114.023498] mstaddr = 0x20 mask = 0xfc masterid = 0x8
> [  114.028564] ------------[ cut here ]------------
> [  114.033233] WARNING: CPU: 0 PID: 0 at drivers/bus/omap_l3_noc.c:149 l3_interrupt_handler+0x280/0x388()
> [  114.042572] 44000000.ocp:L3 Custom Error: MASTER DSP TARGET ABE (Idle): Data Access in Supervisor mode during Functional 
> access
> 
> OMAP5 [Incorrect]
> IPU accessing Timer4:
> [   29.579306] flagmux = 1, err_reg = 0x8000 err_src = 0xf
> [   29.584550] mstaddr = 0x220 mask = 0xfc masterid = 0x8
> [   29.589705] ------------[ cut here ]------------
> [   29.594345] WARNING: CPU: 0 PID: 61 at drivers/bus/omap_l3_noc.c:149 l3_interrupt_handler+0x280/0x388()
> [   29.603774] 44000000.ocp:L3 Custom Error: MASTER DSP TARGET L4PER3 (Idle): Data Access in User mode during Functional 
> access
> 
> DSP accessing Timer5:
> [   21.347105] flagmux = 0, err_reg = 0x4 err_src = 0x2
> [   21.352091] mstaddr = 0x100 mask = 0xfc masterid = 0x0
> [   21.357250] ------------[ cut here ]------------
> [   21.361896] WARNING: CPU: 0 PID: 0 at drivers/bus/omap_l3_noc.c:149 l3_interrupt_handler+0x280/0x388()
> [   21.371242] 44000000.ocp:L3 Custom Error: MASTER MPU TARGET ABE (Idle): Data Access in Supervisor mode during Functional 
> access
> 
> After Patch:
> OMAP4 same as above
> 
> OMAP5 [Corrected]
> IPU accessing Timer4
> [   67.896693] flagmux = 1, err_reg = 0x8000 err_src = 0xf
> [   67.901940] mstaddr = 0x220 mask = 0x7e0 masterid = 0x11
> [   67.907275] ------------[ cut here ]------------
> [   67.911924] WARNING: CPU: 0 PID: 61 at drivers/bus/omap_l3_noc.c:149 l3_interrupt_handler+0x280/0x388()
> [   67.921357] 44000000.ocp:L3 Custom Error: MASTER DucatiM3 TARGET L4PER3 (Idle): Data Access in User mode during 
> Functional access
> 
> DSP accessing Timer5
> [   24.452565] flagmux = 0, err_reg = 0x4 err_src = 0x2
> [   24.457552] mstaddr = 0x100 mask = 0x7e0 masterid = 0x8
> [   24.462798] ------------[ cut here ]------------
> [   24.467449] WARNING: CPU: 0 PID: 0 at drivers/bus/omap_l3_noc.c:149 l3_interrupt_handler+0x280/0x388()
> [   24.476795] 44000000.ocp:L3 Custom Error: MASTER DSP TARGET ABE (Idle): Data Access in Supervisor mode during Functional
>  access
> 
> 
>  .../devicetree/bindings/arm/omap/l3-noc.txt        |  1 +
>  arch/arm/boot/dts/omap5.dtsi                       |  2 +-
>  drivers/bus/omap_l3_noc.c                          |  5 ++-
>  drivers/bus/omap_l3_noc.h                          | 52 ++++++++++++++++------
>  4 files changed, 44 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/l3-noc.txt b/Documentation/devicetree/bindings/arm/omap/l3-noc.txt
> index 974624ea68f6..161448da959d 100644
> --- a/Documentation/devicetree/bindings/arm/omap/l3-noc.txt
> +++ b/Documentation/devicetree/bindings/arm/omap/l3-noc.txt
> @@ -6,6 +6,7 @@ provided by Arteris.
>  Required properties:
>  - compatible : Should be "ti,omap3-l3-smx" for OMAP3 family
>                 Should be "ti,omap4-l3-noc" for OMAP4 family
> +               Should be "ti,omap5-l3-noc" for OMAP5 family
>  	       Should be "ti,dra7-l3-noc" for DRA7 family
>                 Should be "ti,am4372-l3-noc" for AM43 family
>  - reg:	Contains L3 register address range for each noc domain.
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index efe5f737f39b..7d24ae0306b5 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -128,7 +128,7 @@
>  	 * hierarchy.
>  	 */
>  	ocp {
> -		compatible = "ti,omap4-l3-noc", "simple-bus";
> +		compatible = "ti,omap5-l3-noc", "simple-bus";
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		ranges;
> diff --git a/drivers/bus/omap_l3_noc.c b/drivers/bus/omap_l3_noc.c
> index 11f7982cbdb3..ebee57d715d2 100644
> --- a/drivers/bus/omap_l3_noc.c
> +++ b/drivers/bus/omap_l3_noc.c
> @@ -1,7 +1,7 @@
>  /*
>   * OMAP L3 Interconnect error handling driver
>   *
> - * Copyright (C) 2011-2014 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2011-2015 Texas Instruments Incorporated - http://www.ti.com/
>   *	Santosh Shilimkar <santosh.shilimkar@ti.com>
>   *	Sricharan <r.sricharan@ti.com>
>   *
> @@ -233,7 +233,8 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
>  }
>  
>  static const struct of_device_id l3_noc_match[] = {
> -	{.compatible = "ti,omap4-l3-noc", .data = &omap_l3_data},
> +	{.compatible = "ti,omap4-l3-noc", .data = &omap4_l3_data},
> +	{.compatible = "ti,omap5-l3-noc", .data = &omap5_l3_data},
>  	{.compatible = "ti,dra7-l3-noc", .data = &dra_l3_data},
>  	{.compatible = "ti,am4372-l3-noc", .data = &am4372_l3_data},
>  	{},
> diff --git a/drivers/bus/omap_l3_noc.h b/drivers/bus/omap_l3_noc.h
> index 95254585db86..3ba40db7380b 100644
> --- a/drivers/bus/omap_l3_noc.h
> +++ b/drivers/bus/omap_l3_noc.h
> @@ -1,7 +1,7 @@
>  /*
>   * OMAP L3 Interconnect  error handling driver header
>   *
> - * Copyright (C) 2011-2014 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2011-2015 Texas Instruments Incorporated - http://www.ti.com/
>   *	Santosh Shilimkar <santosh.shilimkar@ti.com>
>   *	sricharan <r.sricharan@ti.com>
>   *
> @@ -175,16 +175,14 @@ static struct l3_flagmux_data omap_l3_flagmux_clk2 = {
>  };
>  
>  
> -static struct l3_target_data omap_l3_target_data_clk3[] = {
> -	{0x0100, "EMUSS",},
> -	{0x0300, "DEBUG SOURCE",},
> -	{0x0,	"HOST CLK3",},
> +static struct l3_target_data omap4_l3_target_data_clk3[] = {
> +	{0x0100, "DEBUGSS",},
>  };
>  
> -static struct l3_flagmux_data omap_l3_flagmux_clk3 = {
> +static struct l3_flagmux_data omap4_l3_flagmux_clk3 = {
>  	.offset = 0x0200,
> -	.l3_targ = omap_l3_target_data_clk3,
> -	.num_targ_data = ARRAY_SIZE(omap_l3_target_data_clk3),
> +	.l3_targ = omap4_l3_target_data_clk3,
> +	.num_targ_data = ARRAY_SIZE(omap4_l3_target_data_clk3),
>  };
>  
>  static struct l3_masters_data omap_l3_masters[] = {
> @@ -215,21 +213,49 @@ static struct l3_masters_data omap_l3_masters[] = {
>  	{ 0x32, "USBHOSTFS"}
>  };
>  
> -static struct l3_flagmux_data *omap_l3_flagmux[] = {
> +static struct l3_flagmux_data *omap4_l3_flagmux[] = {
>  	&omap_l3_flagmux_clk1,
>  	&omap_l3_flagmux_clk2,
> -	&omap_l3_flagmux_clk3,
> +	&omap4_l3_flagmux_clk3,
>  };
>  
> -static const struct omap_l3 omap_l3_data = {
> -	.l3_flagmux = omap_l3_flagmux,
> -	.num_modules = ARRAY_SIZE(omap_l3_flagmux),
> +static const struct omap_l3 omap4_l3_data = {
> +	.l3_flagmux = omap4_l3_flagmux,
> +	.num_modules = ARRAY_SIZE(omap4_l3_flagmux),
>  	.l3_masters = omap_l3_masters,
>  	.num_masters = ARRAY_SIZE(omap_l3_masters),
>  	/* The 6 MSBs of register field used to distinguish initiator */
>  	.mst_addr_mask = 0xFC,
>  };
>  
> +/* OMAP5 data */
> +static struct l3_target_data omap5_l3_target_data_clk3[] = {
> +	{0x0100, "L3INSTR",},
> +	{0x0300, "DEBUGSS",},
> +	{0x0,	 "HOSTCLK3",},

"HOST CLK"

> +};
> +
> +static struct l3_flagmux_data omap5_l3_flagmux_clk3 = {
> +	.offset = 0x0200,
> +	.l3_targ = omap5_l3_target_data_clk3,
> +	.num_targ_data = ARRAY_SIZE(omap5_l3_target_data_clk3),
> +};
> +
> +static struct l3_flagmux_data *omap5_l3_flagmux[] = {
> +	&omap_l3_flagmux_clk1,
> +	&omap_l3_flagmux_clk2,
> +	&omap5_l3_flagmux_clk3,
> +};
> +
> +static const struct omap_l3 omap5_l3_data = {
> +	.l3_flagmux = omap5_l3_flagmux,
> +	.num_modules = ARRAY_SIZE(omap5_l3_flagmux),
> +	.l3_masters = omap_l3_masters,
> +	.num_masters = ARRAY_SIZE(omap_l3_masters),
> +	/* The 6 MSBs of register field used to distinguish initiator */
> +	.mst_addr_mask = 0x7E0,
> +};
> +
>  /* DRA7 data */
>  static struct l3_target_data dra_l3_target_data_clk1[] = {
>  	{0x2a00, "AES1",},
> 

If tony does not mind dts+driver patch, then except for the above comment:

Acked-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
