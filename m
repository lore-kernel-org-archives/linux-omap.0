From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v11 08/14] usb: otg: add OTG/dual-role core
Date: Mon, 20 Jun 2016 15:46:29 +0300
Message-ID: <87ziqgownu.fsf@linux.intel.com>
References: <1465564043-27163-1-git-send-email-rogerq@ti.com> <1465564043-27163-9-git-send-email-rogerq@ti.com> <575E672E.5070603@ti.com> <87h9coxq04.fsf@linux.intel.com> <5767C1B9.2060805@ti.com> <878ty0qd7q.fsf@linux.intel.com> <5767E0EB.3020602@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5767E0EB.3020602@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, peter.chen@freescale.com, yoshihiro.shimoda.uh@renesas.com
Cc: tony@atomide.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, mathias.nyman@linux.intel.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, jun.li@freescale.com, grygorii.strashko@ti.com, robh@kernel.org, nsekhar@ti.com, b-liu@ti.com, joe@perches.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq@ti.com> writes:
>>>>> diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
>>>>> index 8689dcb..ed596ec 100644
>>>>> --- a/drivers/usb/Kconfig
>>>>> +++ b/drivers/usb/Kconfig
>>>>> @@ -32,6 +32,23 @@ if USB_SUPPORT
>>>>>  config USB_COMMON
>>>>>  	tristate
>>>>>=20=20
>>>>> +config USB_OTG_CORE
>>>>> +	tristate
>>>>
>>>> why tristate if you can never set it to 'M'?
>>>
>>> This gets internally set to M if either USB or GADGET is M.
>>> We select it in USB and GADGET.
>>> This was the only way I could get usb-otg.c to build as
>>>
>>> m if USB OR GADGET is m
>>> built-in if USB and GADGET are built in.
>>=20
>> I could only see a "select USB_OTG_CORE", select will always set it 'y'
>> and disregard dependencies. Maybe I missed something else.
>
> Not always. See how USB_COMMON works.

USB_COMMON is always 'y'. That could be changes a bool as well.

Do you have any defconfig where USB_COMMON or USB_OTG_CORE gets set to
'm'?

