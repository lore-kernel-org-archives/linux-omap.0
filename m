From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 7/8] ARM: dts: dra7: Add USB related nodes
Date: Fri, 14 Mar 2014 14:11:56 +0200
Message-ID: <5322F20C.50600@ti.com>
References: <1394197751-28984-1-git-send-email-rogerq@ti.com> <1394197751-28984-8-git-send-email-rogerq@ti.com> <5322DC0E.1020600@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5322DC0E.1020600-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: george.cherian-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 03/14/2014 12:38 PM, Kishon Vijay Abraham I wrote:
> Hi Roger,
> 
> On Friday 07 March 2014 06:39 PM, Roger Quadros wrote:
>> Add nodes for the Super Speed USB controllers, omap-control-usb,
>> USB2 PHY and USB3 PHY devices.
>>
>> Remove ocp2scp1 address space from hwmod data as it is
>> now provided via device tree.
>>
>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>> ---
>>   arch/arm/boot/dts/dra7.dtsi               | 110 ++++++++++++++++++++++++++++++
>>   arch/arm/mach-omap2/omap_hwmod_7xx_data.c |  10 ---
>>   2 files changed, 110 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
>> index 597979b..1e73900 100644
>> --- a/arch/arm/boot/dts/dra7.dtsi
>> +++ b/arch/arm/boot/dts/dra7.dtsi
>> @@ -811,6 +811,116 @@
>>               clocks = <&sata_ref_clk>;
>>               ti,hwmods = "sata";
>>           };
>> +
>> +        omap_control_usb2phy1: control-phy@4a002300 {
>> +            compatible = "ti,control-phy-usb2";
>> +            reg = <0x4a002300 0x4>;
>> +            reg-names = "power";
>> +        };
>> +
>> +        omap_control_usb3phy1: control-phy@4a002370 {
>> +            compatible = "ti,control-phy-pipe3";
>> +            reg = <0x4a002370 0x4>;
>> +            reg-names = "power";
>> +        };
>> +
>> +        omap_control_usb2phy2: control-phy@0x4a002e74 {
>> +            compatible = "ti,control-phy-usb2-dra7";
>> +            reg = <0x4a002e74 0x4>;
>> +            reg-names = "power";
>> +        };
>> +
>> +        /* OCP2SCP1 */
>> +        ocp2scp@4a080000 {
>> +            compatible = "ti,omap-ocp2scp";
>> +            #address-cells = <1>;
>> +            #size-cells = <1>;
>> +            ranges;
>> +            reg = <0x4a080000 0x20>;
>> +            ti,hwmods = "ocp2scp1";
>> +
>> +            usb2_phy1: phy@4a084000 {
>> +                compatible = "ti,omap-usb2";
>> +                reg = <0x4a084000 0x400>;
>> +                ctrl-module = <&omap_control_usb2phy1>;
>> +                clocks = <&usb_phy1_always_on_clk32k>,
>> +                     <&usb_otg_ss1_refclk960m>;
>> +                clock-names =    "wkupclk",
>> +                        "refclk";
>> +                #phy-cells = <0>;
>> +            };
>> +
>> +            usb2_phy2: phy@4a085000 {
>> +                compatible = "ti,omap-usb2";
>> +                reg = <0x4a085000 0x400>;
>> +                ctrl-module = <&omap_control_usb2phy2>;
>> +                clocks = <&usb_phy2_always_on_clk32k>,
>> +                     <&usb_otg_ss2_refclk960m>;
>> +                clock-names =    "wkupclk",
>> +                        "refclk";
>> +                #phy-cells = <0>;
>> +            };
>> +
>> +            usb3_phy1: phy@4a084400 {
>> +                compatible = "ti,omap-usb3";
>> +                reg = <0x4a084400 0x80>,
>> +                      <0x4a084800 0x64>,
>> +                      <0x4a084c00 0x40>;
>> +                reg-names = "phy_rx", "phy_tx", "pll_ctrl";
>> +                ctrl-module = <&omap_control_usb3phy1>;
>> +                clocks = <&usb_phy3_always_on_clk32k>,
>> +                     <&sys_clkin1>,
>> +                     <&usb_otg_ss1_refclk960m>,
>> +                     <&dpll_core_h13x2_ck>;
>> +                clock-names =    "wkupclk",
>> +                        "sysclk",
>> +                        "refclk",
>> +                        "optclk";
> 
> Do we use this 'optclk' in driver?

No we don't. Still the device seems to work without it.
This is supposed to be USB_LFPS_TX_GFCLK or USB3PHY_REF_CLK.

Any idea why it works without that on OMAP5 as well?

cheers,
-roger

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
