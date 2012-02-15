From: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 2/4] ARM: OMAP2/3: intc: Add DT support for TI interrupt
 controller
Date: Wed, 15 Feb 2012 14:21:48 +0100
Message-ID: <4F3BB16C.90600@ti.com>
References: <1329242172-4214-1-git-send-email-b-cousson@ti.com>
 <1329242172-4214-3-git-send-email-b-cousson@ti.com>
 <20120214205208.GA2656@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20120214205208.GA2656-e0URQFbLeQY2iJbIjFUEsiwD8/FfD2ys@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 2/14/2012 9:52 PM, Grant Likely wrote:
> On Tue, Feb 14, 2012 at 06:56:10PM +0100, Benoit Cousson wrote:
>> Add a function to initialize the OMAP2/3 interrupt controller (INTC)
>> using a device tree node.
>>
>> This version take advantage of the new irq_domain_add_legacy API.
>>
>> Replace some printk() with the proper pr_ macro.
>>
>> Signed-off-by: Benoit Cousson<b-cousson-l0cyMroinI0@public.gmane.org>
>> Cc: Tony Lindgren<tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>> Cc: Rob Herring<rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
>> Cc: Grant Likely<grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
>> ---
>>   .../devicetree/bindings/arm/omap/intc.txt          |   27 +++++++++
>>   arch/arm/mach-omap2/common.h                       |   10 +++
>>   arch/arm/mach-omap2/irq.c                          |   59 ++++++++++++++++---
>>   3 files changed, 86 insertions(+), 10 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/arm/omap/intc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/omap/intc.txt b/Documentation/devicetree/bindings/arm/omap/intc.txt
>> new file mode 100644
>> index 0000000..f2583e6
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/omap/intc.txt
>> @@ -0,0 +1,27 @@
>> +* OMAP Interrupt Controller
>> +
>> +OMAP2/3 are using a TI interrupt controller that can support several
>> +configurable number of interrupts.
>> +
>> +Main node required properties:
>> +
>> +- compatible : should be:
>> +	"ti,omap2-intc"
>> +- interrupt-controller : Identifies the node as an interrupt controller
>> +- #interrupt-cells : Specifies the number of cells needed to encode an
>> +  interrupt source. The type shall be a<u32>  and the value shall be 1.
>> +
>> +  The cell contains the interrupt number in the range [0-128].
>> +- ti,intc-size: Number of interrupts handled by the interrupt controller.
>> +- reg: physical base address and size of the intc registers map.
>> +
>> +Example:
>> +
>> +	intc: interrupt-controller@1 {
>> +		compatible = "ti,omap2-intc";
>> +		interrupt-controller;
>> +		#interrupt-cells =<1>;
>> +		ti,intc-size =<96>;
>> +		reg =<0x48200000 0x1000>;
>> +	};
>> +
>> diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
>> index febffde..a87ce52 100644
>> --- a/arch/arm/mach-omap2/common.h
>> +++ b/arch/arm/mach-omap2/common.h
>> @@ -174,6 +174,16 @@ void omap3_intc_handle_irq(struct pt_regs *regs);
>>   extern void __iomem *omap4_get_l2cache_base(void);
>>   #endif
>>
>> +struct device_node;
>> +#ifdef CONFIG_OF
>> +int __init intc_of_init(struct device_node *node, struct device_node *parent);
>
> This name is pretty generic for a global symbol.  How about omap2_intc_of_init?

That's a good point, I was trying mimic the gic name without thinking in 
my case it is not a generic IP :-(.

I'll rename that omap2_intc_of_init and update the branch for the pull 
request.

> Otherwise this series looks good.
>
> Acked-by: Grant Likely<grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>

> This series need to be committed on top of the irqdomain tree.  I can either
> pick it up myself (with Tony's ack) or I can stabilize the irqdomain/next tree
> so that you can use it as a stable base to commit against (which I should
> probably do anyway since there are others who will depend on it).

This series is the base for all the other OMAP DT series, so I'd rather 
keep it in Tony's tree that contains as well some OMAP fixes not yet in 
mainline.

I guess ideally the irqdomain/next should be stabilized and maybe pulled 
in arm-soc. I'm not sure how Arnd / Olof are handling this kind of 
dependency.

Thanks,
Benoit
