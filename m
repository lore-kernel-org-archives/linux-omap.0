From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 4/4] dt: i2c-omap: Convert i2c driver to use device tree
Date: Wed, 3 Aug 2011 14:56:53 +0200
Message-ID: <4E394595.7020804@ti.com>
References: <1310592975-25773-1-git-send-email-manjugk@ti.com> <1310592975-25773-5-git-send-email-manjugk@ti.com> <CACxGe6vG9BKUDvthOKFtx3u=Vq0EfBaZakxVqx8AYfRe_ruNdg@mail.gmail.com> <4E319DA7.5050608@ti.com> <CACxGe6speWWuhSL1m3ysc6zrTvxYRyNf8Qj3Rt0jjdUGYi_v8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36301 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755554Ab1HCM5W (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Aug 2011 08:57:22 -0400
In-Reply-To: <CACxGe6speWWuhSL1m3ysc6zrTvxYRyNf8Qj3Rt0jjdUGYi_v8g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 7/28/2011 11:32 PM, Grant Likely wrote:
> On Thu, Jul 28, 2011 at 11:34 AM, Cousson, Benoit<b-cousson@ti.com>  wrote:

[...]

>> Do we have to modify every drivers in order to take advantage of the DT bus?
>> Cannot we init the already existing pdata during device creation and let the
>> driver untouched?
>>
>> I think it is a pity to add all that #ifdefry in the driver to be able to
>> support two kinds of bus.
> 
> It's not supporting 2 different kinds of bus.  There is no such think
> as a dt bus type (anymore. there used to be and of_platform_bus_type,
> but that was a mistake).  DT is only a different configuration
> representation.

That's the point, sorry for my confusing sentence. We are creating almost the exact same platform_device in both cases, but we still have to modify the platform_driver due to a change in the device creation method.

No doubt that DT will clean up the messy devices creation from board file we have today in OMAP.
But, for a smooth migration to DT, I would have defined a legacy mode that will avoid hacking every drivers just because we are using a different "bus enumeration" method.

And then later we will be able to use DT for the configuration if needed.

>> Cannot we have an intermediate phase that will deal only with the device
>> creation with DT?
>>
>> That will allow us to clean the omap_device creation from hwmod we have
>> today spread everywhere in plat-omap and mach-omap2.
> 
> Consider what you're suggesting...  Pretty much every driver that
> needs platform data has as a unique platform_data structure.  That
> means that for every driver there needs to be a separate block of code
> to translate from DT data into struct<driver>_platform_data.  There
> is no way to make that generic.  That translation code needs to live
> somewhere, and something needs to be responsible for executing it when
> relevant devices appear.  It can either be built into the driver, or
> it can be done sometime before the driver is probed.
> 
> Option 1: If it is part of the driver, the sequence looks like this:
> ...early boot:
> 1) allocate and register platform_devices for DT nodes (generic code,
> attach device_node)
> ... boot progresses to initcalls...
> 2) probe platform_driver (DT translation code to obtain
> <device>_platform_data from device_node)
> 
> Option 2: If it is part of platform_device registration, the sequence
> looks something like:
> ...early boot:
> 1) allocate and register platform_devices for DT nodes (call device
> specific translation code for each device to create
> <device>_platform_data)
> ...boot progresses to initcalls
> 2) probe platform_driver (use platform_data, nothing changes here)
> 
> Option 3: decoupled from device registration and the device driver:
> ...early boot:
> 1) allocate and register platform_devices for DT nodes (generic code,
> attach device_node)
> ...boot progresses to initcalls
> 2) hook into device model *before* drivers get probed to call device
> specific translation code.
> 3) probe platform_driver (use platform_data, nothing changes here)
> 
> I understand the desire to not change the drivers, but going with
> either option 2 or 3 causes a giant mess in figuring out how to make
> sure the correct translation code gets called.  Option 2 is a disaster
> because the translation code for any device that may possibly be
> attached to the kernel must be statically linked in.  It cannot be in
> modules because it must be available during early init.  Option 2 is
> similarly a no-go because it requires a new hunk of infrastructure to
> take care of finding and executing translation code before the device
> can get probed by the device driver.

Mmm, cannot we have an option #4?

It seems to me that you already have in place some hooks to provide pdata thanks to OF_DEV_AUXDATA. Adding a callback will potentially allow a custom board code to translate configuration from DT into legacy pdata.


static struct omap_pdata i2c_pdata = {
	.clkrate= 400000,
};

void init_i2c_pdata(...) {
	of_property_read_u32(pdev->dev.of_node, pdata->clkrate);
}

static struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
	OF_DEV_AUXDATA_CB("ti,omap-i2c", XXX, "i2c.1", &i2c_pdata, init_i2c_pdata),
	{}
};

In legacy mode you get the pdata from the static board.
If CONFIG_OF is set you can override the value from the callback.
The driver remains the same.
That being said, does it worth the effort? I'm not sure, but the idea was to allow focusing on the device creation first without hacking every drivers.

Using a regular OF_DEV_AUXDATA with pdata, seems a good tradeoff already.

> Besides, no matter how you look at it, the DT translation code is
> always device-driver-specific.  It isn't something that can be handled
> by generic code for all devices, and the *whole point* of the DT
> transition is to get away from board specific code during early init.

Well, AFAIK, the main motivation, at least for OMAP, was to get rid of static data in the arm directory. Getting rid of board code is, I agree, quite interesting as well.

> Why wouldn't DT translation code live inside the one device driver
> that it supports?

Because, it is still optional and force us to maintain two different methods in the driver code when pdata is needed.
Ideally "of_property_xxx" will be a platform_property_xxx call always available, and DT will be one of the potential source of configuration.
Drivers will then be able to use one and only one standard Linux API, and various implementation will allow the board static stuff for non-DT case or DT blob when available.

That is just my .2 euros.

Regards,
Benoit
