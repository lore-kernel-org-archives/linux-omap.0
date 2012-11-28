From: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 1/5] drivers : introduce device_path api
Date: Wed, 28 Nov 2012 10:30:26 +0800
Message-ID: <50B57742.2010107@linaro.org>
References: <Pine.LNX.4.44L0.1211271446430.1489-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1211271446430.1489-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 11/28/2012 04:10 AM, the mail apparently from Alan Stern included:
> On Wed, 28 Nov 2012, Andy Green wrote:
>
>> OK.  So I try to sketch it out iteractively to try to get in sync:
>>
>> device.h:
>>
>> 	enum asset_event {
>> 		AE_PROBED,
>> 		AE_REMOVED
>> 	};
>>
>> 	struct device_asset {
>> 		char *name; /* name of regulator, clock, etc */
>> 		void *asset; /* regulator, clock, etc */
>> 		int (*handler)(struct device *dev_owner, enum asset_event asset_ev=
ent,
>> struct device_asset *asset);
>> 	};
>
> Another possibility is to have two handlers: one for pre-probe and th=
e
> other for post-remove.  Then of course asset_event wouldn't be needed=
=2E
> Linus tends to prefer this strategy -- separate functions for separat=
e
> events.  That's why struct dev_pm_ops has so many method pointers.

OK.

I wonder if this needs extending to PM ops passing in to the assets.=20
Regulator is usually self-sufficient but sometimes clocks at least need=
=20
meddling in suspend paths.

Maybe it's enough instead to offer a standalone api for drivers that=20
want to meddle with assets, like enable / disable an asset clock...

void *device_find_asset(struct device *device, const char *name);

=2E..if it wants to touch anything like that it needs to mandate a=20
nonambiguous name for the asset like "reg-mydriver-ehci-omap.0".

This is also handy since the driver can then adapt around absence or=20
presence of optional assets if it wants.

>> 	struct device {
>> 	...
>> 		struct device_asset *assets;
>
> Or a list instead of a NULL-terminated array.  It depends on whether
> people will want to add or remove assets dynamically.  For now an arr=
ay
> would be fine.

OK.

>> 	...
>> 	};
>>
>>
>> drivers/base/dd.c | really_probe():
>>
>> ...
>> 	struct device_asset *asset;
>> ...
>> 	asset =3D dev->assets;
>> 	while (asset && asset->name) {
>
> Maybe it would be better to test asset->handler.  Some assets might n=
ot
> need names.

Good point.

>> 		if (asset->handler(dev, AE_PROBED, asset)) {
>> 			/* clean up and bail */
>> 		}
>> 		asset++;
>> 	}
>>
>> 	/* do probe */
>> ...
>>
>>
>> drivers/base/dd.c | __device_release_driver:  (is this really the be=
st
>> place to oppose probe()?)
>
> The right place is just after the remove method is called, so yes.
>
>> ...
>> 	struct device_asset *asset;
>> ...
>>
>> 	/* call device ->remove() */
>> ...
>> 	asset =3D dev->assets;
>> 	while (asset && asset->name) {
>> 		asset->handler(dev, AE_REMOVED, asset);
>> 		asset++;
>> 	}
>
> It would be slightly safer to iterate in reverse order.

Good point.

>> ...
>>
>>
>> board file:
>>
>> 	static struct regulator myreg =3D {
>> 		.name =3D "mydevice-regulator",
>> 	};
>>
>> 	static struct device_asset mydevice_assets[] =3D {
>> 		{
>> 			.name =3D "mydevice-regulator",
>> 			.handler =3D regulator_default_asset_handler,
>> 		},
>> 		{ }
>> 	};
>>
>> 	static struct platform_device mydevice =3D {
>> 	...
>> 		.dev =3D {
>> 			.assets =3D mydevice_assets,
>> 		},
>> 	...
>> 	};
>>
>>
>> regulator code:
>>
>> int regulator_default_asset_handler(struct device *dev_owner, enum
>> asset_event asset_event, struct device_asset *asset)
>> {
>> 	struct regulator **reg =3D &asset->asset;
>> 	int n;
>>
>> 	switch (asset_event) {
>> 	case AE_PROBED:
>> 		*reg =3D regulator_get(dev_owner, asset->name);
>> 		if (IS_ERR(*reg))
>> 			return *reg;
>
> PTR_ERR.

Right.

I'll offer a series with these adaptations shortly.

-Andy

>> 		n =3D regulator_enable(*reg);
>> 		if (n < 0)
>> 			regulator_put(*reg);
>> 		return n;
>>
>> 	case AE_REMOVED:
>> 		regulator_put(*reg);
>> 		break;
>> 	}
>>
>> 	return 0;
>> }
>> EXPORT_SYMBOL_GPL(regulator_default_asset_handler);
>>
>>
>> The subsystems that can expect to get used (clock...) might each wan=
t to
>> define a default handler like the one for regulator.  That'll be an =
end
>> to the code duplication issue.  The user can still do his own handle=
r if
>> he wants.
>>
>> I put a name field in so we can use regulator_get() nicely, we don't
>> need access to the object pointer or that it exists at boardfile-tim=
e
>> that way either.  But I can see it's arguable.
>
> It hadn't occurred to me, but it seems like a good idea.
>
> Yes, overall this is almost exactly what I had in mind.
>
>>>> Throwing out the path stuff and limiting this to platform_device m=
eans
>>>> you cannot bind to dynamically created objects like hub or anythin=
g
>>>> downstream of a hub.  So Felipe's identification of the hub as the
>>>> happening place to do this is out of luck.
>>>
>>> Greg pointed out that this could be useful for arbitrary devices, n=
ot
>>> just platform devices, so it could be applied to dynamically create=
d
>>> objects.
>>
>> Well that is cool, but to exploit that in the dynamic object case
>> arrangements for identifying the appropriate object has appeared are
>> needed.
>
> For example, this scheme wouldn't lend itself easily to associating t=
he
> regulator with the particular root-hub port that the LAN95xx is
> attached to.  I can't think of any reasonable way to do that other th=
an
> the approaches we have already considered.
>
>>   We have a nice array of platform_devices nicely there in the
>> board file we can attach assets to like "pdev[1].dev.assets =3D xxx;=
" but
>> that's not there in dynamic device case.  Anyway this sounds like wh=
at
>> we're discussing can be well worth establishing and might lead to th=
at
>> later.
>
> Agreed.
>
> Alan Stern
>


--=20
Andy Green | TI Landing Team Leader
Linaro.org =E2=94=82 Open source software for ARM SoCs | Follow Linaro
http://facebook.com/pages/Linaro/155974581091106  -=20
http://twitter.com/#!/linaroorg - http://linaro.org/linaro-blog
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
