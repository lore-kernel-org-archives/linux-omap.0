From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH 15/17] ARM: dts: AM33xx: Add the PRU-ICSS DT nodes
Date: Mon, 26 Nov 2018 10:37:23 -0600
Message-ID: <55dc1462-b154-8e57-c352-88f8ff28a708@lechnology.com>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
 <1542886753-17625-16-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542886753-17625-16-git-send-email-rogerq@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, tony@atomide.com
Cc: robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org, ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/22/18 5:39 AM, Roger Quadros wrote:
> From: Suman Anna <s-anna@ti.com>
> 
> Add the DT nodes for the PRU-ICSS on AM33xx family of SoCs. The
> AM33xx SoCs contain a single PRU-ICSS instance and is represented
> by the pruss-soc-bus node and a child PRUSS node. PRU-ICSS is not
> supported on AM3352 SoC though in the AM33xx family, so the nodes
> are added in disabled state to the common am33xx dtsi file. They
> should be enabled in only those derivative board files that use
> a SoC containing PRU-ICSS.
> 
> The PRUSS subsystem node contains the entire address space and
> the various interrupts generated towards the main MPU. The various
> sub-modules of the PRU-ICSS are represented as individual child
> nodes (so platform devices themselves) of the PRUSS subsystem node.
> These include the two PRU cores and the interrupt controller. The
> Industrial Ethernet Peripheral (IEP), the Real Time Media Independent
> Interface controller (MII_RT), and the CFG sub-module are represented
> as syscon nodes. All the Data RAMs are represented within a child
> node of its own named 'memories' without any compatible.
> 
> The DT nodes use all standard properties. The regs property in
> the PRU nodes define the addresses for the Instruction RAM, the
> Debug and Control sub-modules for that PRU core. The firmware for
> each PRU core is defined through a 'firmware-name' property.
> 
> The default names for the firmware images for each PRU core are
> defined as follows (these can be adjusted either in derivative
> board dts files or through sysfs at runtime if required):
>       PRU-ICSS PRU0 Core: am335x-pru1_0-fw
>       PRU-ICSS PRU1 Core: am335x-pru1_1-fw
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>   arch/arm/boot/dts/am33xx.dtsi | 72 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 72 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index d3dd6a1..ce42cd9 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -924,6 +924,78 @@
>   			};
>   		};
>   
> +		pruss_soc_bus: pruss_soc_bus@4a326004 {
> +			compatible = "ti,am3356-pruss-soc-bus";
> +			reg = <0x4a326004 0x4>;
> +			ti,hwmods = "pruss";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			status = "disabled";
> +
> +			pruss: pruss@4a300000 {

<snip>

> +
>   		elm: elm@48080000 {
>   			compatible = "ti,am3352-elm";
>   			reg = <0x48080000 0x2000>;
> 

This doesn't apply cleanly to next-20181126. elm: elm@48080000 node
is not there. If it was, it seems like the pruss node should be after
instead of before to keep things sorted since 4a300000 > 48080000.
