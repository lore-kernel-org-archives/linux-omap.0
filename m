From: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 1/5] drivers : introduce device_path api
Date: Wed, 28 Nov 2012 03:22:59 +0800
Message-ID: <50B51313.2060003@linaro.org>
References: <Pine.LNX.4.44L0.1211271253230.1489-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1211271253230.1489-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 11/28/2012 02:09 AM, the mail apparently from Alan Stern included:
> On Wed, 28 Nov 2012, Andy Green wrote:
>
>>> Greg's advice was simply not to rely on pathnames in sysfs because =
they
>>> aren't fixed in stone.  That leaves plenty of other ways to approac=
h
>>> this problem.
>>
>> It's sage advice, but there is zero code provided in my patches that
>> "relies on pathnames in sysfs".
>
> In your 1/5 patch, _device_path_generate() concatenates device name
> strings, starting from a device root and separating elements with '/'
> characters.  Isn't that the same as a sysfs pathname?

It's nothing to do with sysfs... yes some unrelated bits of sysfs also=20
walk the device path.  If we want to talk about how fragile the device=20
path is as an id scheme over time we need to talk about likelihood of=20
individual device names changing, not "sysfs".  Anyway -->

>>> Basically, what you want is for something related to device A (the
>>> regulator or the GPIO) to happen whenever device B (the ehci-omap.0
>>> platform device) is bound to a driver.  The most straightforward wa=
y to
>>> arrange this is for A's driver to have a callback that is invoked
>>> whenever B is bound or unbound.  The most straightforward way to
>>> arrange _that_ is to allow each platform_device to have a list of
>>> callbacks.
>>
>> Sorry I didn't really understand this proposal yet.  You want "A", t=
he
>> regulator, driver to grow a callback function that gets called when =
the
>> targeted platform_device ("B", ehci-omap.0) probe happens.  Could yo=
u
>> expand what the callback prototype or new members in the struct migh=
t
>> look like?  It's your tuple thing or we pass it an opaque pointer th=
at
>> is the struct regulator * or suchlike?
>
> Well, it won't be exactly the same as the tuple thing because no
> strings will be involved, but it would be similar.  The callback woul=
d
> receive an opaque pointer (presumably to the regulator) and a device
> pointer (the B device).

OK.  So I try to sketch it out iteractively to try to get in sync:

device.h:

	enum asset_event {
		AE_PROBED,
		AE_REMOVED
	};

	struct device_asset {
		char *name; /* name of regulator, clock, etc */
		void *asset; /* regulator, clock, etc */
		int (*handler)(struct device *dev_owner, enum asset_event asset_event=
,=20
struct device_asset *asset);
	};

	struct device {
	...
		struct device_asset *assets;
	...
	};


drivers/base/dd.c | really_probe():

=2E..
	struct device_asset *asset;
=2E..
	asset =3D dev->assets;
	while (asset && asset->name) {
		if (asset->handler(dev, AE_PROBED, asset)) {
			/* clean up and bail */
		}
		asset++;
	}

	/* do probe */
=2E..


drivers/base/dd.c | __device_release_driver:  (is this really the best=20
place to oppose probe()?)

=2E..
	struct device_asset *asset;
=2E..

	/* call device ->remove() */
=2E..
	asset =3D dev->assets;
	while (asset && asset->name) {
		asset->handler(dev, AE_REMOVED, asset);
		asset++;
	}
=2E..


board file:

	static struct regulator myreg =3D {
		.name =3D "mydevice-regulator",
	};

	static struct device_asset mydevice_assets[] =3D {
		{
			.name =3D "mydevice-regulator",
			.handler =3D regulator_default_asset_handler,
		},
		{ }
	};

	static struct platform_device mydevice =3D {
	...
		.dev =3D {
			.assets =3D mydevice_assets,
		},
	...
	};


regulator code:

int regulator_default_asset_handler(struct device *dev_owner, enum=20
asset_event asset_event, struct device_asset *asset)
{
	struct regulator **reg =3D &asset->asset;
	int n;

	switch (asset_event) {
	case AE_PROBED:
		*reg =3D regulator_get(dev_owner, asset->name);
		if (IS_ERR(*reg))
			return *reg;
		n =3D regulator_enable(*reg);
		if (n < 0)
			regulator_put(*reg);
		return n;

	case AE_REMOVED:
		regulator_put(*reg);
		break;
	}

	return 0;
}
EXPORT_SYMBOL_GPL(regulator_default_asset_handler);


The subsystems that can expect to get used (clock...) might each want t=
o=20
define a default handler like the one for regulator.  That'll be an end=
=20
to the code duplication issue.  The user can still do his own handler i=
f=20
he wants.

I put a name field in so we can use regulator_get() nicely, we don't=20
need access to the object pointer or that it exists at boardfile-time=20
that way either.  But I can see it's arguable.

>> Throwing out the path stuff and limiting this to platform_device mea=
ns
>> you cannot bind to dynamically created objects like hub or anything
>> downstream of a hub.  So Felipe's identification of the hub as the
>> happening place to do this is out of luck.
>
> Greg pointed out that this could be useful for arbitrary devices, not
> just platform devices, so it could be applied to dynamically created
> objects.

Well that is cool, but to exploit that in the dynamic object case=20
arrangements for identifying the appropriate object has appeared are=20
needed.  We have a nice array of platform_devices nicely there in the=20
board file we can attach assets to like "pdev[1].dev.assets =3D xxx;" b=
ut=20
that's not there in dynamic device case.  Anyway this sounds like what=20
we're discussing can be well worth establishing and might lead to that=20
later.

> As for what Felipe said...  He suggested doing this when the hub driv=
er
> binds to the controller's root hub.  The root hub is created when the
> controller's driver registers the new USB bus.  This happens as part =
of
> the driver's probe routine.  So what I have been talking about is ver=
y
> similar (in terms of when it happens) to what Felipe wanted.
>
> Besides, Felipe wasn't thinking in the most general terms.  (In fact,
> at first he confused the root hub with the LAN95xx's hub.)  There's n=
o
> reason to restrict this sort of thing to USB hubs (or to regulators,
> for that matter).  The driver core is the right place for it.

Sounds good to me.

-Andy

--=20
Andy Green | TI Landing Team Leader
Linaro.org =E2=94=82 Open source software for ARM SoCs | Follow Linaro
http://facebook.com/pages/Linaro/155974581091106  -=20
http://twitter.com/#!/linaroorg - http://linaro.org/linaro-blog
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
