From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 05/36] mtd: nand: omap: Move IRQ handling from GPMC to
 NAND driver
Date: Fri, 13 Jun 2014 14:42:08 +0300
Message-ID: <539AE390.4080504@ti.com>
References: <1402477001-31132-1-git-send-email-rogerq@ti.com> <1402477001-31132-6-git-send-email-rogerq@ti.com> <20140613071820.GI17845@atomide.com> <539AAA8C.2070709@ti.com> <20140613075856.GQ17845@atomide.com> <20980858CB6D3A4BAE95CA194937D5E73EAF51DB@DBDE04.ent.ti.com> <539AB4E4.6050408@ti.com> <20140613104610.GS17845@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140613104610.GS17845-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: "Gupta, Pekon" <pekon-l0cyMroinI0@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org" <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org" <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 06/13/2014 01:46 PM, Tony Lindgren wrote:
> * Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [140613 01:24]:
>> On 06/13/2014 11:13 AM, Gupta, Pekon wrote:
>>>> From: Tony Lindgren [mailto:tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org]
>>>>> * Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [140613 00:40]:
>>>>>> On 06/13/2014 10:18 AM, Tony Lindgren wrote:
>>>>>>> * Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [140611 01:58]:
>>>>>
>>>>> OK. But wait pin edge detection was not yet being used and I couldn't
>>>>> think of how it would ever be used. Any ideas?
>>>>
>>>> Maybe to wake-up the system on bus activity or something?
>>>>
>>> Sorry, I wasn't able to review this series.
>>> But just as pointer, GPMC driver was used for interfacing many
>>> non-memory devices like Ethernet (smc91x) and in past GPMC has been
>>> proved to work with camera devices too, but that's wasn't mainlined.
>>> So keeping IRQ and few other things in GPMC driver is helpful.
>>>
>>
>> On further study it seems that the wait pin edge detection is only used in the NAND controller use case.
>> see section 10.1.5.14.2.2 Ready Pin Monitored by Hardware Interrupt
> 
> It seems they can be used for anything slow like NOR and NAND.

But NOR driver never requests for any IRQ.

We should not confuse this wait pin edge interrupt with NOR bus cycle WAIT pin mechanism.
That is configured using GPMC_CONFIG1 register via WAITPINSELECT and WAITREAD/WRITEMONITORING bits.
That wait pin handling is done completely in hardware and doesn't need any software intervention.
Imagine using it for interrupt for every bus cycle wait. It will be dead slow and unusable.

The WAIT edge interrupt mechanism is exclusively for NAND use case to notify the status of READY pin after a block/page operation.

>  
>> For memory devices, no software wait pin intervention is necessary and doesn't even make sense.
> 
> Still seems that it's use can be generic though, not limited
> to NAND.
>  
>> So I don't agree on managing the IRQSTATUS and IRQENABLE register in the GPMC driver. It is adding unnecessary complexity. I don't mind having a wrapper around it though like the other nand registers.
> 
> But all the consumer driver should need to do is request_irq()
> on it? That's pretty much the most common interface we have
> for drivers :)

the client driver side is easy, but it adds unnecessary complication to model it as IRQ chip and assign a line for each event. Since it is going to be used exclusively by NAND we should avoid IRQ chip modeling.

>  
>> To be frank, I think it is cleaner if the NAND driver directly accesses the NAND registers.
>> I don't see why we should make things complicated just because the hardware designers didn't create a clear register split between GPMC and NAND.
> 
> Because they are in separate hardware modules :)
> 
> Who knows why it was set up this way. Maybe the plan was to have
> the common features in GPMC that then can be used by various MTD
> devices.
>  
>> Only the GPMC_CONFIG register needs to remain with the GPMC driver.
> 
> And managing clocks and runtime PM in general. In any case, let's
> not let drivers tinker with the GPMC registers directly though.
> Some kind of abstraction via existing frameworks or with regmap
> is needed.

OK. I agree about using some kind of abstraction instead of direct access.

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
