From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 08/18] GPIO: OMAP: Use wkup regs off/suspend support flag
Date: Thu, 30 Jun 2011 15:57:21 -0700
Message-ID: <87y60jc4ha.fsf@ti.com>
References: <1308111776-29130-1-git-send-email-tarun.kanti@ti.com>
	<1308111776-29130-7-git-send-email-tarun.kanti@ti.com>
	<87boxxpvi2.fsf@ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB037BC164D8@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:33808 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751514Ab1F3W5Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Jun 2011 18:57:25 -0400
Received: by mail-iy0-f179.google.com with SMTP id 35so3111127iyn.24
        for <linux-omap@vger.kernel.org>; Thu, 30 Jun 2011 15:57:24 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB037BC164D8@dbde02.ent.ti.com>
	(Tarun Kanti DebBarma's message of "Thu, 30 Jun 2011 19:05:42 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>

"DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:

> Kevin,
> [...]
>> > -#endif
>> > -		default:
>> > -			continue;
>> > -		}
>> > +		if (!bank->suspend_support)
>> > +			return 0;
>> 
>> Rather than check the flag here in every suspend, don't add a suspend
>> method in dev_pm_ops for banks that don't have the wkup_* registers.
> While trying to implement this comment I am facing issues:
>
> struct device_driver {
> ...
>         const struct dev_pm_ops *pm;
>
> ...
> };
>
> Since *pm is constant we can not assign pm->suspend/resume dynamically.

Oh, right.

> Also, I am not sure if it is permissible to have following code in probe:
>
> ... omap_gpio_probe(...)
> {
> ...
>         if (bank->regs->wkup_status) {
>                 pdrv->driver.pm->suspend = omap_gpio_suspend;
>                 pdrv->driver.pm->resume = omap_gpio_resume;
>         }
> ...
>

OK, then I guess having a check for regs->wkup_status in the beginning
of the suspend/resume functions will be fine.

Thanks,

Kevin

