From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v10 06/14] usb: gadget.h: Add OTG to gadget interface
Date: Mon, 20 Jun 2016 12:24:53 +0300
Message-ID: <87inx4qkka.fsf@linux.intel.com>
References: <1465564043-27163-1-git-send-email-rogerq@ti.com> <1465564043-27163-7-git-send-email-rogerq@ti.com> <87k2hkxr4d.fsf@linux.intel.com> <57679B30.6030809@ti.com> <87d1ncxopa.fsf@linux.intel.com> <5767A87C.20704@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5767A87C.20704-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
>>>> Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
>>>>> The OTG core will use struct otg_gadget_ops to
>>>>> start/stop the gadget controller.
>>>>>
>>>>> The main purpose of this interface is to avoid directly
>>>>> calling usb_gadget_start/stop() from the OTG core as they
>>>>> wouldn't be defined in the built-in symbol table if
>>>>> CONFIG_USB_GADGET is m.
>>>>>
>>>>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>>>>> ---
>>>>>  include/linux/usb/gadget.h | 16 ++++++++++++++++
>>>>>  1 file changed, 16 insertions(+)
>>>>>
>>>>> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
>>>>> index 2dd9e6b..f4fc0aa 100644
>>>>> --- a/include/linux/usb/gadget.h
>>>>> +++ b/include/linux/usb/gadget.h
>>>>> @@ -639,6 +639,22 @@ struct usb_gadget_driver {
>>>>>  };
>>>>>=20=20
>>>>>=20=20
>>>>> +/*------------------------------------------------------------------=
-------*/
>>>>> +
>>>>> +/**
>>>>> + * struct otg_gadget_ops - Interface between OTG core and gadget
>>>>> + *
>>>>> + * Provided by the gadget core to allow the OTG core to start/stop t=
he gadget
>>>>> + *
>>>>> + * @start: function to start the gadget
>>>>> + * @stop: function to stop the gadget
>>>>> + * @connect_control: function to connect/disconnect from the bus
>>>>> + */
>>>>> +struct otg_gadget_ops {
>>>>> +	int (*start)(struct usb_gadget *gadget);
>>>>> +	int (*stop)(struct usb_gadget *gadget);
>>>>> +	int (*connect_control)(struct usb_gadget *gadget, bool connect);
>>>>> +};
>>>>
>>>> you shouldn't need these at all. They are already part of the gadget
>>>> framework as ->udc_start(), ->udc_stop() and ->pullup()
>>>>
>>>
>>> This is to avoid the undefined symbol errors during build when OTG has =
is
>>> built-in because USB (host) is built-in but GADGET is still a module.
>>=20
>> change your Kconfig dependencies. OTG layer shouldn't be built-in unless
>> both Gadget and Host are built-in.
>>=20
>
> That is only one side of the story.
> What happens if OTG is (m), Host is (m) but Gadget is (built in).
>
> Gadget build will fail because of undefined symbol errors for all of
> the OTG APIs.

So you created a circular dependency, right? That's not good either. I
suggest you clean that up because this is bound to create randconfig
build problems in the long run.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXZ7ZlAAoJEIaOsuA1yqREfYkP/R1xSGTH10UaHaKzuRE/OYja
7qonpnHP0lz/TxQg/A/ZzPyMUIZESJ1ls6qZHpMY1w2pg+9jO5BuhkvmOD/HA3pf
1E4fPnlL9M/6yCyWYLbJB7A86p9MjMg43RSty2rqyVoVDtT/+KPvkht6Fq0FVBiU
0zXqz6t3Zi/jmgXK3qFcFCoB0sIMN5M4UJbrksyx0Mi7doIWX26hRRmMR3+PkZT6
7oT+hbXLN1KP7OzNzJ9lq5POZz0P3oxMxUDKStZgP16DAzLTQTIQOd/Vjg0NRGfM
kfwH/dcLvLVlaRET+K9WsauTr6mcz7IuPkFMKekASO1HHTW39usF/7Rhcx9Px/gE
Ww2ZeUpEhnefkCmig0V4XzX1KRnBE+c32/60mpNdUNDYonDkRaRNHblvtktkQXaG
9eX5s+Vu7+wjWWSQVg4GdoYb0qK/uiQGEFhYWI6IUq5CqPDKbdMu9HS0Nf2sIjdS
waw46DlJ7SThWP+LqmiEtQzedNCCGt/YshjCnaHKCtfKqTPh9GMEXudB/0fXiELz
B/OZnE/kz+mlJVFHl2hgf/LUa6oxo8uTFf5+Ptu+CXXOdFIfKIwr3qoj5Y695rIa
VbN5cdl8dVD+G8xERMV+L32ngHEeUvfP/QJ0l68pFpxf8+JKVDVYYGCBLIuQKt9G
+GJ+9D5OlvSzl2tpOnhy
=FpJd
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
