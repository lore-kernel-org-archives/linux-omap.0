From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH 15/15] arm: dts: dra7: add sata node
Date: Fri, 20 Sep 2013 13:19:54 +0300
Message-ID: <523C214A.30406@ti.com>
References: <1379595943-14622-1-git-send-email-rogerq@ti.com> <1379597059-15405-1-git-send-email-rogerq@ti.com> <523B05FD.7020200@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <523B05FD.7020200-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On 09/19/2013 05:11 PM, Sergei Shtylyov wrote:
> Hello.
> 
> On 09/19/2013 05:24 PM, Roger Quadros wrote:
> 
>> From: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
> 
>> Add support for sata controller.
> 
>> [Roger Q] Clean up.
> 
>> CC: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
>> Signed-off-by: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>> ---
>>   arch/arm/boot/dts/dra7.dtsi |   49 +++++++++++++++++++++++++++++++++++++++++++
>>   1 files changed, 49 insertions(+), 0 deletions(-)
> 
>> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
>> index ce9a0f0..545545d 100644
>> --- a/arch/arm/boot/dts/dra7.dtsi
>> +++ b/arch/arm/boot/dts/dra7.dtsi
>> @@ -426,6 +426,55 @@
>>               dma-names = "tx", "rx";
>>           };
>>
>> +        omap_control_sata: control-phy@4a002374 {
>> +            compatible = "ti,control-phy-pipe3";
>> +            reg = <0x4a002374 0x4>;
>> +            reg-names = "power";
>> +            clocks = <&sys_clkin1>;
>> +            clock-names = "sysclk";
>> +        };
>> +
>> +        ocp2scp3: ocp2scp3@4a090000 {
>> +            compatible = "ti,omap-ocp2scp";
>> +            #address-cells = <1>;
>> +            #size-cells = <1>;
>> +            ranges;
>> +            ti,hwmods = "ocp2scp3";
>> +            reg = <0x4a090000 0x1f>; /* ocp2scp3 */
>> +            reg-names = "ocp2scp3";
>> +            sata_phy: sataphy@4A096000 {
> 
>    It's better to name the PHY nodes uniformly after already standard "ethernet-phy" and your "control-phy".

OK. will fix it to sata-phy.

> 
>> +                compatible = "ti,phy-pipe3-sata";
>> +                reg = <0x4A096000 0x80>, /* phy_rx */
>> +                      <0x4A096400 0x64>, /* phy_tx */
>> +                      <0x4A096800 0x40>; /* pll_ctrl */
>> +                reg-names = "phy_rx", "phy_tx", "pll_ctrl";
>> +                ctrl-module = <&omap_control_sata>;
>> +                clocks = <&sata_ref_clk>,
>> +                     <&sys_clkin1>;
>> +                clock-names = "optclk", "sysclk";
>> +                #phy-cells = <0>;
>> +            };
>> +        };
>> +
>> +        sata: sata@4a141100 {
>> +            compatible = "ti,sata";
>> +            ti,hwmods = "sata";
>> +            reg = <0x4a141100 0x7>;
>> +            #address-cells = <1>;
>> +            #size-cells = <1>;
>> +            ranges;
>> +            dwc-ahci@4a140000 {
> 
>    Hm, ePAPR spec. [1] says that "the name of a node should be somewhat generic, reflecting the function of the device and not its precise programming model", so it looks like the name should be "sata" as well. I'm a bit at a loss here, not sure why you had to use the nested device nodes.
> 

ok. will fix it to sata.
I've nested it because the wrapper registers are not part of the AHCI sata controller.
They are TI specific registers for power management. 
Similar setup is on the USB controller. Please see omap_dwc3 node.

But if you have better idea, please let me know.

>> +                  compatible = "snps,dwc-ahci";
>> +                  reg = <0x4a140000 0x1100>;
>> +                  interrupts = <0 54 0x4>;
>> +                  phys = <&sata_phy>;
> 
>    Hm, it's the third PHY related generic property I'm encountering. First, there was "phy-handle", then "phy", now "phys"... Seems like a bit too much. :-)

I'm afraid but this is how the designers have made it.

1) control-phy-pipe3 is that part of the PHY which sits in control module space and is different
from the sata-phy space and hence needs a different node. If it were to me, I would just put this
resource in sata-phy node, but there was a discussion about this earlier to do it otherwise [1].

2) sata-phy (sataphy) is the actual SATA PHY device.

3) phys is just a reference to the sata_phy and is used via the generic PHY framework.
It is upto the sata driver to power up/down the phy.

> 
>> +                  phy-names = "sata-phy";
>> +                  clocks = <&sata_ref_clk>;
>> +                  clock-names = "optclk";
>> +            };
>> +        };
> 
> [1] http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf
> 

cheers,
-roger

[1] - https://lkml.org/lkml/2012/9/10/399
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