>>>>> +static DEFINE_MUTEX(otg_list_mutex);
>>>>> +
>>>>> +static int usb_otg_hcd_is_primary_hcd(struct usb_hcd *hcd)
>>>>> +{
>>>>> +	if (!hcd->primary_hcd)
>>>>> +		return 1;
>>>>
>>>> these seems inverted. If hcd->primary is NULL (meaning, there's no
>>>> ->primary_hcd), then we tell caller that this _is_ a primary hcd? Care
>>>> to explain?
>>>
>>> hcd->primary_hcd is a link used by the shared hcd to point to the
>>> primary_hcd.  primary_hcd's have this link as NULL.
>>=20
>> So the following check is unnecessary and should always evaluate to
>> false, right ?
>
> Actually primary_hcd's not having a shared HCD have hcd->primary_hcd as N=
ULL
> and those having a shared HCD do have it pointing to the primary hcd.

But look at your check:

is_primary(struct usb_hcd *hcd)
{
	if (!hcd->primary_hcd)
        	return true;

	return hcd =3D=3D hcd->primary_hcd;
}

if you're passing a primary hcd, you're gonna return on the first
branch. If you're passing a secondary hcd, then your equality will
always be false.=20

IOW, this can be reduced to:

is_primary(struct usb_hcd *hcd)
{
	return !hcd->primary_hcd;
}

right?

>>>>> +int usb_otg_start_host(struct usb_otg *otg, int on)
>>>>> +{
>>>>> +	struct otg_hcd_ops *hcd_ops =3D otg->hcd_ops;
>>>>> +	int ret;
>>>>> +
>>>>> +	dev_dbg(otg->dev, "otg: %s %d\n", __func__, on);
>>>>> +	if (!otg->host) {
>>>>> +		WARN_ONCE(1, "otg: fsm running without host\n");
>>>>
>>>> if (WARN_ONCE(!otg->host, "otg: fsm running without host\n"))
>>>> 	return 0;
>>>>
>>>> but, frankly, if you require a 'host' and a 'gadget' don't start this
>>>> layer until you have both.
>>>
>>> We don't start the layer till we have both host and gadget. But
>>> this API is for external use and might be called at any time.
>>=20
>> well, if callers call this at the wrong time, it's callers' fault. Let
>> them oops so we catch the error.
>
> So you suggest we allow a NULL pointer dereference here?

yes, it's a clear violation of the API contract. The only situation
where this would ever trigger, is if somebody is calling
usb_otg_start_host() without calling start_fsm() first. That shouldn't
be valid.

>>>>> +		return 0;
>>>>> +	}
>>>>> +
>>>>> +	if (on) {
>>>>> +		if (otg->flags & OTG_FLAG_HOST_RUNNING)
>>>>> +			return 0;
>>>>> +
>>>>> +		/* start host */
>>>>> +		ret =3D hcd_ops->add(otg->primary_hcd.hcd,
>>>>> +				   otg->primary_hcd.irqnum,
>>>>> +				   otg->primary_hcd.irqflags);
>>>>
>>>> this is usb_add_hcd(), is it not? Why add an indirection?
>>>
>>> I've introduced the host and gadget ops interface to get around the
>>> circular dependency issue we can't avoid.
>>> otg needs to call host/gadget functions and host/gadget also needs to
>>> call otg functions.
>>=20
>> IMO, this shows a fragility of your design. You're, now, lying to
>> usb_hcd and usb_udc and making them register into a virtual layer that
>> doesn't exist. And that layer will end up calling the real registration
>> function when some magic event happens.
>>=20
>> This is only really needed for quirky devices like dwc3 (but see more on
>> dwc3 below) where host and peripheral registers shadow each
>> other. Otherwise we would be able to always keep hcd and udc always
>> registered. They would get different interrupt statuses anyway and
>> nothing would ever break.
>
> Well I only had the opportunity to work with dwc3 so I had to ensure
> the design worked with it.

but this is exactly what I'm pointing you to. DWC3 does not need to go
through this because the HW maintains state machine for you.

>> However, when it comes to dwc3, we already have all the code necessary
>> to workaround this issue by destroying the XHCI pdev when OTG interrupt
>> says we should be peripheral (and vice-versa). DWC3 also keeps track of
>> the OTG states for those folks who really care about OTG (Hint: nobody
>> has cared for the past 10 years, why would they do so now?) and we don't
>> need a SW state machine when the HW handles that for us, right?
>
> Where is the code? I'd like to test dual-role on TI platforms.

Well, we just need an OTG IRQ handler to call dwc3_gadget_suspend() (or
that function renamed to match the usage) and something similar for the
host side.

It's all doable in a day or two.

>>> why? The kick could be triggered from an interrupt
>>> context. e.g. otg_irq.
>>=20
>> We have threaded IRQ handlers in the kernel, right? Make use of that
>> and, with a little smart locking and IRQ masking, you can run the OTG
>> IRQ thread almost completely lockless ;-)
>
> Not a problem if we have the constraint that usb_otg_sync_inputs()
> needs to be called in thread context only.

that should be the case, right? If you're registering/unregistering
devices, you can't possibly call this from hardirq context.

>>>>> +	if (config->otg_work)	/* custom otg_work ? */
>>>>> +		INIT_WORK(&otg->work, config->otg_work);
>>>>> +	else
>>>>> +		INIT_WORK(&otg->work, usb_drd_work);
>>>>
>>>> why do you need to cope with custom work handlers?
>>>
>>> It was just a provision to provide your own state machine if the generic
>>> one does not meet your needs. But i'm OK to get rid of it as well.
>>=20
>> If you allow for this, every time there is a limitation, people will
>> just provide a copy of the state machine with a small change here and
>> there instead of fixing the real issue.
>
> I agree with you here. I'll get rid of the custom_otg_work.

thanks

>>>>> +static void usb_otg_start_fsm(struct usb_otg *otg)
>>>>> +{
>>>>> +	struct otg_fsm *fsm =3D &otg->fsm;
>>>>> +
>>>>> +	if (fsm->running)
>>>>> +		goto kick_fsm;
>>>>> +
>>>>> +	if (!otg->host) {
>>>>> +		dev_info(otg->dev, "otg: can't start till host registers\n");
>>>>> +		return;
>>>>> +	}
>>>>> +
>>>>> +	if (!otg->gadget) {
>>>>> +		dev_info(otg->dev,
>>>>> +			 "otg: can't start till gadget UDC registers\n");
>>>>> +		return;
>>>>> +	}
>>>>
>>>> okay, so you never kick the FSM until host and gadget are
>>>> registered. Why do you need to test for the case where the FSM is
>>>> running without host/gadget?
>>>
>>> That message in the test was misleading. It could also be a
>>> used as a warning if users did something wrong.
>>=20
>> this usb_otg_start_fsm() establishes a contract. That contract says that
>> the USB OTG FSM won't start until host and gadget are running and
>> registered, yada yada yada. Drivers trying to kicking the FSM without
>> calling usb_otg_start_fsm() first deserve to oops.
>
> I'm considering the worst case where OTG controller, host controller
> and gadget controller are 3 independent entities which can get probed
> in any order.

there is no such thing as OTG controller :-) Even in our wildest dreams,
the most we get is a multiplexer inside the SoC to mux signals to HCD or
UDC. DWC3, when configured as a dual-role-capable IP, has its own OTG
block. But that's all self-contained inside DWC3 itself :-)

> OTG controller driver doesn't really know when host and gadget
> register.  All it cares about is getting the hardware events and
> kicking the OTG machine.

Nothing should be kicking the OTG state machine anyways, until all parts
are ready, registered, running, etc.

> (NOTE: when I say OTG controller it might as well be just the
> dual-role bits that handle the ID and VBUS interrupts).

right

> usb_otg_start_fsm() is not public.
> usb_otg_sync_inputs() is the public function that the OTG driver will use.

the outcome is the same, right?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXZ+WlAAoJEIaOsuA1yqREoSwP/3yoysdwnuOIuMYI6UHvNKfQ
6sIXDS13sgfM4YbjDZ+CBob2pCA+O8gJ1/jZ1UtrZzmOg7c9rpeQmRWJFaoU6zG4
OhivdMAOSCzAzMQ63160IgPOT+yLsTjSjbgnXJiD35LluOb+o0bs7kcGHBuXrj3P
V1gaTQ59MJ/x4ay8GI6wQ1VJDPWVTXB+mzKUfqe398DgTKn9PO8zd65bPts6L7qc
JBuYis2vsax3jPLt+76FFpeFTIlQoanEWPk9y+/+nnu4Vwcj/vSGEXfXvPhtS1gJ
B1CA5+EJ4A4OwFmT6idx/SsekrFCe8/EikoVt5SGXsH96D9Djgx262zNb5OIpjwJ
TO0zg1V3jdqeInylDhxXMVpAivp+NSJRJOwE0/rZvjbJxCqxKfe2X6kjUmfoqnlg
Kl0S4YT5Io72q5FYAK3Lng7SZYvgkDBUpwfqWAgH8hGtao2UQn3hGf9YsnYL8UCw
WGhvWVQcqI7BN94NstJICc9nlmWRQS4qv7c/Avo4v/t6nbCPfGNLmGc6DYdu28cA
DKX8IZZM1gI5Hn3aZPVkg9ubnESoBVUr41/iDfPgmWFzfJK9U0GUUDKmCKynSlAg
H8b7d3Ge60+SoG6o5gfh4tcT2w8lOBm2v/ffgHpfVE2iicecdoGQ1/LAqSsLDC/n
EN0hSNO1QYUB0PB2QtfE
=Ymgw
-----END PGP SIGNATURE-----
--=-=-=--
