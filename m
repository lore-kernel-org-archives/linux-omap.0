From: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 1/2] ARM: dts: dra7: Add CPSW and MDIO module nodes
 for dra7
Date: Thu, 11 Sep 2014 12:07:45 +0530
Message-ID: <54114339.5070404@ti.com>
References: <1410356247-25925-1-git-send-email-mugunthanvnm@ti.com> <1410356247-25925-2-git-send-email-mugunthanvnm@ti.com> <5410573B.5010907@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5410573B.5010907-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 10 September 2014 07:20 PM, Nishanth Menon wrote:
> On 09/10/2014 08:37 AM, Mugunthan V N wrote:
>> Add CPSW and MDIO related device tree data for DRA7XX and made as status
>> disabled. Phy-id, pinmux for active and sleep state needs to be added in
>> board dts files and enable the CPSW device.
>>
>> Signed-off-by: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
>> ---
>>  arch/arm/boot/dts/dra7.dtsi | 59 +++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 59 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
>> index d678152..8d79321 100644
>> --- a/arch/arm/boot/dts/dra7.dtsi
>> +++ b/arch/arm/boot/dts/dra7.dtsi
>> @@ -34,6 +34,8 @@
>>  		serial3 = &uart4;
>>  		serial4 = &uart5;
>>  		serial5 = &uart6;
>> +		ethernet0 = &cpsw_emac0;
>> +		ethernet1 = &cpsw_emac1;
> 
> should this rather be in board dts?

This should be here as the MAC address is filled in uboot with ethernet0
and ethernet1, moving this to dts, the ordering of the ethernet can go
for toss when they have other ethernet devices other than cpsw.

> 
>>  	};
>>  
>>  	timer {
>> @@ -1262,6 +1264,63 @@
>>  			ti,irqs-skip = <10 133 139 140>;
>>  			ti,irqs-safe-map = <0>;
>>  		};
>> +
>> +		mac: ethernet@4a100000 {
>> +			compatible = "ti,cpsw";
>> +			ti,hwmods = "gmac";
>> +			cpdma_channels = <8>;
>> +			ale_entries = <1024>;
>> +			bd_ram_size = <0x2000>;
>> +			no_bd_ram = <0>;
>> +			rx_descs = <64>;
>> +			mac_control = <0x20>;
>> +			slaves = <2>;
>> +			active_slave = <0>;
>> +			cpts_clock_mult = <0x80000000>;
>> +			cpts_clock_shift = <29>;
>> +			reg = <0x48484000 0x1000
>> +			       0x48485200 0x2E00>;
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			/*
>> +			 * rx_thresh_pend
>> +			 * rx_pend
>> +			 * tx_pend
>> +			 * misc_pend
>> +			 */
>> +			interrupts = <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>;
>> +			ranges;
>> +			status = "disabled";
>> +
>> +			davinci_mdio: mdio@48485000 {
>> +				compatible = "ti,davinci_mdio";
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				ti,hwmods = "davinci_mdio";
>> +				bus_freq = <1000000>;
>> +				reg = <0x48485000 0x100>;
>> +			};
>> +
>> +			cpsw_emac0: slave@48480200 {
>> +				/* Filled in by U-Boot */
>> +				mac-address = [ 00 00 00 00 00 00 ];
> 
> should be disabled? what about platforms that do not have both emac ports?

the mac node is already disabled, so platforms which doesn't have emac
should not enable this which in-turn emac node will be disabled.

Regards
Mugunthan V N
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
