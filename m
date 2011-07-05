From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv5 01/11] OMAP: prcm: switch to a chained IRQ handler mechanism
Date: Tue, 5 Jul 2011 14:32:18 +0300
Message-ID: <1309865538.17918.9.camel@sokoban>
References: <1309861677-2769-1-git-send-email-t-kristo@ti.com> <1309861677-2769-2-git-send-email-t-kristo@ti.com> <20110705111842.GZ2820@legolas.emea.dhcp.ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:32957 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932176Ab1GELcZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jul 2011 07:32:25 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <20110705111842.GZ2820@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: linux-omap@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "Mahadeva, Avinash" <avinashhm@ti.com>, "Hilman, Kevin" <khilman@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, "R, Govindraj" <govindraj.raja@ti.com>

On Tue, 2011-07-05 at 13:18 +0200, Balbi, Felipe wrote:
> Hi,
> 
> On Tue, Jul 05, 2011 at 01:27:47PM +0300, Tero Kristo wrote:
> > @@ -854,20 +802,35 @@ static int __init omap3_pm_init(void)
> >  	/* XXX prcm_setup_regs needs to be before enabling hw
> >  	 * supervised mode for powerdomains */
> >  	prcm_setup_regs();
> > +	ret = omap_prcm_irq_init();
> > +	if (ret) {
> > +		pr_err("omap_prcm_irq_init() failed with %d\n", ret);
> > +		goto err_prcm_irq_init;
> > +	}
> > +
> > +	prcm_wkup_irq = omap_prcm_event_to_irq("wkup");
> > +	prcm_io_irq = omap_prcm_event_to_irq("io");
> > +
> > +	ret = request_irq(prcm_wkup_irq, _prcm_int_handle_wakeup,
> > +			IRQF_NO_SUSPEND | IRQF_DISABLED, "prcm_wkup", NULL);
> 
> IRQF_DISABLED shouldn't be used anymore ;-)

Oh man, well that is easy to remove as it doesn't do anything. Should I
send a new version of the set for this? :P Kevin's call I guess.

I just tried the set without this flag and yes it still works. :)

> 
> <linux/interrupt.h>:
> 
>  45  * IRQF_DISABLED - keep irqs disabled when calling the action handler.
>  46  *                 DEPRECATED. This flag is a NOOP and scheduled to be removed
> 
> 



Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

