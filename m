From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v3 3/3] ARM: OMAP2+: Add GPMC DT support for Ethernet
 child nodes
Date: Fri, 15 Mar 2013 10:34:05 -0500
Message-ID: <51433F6D.1060205@ti.com>
References: <1363298051-24574-1-git-send-email-javier.martinez@collabora.co.uk> <51433D3E.1070002@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60490 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754767Ab3COPeT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Mar 2013 11:34:19 -0400
In-Reply-To: <51433D3E.1070002@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>
Cc: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Enric Balletbo i Serra <eballetbo@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-omap@vger.kernel.org, device-tree <devicetree-discuss@lists.ozlabs.org>

Rob, Grant,

On 03/15/2013 10:24 AM, Jon Hunter wrote:
> 
> On 03/14/2013 04:54 PM, Javier Martinez Canillas wrote:
>> Besides being used to interface with external memory devices,
>> the General-Purpose Memory Controller can be used to connect
>> Pseudo-SRAM devices such as ethernet controllers to OMAP2+
>> processors using the TI GPMC as a data bus.
>>
>> This patch allows an ethernet chip to be defined as an GPMC
>> child device node.
>>
>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> ---
>>
>> Changes since v2:
>>   - remove optional #address-cells and #size-cells since are not relevant for
>>     ethernet chips; suggested by Jon Hunter.
>>
>> Changes since v1:
>>   - Improve the DT binding documentation explaining that even when the GPMC
>>     maximum bus address width is 16-bit, it supports devices with 32-bit
>>     registers address width and the device property especifying this has to
>>     be set accordingly; suggested by Jon Hunter.
>>
>>  Documentation/devicetree/bindings/net/gpmc-eth.txt |   97 ++++++++++++++++++++
>>  arch/arm/mach-omap2/gpmc.c                         |    8 ++
>>  2 files changed, 105 insertions(+), 0 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/net/gpmc-eth.txt
>>
>> diff --git a/Documentation/devicetree/bindings/net/gpmc-eth.txt b/Documentation/devicetree/bindings/net/gpmc-eth.txt
>> new file mode 100644
>> index 0000000..24cb4e4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/gpmc-eth.txt
>> @@ -0,0 +1,97 @@
>> +Device tree bindings for Ethernet chip connected to TI GPMC
>> +
>> +Besides being used to interface with external memory devices, the
>> +General-Purpose Memory Controller can be used to connect Pseudo-SRAM devices
>> +such as ethernet controllers to processors using the TI GPMC as a data bus.
>> +
>> +Ethernet controllers connected to TI GPMC are represented as child nodes of
>> +the GPMC controller with an "ethernet" name.
>> +
>> +All timing relevant properties as well as generic GPMC child properties are
>> +explained in a separate documents. Please refer to
>> +Documentation/devicetree/bindings/bus/ti-gpmc.txt
>> +
>> +For the properties relevant to the ethernet controller connected to the GPMC
>> +refer to the binding documentation of the device. For example, the documentation
>> +for the SMSC 911x is Documentation/devicetree/bindings/net/smsc911x.txt
>> +
>> +Child nodes need to specify the GPMC bus address width using the "bank-width"
>> +property but is possible that an ethernet controller also has a property to
>> +specify the I/O registers address width. Even when the GPMC has a maximum 16-bit
>> +address width, it supports devices with 32-bit word registers.
>> +For example with an SMSC LAN911x/912x controller connected to the TI GPMC on an
>> +OMAP2+ board, "bank-width = <2>;" and "reg-io-width = <4>;".
>> +
>> +Required properties:
>> +- bank-width: 		Address width of the device in bytes. GPMC supports 8-bit
>> +			and 16-bit devices and so must be either 1 or 2 bytes.
>> +- compatible:		Compatible string property for the ethernet child device.
>> +- gpmc,cs-on:		Chip-select assertion time
>> +- gpmc,cs-rd-off:	Chip-select de-assertion time for reads
>> +- gpmc,cs-wr-off:	Chip-select de-assertion time for writes
>> +- gpmc,oe-on:		Output-enable assertion time
>> +- gpmc,oe-off		Output-enable de-assertion time
>> +- gpmc,we-on:		Write-enable assertion time
>> +- gpmc,we-off:		Write-enable de-assertion time
>> +- gpmc,access:		Start cycle to first data capture (read access)
>> +- gpmc,rd-cycle:	Total read cycle time
>> +- gpmc,wr-cycle:	Total write cycle time
>> +- reg:			Chip-select, base address (relative to chip-select)
>> +			and size of the memory mapped for the device.
>> +			Note that base address will be typically 0 as this
>> +			is the start of the chip-select.
>> +
>> +Optional properties:
>> +- gpmc,XXX		Additional GPMC timings and settings parameters. See
>> +			Documentation/devicetree/bindings/bus/ti-gpmc.txt
>> +
>> +Example:
>> +
>> +gpmc: gpmc@6e000000 {
>> +	compatible = "ti,omap3430-gpmc";
>> +	ti,hwmods = "gpmc";
>> +	reg = <0x6e000000 0x1000>;
>> +	interrupts = <20>;
>> +	gpmc,num-cs = <8>;
>> +	gpmc,num-waitpins = <4>;
>> +	#address-cells = <2>;
>> +	#size-cells = <1>;
>> +
>> +	ranges = <5 0 0x2c000000 0x1000000>;
>> +
>> +	ethernet@5,0 {
>> +		compatible = "smsc,lan9221", "smsc,lan9115";
>> +		reg = <5 0 0xff>;
>> +		bank-width = <2>;
>> +
>> +		gpmc,mux-add-data;
>> +		gpmc,cs-on = <0>;
>> +		gpmc,cs-rd-off = <186>;
>> +		gpmc,cs-wr-off = <186>;
>> +		gpmc,adv-on = <12>;
>> +		gpmc,adv-rd-off = <48>;
>> +		gpmc,adv-wr-off = <48>;
>> +		gpmc,oe-on = <54>;
>> +		gpmc,oe-off = <168>;
>> +		gpmc,we-on = <54>;
>> +		gpmc,we-off = <168>;
>> +		gpmc,rd-cycle = <186>;
>> +		gpmc,wr-cycle = <186>;
>> +		gpmc,access = <114>;
>> +		gpmc,page-burst-access = <6>;
>> +		gpmc,bus-turnaround = <12>;
>> +		gpmc,cycle2cycle-delay = <18>;
>> +		gpmc,wr-data-mux-bus = <90>;
>> +		gpmc,wr-access = <186>;
>> +		gpmc,cycle2cycle-samecsen;
>> +		gpmc,cycle2cycle-diffcsen;
>> +
>> +		interrupt-parent = <&gpio6>;
>> +		interrupts = <16>;
>> +		vmmc-supply = <&vddvario>;
>> +		vmmc_aux-supply = <&vdd33a>;
>> +		reg-io-width = <4>;
>> +
>> +		smsc,save-mac-address;
>> +	};
>> +};
>> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
>> index 898b44d..2bc276b 100644
>> --- a/arch/arm/mach-omap2/gpmc.c
>> +++ b/arch/arm/mach-omap2/gpmc.c
>> @@ -1559,6 +1559,14 @@ static int gpmc_probe_dt(struct platform_device *pdev)
>>  		}
>>  	}
>>  
>> +	for_each_node_by_name(child, "ethernet") {
>> +		ret = gpmc_probe_generic_child(pdev, child);
>> +		if (ret < 0) {
>> +			of_node_put(child);
>> +			return ret;
>> +		}
>> +	}
>> +
>>  	return 0;
>>  }
>>  #else
> 
> Thanks! I have added this to my gpmc branch [1].

If you are ok with the Documentation part, can you ACK this?

Thanks
Jon
