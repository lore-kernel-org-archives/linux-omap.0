From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] input: touchscreen: edt-ft5x06: fix driver autoprobing
Date: Tue, 18 Nov 2014 12:14:21 -0800
Message-ID: <20141118201421.GH3003@dtor-ws>
References: <20141118192112.GM6179@saruman>
 <1416338862-8240-1-git-send-email-balbi@ti.com>
 <20141118195902.GF3003@dtor-ws>
 <20141118200340.GP6179@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:58103 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754223AbaKRUO2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Nov 2014 15:14:28 -0500
Content-Disposition: inline
In-Reply-To: <20141118200340.GP6179@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-input@vger.kernel.org, stable@vger.kernel.org

On Tue, Nov 18, 2014 at 02:03:40PM -0600, Felipe Balbi wrote:
> On Tue, Nov 18, 2014 at 11:59:02AM -0800, Dmitry Torokhov wrote:
> > On Tue, Nov 18, 2014 at 01:27:42PM -0600, Felipe Balbi wrote:
> > > Because with OF we can pass more specific
> > > compatible flags (such as edt-ft5306) instead
> > > of generic edt-ft5x06, when i2c-core's
> > > of_i2c_register_devices() tries to request_module(),
> > > it'll request it with a non-existent specific module
> > > alias.
> > > 
> > > In order to have this driver autoprobing again, we
> > > just need to add missing MODULE_ALIAS() entries to
> > > edt-ft5x06 driver.
> > > 
> > > Thanks to Dmitry for noticing that it actually should
> > > autoprobe even with of_device_id.
> > > 
> > > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > Cc: <linux-input@vger.kernel.org>
> > > Cc: <stable@vger.kernel.org> # v3.15+
> > > Fixes: dac90dc2 (Input: edt-ft5x06 - add DT support)
> > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > ---
> > >  drivers/input/touchscreen/edt-ft5x06.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> > > index ee3434f..bcbf688 100644
> > > --- a/drivers/input/touchscreen/edt-ft5x06.c
> > > +++ b/drivers/input/touchscreen/edt-ft5x06.c
> > > @@ -1147,6 +1147,9 @@ static struct i2c_driver edt_ft5x06_ts_driver = {
> > >  
> > >  module_i2c_driver(edt_ft5x06_ts_driver);
> > >  
> > > +MODULE_ALIAS("i2c:edt-ft5206");
> > > +MODULE_ALIAS("i2c:edt-ft5306");
> > > +MODULE_ALIAS("i2c:edt-ft5406");
> > >  MODULE_AUTHOR("Simon Budig <simon.budig@kernelconcepts.de>");
> > >  MODULE_DESCRIPTION("EDT FT5x06 I2C Touchscreen Driver");
> > >  MODULE_LICENSE("GPL");
> > > -- 
> > > 2.1.0.GIT
> > > 
> > 
> > Here is what I see if I run modinfo on the module:
> > 
> > dtor@dtor-ws:~/kernel/work$ modinfo
> > drivers/input/touchscreen/edt-ft5x06.ko
> > filename:
> > /home/dtor/kernel/work/drivers/input/touchscreen/edt-ft5x06.ko
> > license:        GPL
> > description:    EDT FT5x06 I2C Touchscreen Driver
> > author:         Simon Budig <simon.budig@kernelconcepts.de>
> > alias:          i2c:edt-ft5x06
> > alias:          of:N*T*Cedt,edt-ft5406*
> > alias:          of:N*T*Cedt,edt-ft5306*
> > alias:          of:N*T*Cedt,edt-ft5206*
> > depends:        i2c-core
> > intree:         Y
> > vermagic:       3.17.0+ SMP preempt mod_unload 
> > 
> > As you can see we already have what I consider proper modaliases for the
> > driver. Why don't they work? Is it because modprobe doe snot know how to
> > handle OF-style modaliases or device's uevents are missing OF data in
> > them?
> 
> no, it's because i2c call request_module for i2c:edt-ft5306. i2c core
> never uses any of the of aliases.

1. I think both i2c and spi are cheating in this regard: they should
rely on normal driver request paths through udev.

2. I2C should emit proper modalias for devices coming by the way of
devicetree. It already does special handling for ACPI, it needs to do
the same for OF. I think SPI does the right thing there.

Thanks.

-- 
Dmitry
