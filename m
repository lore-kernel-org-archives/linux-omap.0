From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 01/17] dt-bindings: remoteproc: Add TI PRUSS bindings
Date: Mon, 26 Nov 2018 09:47:49 +0200
Message-ID: <5BFBA525.3060806@ti.com>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
 <1542886753-17625-2-git-send-email-rogerq@ti.com>
 <20181123162417.GZ53235@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181123162417.GZ53235@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org, ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On 23/11/18 18:24, Tony Lindgren wrote:
> Hi,
> 
> * Roger Quadros <rogerq@ti.com> [181122 11:39]:
>> From: Suman Anna <s-anna@ti.com>
>> +Example:
>> +========
>> +1.	/* AM33xx PRU-ICSS */
>> +	pruss_soc_bus: pruss_soc_bus@4a326004 {
>> +		compatible = "ti,am3356-pruss-soc-bus";
>> +		ti,hwmods = "pruss";
>> +		reg = <0x4a326004 0x4>;
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges;
> 
> The top level interconnect target module driver should be just ti-sysc
> as documented in Documentation/devicetree/bindings/bus/ti-sysc.txt.
> AFAIK there is nothing PRU specific there. So let's not add yet
> another custom interconnect target module handling code to deal with.
> 
> I also posted a patch a while back for using reset-simple with
> ti-sysc as "[PATCHv2] reset: ti-rstctrl: use the reset-simple driver".
> 

Cool. I will try that out.

>> +			pruss_cfg: cfg@4a326000 {
>> +				compatible = "syscon";
>> +				reg = <0x4a326000 0x2000>;
>> +			};
>> +
>> +			pruss_iep: iep@4a32e000 {
>> +				compatible = "syscon";
>> +				reg = <0x4a32e000 0x31c>;
>> +			};
>> +
>> +			pruss_mii_rt: mii_rt@4a332000 {
>> +				compatible = "syscon";
>> +				reg = <0x4a332000 0x58>;
>> +			};
> 
> Hmm what are these syscon register actually doing? Sseems like
> they should be just handled by a phy driver nowadays?

Not the PHY driver but the Ethernet driver. The PHY driver will be
a davinci-MDIO device node (not yet in this series). I should probably
add merge that with this series.

The Ethernet device tree node will reference to these syscon nodes.
e.g.
        pruss2_eth {
                compatible = "ti,am57-prueth";
                prus = <&pru2_0>, <&pru2_1>;
                firmware-name = "ti-pruss/am57xx-pru0-prueth-fw.elf",
                                "ti-pruss/am57xx-pru1-prueth-fw.elf";
                sram = <&ocmcram1>;
                interrupt-parent = <&pruss2_intc>;
-->             mii-rt = <&pruss2_mii_rt>;
-->             iep = <&pruss2_iep>;
	}

Do you see any issues with that?

> 
> Other than that the binding looks OK to me. Good to finally
> see some activity in getting the PRU support merged :)

Thanks :)

cheers,
-roger

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
