From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v5 10/26] mtd: nand: omap: Update DT binding documentation
Date: Wed, 24 Feb 2016 11:55:25 +0200
Message-ID: <56CD7E0D.6000304@ti.com>
References: <1455916548-3441-1-git-send-email-rogerq@ti.com>
 <1455916548-3441-11-git-send-email-rogerq@ti.com>
 <20160223194129.GA12616@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160223194129.GA12616@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 23/02/16 21:41, Rob Herring wrote:
> On Fri, Feb 19, 2016 at 11:15:32PM +0200, Roger Quadros wrote:
>> Add compatible id and interrupts. The NAND interrupts are
>> provided by the GPMC controller node.
> 
> This doesn't look like a backwards compatible change.

The existing OMAP NAND DT implementation doesn't even need a compatible id
in its DT node and so we are not intending to keep it backward compatible.

We are placing a warning instead if we encounter an old style NAND node.

> 
> 
>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
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
> 
> gpmc also needs an interrupt-controller property.

Yes. will fix.
> 
>> +			interrupts = <0 IRQ_TYPE_NONE>, <1 IRQ_TYPE NONE>;
>>  			nand-bus-width = <16>;
>>  			ti,nand-ecc-opt = "bch8";
>>  			ti,nand-xfer-type = "polled";
>> +			interrupt-parent = <&gpmc>;
>> +			interrupts = <0>, <1>;
> 
> Twice?

oops. will remove this.

> 
>>  
>>  			gpmc,sync-clk-ps = <0>;
>>  			gpmc,cs-on-ns = <0>;
>> -- 
>> 2.1.4
>>

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
