From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH v6 8/8] Input: omap4 - pm runtime
Date: Fri, 1 Oct 2010 11:01:25 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030CD032F1@dbde02.ent.ti.com>
References: <1285825000-25622-1-git-send-email-x0066660@ti.com>
 <87aamzl4pu.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <87aamzl4pu.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
To: "Arce, Abraham" <x0066660@ti.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>
List-Id: linux-omap@vger.kernel.org

Abraham,

> -----Original Message-----
> To: Arce, Abraham
> Cc: linux-input@vger.kernel.org; linux-omap@vger.kernel.org
> Subject: Re: [PATCH v6 8/8] Input: omap4 - pm runtime
> 
> Abraham Arce <x0066660@ti.com> writes:
> 
> > Enable pm runtime in driver
> 
> So power is enabled on probe and cut on _remove().  Did you consider
> doing any more fine grained PM for this device?  For example, cutting
> power after some inactivity timer and re-enabling on a
> keypress/interrupt?
> 
> Kevin
> 
> 
> 
> > Reviewed-by: Basak, Partha <p-basak2@ti.com>
> > Signed-off-by: Abraham Arce <x0066660@ti.com>
> > ---
> >  drivers/input/keyboard/omap4-keypad.c |    7 +++++++
> >  1 files changed, 7 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/input/keyboard/omap4-keypad.c 
> b/drivers/input/keyboard/omap4-keypad.c
> > index 45bd097..ed47e9a 100644
> > --- a/drivers/input/keyboard/omap4-keypad.c
> > +++ b/drivers/input/keyboard/omap4-keypad.c
> > @@ -29,6 +29,7 @@
> >  #include <linux/io.h>
> >  #include <linux/input.h>
> >  #include <linux/slab.h>
> > +#include <linux/pm_runtime.h>
> >  
> >  #include <plat/omap4-keypad.h>
> >  
> > @@ -239,6 +240,9 @@ static int __devinit 
> omap4_keypad_probe(struct platform_device *pdev)
> >  	matrix_keypad_build_keymap(pdata->keymap_data, row_shift,
> >  			input_dev->keycode, input_dev->keybit);
> >  
> > +	pm_runtime_enable(&pdev->dev);
> > +	pm_runtime_get_sync(&pdev->dev);

In patch 1, kbd is included in the hwmods list. Hence kbd would be reset
during init and clocks would be disabled. Probe is not doing any clock
enable before accessing the kbd registers. Later, only in this patch,
pm_runtime_get_sync() is being done.

Ideally, once the kbd is included in the hwmod list, clock_enable()
shall be used before accessing kbd registers and later in this patch
pm_runtime_get_sync() shall be used while removing usage of clk_enable().

-V Charulatha

> > +
> >  	omap4_keypad_config(keypad_data);
> >  
> >  	error = request_irq(keypad_data->irq, omap4_keypad_interrupt,
> > @@ -277,6 +281,9 @@ static int __devexit 
> omap4_keypad_remove(struct platform_device *pdev)
> >  	struct omap4_keypad *keypad_data = platform_get_drvdata(pdev);
> >  	struct resource *res;
> >  
> > +	pm_runtime_put_sync(&pdev->dev);
> > +	pm_runtime_disable(&pdev->dev);
> > +
> >  	free_irq(keypad_data->irq, keypad_data);
> >  	input_unregister_device(keypad_data->input);
