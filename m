From: Andy Green <andy.green@linaro.org>
Subject: Re: [try#1 PATCH 5/7] omap4: panda: add smsc95xx regulator and reset
 dependent on root hub
Date: Fri, 30 Nov 2012 04:58:51 +0800
Message-ID: <50B7CC8B.5050802@linaro.org>
References: <Pine.LNX.4.44L0.1211291247130.1535-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from warmcat.com ([87.106.134.80]:51071 "EHLO warmcat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751689Ab2K2U7E (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Nov 2012 15:59:04 -0500
In-Reply-To: <Pine.LNX.4.44L0.1211291247130.1535-100000@iolanthe.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Roger Quadros <rogerq@ti.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, gregkh@linuxfoundation.org, keshava_mgowda@ti.com, balbi@ti.com

On 11/30/2012 01:57 AM, the mail apparently from Alan Stern included:
> On Thu, 29 Nov 2012, Andy Green wrote:
>
>> However I think what you're saying about binding to hub power is goo=
d.
>> The hub ports are not devices, but it would be possible to bind an a=
sset
>> array to them and make the pre- and post- code functions.
>
> In the 3.6 kernel, hub ports are not devices.  In 3.7 they are -- tha=
t
> is, each hub port has its own struct device.

Right, I should have seen this in hub.c before.  It's much better like =
that.

>> I think it will be possible to address objections around the "pathin=
ess"
>> by being able to seed the path match with a platform_device pointer
>> (there exists in the board file time a platform_device for ehci-omap=
=2E0
>> ...) and just matching the remainder on a single usb device's name, =
like
>> "*-1.1-1".
>
> Can you think of a way to do this without checking for a match every
> time a new device is registered?  For instance, in this case it would
> be preferable to do this match only for descendants of ehci-omap.0.  =
To
> match the port device, the string would have to be something like
> "*-0:1.0/port2".

Yes.  How about adding a third callback to struct device_asset, along=20
the lines of

	int (*pre_child_register)(struct device *child);

then, in register_device() we add code that before we get down to it, w=
e=20
walk up the new device's parents calling ->pre_child_register() on any=20
assets the parents may have.  In the typical case that's a rapid NOP=20
once per device registration.

However... if we had arranged back at boot time that the ehci-omap.0=20
struct device had an asset with only pre_device_register callback set,=20
we can use that asset's .name for the right-justified child device name=
=20
we are looking for like "-0:1.0/port2", and its .asset member to point=20
to another asset table the pre_child_register callback will attach to=20
the child device if the name matches.  So in the board file:

	struct device_asset ehci_omap0_smsc_hub_port_assets[] =3D {
		/* the smsc regulator and clock assets destined for the hub port */
		{ }
	};

	/* below is attached to ehci-omap.0 like in try#1 */

	struct device_asset ehci_omap0_assets[] =3D {
		{
			.name =3D "-0:1.0/port2",
			.asset =3D ehci_omap0_smsc_hub_port_assets,
			.pre_child_register =3D device_asset_attach_to_child,
		},
		{ }
	};

In that way we can project as many stashed asset tables on to=20
dynamically probed devices as we like from the platform_devices at boot=
=20
time.  Only children of the right platform devices do any checking or=20
processing.

> In fact, if the match were anchored at the end of the string, we
> wouldn't need the wildcard at all -- at least, not in this case.  The
> string could simply be "-0:1.0/port2".  But that's only if the match =
is
> restricted to devices below ehci-omap.0.

It's a good idea, it won't get fooled by a hub getting plugged there=20
which has its own port2 either, the -0:1.0 bit will have been elaborate=
d=20
for the subsequent hub "path" and won't match.


It may be neater to split out the device_asset callbacks to an ..._ops=20
struct.

	struct device_asset_ops {
		int (*pre_probe)(struct device *device, struct device_asset *asset);
		void (*post_remove)(struct device *device, struct device_asset *asset=
);
		int (*pre_child_register)(struct device *child);
	};

	struct device_asset {
		...
		struct device_asset_ops *ops;
	};

that also lets us export and set one thing to select say regulator=20
"handler", instead of n callbacks that must match.


Something else I think mux would be a great target for device_asset=20
support.  That way it could become normal for mux function to get set a=
s=20
part of the specific device instantiation, so if you know you have an=20
8-bit ULPI PHY that will be logically created by the platform_device,=20
you can attach ULPI-mode mux config appropriate for your exact SoC as a=
n=20
asset to the platform_device.

When the device is destroyed, balls can go back to safe mode and save=20
power, and if the balls are muxed with other things again the right mux=
=20
asset can be associated with that so it switches automagically accordin=
g=20
to what you are doing.  That's a lot better than forcing them once at=20
boot which is the current method.  Are there any gotchas with that?

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
