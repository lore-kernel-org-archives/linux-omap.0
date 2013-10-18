From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 4/5] usb: musb: dsps: add support for suspend and resume
Date: Fri, 18 Oct 2013 12:00:28 +0200
Message-ID: <526106BC.6060508@gmail.com>
References: <1382089175-13487-1-git-send-email-zonque@gmail.com> <1382089175-13487-5-git-send-email-zonque@gmail.com> <52610643.1000607@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52610643.1000607-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, neumann-SRDuVqtxQLSzQB+pC5nmwQ@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 10/18/2013 11:58 AM, Sebastian Andrzej Siewior wrote:
> On 10/18/2013 11:39 AM, Daniel Mack wrote:
> 
>> diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
>> index da21a4e..ce5bbc6 100644
>> --- a/drivers/usb/musb/musb_dsps.c
>> +++ b/drivers/usb/musb/musb_dsps.c
>> @@ -632,11 +648,54 @@ static const struct of_device_id musb_dsps_of_match[] = {
>>  };
>>  MODULE_DEVICE_TABLE(of, musb_dsps_of_match);
>>  
>> +#ifdef CONFIG_PM
>> +static int dsps_suspend(struct device *dev)
>> +{
>> +	struct dsps_glue *glue = dev_get_drvdata(dev);
>> +	const struct dsps_musb_wrapper *wrp = glue->wrp;
>> +	struct musb *musb = platform_get_drvdata(glue->musb);
>> +	void __iomem *mbase = musb->ctrl_base;
>> +
>> +	glue->context.control = dsps_readl(mbase, wrp->control);
>> +	glue->context.epintr = dsps_readl(mbase, wrp->epintr_set);
>> +	glue->context.coreintr = dsps_readl(mbase, wrp->coreintr_set);
>> +	glue->context.phy_utmi = dsps_readl(mbase, wrp->phy_utmi);
>> +	glue->context.mode = dsps_readl(mbase, wrp->mode);
>> +	glue->context.tx_mode = dsps_readl(mbase, wrp->tx_mode);
>> +	glue->context.rx_mode = dsps_readl(mbase, wrp->rx_mode);
> 
> Looking at this made me wonder, what about
> 
>    drivers/usb/phy/phy-am335x-control.c
> 
> Since it seems to work for you, maybe we don't need this after all :P

Yes, I thought that needs fixing as well, but at least on my system, it
doesn't. So I skipped that for now.


Daniel

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
