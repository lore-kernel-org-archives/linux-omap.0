From: Roger Quadros <rogerq@ti.com>
Subject: Re: [RFC PATCH 1/5] drivers : introduce device_path api
Date: Wed, 28 Nov 2012 14:45:57 +0200
Message-ID: <50B60785.4000101@ti.com>
References: <Pine.LNX.4.44L0.1211271253230.1489-100000@iolanthe.rowland.org> <50B51313.2060003@linaro.org> <50B5F1DB.8090502@ti.com> <50B5F9DD.5060308@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44076 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754291Ab2K1MqE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Nov 2012 07:46:04 -0500
In-Reply-To: <50B5F9DD.5060308@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Green <andy.green@linaro.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg KH <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, balbi@ti.com

On 11/28/2012 01:47 PM, Andy Green wrote:
> On 11/28/2012 07:13 PM, the mail apparently from Roger Quadros included:
>> On 11/27/2012 09:22 PM, Andy Green wrote:
>>> On 11/28/2012 02:09 AM, the mail apparently from Alan Stern included:
>>>> On Wed, 28 Nov 2012, Andy Green wrote:
>>>>
>>>>>> Greg's advice was simply not to rely on pathnames in sysfs because
>>>>>> they
>>>>>> aren't fixed in stone.  That leaves plenty of other ways to approach
>>>>>> this problem.
>>>>>
>>>>> It's sage advice, but there is zero code provided in my patches that
>>>>> "relies on pathnames in sysfs".
>>>>
>>>> In your 1/5 patch, _device_path_generate() concatenates device name
>>>> strings, starting from a device root and separating elements with '/'
>>>> characters.  Isn't that the same as a sysfs pathname?
>>>
>>> It's nothing to do with sysfs... yes some unrelated bits of sysfs also
>>> walk the device path.  If we want to talk about how fragile the device
>>> path is as an id scheme over time we need to talk about likelihood of
>>> individual device names changing, not "sysfs".  Anyway -->
>>>
>>>>>> Basically, what you want is for something related to device A (the
>>>>>> regulator or the GPIO) to happen whenever device B (the ehci-omap.0
>>>>>> platform device) is bound to a driver.  The most straightforward
>>>>>> way to
>>>>>> arrange this is for A's driver to have a callback that is invoked
>>>>>> whenever B is bound or unbound.  The most straightforward way to
>>>>>> arrange _that_ is to allow each platform_device to have a list of
>>>>>> callbacks.
>>>>>
>>>>> Sorry I didn't really understand this proposal yet.  You want "A", the
>>>>> regulator, driver to grow a callback function that gets called when
>>>>> the
>>>>> targeted platform_device ("B", ehci-omap.0) probe happens.  Could you
>>>>> expand what the callback prototype or new members in the struct might
>>>>> look like?  It's your tuple thing or we pass it an opaque pointer that
>>>>> is the struct regulator * or suchlike?
>>>>
>>>> Well, it won't be exactly the same as the tuple thing because no
>>>> strings will be involved, but it would be similar.  The callback would
>>>> receive an opaque pointer (presumably to the regulator) and a device
>>>> pointer (the B device).
>>>
>>> OK.  So I try to sketch it out iteractively to try to get in sync:
>>>
>>> device.h:
>>>
>>>      enum asset_event {
>>>          AE_PROBED,
>>>          AE_REMOVED
>>>      };
>>>
>>>      struct device_asset {
>>>          char *name; /* name of regulator, clock, etc */
>>>          void *asset; /* regulator, clock, etc */
>>>          int (*handler)(struct device *dev_owner, enum asset_event
>>> asset_event, struct device_asset *asset);
>>>      };
>>>
>>>      struct device {
>>>      ...
>>>          struct device_asset *assets;
>>>      ...
>>>      };
>>>
>>>
>>> drivers/base/dd.c | really_probe():
>>>
>>> ...
>>>      struct device_asset *asset;
>>> ...
>>>      asset = dev->assets;
>>>      while (asset && asset->name) {
>>>          if (asset->handler(dev, AE_PROBED, asset)) {
>>>              /* clean up and bail */
>>>          }
>>>          asset++;
>>>      }
>>>
>>>      /* do probe */
>>> ...
>>>
>>>
>>> drivers/base/dd.c | __device_release_driver:  (is this really the best
>>> place to oppose probe()?)
>>>
>>> ...
>>>      struct device_asset *asset;
>>> ...
>>>
>>>      /* call device ->remove() */
>>> ...
>>>      asset = dev->assets;
>>>      while (asset && asset->name) {
>>>          asset->handler(dev, AE_REMOVED, asset);
>>>          asset++;
>>>      }
>>> ...
>>>
>>>
>>> board file:
>>>
>>>      static struct regulator myreg = {
>>>          .name = "mydevice-regulator",
>>>      };
>>>
>>>      static struct device_asset mydevice_assets[] = {
>>>          {
>>>              .name = "mydevice-regulator",
>>>              .handler = regulator_default_asset_handler,
>>>          },
>>>          { }
>>>      };
>>>
>>>      static struct platform_device mydevice = {
>>>      ...
>>>          .dev = {
>>>              .assets = mydevice_assets,
>>>          },
>>>      ...
>>>      };
>>>
>>
>>  From Pandaboard's point of view, is mydevice supposed to be referring to
>> ehci-omap, LAN95xx or something else?
>>
>> Strictly speaking, the regulator doesn't belongs neither to ehci-omap
>> nor LAN95xx. It belongs to a power domain on the board. And user should
>> have control to switch it OFF when required without hampering operation
>> of ehci-omap, so that the other USB ports are still usable.
> 
> I'd prefer to deal with that after a try#1 with regulator, I didn't see
> any code about power domain in there right now.  There's a lot to get
> consensus on already with this series.

Sure. I meant power domain in the general sense and not referring to any
code or framework in the kernel. It could as well be implemented using
the existing regulator framework.

> 
> Notice that these assets are generic, I will provide clk and regulator
> handlers with try#1, and working examples for Panda case with both, but
> presumably power domain can fold into it as well.
> 
> Since I am on usb-next and there's nothing to be seen about power
> domains, what is the situation with that support?
> 

Looking around there seems to be some power domain framework tied to
runtime PM in drivers/base/power/domain.c

The idea is that the power domain is powered on/off by the runtime PM
core when the device is runtime resumed/suspended. I think this is meant
for SoC power domains and appears to be too complicated for a GPIO based
regulator control.

--
regards,
-roger
