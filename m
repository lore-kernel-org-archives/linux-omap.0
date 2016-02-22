From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] usb: dwc3: drop FIFO resizing logic
Date: Mon, 22 Feb 2016 10:37:17 +0200
Message-ID: <87vb5hnnsy.fsf@ti.com>
References: <1454588282-14383-1-git-send-email-balbi@kernel.org> <56B4C8B0.9070909@ti.com> <87h9hgswjw.fsf@ti.com> <56BB0E2D.1030600@ti.com> <56CAC1F1.7010408@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56CAC1F1.7010408-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nm-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> writes:
>>>> On Thursday 04 February 2016 05:48 PM, Felipe Balbi wrote:
>>>>> That FIFO resizing logic was added to support OMAP5
>>>>> ES1.0 which had a bogus default FIFO size. I can't
>>>>> remember the exact size of default FIFO, but it was
>>>>> less than one bulk superspeed packet (<1024) which
>>>>> would prevent USB3 from ever working on OMAP5 ES1.0.
>>>>>
>>>>> However, OMAP5 ES1.0 support has been dropped by
>>>>> commit aa2f4b16f830 ("ARM: OMAP5: id: Remove ES1.0
>>>>> support") which renders FIFO resizing unnecessary.
>>>>>
>>>>> Signed-off-by: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>>>>
>>>> tested this series on both dra7-evm and dra72-evm using mass storage g=
adget and
>>>> msc.sh
>>>
>>> both HS and SS ?
>>=20
>> yes.. but the logs here were for only SS.
>>>
>>>> dra72-evm: http://pastebin.ubuntu.com/14887997/
>>>> dra7-evm: http://pastebin.ubuntu.com/14887975/
>>>>
>>>> Tested-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>>>>
>>>> Let me know if you want me to do any other testing on dra7.
>>>
>>> yeah, run testusb for a week or so, that usually catches odd bugs.
>>=20
>> Okay. I'll start the test before I go for vacation next week.
>
> Looks like the test couldn't complete and I see dumps [1] in my host
> PC. Here's the output of testusb [2].
>
> [1] -> http://pastebin.ubuntu.com/15169114/
> [2] -> http://pastebin.ubuntu.com/15169116/

Does this also happen without this patch applied ?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWysi+AAoJEIaOsuA1yqREjcUP/3JmvBLKE6W7hj7onRmdoCS5
9xmclMyug39xOKsvV6kipYdEqMiI2H4xibhRCtgvOjdKE9Cyu690hhaBqvCnyT0z
vvrciL0eudgXeCqDcHXHD7V7ncn/rcZcjrGmok5k9Ek5FOHKu1uWvDNcyJqEraDB
exxTRbZNNYeRktxcve79yisbpVkITIPpHkQ4s0AczwA/K074YZNnyr/aESIu9Cga
TTxvIGhNLTYgNg/hcKoYGgqC0JpDC+gG6hq4c9teSSm3oI7kLBeScemVxi98I+M3
Ywtd2v0tAKQjjmPxGMfYYYr2Xbl0DMkWg+yWvZjrB9FyZRU/FZMXwxfBPgpmJ9M9
sr0aCgfrSn8O8fzXY4JrPjsJ9bSVpfn1QglIlk3YbSCnNZabA3RvwUqjX8wvWVct
TjNaEkDoF1lA087BJPEeCSYqr+GYz/KypqTpWC1P2wVXdCjiA8q/mvoM+KReCOD7
N8ztnyACEhN5S8v1cK+97qAkXXAIno4+mG/K2G72I8qOPGUURH8TFzGgdxVfYP6a
+JZOtKQSPZ+LdQRRrqBmYYXxAKtz/VnAm1MoHg3NHnHIUE0MMvY1H5I23gxx5RlB
YEv7oJjGQhz/xwJGSqSelO2XmzVXNgBn3qNklcc99WSu5elLx8bbyOwG/8H9ZCp3
QNPiu7UVNG7bNOYDOmTG
=jxh+
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
