From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v11 08/14] usb: otg: add OTG/dual-role core
Date: Mon, 20 Jun 2016 15:03:37 +0300
Message-ID: <878ty0qd7q.fsf@linux.intel.com>
References: <1465564043-27163-1-git-send-email-rogerq@ti.com> <1465564043-27163-9-git-send-email-rogerq@ti.com> <575E672E.5070603@ti.com> <87h9coxq04.fsf@linux.intel.com> <5767C1B9.2060805@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5767C1B9.2060805@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, peter.chen@freescale.com, yoshihiro.shimoda.uh@renesas.com
Cc: tony@atomide.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, mathias.nyman@linux.intel.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, jun.li@freescale.com, grygorii.strashko@ti.com, robh@kernel.org, nsekhar@ti.com, b-liu@ti.com, joe@perches.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq@ti.com> writes:
>> Roger Quadros <rogerq@ti.com> writes:
>>> It provides APIs for the following tasks
>>>
>>> - Registering an OTG/dual-role capable controller
>>> - Registering Host and Gadget controllers to OTG core
>>> - Providing inputs to and kicking the OTG state machine
>>=20
>> I think I have already mentioned this, but after over 10 years of OTG,
>> nobody seems to care about it, why are we still touching at all I don't
>> know. For common non-OTG role-swapping we really don't need any of this
>> and, quite frankly, I fail to see enough users for this.
>>=20
>> Apparently there's only chipidea which, AFAICT, already had working
>> dual-role before this OTG State Machine was added to the kernel.
>>=20
>>> Provide a dual-role device (DRD) state machine.
>>=20
>> there's not such thing as DRD state machine. You don't need to go
>> through all these states, actually.
>
> There are 3 states though.
> HOST (id =3D 0)
> PERIPHERAL (id =3D 1, vbus =3D 1)
> IDLE (id =3D 1, vbus =3D 0).

IDLE is pretty much given, though ;-)

>>> DRD mode is a reduced functionality OTG mode. In this mode
>>> we don't support SRP, HNP and dynamic role-swap.
>>>
>>> In DRD operation, the controller mode (Host or Peripheral)
>>> is decided based on the ID pin status. Once a cable plug (Type-A
>>> or Type-B) is attached the controller selects the state
>>> and doesn't change till the cable in unplugged and a different
>>> cable type is inserted.
>>>
>>> As we don't need most of the complex OTG states and OTG timers
>>> we implement a lean DRD state machine in usb-otg.c.
>>> The DRD state machine is only interested in 2 hardware inputs
>>> 'id' and 'b_sess_vld'.
>>>
>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>> ---
>>> v11:
>>> - remove usb_otg_kick_fsm().
>>> - typo fixes: structa/structure, upto/up to.
>>> - remove "obj-$(CONFIG_USB_OTG_CORE)     +=3D common/" from Makefile.
>>>
>>>  drivers/usb/Kconfig          |  18 +
>>>  drivers/usb/common/Makefile  |   6 +-
>>>  drivers/usb/common/usb-otg.c | 877 +++++++++++++++++++++++++++++++++++=
++++++++
>>>  drivers/usb/core/Kconfig     |  14 -
>>>  drivers/usb/gadget/Kconfig   |   1 +
>>>  include/linux/usb/gadget.h   |   2 +
>>>  include/linux/usb/hcd.h      |   1 +
>>>  include/linux/usb/otg-fsm.h  |   7 +
>>>  include/linux/usb/otg.h      | 174 ++++++++-
>>>  9 files changed, 1070 insertions(+), 30 deletions(-)
>>>  create mode 100644 drivers/usb/common/usb-otg.c
>>>
>>> diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
>>> index 8689dcb..ed596ec 100644
>>> --- a/drivers/usb/Kconfig
>>> +++ b/drivers/usb/Kconfig
>>> @@ -32,6 +32,23 @@ if USB_SUPPORT
>>>  config USB_COMMON
>>>  	tristate
>>>=20=20
>>> +config USB_OTG_CORE
>>> +	tristate
>>=20
>> why tristate if you can never set it to 'M'?
>
> This gets internally set to M if either USB or GADGET is M.
> We select it in USB and GADGET.
> This was the only way I could get usb-otg.c to build as
>
> m if USB OR GADGET is m
> built-in if USB and GADGET are built in.

I could only see a "select USB_OTG_CORE", select will always set it 'y'
and disregard dependencies. Maybe I missed something else.

