From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3] ARM: OMAP: i2c: fix interrupt flood during resume
Date: Fri, 12 Oct 2012 09:43:27 -0700
Message-ID: <87r4p363ps.fsf@deeprootsystems.com>
References: <1349871480-25182-1-git-send-email-kalle.jokiniemi@jollamobile.com>
	<87ipag90om.fsf@deeprootsystems.com>
	<902E09E6452B0E43903E4F2D568737AB2C87B0@DNCE04.ent.ti.com>
	<87d30n7o9q.fsf@deeprootsystems.com>
	<902E09E6452B0E43903E4F2D568737AB2C8C9F@DNCE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63095 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759818Ab2JLQnX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Oct 2012 12:43:23 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so3088678pbb.19
        for <linux-omap@vger.kernel.org>; Fri, 12 Oct 2012 09:43:22 -0700 (PDT)
In-Reply-To: <902E09E6452B0E43903E4F2D568737AB2C8C9F@DNCE04.ent.ti.com>
	(Grygorii Strashko's message of "Fri, 12 Oct 2012 14:46:12 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Strashko, Grygorii" <grygorii.strashko@ti.com>
Cc: Kalle Jokiniemi <kalle.jokiniemi@jollamobile.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "Kankroliwala, Huzefa" <huzefank@ti.com>

"Strashko, Grygorii" <grygorii.strashko@ti.com> writes:

> Hi Kevin,
>
> yep, [1] is the same fix - thanks. 

> Hi Kalle,
>
> i've applied these changes and PM runtime fix on top of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git (omap2plus_defconfig)
> Could you check it with your use case, pls? (just to be sure that idea is right)

I think the ideas is right, but [1] introduces more potential problems
since it disables the IRQ at the INTC well before being disabled at the
device.  With runtime PM autosuspend timeouts, that means any IRQs
firing during the autosuspend delay will be lost, which basically
nullifies the use of autosuspend.

Since Shubhrajyoti didn't respond to my runtime PM comments on the
original patch, I'll respin this patch by moving the INTC disable/enable
into the runtime PM callbacks and make the changelog a bit more clear.

Grygorii, that pm_runtime_resume() change is needed to.  Can you spin a
patch with just that change with a nice descriptive changelog about why
it is needed?  Thanks.

Kevin


>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index a0e49f6..cb09e20 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -586,6 +586,9 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>         if (IS_ERR_VALUE(r))
>                 goto out;
>  
> +       /* We have the bus, enable IRQ */
> +       enable_irq(dev->irq);
> +
>         r = omap_i2c_wait_for_bb(dev);
>         if (r < 0)
>                 goto out;
> @@ -606,6 +609,7 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>                 r = num;
>  
>         omap_i2c_wait_for_bb(dev);
> +       disable_irq(dev->irq);
>  out:
>         pm_runtime_put(dev->dev);
>         return r;
> @@ -1060,6 +1064,9 @@ omap_i2c_probe(struct platform_device *pdev)
>                                                                    omap_i2c_isr;
>         r = request_irq(dev->irq, isr, IRQF_NO_SUSPEND, pdev->name, dev);
>  
> +       /* We enable IRQ only when request for I2C from master */
> +        disable_irq(dev->irq);
> +
>         if (r) {
>                 dev_err(dev->dev, "failure requesting irq %i\n", dev->irq);
>                 goto err_unuse_clocks;
> @@ -1182,7 +1189,23 @@ static int omap_i2c_runtime_resume(struct device *dev)
>  }
>  #endif /* CONFIG_PM_RUNTIME */
>  
> +static int omap_i2c_suspend(struct device *dev)
> +{
> +       int ret;
> +
> +       /*
> +        *  Enable I2C device, so it will be accessible during
> +        * later stages of suspending when device Runtime PM is disabled.
> +        * I2C device will be turned off at "noirq" suspend stage.
> +        */
> +       ret = pm_runtime_resume(dev);
> +       if (ret < 0)
> +               return ret;
> +       return 0;
> +}
> +
>  static struct dev_pm_ops omap_i2c_pm_ops = {
> +       SET_SYSTEM_SLEEP_PM_OPS(omap_i2c_suspend, NULL)
>         SET_RUNTIME_PM_OPS(omap_i2c_runtime_suspend,
>                            omap_i2c_runtime_resume, NULL)
>  };
>
> - Grygorii
> ________________________________________
> From: Kevin Hilman [khilman@deeprootsystems.com]
> Sent: Friday, October 12, 2012 5:34 PM
> To: Strashko, Grygorii
> Cc: Kalle Jokiniemi; linux-i2c@vger.kernel.org; w.sang@pengutronix.de; ben-linux@fluff.org; tony@atomide.com; linux-omap@vger.kernel.org; Datta, Shubhrajyoti; Kankroliwala, Huzefa
> Subject: Re: [PATCH v3] ARM: OMAP: i2c: fix interrupt flood during resume
>
> "Strashko, Grygorii" <grygorii.strashko@ti.com> writes:
>
>> Hi All,
>>
>> Sorry, for the late reply.
>> + CC Huzefa Kankroliwala - who is I2C driver owner on Android Kernel 3.4.
>
> Hi Grygorii, thanks for reviewing.  I was hoping you would have some
> ideas here as this was sounding familiar to something you had
> mentioned elsewhere.
>
>> Regarding this patch -  from my point of view, it fixes corner case and not an issue in general.
>> Let take a look on resume sequence:
>>    - platform resume
>>    - syscore resume
>>    - resume_noirq
>>    - enable IRQs - resume_device_irqs()
>>      |- at this point IRQ handler will be invoked if IRQ state is IRQS_PENDING.
>>      |- so, the I2C device IRQ handler may be called at time when I2C adapter IRQ is still disabled and, as result, the I2C device IRQ-handler may fail. (I2C device and I2C adapter may use different physical IRQ lines)
>>    - resume_late
>>      |- enable I2C bus IRQ
>>
>> Possibly, the better way is to enable/disable I2C bus IRQ when needed - in our case in omap_i2c_xfer().
>> We use such approach in Android kernel 3.4
>> (http://git.omapzoom.org/?p=kernel/omap.git;a=commitdiff;h=1445a4d3b587c164bd30d108b61760aaaa07365e)
>
> I agree, that should work and cover the cases where I2C is used by other
> processors also.  Shubhrajyoti already posted something similar[1] but
> it needed some rework (comments from Russell and myself.)
>
> Huzefa, Shubhrajyoti, who can rework this idea for the upstream and/or
> follow up with the earlier patch[1]?
>
> Wolfram, I guess for now lets hold off on $SUBJECT patch.  Seems we can
> come up with a broader solution.  Thanks.
>
> Kevin
>
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-October/124427.html
