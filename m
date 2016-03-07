From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v5 10/26] mtd: nand: omap: Update DT binding documentation
Date: Mon, 7 Mar 2016 11:46:24 +0200
Message-ID: <56DD4DF0.4020500@ti.com>
References: <1455916548-3441-1-git-send-email-rogerq@ti.com>
 <1455916548-3441-11-git-send-email-rogerq@ti.com>
 <20160305020430.GL55664@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160305020430.GL55664@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: tony@atomide.com, dwmw2@infradead.org, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>
List-Id: linux-omap@vger.kernel.org

On 05/03/16 04:04, Brian Norris wrote:
> On Fri, Feb 19, 2016 at 11:15:32PM +0200, Roger Quadros wrote:
>> Add compatible id and interrupts. The NAND interrupts are
>> provided by the GPMC controller node.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  Documentation/devicetree/bindings/mtd/gpmc-nand.txt | 17 +++++++++++++----
>>  1 file changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
>> index fb733c4..810b87b 100644
>> --- a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
>> +++ b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
>> @@ -13,7 +13,11 @@ Documentation/devicetree/bindings/mtd/nand.txt
>>  
>>  Required properties:
>>  
>> - - reg:		The CS line the peripheral is connected to
>> + - compatible:	"ti,omap2-nand"
>> + - reg:		range id (CS number), base offset and length of the
>> +		NAND I/O space
> 
> Is it normal to mix types of addressing in a single 'reg' property? Is
> your code working for anything besides CS==0?

Yes we're using non zero CS on different omap platforms.
I haven't changed the behaviour of the reg property in this series. Just updated the documentation.

I didn't understand what you meant by mixing type of addressing.

This usage is exactly as mentioned here
http://devicetree.org/Device_Tree_Usage#Ranges_.28Address_Translation.29

cheers,
-roger

> 
>> + - interrupt-parent: must point to gpmc node
>> + - interrupts:	Two interrupt specifiers, one for fifoevent, one for termcount.
>>  
>>  Optional properties:
>>  
>> @@ -55,20 +59,25 @@ Example for an AM33xx board:
>>  	gpmc: gpmc@50000000 {
>>  		compatible = "ti,am3352-gpmc";
>>  		ti,hwmods = "gpmc";
>> -		reg = <0x50000000 0x1000000>;
>> +		reg = <0x50000000 0x36c>;
>>  		interrupts = <100>;
>>  		gpmc,num-cs = <8>;
>>  		gpmc,num-waitpins = <2>;
>>  		#address-cells = <2>;
>>  		#size-cells = <1>;
>> -		ranges = <0 0 0x08000000 0x2000>;	/* CS0: NAND */
>> +		ranges = <0 0 0x08000000 0x1000000>;	/* CS0 space, 16MB */
>>  		elm_id = <&elm>;
>>  
>>  		nand@0,0 {
>> -			reg = <0 0 0>; /* CS0, offset 0 */
>> +			compatible = "ti,omap2-nand";
>> +			reg = <0 0 4>;		/* CS0, offset 0, NAND I/O window 4 */
>> +			interrupt-parent = <&gpmc>;
>> +			interrupts = <0 IRQ_TYPE_NONE>, <1 IRQ_TYPE NONE>;
>>  			nand-bus-width = <16>;
>>  			ti,nand-ecc-opt = "bch8";
>>  			ti,nand-xfer-type = "polled";
>> +			interrupt-parent = <&gpmc>;
>> +			interrupts = <0>, <1>;
>>  
>>  			gpmc,sync-clk-ps = <0>;
>>  			gpmc,cs-on-ns = <0>;
>> -- 
>> 2.1.4
>>
