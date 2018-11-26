From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 01/17] dt-bindings: remoteproc: Add TI PRUSS bindings
Date: Mon, 26 Nov 2018 11:35:46 -0800
Message-ID: <20181126193546.GP53235@atomide.com>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
 <1542886753-17625-2-git-send-email-rogerq@ti.com>
 <20181123162417.GZ53235@atomide.com>
 <5BFBA525.3060806@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5BFBA525.3060806@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org, ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [181126 07:48]:
> Not the PHY driver but the Ethernet driver. The PHY driver will be
> a davinci-MDIO device node (not yet in this series). I should probably
> add merge that with this series.
> 
> The Ethernet device tree node will reference to these syscon nodes.
> e.g.
>         pruss2_eth {
>                 compatible = "ti,am57-prueth";
>                 prus = <&pru2_0>, <&pru2_1>;
>                 firmware-name = "ti-pruss/am57xx-pru0-prueth-fw.elf",
>                                 "ti-pruss/am57xx-pru1-prueth-fw.elf";
>                 sram = <&ocmcram1>;
>                 interrupt-parent = <&pruss2_intc>;
> -->             mii-rt = <&pruss2_mii_rt>;
> -->             iep = <&pruss2_iep>;
> 	}
> 
> Do you see any issues with that?

Well maybe take a look at Grygorii's series adding proper
PHY driver for CPSW and see if it affects this too.

Regards,

Tony
