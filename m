From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH 1/5] drivers : introduce device_path api
Date: Wed, 28 Nov 2012 13:13:31 +0200
Message-ID: <50B5F1DB.8090502@ti.com>
References: <Pine.LNX.4.44L0.1211271253230.1489-100000@iolanthe.rowland.org> <50B51313.2060003@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50B51313.2060003-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 11/27/2012 09:22 PM, Andy Green wrote:
> On 11/28/2012 02:09 AM, the mail apparently from Alan Stern included:
>> On Wed, 28 Nov 2012, Andy Green wrote:
>>
>>>> Greg's advice was simply not to rely on pathnames in sysfs because they
>>>> aren't fixed in stone.  That leaves plenty of other ways to approach
>>>> this problem.
>>>
>>> It's sage advice, but there is zero code provided in my patches that
>>> "relies on pathnames in sysfs".
>>
>> In your 1/5 patch, _device_path_generate() concatenates device name
>> strings, starting from a device root and separating elements with '/'
>> characters.  Isn't that the same as a sysfs pathname?
> 
> It's nothing to do with sysfs... yes some unrelated bits of sysfs also
> walk the device path.  If we want to talk about how fragile the device
> path is as an id scheme over time we need to talk about likelihood of
> individual device names changing, not "sysfs".  Anyway -->
> 
>>>> Basically, what you want is for something related to device A (the
>>>> regulator or the GPIO) to happen whenever device B (the ehci-omap.0
>>>> platform device) is bound to a driver.  The most straightforward way to
>>>> arrange this is for A's driver to have a callback that is invoked
>>>> whenever B is bound or unbound.  The most straightforward way to
>>>> arrange _that_ is to allow each platform_device to have a list of
>>>> callbacks.
>>>
>>> Sorry I didn't really understand this proposal yet.  You want "A", the
>>> regulator, driver to grow a callback function that gets called when the
>>> targeted platform_device ("B", ehci-omap.0) probe happens.  Could you
>>> expand what the callback prototype or new members in the struct might
>>> look like?  It's your tuple thing or we pass it an opaque pointer that
>>> is the struct regulator * or suchlike?
>>
>> Well, it won't be exactly the same as the tuple thing because no
>> strings will be involved, but it would be similar.  The callback would
>> receive an opaque pointer (presumably to the regulator) and a device
>> pointer (the B device).
> 
> OK.  So I try to sketch it out iteractively to try to get in sync:
> 
> device.h:
> 
>     enum asset_event {
>         AE_PROBED,
>         AE_REMOVED
>     };
> 
>     struct device_asset {
>         char *name; /* name of regulator, clock, etc */
>         void *asset; /* regulator, clock, etc */
>         int (*handler)(struct device *dev_owner, enum asset_event
> asset_event, struct device_asset *asset);
>     };
> 
>     struct device {
>     ...
>         struct device_asset *assets;
>     ...
>     };
> 
> 
> drivers/base/dd.c | really_probe():
> 
> ...
>     struct device_asset *asset;
> ...
>     asset = dev->assets;
>     while (asset && asset->name) {
>         if (asset->handler(dev, AE_PROBED, asset)) {
>             /* clean up and bail */
>         }
>         asset++;
>     }
> 
>     /* do probe */
> ...
> 
> 
> drivers/base/dd.c | __device_release_driver:  (is this really the best
> place to oppose probe()?)
> 
> ...
>     struct device_asset *asset;
> ...
> 
>     /* call device ->remove() */
> ...
>     asset = dev->assets;
>     while (asset && asset->name) {
>         asset->handler(dev, AE_REMOVED, asset);
>         asset++;
>     }
> ...
> 
> 
> board file:
> 
>     static struct regulator myreg = {
>         .name = "mydevice-regulator",
>     };
> 
>     static struct device_asset mydevice_assets[] = {
>         {
>             .name = "mydevice-regulator",
>             .handler = regulator_default_asset_handler,
>         },
>         { }
>     };
> 
>     static struct platform_device mydevice = {
>     ...
>         .dev = {
>             .assets = mydevice_assets,
>         },
>     ...
>     };
> 

>From Pandaboard's point of view, is mydevice supposed to be referring to
ehci-omap, LAN95xx or something else?

Strictly speaking, the regulator doesn't belongs neither to ehci-omap
nor LAN95xx. It belongs to a power domain on the board. And user should
have control to switch it OFF when required without hampering operation
of ehci-omap, so that the other USB ports are still usable.

--
regards,
-roger

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
