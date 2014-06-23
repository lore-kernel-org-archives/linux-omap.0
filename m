From: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH V3 03/16] irqchip: crossbar: introduce ti,irqs-skip to
 skip
Date: Mon, 23 Jun 2014 12:50:33 +0530
Message-ID: <53A7D541.6090009@ti.com>
References: <1402917796-31574-1-git-send-email-r.sricharan@ti.com> <1402917796-31574-4-git-send-email-r.sricharan@ti.com> <20140621023302.GE21711@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140621023302.GE21711-u4khhh1J0LxI1Ri9qeTfzeTW4wlIGRCZ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Saturday 21 June 2014 08:03 AM, Jason Cooper wrote:
> Sricharan,
> 
> Your subject line seems truncated:
> 
>   "irqchip: crossbar: introduce ti,irqs-skip to skip"
> 
> maybe "... Introduce DT property to skip hardwired irqs" ?
> 
> Also note that you need to correct the subject line for *every* patch in
> the series wrt capitalization.
> 
> I don't mind correcting it when I apply it, provided that:
> 
ha, i think this got truncated unintentionally. Sorry will fix this.
>  - the patch is otherwise ready
>  - I only have to do it once or twice for the series
>  - I never had a chance to ask since you created a rockstar patch series
>    the first time out of the gate (except for capitalization).
> 
> Once I've looked over the whole series, please resend with the subject
> lines corrected.
> 
Ok. I will look for your comments on the rest of the patches and
resend with capitalization fix said above.

> On Mon, Jun 16, 2014 at 04:53:03PM +0530, Sricharan R wrote:
>> From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
>>
>> When, in the system due to varied reasons, interrupts might be unusable
>> due to hardware behavior, but register maps do exist, then those interrupts
>> should be skipped while mapping irq to crossbars.
>>
>> Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
>> ---
>> [V3] introduced ti,irqs-skip dt property to list the
>>      irqs to be skipped.
>>
>>  .../devicetree/bindings/arm/omap/crossbar.txt      |    4 ++++
>>  drivers/irqchip/irq-crossbar.c                     |   20 ++++++++++++++++++++
>>  2 files changed, 24 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/omap/crossbar.txt b/Documentation/devicetree/bindings/arm/omap/crossbar.txt
>> index fb88585..cfcbd52 100644
>> --- a/Documentation/devicetree/bindings/arm/omap/crossbar.txt
>> +++ b/Documentation/devicetree/bindings/arm/omap/crossbar.txt
>> @@ -17,6 +17,10 @@ Required properties:
>>  		 so crossbar bar driver should not consider them as free
>>  		 lines.
>>  
>> +Optional properties:
>> +- ti,irqs-skip: This is similar to "ti,irqs-reserved", but are irq mappings
>> +  which are not supposed to be used for errata or other reasons(virtualization).
> 
> I would specifically mention SoC-specific hard-wiring of irqs here.
> Also the fact that the hardwiring unexpectedly bypasses the crossbar.
ok, that will be more easily understandable and will add that.
> 
>> +
>>  Examples:
>>  		crossbar_mpu: @4a020000 {
>>  			compatible = "ti,irq-crossbar";
> 
> Please include a ti,irqs-skip example here.
> 
ok.
>> diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
>> index 51d4b87..27049de 100644
>> --- a/drivers/irqchip/irq-crossbar.c
>> +++ b/drivers/irqchip/irq-crossbar.c
>> @@ -18,6 +18,7 @@
>>  
>>  #define IRQ_FREE	-1
>>  #define IRQ_RESERVED	-2
>> +#define IRQ_SKIP	-3
>>  #define GIC_IRQ_START	32
>>  
>>  /*
>> @@ -160,6 +161,25 @@ static int __init crossbar_of_init(struct device_node *node)
>>  		}
>>  	}
>>  
>> +	/* Skip the ones marked as skip */
> 
> This comment is redundant, perhaps "Skip irqs hardwired to bypass the
> crossbar."?
ok, will change this.

Regards,
 Sricharan
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
