From: Andy Green <andy.green@linaro.org>
Subject: Re: [RFC PATCH 1/5] drivers : introduce device_path api
Date: Wed, 28 Nov 2012 19:47:41 +0800
Message-ID: <50B5F9DD.5060308@linaro.org>
References: <Pine.LNX.4.44L0.1211271253230.1489-100000@iolanthe.rowland.org> <50B51313.2060003@linaro.org> <50B5F1DB.8090502@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from warmcat.com ([87.106.134.80]:42679 "EHLO warmcat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754110Ab2K1Lrw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Nov 2012 06:47:52 -0500
In-Reply-To: <50B5F1DB.8090502@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg KH <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, balbi@ti.com

On 11/28/2012 07:13 PM, the mail apparently from Roger Quadros included=
:
> On 11/27/2012 09:22 PM, Andy Green wrote:
>> On 11/28/2012 02:09 AM, the mail apparently from Alan Stern included=
:
>>> On Wed, 28 Nov 2012, Andy Green wrote:
>>>
>>>>> Greg's advice was simply not to rely on pathnames in sysfs becaus=
e they
>>>>> aren't fixed in stone.  That leaves plenty of other ways to appro=
ach
>>>>> this problem.
>>>>
>>>> It's sage advice, but there is zero code provided in my patches th=
at
>>>> "relies on pathnames in sysfs".
>>>
>>> In your 1/5 patch, _device_path_generate() concatenates device name
>>> strings, starting from a device root and separating elements with '=
/'
>>> characters.  Isn't that the same as a sysfs pathname?
>>
>> It's nothing to do with sysfs... yes some unrelated bits of sysfs al=
so
>> walk the device path.  If we want to talk about how fragile the devi=
ce
>> path is as an id scheme over time we need to talk about likelihood o=
f
>> individual device names changing, not "sysfs".  Anyway -->
>>
>>>>> Basically, what you want is for something related to device A (th=
e
>>>>> regulator or the GPIO) to happen whenever device B (the ehci-omap=
=2E0
>>>>> platform device) is bound to a driver.  The most straightforward =
way to
>>>>> arrange this is for A's driver to have a callback that is invoked
>>>>> whenever B is bound or unbound.  The most straightforward way to
>>>>> arrange _that_ is to allow each platform_device to have a list of
>>>>> callbacks.
>>>>
>>>> Sorry I didn't really understand this proposal yet.  You want "A",=
 the
>>>> regulator, driver to grow a callback function that gets called whe=
n the
>>>> targeted platform_device ("B", ehci-omap.0) probe happens.  Could =
you
>>>> expand what the callback prototype or new members in the struct mi=
ght
>>>> look like?  It's your tuple thing or we pass it an opaque pointer =
that
>>>> is the struct regulator * or suchlike?
>>>
>>> Well, it won't be exactly the same as the tuple thing because no
>>> strings will be involved, but it would be similar.  The callback wo=
uld
>>> receive an opaque pointer (presumably to the regulator) and a devic=
e
>>> pointer (the B device).
>>
>> OK.  So I try to sketch it out iteractively to try to get in sync:
>>
>> device.h:
>>
>>      enum asset_event {
>>          AE_PROBED,
>>          AE_REMOVED
>>      };
>>
>>      struct device_asset {
>>          char *name; /* name of regulator, clock, etc */
>>          void *asset; /* regulator, clock, etc */
>>          int (*handler)(struct device *dev_owner, enum asset_event
>> asset_event, struct device_asset *asset);
>>      };
>>
>>      struct device {
>>      ...
>>          struct device_asset *assets;
>>      ...
>>      };
>>
>>
>> drivers/base/dd.c | really_probe():
>>
>> ...
>>      struct device_asset *asset;
>> ...
>>      asset =3D dev->assets;
>>      while (asset && asset->name) {
>>          if (asset->handler(dev, AE_PROBED, asset)) {
>>              /* clean up and bail */
>>          }
>>          asset++;
>>      }
>>
>>      /* do probe */
>> ...
>>
>>
>> drivers/base/dd.c | __device_release_driver:  (is this really the be=
st
>> place to oppose probe()?)
>>
>> ...
>>      struct device_asset *asset;
>> ...
>>
>>      /* call device ->remove() */
>> ...
>>      asset =3D dev->assets;
>>      while (asset && asset->name) {
>>          asset->handler(dev, AE_REMOVED, asset);
>>          asset++;
>>      }
>> ...
>>
>>
>> board file:
>>
>>      static struct regulator myreg =3D {
>>          .name =3D "mydevice-regulator",
>>      };
>>
>>      static struct device_asset mydevice_assets[] =3D {
>>          {
>>              .name =3D "mydevice-regulator",
>>              .handler =3D regulator_default_asset_handler,
>>          },
>>          { }
>>      };
>>
>>      static struct platform_device mydevice =3D {
>>      ...
>>          .dev =3D {
>>              .assets =3D mydevice_assets,
>>          },
>>      ...
>>      };
>>
>
>  From Pandaboard's point of view, is mydevice supposed to be referrin=
g to
> ehci-omap, LAN95xx or something else?
>
> Strictly speaking, the regulator doesn't belongs neither to ehci-omap
> nor LAN95xx. It belongs to a power domain on the board. And user shou=
ld
> have control to switch it OFF when required without hampering operati=
on
> of ehci-omap, so that the other USB ports are still usable.

I'd prefer to deal with that after a try#1 with regulator, I didn't see=
=20
any code about power domain in there right now.  There's a lot to get=20
consensus on already with this series.

Notice that these assets are generic, I will provide clk and regulator=20
handlers with try#1, and working examples for Panda case with both, but=
=20
presumably power domain can fold into it as well.

Since I am on usb-next and there's nothing to be seen about power=20
domains, what is the situation with that support?

-Andy

--=20
Andy Green | TI Landing Team Leader
Linaro.org =E2=94=82 Open source software for ARM SoCs | Follow Linaro
http://facebook.com/pages/Linaro/155974581091106  -=20
http://twitter.com/#!/linaroorg - http://linaro.org/linaro-blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
