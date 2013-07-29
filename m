From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 1/3] Input: omap-keypad: Enable wakeup capability for keypad.
Date: Mon, 29 Jul 2013 13:40:28 -0700
Message-ID: <1861803.h9dhBdaB3X@dtor-d630.eng.vmware.com>
References: <1375116311-13999-1-git-send-email-illia.smyrnov@ti.com> <2416808.ThTjdiEasK@dtor-d630.eng.vmware.com> <20130729203605.GB6547@radagast>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20130729203605.GB6547@radagast>
Sender: linux-input-owner@vger.kernel.org
To: balbi@ti.com
Cc: Illia Smyrnov <illia.smyrnov@ti.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
List-Id: linux-omap@vger.kernel.org

On Monday, July 29, 2013 11:36:05 PM Felipe Balbi wrote:
> Hi,
> 
> On Mon, Jul 29, 2013 at 12:59:23PM -0700, Dmitry Torokhov wrote:
> > > > > > @@ -439,12 +444,50 @@ static const struct of_device_id
> > > > > > omap_keypad_dt_match[] = {>
> > > > > > 
> > > > > >  MODULE_DEVICE_TABLE(of, omap_keypad_dt_match);
> > > > > >  #endif
> > > > > > 
> > > > > > +#ifdef CONFIG_PM_SLEEP
> > > > > > +static int omap4_keypad_suspend(struct device *dev)
> > > > > > +{
> > > > > > +	struct platform_device *pdev = to_platform_device(dev);
> > > > > 
> > > > > you don't need to access the platform_device...
> > > > > 
> > > > > > +	struct omap4_keypad *keypad_data = platform_get_drvdata(pdev);
> > > > > 
> > > > > ... since this can become:
> > > > > 	struct omap4_keypad *keypad_data = dev_get_drvdata(dev);
> > > > 
> > > > No, please use correct accessors for the objects. Platform drivers
> > > > deal
> > > > with platform devices and I prefer using platform_get_drvdata() on
> > > > them.
> > > 
> > > The argument to this function is a struct device, you prefer to do some
> > > pointer math to find the containing pdev, then deref that back to dev,
> > > then to struct device_private and further to driver_data ?
> > > 
> > > Sounds like a waste of time IMHO. You already have the device pointer
> > > anyway, why would you go through the trouble of calculating the
> > > offsets for the containing struct platform_device ?
> > 
> > This assumes knowledge of dev_get_drvdata() implementation and assumption
> > that it will stay the same. Unless I hear from device core guys that
> > <bus>_{get|set}_drvdata() methods are obsolete and will be eventually
> > removed I will require proper accessors being used.
> 
> they're not obsolete and will never be removed. They're nothing but
> helpers though. Instead of calling:
> 
> 	dev_set_drvdata(&pdev->dev);
> 
> you call:
> 
> 	platform_set_drvdata(pdev);
> 
> same is valid for every single bus, but in the end they all just wrap a
> call dev_{set,get}_drvdata() internally. If you already have a struct
> device pointer as argument, why waste cycles doing pointer math just to
> go back to the same struct device pointer on the next call ?

Because I do not want to rely on the fact that what my driver set up
with platform_set_drvdata(pdev, XXX) is the same as what dev_get_drvdata()
will return *in the current implementation*. Software layers and all
that...

-- 
Dmitry
