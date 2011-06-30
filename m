From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v2 08/18] GPIO: OMAP: Use wkup regs off/suspend support
 flag
Date: Thu, 30 Jun 2011 19:05:42 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037BC164D8@dbde02.ent.ti.com>
References: <1308111776-29130-1-git-send-email-tarun.kanti@ti.com>
	<1308111776-29130-7-git-send-email-tarun.kanti@ti.com>
 <87boxxpvi2.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41969 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751057Ab1F3Nfw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jun 2011 09:35:52 -0400
In-Reply-To: <87boxxpvi2.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>

Kevin,
[...]
> > -#endif
> > -		default:
> > -			continue;
> > -		}
> > +		if (!bank->suspend_support)
> > +			return 0;
> 
> Rather than check the flag here in every suspend, don't add a suspend
> method in dev_pm_ops for banks that don't have the wkup_* registers.
While trying to implement this comment I am facing issues:

struct device_driver {
...
        const struct dev_pm_ops *pm;

...
};
Since *pm is constant we can not assign pm->suspend/resume dynamically.
Also, I am not sure if it is permissible to have following code in probe:

... omap_gpio_probe(...)
{
...
        if (bank->regs->wkup_status) {
                pdrv->driver.pm->suspend = omap_gpio_suspend;
                pdrv->driver.pm->resume = omap_gpio_resume;
        }
...

[...]
