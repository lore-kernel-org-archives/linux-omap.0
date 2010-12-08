From: "Basak, Partha" <p-basak2@ti.com>
Subject: RE: [PATCH v6 8/8] Input: omap4 - pm runtime
Date: Wed, 8 Dec 2010 12:15:56 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930247C471A5@dbde02.ent.ti.com>
References: <1285825000-25622-1-git-send-email-x0066660@ti.com>
 <87aamzl4pu.fsf@deeprootsystems.com>
 <0680EC522D0CC943BC586913CF3768C0041390E45B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37711 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753190Ab0LHGqD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Dec 2010 01:46:03 -0500
In-Reply-To: <0680EC522D0CC943BC586913CF3768C0041390E45B@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Arce, Abraham" <x0066660@ti.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Datta, Shubhrajyoti
> Sent: Monday, December 06, 2010 6:30 PM
> To: Kevin Hilman; Arce, Abraham
> Cc: linux-input@vger.kernel.org; linux-omap@vger.kernel.org
> Subject: RE: [PATCH v6 8/8] Input: omap4 - pm runtime
> 
> 
> Kevin,
> > -----Original Message-----
> > From: linux-input-owner@vger.kernel.org [mailto:linux-input-
> > owner@vger.kernel.org] On Behalf Of Kevin Hilman
> > Sent: Thursday, September 30, 2010 7:21 PM
> > To: Arce, Abraham
> > Cc: linux-input@vger.kernel.org; linux-omap@vger.kernel.org
> > Subject: Re: [PATCH v6 8/8] Input: omap4 - pm runtime
> >
> > Abraham Arce <x0066660@ti.com> writes:
> >
> > > Enable pm runtime in driver
> >
> > So power is enabled on probe and cut on _remove().  Did you consider
> > doing any more fine grained PM for this device?  For example, cutting
> > power after some inactivity timer and re-enabling on a
> > keypress/interrupt?
> My idea is that the clock needs to be on to get interrupts (OMAP4 the
> control is at module level and  ick/fclk level control is difficult).
> So disabling will prevent interrupts.
> The keypad is in wakeup domain which is always on. So the power impact
> may be minimal.
> 
> What do you think.

Kevin, I hope you are OK with this. 

> >
> > Kevin
> >
> >
> >
> > > Reviewed-by: Basak, Partha <p-basak2@ti.com>
> > > Signed-off-by: Abraham Arce <x0066660@ti.com>
> > > ---
> > >  drivers/input/keyboard/omap4-keypad.c |    7 +++++++
> > >  1 files changed, 7 insertions(+), 0 deletions(-)
> > >
> > > diff --git a/drivers/input/keyboard/omap4-keypad.c
> > b/drivers/input/keyboard/omap4-keypad.c
> > > index 45bd097..ed47e9a 100644
> > > --- a/drivers/input/keyboard/omap4-keypad.c
> > > +++ b/drivers/input/keyboard/omap4-keypad.c
> > > @@ -29,6 +29,7 @@
> > >  #include <linux/io.h>
> > >  #include <linux/input.h>
> > >  #include <linux/slab.h>
> > > +#include <linux/pm_runtime.h>
> > >
> > >  #include <plat/omap4-keypad.h>
> > >
> > > @@ -239,6 +240,9 @@ static int __devinit omap4_keypad_probe(struct
> > platform_device *pdev)
> > >  	matrix_keypad_build_keymap(pdata->keymap_data, row_shift,
> > >  			input_dev->keycode, input_dev->keybit);
> > >
> > > +	pm_runtime_enable(&pdev->dev);
> > > +	pm_runtime_get_sync(&pdev->dev);
> > > +
> > >  	omap4_keypad_config(keypad_data);
> > >
> > >  	error = request_irq(keypad_data->irq, omap4_keypad_interrupt,
> > > @@ -277,6 +281,9 @@ static int __devexit omap4_keypad_remove(struct
> > platform_device *pdev)
> > >  	struct omap4_keypad *keypad_data = platform_get_drvdata(pdev);
> > >  	struct resource *res;
> > >
> > > +	pm_runtime_put_sync(&pdev->dev);
> > > +	pm_runtime_disable(&pdev->dev);
> > > +
> > >  	free_irq(keypad_data->irq, keypad_data);
> > >  	input_unregister_device(keypad_data->input);
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-
> input" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
