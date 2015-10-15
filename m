From: "Franklin S Cooper Jr." <fcooper@ti.com>
Subject: Re: [PATCH 5/5] ARM: OMAP2+: Update gpmc and nand DT binding
 documentation
Date: Thu, 15 Oct 2015 12:14:52 -0500
Message-ID: <561FDF0C.4020902@ti.com>
References: <1444700338-27582-1-git-send-email-fcooper@ti.com>
 <1444700338-27582-6-git-send-email-fcooper@ti.com> <561E417F.4020304@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <561E417F.4020304@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, nsekhar@ti.com, computersforpeace@gmail.com, dwmw2@infradead.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org



On 10/14/2015 06:50 AM, Roger Quadros wrote:
> On 13/10/15 04:38, Franklin S Cooper Jr wrote:
>> Add additional details to the gpmc and nand documentation to clarify
>> what is needed to enable nand dma prefetch.
>>
>> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
>> ---
>>  Documentation/devicetree/bindings/memory-controllers/omap-gpmc.txt | 7 ++++++-
>>  Documentation/devicetree/bindings/mtd/gpmc-nand.txt                | 2 ++
>>  2 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/memory-controllers/omap-gpmc.txt b/Documentation/devicetree/bindings/memory-controllers/omap-gpmc.txt
>> index 704be93..b1e2802 100644
>> --- a/Documentation/devicetree/bindings/memory-controllers/omap-gpmc.txt
>> +++ b/Documentation/devicetree/bindings/memory-controllers/omap-gpmc.txt
>> @@ -33,6 +33,10 @@ Required properties:
>>  			As this will change in the future, filling correct
>>  			values here is a requirement.
>>  
>> +GPMC DMA information. Required only when GPMC nand prefetch is enabled.
>> + - dmas			GPMC nand prefetch dma channel
> s/nand/NAND
>
>> + - dma-names		DMA channel name use as a reference within the Nand driver
> s/Nand/NAND
>
> This is inevitably going to be "rxtx". So why not say that it should be "rxtx"
I'll fix all three of these
>
> Should these bindings go in bindings/mtd/gpmc-nand.txt instead?
>
>> +
>>  Timing properties for child nodes. All are optional and default to 0.
>>  
>>   - gpmc,sync-clk-ps:	Minimum clock period for synchronous mode, in picoseconds
>> @@ -119,7 +123,8 @@ Example for an AM33xx board:
>>  		ti,hwmods = "gpmc";
>>  		reg = <0x50000000 0x2000>;
>>  		interrupts = <100>;
>> -
>> +		dmas = <&edma 52>;
>> +		dma-names = "rxtx";
> Why not define these in the NAND node instead of gpmc node?
Since we decided that the dma entry will stay in the GPMC node I'll leave these as is.
>
>>  		gpmc,num-cs = <8>;
>>  		gpmc,num-waitpins = <2>;
>>  		#address-cells = <2>;
>> diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
>> index 253e6de..4b0c240 100644
>> --- a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
>> +++ b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
>> @@ -61,6 +61,8 @@ Example for an AM33xx board:
>>  		ti,hwmods = "gpmc";
>>  		reg = <0x50000000 0x36c>;
>>  		interrupts = <100>;
>> +		dmas = <&edma 52>;
>> +		dma-names = "rxtx";
>>  		gpmc,num-cs = <8>;
>>  		gpmc,num-waitpins = <2>;
>>  		#address-cells = <2>;
>>
> cheers,
> -roger
