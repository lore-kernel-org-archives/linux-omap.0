From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/4] mfd: ti_am335x_tscadc: store physical address
Date: Mon, 31 Oct 2016 08:16:43 +0000
Message-ID: <20161031081643.GN13127@dell>
References: <20160921161134.6951-1-mugunthanvnm@ti.com>
 <20160921161134.6951-2-mugunthanvnm@ti.com>
 <20160927194045.GK21388@dell>
 <f271b805-82c2-a45e-0de9-39edafd34d2e@ti.com>
 <20161026121730.GS8574@dell>
 <954adfa7-94d9-f785-aeab-6f20c8f4c3b9@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <954adfa7-94d9-f785-aeab-6f20c8f4c3b9-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, "Andrew F . Davis" <afd-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Sun, 30 Oct 2016, Jonathan Cameron wrote:

> On 26/10/16 13:17, Lee Jones wrote:
> > On Fri, 30 Sep 2016, Mugunthan V N wrote:
> > 
> >> On Wednesday 28 September 2016 01:10 AM, Lee Jones wrote:
> >>> On Wed, 21 Sep 2016, Mugunthan V N wrote:
> >>>
> >>>> store the physical address of the device in its priv to use it
> >>>> for DMA addressing in the client drivers.
> >>>>
> >>>> Signed-off-by: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
> >>>> ---
> >>>>  drivers/mfd/ti_am335x_tscadc.c       | 1 +
> >>>>  include/linux/mfd/ti_am335x_tscadc.h | 1 +
> >>>>  2 files changed, 2 insertions(+)
> >>>>
> >>>> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> >>>> index c8f027b..0f3fab4 100644
> >>>> --- a/drivers/mfd/ti_am335x_tscadc.c
> >>>> +++ b/drivers/mfd/ti_am335x_tscadc.c
> >>>> @@ -183,6 +183,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
> >>>>  		tscadc->irq = err;
> >>>>  
> >>>>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >>>> +	tscadc->tscadc_phys_base = res->start;
> >>>
> >>> This is unusual.  Can't you use a virt_to_phys() variant instead?
> >>>
> >>
> >> I tried using virt_to_phys(), but its not working for me.
> >> Also saw many drivers uses like this to get physical address
> >> ("git grep -n " res->start;" drivers/*").
> > 
> > Very well:
> > 
> > For my own reference:
> >   Acked-for-MFD-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > 
> > Let me know how you wish this set to be handled.
> I'm happy to pick up the whole series.  There are some more mfd
> header changes in patch 2 but as they only add defines, I
> don't mind that much if I don't an Ack from you on those
> (btw this got to V3 but as patch 1 didn't change I'll carry
> your ack forwards).
> 
> Do you want an immutable branch?  Seems unlikely to cause
> much trouble even if there is a merge issue on all 10ish
> lines of mfd code in the next merge window.

Not at the moment, but if you could set things up so it's possible to
create one at a later date if things go Pete Tong, that would be
great.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
