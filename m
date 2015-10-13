From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v3 27/27] ARM: dts: omap3: Fix gpmc and NAND nodes
Date: Tue, 13 Oct 2015 09:29:23 +0300
Message-ID: <561CA4C3.4@ti.com>
References: <1442588029-13769-1-git-send-email-rogerq@ti.com>
 <1442588029-13769-28-git-send-email-rogerq@ti.com>
 <20151013004335.GU23801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151013004335.GU23801@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: dwmw2@infradead.org, computersforpeace@gmail.com, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 13/10/15 03:43, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [150918 08:00]:
>> Add compatible id, GPMC register resource and interrupt
>> resource to NAND controller nodes.
>>
>> The GPMC driver now implements gpiochip and irqchip so
>> enable gpio-controller and interrupt-controller properties.
>>
>> With this the interrupt parent of NAND node changes so fix it
>> accordingly.
> ...
>> --- a/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
>> +++ b/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
>> @@ -35,11 +35,14 @@
>>  };
>>  
>>  &gpmc {
>> -	ranges = <0 0 0x00000000 0x1000000>;	/* CS0: 16MB for NAND */
>> +	ranges = <0 0 0x08000000 0x1000000>;	/* CS0: 16MB for NAND */
>>  
>>  	nand@0,0 {
>> -		linux,mtd-name = "micron,mt29f4g16abbda3w";
>> +		compatible = "ti,omap2-nand";
>>  		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
>> +		interrupt-parent = <&intc>;
>> +		interrupts = <20>;
>> +		linux,mtd-name = "micron,mt29f4g16abbda3w";
>>  		nand-bus-width = <16>;
>>  		ti,nand-ecc-opt = "bch8";
>>  		gpmc,sync-clk-ps = <0>;
> 
> At least torpedo breaks for NFSroot as NAND now overlaps with
> Ethernet.. What's the policy you have for moving the addresses
> around?

For OMAP3 I intended to use 0x30000000 for NAND but incorrectly
used 0x08000000 for the torpedo.

Does setting it to 0x30000000 work? If not what is the original
NAND address for this board?

> 
> There may be other similar cases to check too.

Just checked that all other OMAP3 boards I've set to 0x30000000
if they were 0x0.

cheers,
-roger
