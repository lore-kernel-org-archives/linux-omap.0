From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 4/5] ARM: dts: DRA7: add entry for qspi mmap region
Date: Mon, 30 Nov 2015 14:34:09 -0800
Message-ID: <20151130223408.GJ23396@atomide.com>
References: <1448860515-28336-1-git-send-email-vigneshr@ti.com>
 <1448860515-28336-5-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1448860515-28336-5-git-send-email-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Brian Norris <computersforpeace@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, hramrach@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Vignesh R <vigneshr@ti.com> [151129 21:16]:
> Add qspi memory mapped region entries for DRA7xx based SoCs. Also,
> update the binding documents for the controller to document this change.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Vignesh R <vigneshr@ti.com>
...
> --- a/Documentation/devicetree/bindings/spi/ti_qspi.txt
> +++ b/Documentation/devicetree/bindings/spi/ti_qspi.txt
> @@ -26,3 +26,17 @@ qspi: qspi@4b300000 {
>  	spi-max-frequency = <25000000>;
>  	ti,hwmods = "qspi";
>  };
> +
> +For dra7xx:
> +qspi: qspi@4b300000 {
> +	compatible = "ti,dra7xxx-qspi";
> +	reg = <0x4b300000 0x100>,
> +	      <0x5c000000 0x4000000>,
> +	      <0x4a002558 0x4>;
> +	reg-names = "qspi_base", "qspi_mmap",
> +		    "qspi_ctrlmod";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	spi-max-frequency = <48000000>;
> +	ti,hwmods = "qspi";
> +};

Actually none of the IO areas above are within the same interconnect target:

0x4b300000  QSPI0 address space in L3 main interconnect
0x5c000000  QSPI1 address space in L3 main interconnect
0x4a002558  CTRL_CORE_CONTROL_IO_2 in System Control Module (SCM) in L4_CFG

The first two address spaces should be two separate instances of this driver.
The CTRL_CORE_CONTROL_IO_2 needs seems like a shared clock register that
needs to be accessed using the clock framework most likely.

So not applying, this will be impossible to move to some real interconnect
driver until these issues are fixed.

Regards,

Tony
