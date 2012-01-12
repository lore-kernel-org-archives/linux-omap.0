From: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv8 4/5] OMAP: I2C: Remove the reset in the init path
Date: Thu, 12 Jan 2012 15:13:47 +0100
Message-ID: <4F0EEA9B.3030104@ti.com>
References: <1323773758-6375-1-git-send-email-shubhrajyoti@ti.com> <1323773758-6375-5-git-send-email-shubhrajyoti@ti.com> <alpine.DEB.2.00.1112160139010.12660@utopia.booyaka.com> <4EEB086A.2050607@ti.com> <CANQgH-Ze1S6sy1uhzy_b8GWOCjF4+-9DOCcUn9mq1kAaT+Y7FA@mail.gmail.com> <CANQgH-YLez8B-t8nf9_M8samn9YWUa7LcOFx6uPFrJE9tnXB1Q@mail.gmail.com> <87hb03tw8h.fsf@ti.com> <4F0D26DF.1020108@ti.com> <alpine.DEB.2.00.1201110619090.31702@utopia.booyaka.com> <4F0D9B70.3000309@ti.com> <alpine.DEB.2.00.1201110809530.31702@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1201110809530.31702-rwI8Ez+7Ko+d5PgPZx9QOdBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 1/11/2012 4:22 PM, Paul Walmsley wrote:
> On Wed, 11 Jan 2012, Cousson, Benoit wrote:
>
>> Something that puzzle me on that point is most architecture does not use
>> plateform_device and thus does not have any pdata to hack some custom function
>> pointers here an there.
>> It means that there is probably some better solution to handle that.
>
> PCI and USB have their own bus-level device reset functions that are
> exported from bus code that lives under drivers/.  In a similar fashion,
> we could export omap_device_reset() from our arch/arm/plat-omap code.
> But that would require that arch/arm/plat-omap and arch/arm/mach-omap2
> code to be compiled for any ARM build that includes i2c-omap.c.  This
> would be good to avoid, under the principle that drivers should be
> buildable for any architecture.  (This is also why we wish to remove
> omap_{read,write}*() and cpu_is_omap() from any drivers which contain
> those.)
>
> The intention a few years ago was to eventually create a a real omap_bus
> and omap_device, with the bus/device integration code living under
> drivers.  In such a situation, we'd be able to use something like the
> PCI/USB approach cleanly, since there wouldn't be dependencies to arch/
> code.

For reset, maybe the custom bus is a better approach, since it is 
something that is handled by the OMAP core infrastructure.
I was referring more to all the other function pointer we have today in 
driver like MMC, DSS that does not necessarily belong to a OMAP core stuff.

>> AFAIU, the way PPC is handling that is by splitting the driver in a generic
>> part and in a platform specific part.
>>
>> You can then add any OMAP specific hacks in the OMAP specific part while
>> keeping most of generic code in a generic driver.
>>
>> In this case, we just have to implement a small shim that will handle the OMAP
>> specific code for the reset. The generic driver will handle the rest.
>>
>> Maybe I'm missing some important details, but that does seems easily doable
>> for the i2c case.
>
> Hmm.  How do those drivers call the platform-specific code in a way that
> allows those drivers to be built for non-PPC platforms?

Well, the point is that a lot of that code should not be in the omap 
arch directory at the first place.
For example, the MMC is using extensively function pointers because of 
the control module dependency.
Having a control module driver will allow stacking the drivers without 
having to get any code in mach-omap directory.

Otherwise, there is as well a dedicated drivers/platform directory that 
can store some platform specific drivers. So far it looks like it is 
used for x86 board kind of drivers only.

Regards,
Benoit