>>> diff --git a/drivers/usb/common/usb-otg.c b/drivers/usb/common/usb-otg.c
>>> new file mode 100644
>>> index 0000000..a23ab1e
>>> --- /dev/null
>>> +++ b/drivers/usb/common/usb-otg.c
>>> @@ -0,0 +1,877 @@
>>> +/**
>>> + * drivers/usb/common/usb-otg.c - USB OTG core
>>> + *
>>> + * Copyright (C) 2016 Texas Instruments Incorporated - http://www.ti.c=
om
>>> + * Author: Roger Quadros <rogerq@ti.com>
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License version 2 as
>>> + * published by the Free Software Foundation.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + * GNU General Public License for more details.
>>> + */
>>> +
>>> +#include <linux/kernel.h>
>>> +#include <linux/list.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of.h>
>>> +#include <linux/of_platform.h>
>>> +#include <linux/usb/of.h>
>>> +#include <linux/usb/otg.h>
>>> +#include <linux/usb/gadget.h>
>>> +#include <linux/workqueue.h>
>>> +
>>> +/* OTG device list */
>>> +LIST_HEAD(otg_list);
>>=20
>> not static? Who needs to touch this private list?
>
> right, it should be static.
>
>>=20
>>> +static DEFINE_MUTEX(otg_list_mutex);
>>> +
>>> +static int usb_otg_hcd_is_primary_hcd(struct usb_hcd *hcd)
>>> +{
>>> +	if (!hcd->primary_hcd)
>>> +		return 1;
>>=20
>> these seems inverted. If hcd->primary is NULL (meaning, there's no
>> ->primary_hcd), then we tell caller that this _is_ a primary hcd? Care
>> to explain?
>
> hcd->primary_hcd is a link used by the shared hcd to point to the
> primary_hcd.  primary_hcd's have this link as NULL.

So the following check is unnecessary and should always evaluate to
false, right ?

>>> +	return hcd =3D=3D hcd->primary_hcd;
>>> +}
>>> +
>>> +/**
>>> + * usb_otg_get_data() - get usb_otg data structure
>>> + * @otg_dev:	OTG controller device
>>> + *
>>> + * Check if the OTG device is in our OTG list and return
>>> + * usb_otg data, else NULL.
>>> + *
>>> + * otg_list_mutex must be held.
>>> + *
>>> + * Return: usb_otg data on success, NULL otherwise.
>>> + */
>>> +static struct usb_otg *usb_otg_get_data(struct device *otg_dev)
>>> +{
>>> +	struct usb_otg *otg;
>>> +
>>> +	if (!otg_dev)
>>> +		return NULL;
>>> +
>>> +	list_for_each_entry(otg, &otg_list, list) {
>>> +		if (otg->dev =3D=3D otg_dev)
>>> +			return otg;
>>> +	}
>>> +
>>> +	return NULL;
>>> +}
>>> +
>>> +/**
>>> + * usb_otg_start_host() - start/stop the host controller
>>> + * @otg:	usb_otg instance
>>> + * @on:		true to start, false to stop
>>> + *
>>> + * Start/stop the USB host controller. This function is meant
>>> + * for use by the OTG controller driver.
>>> + *
>>> + * Return: 0 on success, error value otherwise.
>>> + */
>>> +int usb_otg_start_host(struct usb_otg *otg, int on)
>>> +{
>>> +	struct otg_hcd_ops *hcd_ops =3D otg->hcd_ops;
>>> +	int ret;
>>> +
>>> +	dev_dbg(otg->dev, "otg: %s %d\n", __func__, on);
>>> +	if (!otg->host) {
>>> +		WARN_ONCE(1, "otg: fsm running without host\n");
>>=20
>> if (WARN_ONCE(!otg->host, "otg: fsm running without host\n"))
>> 	return 0;
>>=20
>> but, frankly, if you require a 'host' and a 'gadget' don't start this
>> layer until you have both.
>
> We don't start the layer till we have both host and gadget. But
> this API is for external use and might be called at any time.

well, if callers call this at the wrong time, it's callers' fault. Let
them oops so we catch the error.

> I could change the warning message to
>=20=20
> if (WARN_ONCE(!otg->host, "otg: %s called in invalid context\n", __func__=
))
> 	return 0;

you don't neet that.

>>> +		return 0;
>>> +	}
>>> +
>>> +	if (on) {
>>> +		if (otg->flags & OTG_FLAG_HOST_RUNNING)
>>> +			return 0;
>>> +
>>> +		/* start host */
>>> +		ret =3D hcd_ops->add(otg->primary_hcd.hcd,
>>> +				   otg->primary_hcd.irqnum,
>>> +				   otg->primary_hcd.irqflags);
>>=20
>> this is usb_add_hcd(), is it not? Why add an indirection?
>
> I've introduced the host and gadget ops interface to get around the
> circular dependency issue we can't avoid.
> otg needs to call host/gadget functions and host/gadget also needs to
> call otg functions.

IMO, this shows a fragility of your design. You're, now, lying to
usb_hcd and usb_udc and making them register into a virtual layer that
doesn't exist. And that layer will end up calling the real registration
function when some magic event happens.

This is only really needed for quirky devices like dwc3 (but see more on
dwc3 below) where host and peripheral registers shadow each
other. Otherwise we would be able to always keep hcd and udc always
registered. They would get different interrupt statuses anyway and
nothing would ever break.

However, when it comes to dwc3, we already have all the code necessary
to workaround this issue by destroying the XHCI pdev when OTG interrupt
says we should be peripheral (and vice-versa). DWC3 also keeps track of
the OTG states for those folks who really care about OTG (Hint: nobody
has cared for the past 10 years, why would they do so now?) and we don't
need a SW state machine when the HW handles that for us, right?

As for chipidea, IIRC, that doesn't need a SW state machine either, but
I know very little about that IP and don't even have documentation on
it. My understanding, however, is that chipidea behaves kinda like MUSB,
which changes roles automatically in HW based on ID pin state.

>>> +EXPORT_SYMBOL_GPL(drd_statemachine);
>>=20
>> why is this exported at all? It only runs from the work_struct
>
> You're right. It shouldn't be exported.
>
>> below. BTW, that work_struct looks unnecessary.
>
> why? The kick could be triggered from an interrupt
> context. e.g. otg_irq.

We have threaded IRQ handlers in the kernel, right? Make use of that
and, with a little smart locking and IRQ masking, you can run the OTG
IRQ thread almost completely lockless ;-)

>>> +/**
>>> + * usb_otg_register() - Register the OTG/dual-role device to OTG core
>>> + * @dev: OTG/dual-role controller device.
>>> + * @config: OTG configuration.
>>> + *
>>> + * Registers the OTG/dual-role controller device with the USB OTG core.
>>> + *
>>> + * Return: struct usb_otg * if success, ERR_PTR() otherwise.
>>> + */
>>> +struct usb_otg *usb_otg_register(struct device *dev,
>>> +				 struct usb_otg_config *config)
>>> +{
>>> +	struct usb_otg *otg;
>>> +	int ret =3D 0;
>>> +
>>> +	if (!dev || !config || !config->fsm_ops)
>>> +		return ERR_PTR(-EINVAL);
>>> +
>>> +	/* already in list? */
>>> +	mutex_lock(&otg_list_mutex);
>>> +	if (usb_otg_get_data(dev)) {
>>> +		dev_err(dev, "otg: %s: device already in otg list\n",
>>> +			__func__);
>>> +		ret =3D -EINVAL;
>>> +		goto unlock;
>>> +	}
>>> +
>>> +	/* allocate and add to list */
>>> +	otg =3D kzalloc(sizeof(*otg), GFP_KERNEL);
>>> +	if (!otg) {
>>> +		ret =3D -ENOMEM;
>>> +		goto unlock;
>>> +	}
>>> +
>>> +	otg->dev =3D dev;
>>> +	/* otg->caps is controller caps + DT overrides */
>>> +	otg->caps =3D *config->otg_caps;
>>> +	ret =3D of_usb_update_otg_caps(dev->of_node, &otg->caps);
>>> +	if (ret)
>>> +		goto err_wq;
>>> +
>>> +	if ((otg->caps.hnp_support || otg->caps.srp_support ||
>>> +	     otg->caps.adp_support) && !config->otg_work) {
>>> +		dev_err(dev,
>>> +			"otg: otg_work must be provided for OTG support\n");
>>> +		ret =3D -EINVAL;
>>> +		goto err_wq;
>>> +	}
>>> +
>>> +	if (config->otg_work)	/* custom otg_work ? */
>>> +		INIT_WORK(&otg->work, config->otg_work);
>>> +	else
>>> +		INIT_WORK(&otg->work, usb_drd_work);
>>=20
>> why do you need to cope with custom work handlers?
>
> It was just a provision to provide your own state machine if the generic
> one does not meet your needs. But i'm OK to get rid of it as well.

If you allow for this, every time there is a limitation, people will
just provide a copy of the state machine with a small change here and
there instead of fixing the real issue.

>>> +static void usb_otg_start_fsm(struct usb_otg *otg)
>>> +{
>>> +	struct otg_fsm *fsm =3D &otg->fsm;
>>> +
>>> +	if (fsm->running)
>>> +		goto kick_fsm;
>>> +
>>> +	if (!otg->host) {
>>> +		dev_info(otg->dev, "otg: can't start till host registers\n");
>>> +		return;
>>> +	}
>>> +
>>> +	if (!otg->gadget) {
>>> +		dev_info(otg->dev,
>>> +			 "otg: can't start till gadget UDC registers\n");
>>> +		return;
>>> +	}
>>=20
>> okay, so you never kick the FSM until host and gadget are
>> registered. Why do you need to test for the case where the FSM is
>> running without host/gadget?
>
> That message in the test was misleading. It could also be a
> used as a warning if users did something wrong.

this usb_otg_start_fsm() establishes a contract. That contract says that
the USB OTG FSM won't start until host and gadget are running and
registered, yada yada yada. Drivers trying to kicking the FSM without
calling usb_otg_start_fsm() first deserve to oops.

>>> +MODULE_LICENSE("GPL");
>>=20
>> GPL or GPL 2-only?
>
> GPL v2.
>
>>=20
>>> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
>>> index f4fc0aa..1d74fb8 100644
>>> --- a/include/linux/usb/gadget.h
>>> +++ b/include/linux/usb/gadget.h
>>> @@ -328,6 +328,7 @@ struct usb_gadget_ops {
>>>   * @in_epnum: last used in ep number
>>>   * @mA: last set mA value
>>>   * @otg_caps: OTG capabilities of this gadget.
>>> + * @otg_dev: OTG controller device, if needs to be used with OTG core.
>>=20
>> do you really know of any platform which has a separate OTG controller?
>>=20
>
> Andrew had pointed out in [1] that Tegra210 has separate blocks for OTG, =
host
> and gadget.
>
> [1] http://article.gmane.org/gmane.linux.ports.tegra/22969

that's not an OTG controller, it's just a mux. No different than Intel's
mux for swapping between XHCI and peripheral-only DWC3.

frankly, I would NEVER talk about OTG when type-C comes into play. They
are two competing standards and, apparently, type-C is winning when it
comes to role-swapping.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXZ9uZAAoJEIaOsuA1yqREyksP+wdTfay4U4WUQcKMA+UPumxc
nOqAwsOWEyJJrJwYUzGiWmIxAfDvdpIIfWBBX7oZMjcNzJz0OjdaZrcWXq170XRW
RbHcmhW/cdl0b5kqpDBy5WDtES6LJvdL+zGXD6FYxQXPrPiab84FFSjbU+JiQin+
n6Y9EWgJnJaxKihEv82WwulLY7pYLtH7fUS8Cynz67+5W4/m/isH/Hc8HElfxfcl
GrXXnnK0gbEgZHZcSBLm1jQ0y9caCg3k4a3tpK+87RRiFC56S4TKY6zRNvng/g4D
S2UXRdnuF8lngU2d0m+ldEzChdrSr0V0etz3m3uuTDFUKsXF8S840SGpH777Ol24
/0OoZTKFko/Al2fNxfoT71IYcq1G4w7gr/s0ycp90aAUj5wjcqGNxcstwW+Tjd2s
keHMAmFHCQMaE5zOnwgCXnXzNvdEBAI2+nENPNRKNijQa3MgiTLlwYWTRHdGkYoR
2xuHhwTCtY9WwjQBgu61MR1aNEiyq/PUvsiMyn5gx7Ge1pXUh9epZEVbOe/3cb3+
kQ9wd6/Ukk35I3TjDSR3yAnOGeLFESn78epbLGsKzUqiyteOATKdiMZaQfEQc3op
50r4eYi6ra/GdIs4TgUYiMxDHYEBlLalmL3/JAmTrSJcnECqUTfsEFhk5BNCLCdN
1mUYr7mjDuV/3U3pVKn0
=onuZ
-----END PGP SIGNATURE-----
--=-=-=--
