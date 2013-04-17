From: Lars Poeschel <poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH v3 3/3] ARM: OMAP2+: Add GPMC DT support for Ethernet
 child nodes
Date: Wed, 17 Apr 2013 11:40:52 +0200
Message-ID: <201304171140.52529.poeschel@lemonage.de>
References: <1363298051-24574-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1363298051-24574-1-git-send-email-javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Enric Balletbo i Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Javier!

On Thursday 14 March 2013 at 22:54:11, Javier Martinez Canillas wrote:
> Besides being used to interface with external memory devices,
> the General-Purpose Memory Controller can be used to connect
> Pseudo-SRAM devices such as ethernet controllers to OMAP2+
> processors using the TI GPMC as a data bus.
> 
> This patch allows an ethernet chip to be defined as an GPMC
> child device node.
> 
> Signed-off-by: Javier Martinez Canillas
> <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
> 
> ---
> Changes since v2:
>   - remove optional #address-cells and #size-cells since are not
> relevant for ethernet chips; suggested by Jon Hunter.
> 
> Changes since v1:
>   - Improve the DT binding documentation explaining that even when the
> GPMC maximum bus address width is 16-bit, it supports devices with
> 32-bit registers address width and the device property especifying this
> has to be set accordingly; suggested by Jon Hunter.
> 
>  Documentation/devicetree/bindings/net/gpmc-eth.txt |   97
> ++++++++++++++++++++ arch/arm/mach-omap2/gpmc.c                        
> |    8 ++
>  2 files changed, 105 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/gpmc-eth.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/gpmc-eth.txt
> b/Documentation/devicetree/bindings/net/gpmc-eth.txt new file mode
> 100644
> index 0000000..24cb4e4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/gpmc-eth.txt
> @@ -0,0 +1,97 @@
> +Device tree bindings for Ethernet chip connected to TI GPMC
> +
> +Besides being used to interface with external memory devices, the
> +General-Purpose Memory Controller can be used to connect Pseudo-SRAM
> devices +such as ethernet controllers to processors using the TI GPMC
> as a data bus. +
> +Ethernet controllers connected to TI GPMC are represented as child
> nodes of +the GPMC controller with an "ethernet" name.
> +
> +All timing relevant properties as well as generic GPMC child properties
> are +explained in a separate documents. Please refer to
> +Documentation/devicetree/bindings/bus/ti-gpmc.txt
> +
> +For the properties relevant to the ethernet controller connected to the
> GPMC +refer to the binding documentation of the device. For example,
> the documentation +for the SMSC 911x is
> Documentation/devicetree/bindings/net/smsc911x.txt +
> +Child nodes need to specify the GPMC bus address width using the
> "bank-width" +property but is possible that an ethernet controller also
> has a property to +specify the I/O registers address width. Even when
> the GPMC has a maximum 16-bit +address width, it supports devices with
> 32-bit word registers. +For example with an SMSC LAN911x/912x
> controller connected to the TI GPMC on an +OMAP2+ board, "bank-width =
> <2>;" and "reg-io-width = <4>;".
> +
> +Required properties:
> +- bank-width: 		Address width of the device in bytes. GPMC supports
> 8-bit +			and 16-bit devices and so must be either 1 or 2 bytes.
> +- compatible:		Compatible string property for the ethernet child
> device. +- gpmc,cs-on:		Chip-select assertion time
> +- gpmc,cs-rd-off:	Chip-select de-assertion time for reads
> +- gpmc,cs-wr-off:	Chip-select de-assertion time for writes
> +- gpmc,oe-on:		Output-enable assertion time
> +- gpmc,oe-off		Output-enable de-assertion time
> +- gpmc,we-on:		Write-enable assertion time
> +- gpmc,we-off:		Write-enable de-assertion time
> +- gpmc,access:		Start cycle to first data capture (read access)
> +- gpmc,rd-cycle:	Total read cycle time
> +- gpmc,wr-cycle:	Total write cycle time
> +- reg:			Chip-select, base address (relative to chip-select)
> +			and size of the memory mapped for the device.
> +			Note that base address will be typically 0 as this
> +			is the start of the chip-select.
> +
> +Optional properties:
> +- gpmc,XXX		Additional GPMC timings and settings parameters. See
> +			Documentation/devicetree/bindings/bus/ti-gpmc.txt
> +
> +Example:
> +
> +gpmc: gpmc@6e000000 {
> +	compatible = "ti,omap3430-gpmc";
> +	ti,hwmods = "gpmc";
> +	reg = <0x6e000000 0x1000>;
> +	interrupts = <20>;
> +	gpmc,num-cs = <8>;
> +	gpmc,num-waitpins = <4>;
> +	#address-cells = <2>;
> +	#size-cells = <1>;
> +
> +	ranges = <5 0 0x2c000000 0x1000000>;
> +
> +	ethernet@5,0 {
> +		compatible = "smsc,lan9221", "smsc,lan9115";
> +		reg = <5 0 0xff>;
> +		bank-width = <2>;
> +
> +		gpmc,mux-add-data;
> +		gpmc,cs-on = <0>;
> +		gpmc,cs-rd-off = <186>;
> +		gpmc,cs-wr-off = <186>;
> +		gpmc,adv-on = <12>;
> +		gpmc,adv-rd-off = <48>;
> +		gpmc,adv-wr-off = <48>;
> +		gpmc,oe-on = <54>;
> +		gpmc,oe-off = <168>;
> +		gpmc,we-on = <54>;
> +		gpmc,we-off = <168>;
> +		gpmc,rd-cycle = <186>;
> +		gpmc,wr-cycle = <186>;
> +		gpmc,access = <114>;
> +		gpmc,page-burst-access = <6>;
> +		gpmc,bus-turnaround = <12>;
> +		gpmc,cycle2cycle-delay = <18>;
> +		gpmc,wr-data-mux-bus = <90>;
> +		gpmc,wr-access = <186>;
> +		gpmc,cycle2cycle-samecsen;
> +		gpmc,cycle2cycle-diffcsen;
> +
> +		interrupt-parent = <&gpio6>;
> +		interrupts = <16>;
> +		vmmc-supply = <&vddvario>;
> +		vmmc_aux-supply = <&vdd33a>;
> +		reg-io-width = <4>;
> +
> +		smsc,save-mac-address;
> +	};
> +};
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 898b44d..2bc276b 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -1559,6 +1559,14 @@ static int gpmc_probe_dt(struct platform_device
> *pdev) }
>  	}
> 
> +	for_each_node_by_name(child, "ethernet") {
> +		ret = gpmc_probe_generic_child(pdev, child);
> +		if (ret < 0) {
> +			of_node_put(child);
> +			return ret;
> +		}
> +	}
> +
>  	return 0;
>  }
>  #else

