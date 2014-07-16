From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/5] [RFC-HACK] pinctrl-single: init by
 postcore_initcall()
Date: Wed, 16 Jul 2014 05:36:42 -0700
Message-ID: <20140716123641.GB18374@atomide.com>
References: <1400799986-20043-1-git-send-email-chf.fritz@googlemail.com>
 <1400799986-20043-2-git-send-email-chf.fritz@googlemail.com>
 <20140522233154.GE29577@atomide.com>
 <20140716114558.GA1842@arch.cereza>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:27670 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932902AbaGPMiI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jul 2014 08:38:08 -0400
Content-Disposition: inline
In-Reply-To: <20140716114558.GA1842@arch.cereza>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Christoph Fritz <chf.fritz@googlemail.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Pekon Gupta <pekon@ti.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Daniel Mack <zonque@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Ezequiel Garcia <ezequiel@vanguardiasur.com.ar> [140716 04:48]:
> On 22 May 04:31 PM, Tony Lindgren wrote:
> > * Christoph Fritz <chf.fritz@googlemail.com> [140522 16:07]:
> > > --- a/drivers/pinctrl/pinctrl-single.c
> > > +++ b/drivers/pinctrl/pinctrl-single.c
> > > @@ -2069,7 +2069,22 @@ static struct platform_driver pcs_driver = {
> > >  #endif
> > >  };
> > >  
> > > +#ifdef CONFIG_USE_OF
> > > +static int __init pcs_driver_drv_init(void)
> > > +{
> > > +       return platform_driver_register(&pcs_driver);
> > > +}
> > > +postcore_initcall(pcs_driver_drv_init);
> > > +
> > > +static void __exit pcs_driver_drv_exit(void)
> > > +{
> > > +       platform_driver_unregister(&pcs_driver);
> > > +}
> > > +module_exit(pcs_driver_drv_exit);
> > > +#else
> > >  module_platform_driver(pcs_driver);
> > > +#endif
> > > +
> > 
> > I would prefer to initialize all the drivers with module_init
> > and and if necessary, selected frameworks with subsys_initcall. 
> > 
> > In drivers/Makefile we do have painctrl before gpio, so this
> > too could be just module_init once the other drivers are fixed.
> > 
> 
> I've been using patches that change gpio and i2c initialization to module_init
> for some time now. However, I still see some non-DT boards using the GPIO API
> in early functions such as .init_machine.
> 
> Only when these boards get converted and the legacy support is dropped, we'll
> be able to move all the drivers to module_init.

Hmm yeah tons of dependencies to dropping the legacy booting.. But to not
have that dependency maybe we can convert those .init_machine functions
easily to late_initcall.

Regards,

Tony
