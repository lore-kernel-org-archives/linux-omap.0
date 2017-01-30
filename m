From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: dwc3 gadget breaks on system suspend/resume
Date: Mon, 30 Jan 2017 14:59:04 +0200
Message-ID: <87o9yo66w7.fsf@linux.intel.com>
References: <54bdc1b7-69ed-d580-fd17-3e7499ac1c27@ti.com> <87a8anjm5z.fsf@linux.intel.com> <a0cc2705-b1f5-7b6e-d73c-ff9b525eead2@ti.com> <e64bc4ee-1c71-d72c-cdc7-f5857f49a90e@ti.com> <87inp07fkx.fsf@linux.intel.com> <57fbf2b6-3811-3202-0e69-7cf82662d50f@ti.com> <8760l07dfh.fsf@linux.intel.com> <87wpdg5wtx.fsf@linux.intel.com> <a91c7564-5bfa-c77f-8fa2-1c1b0bcfd815@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <a91c7564-5bfa-c77f-8fa2-1c1b0bcfd815-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb@vger.kernel.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
>> (hmm, I didn't receive your reply in my intel inbox, only
>> gmail. Odd. Replying to myself here, but it should be on your reply,
>> rater).
>>=20
>> Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> writes:
>>>> The previous commit c499ff71ff2a281366c6ec7a904c547d806cbcd1 is fine.
>>>
>>> okay. Then let's try to figure out what's going on. A diff of regdump
>>> before and after suspend/resume might start to give some clue about
>>> what's going on. DWC3 tracepoints should help too. Care to get those?
>>> BTW, is this dwc3 as host or peripheral?
>>=20
>> You don't have any endpoints enabled:
>>=20
>> -DALEPENA =3D 0x0000000f
>> +DALEPENA =3D 0x00000000
>
> Thanks for the hints.
>
> This problem is because reason dwc3_gadget_run_stop() is timing out
> during the suspend sequence and so dwc3_disconnect_gadget() and
> __dwc3_gadget_stop() are not being called.

I see

> dwc3_suspend() does not consider dwc3_gadget_suspend()'s return value
> and happily continues suspending the machine.
>
> If I force dwc3_gadget_run_stop() to return 0 then everything works fine.
>
> Any ideas why DWC3_DSTS_DEVCTRLHLT is not getting set?

no idea. It should always get set when run_stop is cleared. Can you
check if suspending with cable detached has any difference?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAliPOJgACgkQzL64meEa
mQYdGw/7BxxlL5DDlgXZFQuAgWAGddsvgYv7Awp5nXkTBaJFnU9YI/flp86ySkSD
05PcOexydpZhxRsGPrwwosxQU82L1jhvLKV8RCjTu0ujFaBIhrwpyPpoihFNd4Er
V/F6Wv44B1J7CeJNXrzRsSmi0XuscJRYm4PEDcarnvMH+CcWOYP87m0fJ1U1nUwV
bSjrRmWwi+le0yf1n4CZAzPEC+mw3nMyfV4iQZpx7cWUrqBpKC8/pUhFDQ+RmNa6
OUbPZ1VmV6P+D3zEc5LD+wCrOebJCJhhfRLIBWsyx058ZygcK9SgojhDnBCshVLb
5r+xmA1X3xNDmtoeb1Pf3zWDYfzbrYDVIwvJcdb497fqFuCIKXTehyZkV3ClxzVX
dHXxivq2UxIv41uWX1s49GLF5u0wehXqlrq0iSSrcVTxiGBQaiAThGHjgdOxkNTo
6dfPs0dehHURTIWnrMk5wO399U1yqckKMB1Fgv2dWfetjdss9aqw4i7Ee/gAoT1d
q1RIE+EdxtO0G8dsOlAlo7jgyW0NL839Y4hZyyKbSNPvUdADUO74umomqQjai7Mh
4E35uYeL7fWjavi/XcfVisfw6R2qhGWblEU4gMcnIHPkDobDqQIbVTTPjFzwaprF
B8zxxBq5z2IwQyi+ZdgxPnc7yNlru0Nu8qA9RLeGE8iQ5sEb2p0=
=0URX
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