I did a little testing on my am335x based device and this patch does 
introduce a problem for me. I am not sure if it is indeed related to this 
patch or if I created my device tree the wrong way. Maybe you can help a 
bit. Here are the relevant parts of kernel booting up:

...

[    0.136054] OMAP GPIO hardware version 0.1
[    0.139081] platform 481cc000.d_can: alias fck already exists
[    0.141593] omap-gpmc 50000000.gpmc: GPMC revision 6.0
[    0.141978] omap-gpmc 50000000.gpmc: cannot request GPMC CS 1242562560
[    0.141997] omap-gpmc 50000000.gpmc: failed to probe DT parameters
[    0.147869] bio: create slab <bio-0> at 0
[    0.162814] omap-dma-engine omap-dma-engine: OMAP DMA engine driver

...

[    1.013897] brd: module loaded
[    1.020964] loop: module loaded
[    1.024535] at24 0-0056: 512 byte 24c04 EEPROM, writable, 128 
bytes/write
[    1.049607] Unable to handle kernel NULL pointer dereference at virtual 
address 000001a4
[    1.058086] pgd = c0004000
[    1.060942] [000001a4] *pgd=00000000
[    1.064700] Internal error: Oops: 805 [#1] ARM
[    1.069350] Modules linked in:
[    1.072557] CPU: 0    Not tainted  (3.9.0-rc1 #27)
[    1.077600] PC is at omap_hwcontrol+0x44/0x4c
[    1.082173] LR is at nand_command+0x64/0x204
[    1.086650] pc : [<c0297430>]    lr : [<c0293294>]    psr: 00000113
[    1.086650] sp : df059db8  ip : 00000000  fp : 00000001
[    1.098680] r10: c05dffe0  r9 : df059e10  r8 : ffffffff
[    1.104183] r7 : df25ea38  r6 : 00000005  r5 : 00000090  r4 : df25e810
[    1.111024] r3 : 000001a4  r2 : 00000085  r1 : 00000000  r0 : df25e800
[    1.117858] Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment 
kernel
[    1.125514] Control: 10c5387d  Table: 80004019  DAC: 00000015
[    1.131532] Process swapper (pid: 1, stack limit = 0xdf058238)
[    1.137637] Stack: (0xdf059db8 to 0xdf05a000)
[    1.142213] 9da0:                                                       
df25ea38 df25e810
[    1.150788] 9dc0: 00000000 00000000 00000000 df059e10 c05dffe0 c0293764 
00000000 e0832000
[    1.159357] 9de0: 08000000 00001000 00000000 c05c85d4 08000fff c0015308 
00000000 00000004
[    1.167928] 9e00: 00000000 c05dffd0 df0d5ed0 00000000 0000008f c05dffe0 
00000000 df25e800
[    1.176500] 9e20: c062b78c df25e810 df0d5ed0 00000000 0000008f c05dffe0 
00000000 c0297944
[    1.185070] 9e40: 00000000 00000000 df059e70 df25d848 00000001 c00fee28 
c05dffe0 00000003
[    1.193637] 9e60: df00a62c c004f8cc 00000000 00000000 00000000 00000000 
c05e0014 c05dffe0
[    1.202209] 9e80: c05dffe8 c05dffe0 c062b170 c05e0014 00000000 c05f7c8c 
c05a40d8 c024da78
[    1.210783] 9ea0: c05dffe0 c024c78c c05dffe0 c05f7c8c c05e0014 00000000 
c0588360 c024c9ac
[    1.219354] 9ec0: c05f7c8c c024c920 df059ed0 c024b2ac df00a60c df0cf970 
df2585c0 c05f7c8c
[    1.227925] 9ee0: c05f25c0 df2585c0 00000000 c024b9c8 c0513f20 c062b788 
c05ae958 c05ae958
[    1.236495] 9f00: c05f7c8c df058000 00000000 c024cf90 c05ae958 c06049c0 
df058000 00000000
[    1.245070] 9f20: c0588360 c0008698 c0567ee4 c0a3cbe1 c0a3cbdc c05a40d8 
00000000 c04db534
[    1.253650] 9f40: c05675f4 00000006 c0a3cbe6 00000006 00000000 c05ae958 
c05bac60 c06049c0
[    1.262227] 9f60: 00000007 c0588360 0000008f c05ae960 00000000 c0588290 
00000006 00000006
[    1.270795] 9f80: c0588360 ff5c5cfb 00000000 c03ff488 00000000 00000000 
00000000 00000000
[    1.279378] 9fa0: 00000000 c03ff490 00000000 c000e078 00000000 00000000 
00000000 00000000
[    1.287944] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 
00000000 00000000
[    1.296529] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000 
dd5f5ddf 3d6ffed6
[    1.305120] [<c0297430>] (omap_hwcontrol+0x44/0x4c) from [<c0293294>] 
(nand_command+0x64/0x204)
[    1.314246] [<c0293294>] (nand_command+0x64/0x204) from [<c0293764>] 
(nand_scan_ident+0x70/0xc8c)
[    1.323553] [<c0293764>] (nand_scan_ident+0x70/0xc8c) from [<c0297944>] 
(omap_nand_probe+0x1dc/0x638)
[    1.333234] [<c0297944>] (omap_nand_probe+0x1dc/0x638) from [<c024da78>] 
(platform_drv_probe+0x18/0x1c)
[    1.343095] [<c024da78>] (platform_drv_probe+0x18/0x1c) from 
[<c024c78c>] (driver_probe_device+0x90/0x224)
[    1.353216] [<c024c78c>] (driver_probe_device+0x90/0x224) from 
[<c024c9ac>] (__driver_attach+0x8c/0x90)
[    1.363072] [<c024c9ac>] (__driver_attach+0x8c/0x90) from [<c024b2ac>] 
(bus_for_each_dev+0x68/0x8c)
[    1.372562] [<c024b2ac>] (bus_for_each_dev+0x68/0x8c) from [<c024b9c8>] 
(bus_add_driver+0x1bc/0x228)
[    1.382135] [<c024b9c8>] (bus_add_driver+0x1bc/0x228) from [<c024cf90>] 
(driver_register+0x78/0x14c)
[    1.391718] [<c024cf90>] (driver_register+0x78/0x14c) from [<c0008698>] 
(do_one_initcall+0x34/0x17c)
[    1.401304] [<c0008698>] (do_one_initcall+0x34/0x17c) from [<c0588290>] 
(kernel_init_freeable+0xdc/0x1ac)
[    1.411350] [<c0588290>] (kernel_init_freeable+0xdc/0x1ac) from 
[<c03ff490>] (kernel_init+0x8/0xe4)
[    1.420843] [<c03ff490>] (kernel_init+0x8/0xe4) from [<c000e078>] 
(ret_from_fork+0x14/0x3c)
[    1.429600] Code: e5c31000 e12fff1e f57ff04f e590349c (e5c31000) 
[    1.436070] ---[ end trace 2af83d33cc671cfa ]---
[    1.440961] Kernel panic - not syncing: Attempted to kill init! 
exitcode=0x0000000b

As you can see above, gpmc_probe fails. I digged a bit into it and this is 
because gpmc_probe_dt fails which in turn fails because 
gpmc_probe_generic_child in the "ethernet" part fails.
The interesting part is that it finds an "ethernet" node. I did not 
configure one in the gpmc. am335x based devices include am33xx.dtsi in 
their device tree source. This file contains an "ethernet" node for the on-
chip ethernet controller. Your code grabs this node and obviously fails to 
probe it. This is also where the strange CS value in the kernel output 
comes from (0x4a100000 == 1242562560). So I am not able to use the gpmc on 
any am33xx device because probing childs always fails.
For reference here is the gpmc part of my device tree source:

ocp {

...

	gpmc: gpmc@50000000 {
		compatible = "ti,am3352-gpmc";
		ti,hwmods = "gpmc";
		reg = <0x50000000 0x1000000>;
		interrupts = <100>;

		gpmc,num-cs = <7>;
		gpmc,num-waitpins = <2>;
		#address-cells = <2>;
		#size-cells = <1>;
		ranges = <0 0 0x08000000 0x20000000>; /* CS0 @addr 0x8000000, size 
512MiB */

		nand@0,0 {
			reg = <0 0 0>; /* CS0, offset 0 */
			nand-bus-width = <8>;
			ti,nand-ecc-opt = "sw";

			gpmc,sync-clk = <0>;
			gpmc,cs-on = <0>;
			gpmc,cs-rd-off = <44>;
			gpmc,cs-wr-off = <44>;
			gpmc,adv-on = <6>;
			gpmc,adv-rd-off = <34>;
			gpmc,adv-wr-off = <44>;
			gpmc,we-off = <40>;
			gpmc,oe-off = <54>;
			gpmc,access = <64>;
			gpmc,rd-cycle = <82>;
			gpmc,wr-cycle = <82>;
			gpmc,wr-access = <40>;
			gpmc,wr-data-mux-bus = <0>;

			#address-cells = <1>;
			#size-cells = <1>;

			/* partitions go here */
			partition@0 {
				label = "u-boot";
				reg = <0x0000000 0x100000>;
				read-only;
			};
		
			uimage@100000 {
				label = "uImage";
				reg = <0x0100000 0x200000>;
			};
		};
	};
};

Is this a problem of my device tree ? If you need further information or if 
I can help debugging, let me know.

Regards,
Lars
