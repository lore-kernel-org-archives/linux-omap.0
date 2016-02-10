From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] usb: dwc3: drop FIFO resizing logic
Date: Wed, 10 Feb 2016 13:26:36 +0200
Message-ID: <878u2sst5f.fsf@ti.com>
References: <1454588282-14383-1-git-send-email-balbi@kernel.org> <56B4C8B0.9070909@ti.com> <87h9hgswjw.fsf@ti.com> <56BB0E2D.1030600@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56BB0E2D.1030600-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nm-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> writes:
>> Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> writes:
>>> Hi Felipe,
>>>
>>> On Thursday 04 February 2016 05:48 PM, Felipe Balbi wrote:
>>>> That FIFO resizing logic was added to support OMAP5
>>>> ES1.0 which had a bogus default FIFO size. I can't
>>>> remember the exact size of default FIFO, but it was
>>>> less than one bulk superspeed packet (<1024) which
>>>> would prevent USB3 from ever working on OMAP5 ES1.0.
>>>>
>>>> However, OMAP5 ES1.0 support has been dropped by
>>>> commit aa2f4b16f830 ("ARM: OMAP5: id: Remove ES1.0
>>>> support") which renders FIFO resizing unnecessary.
>>>>
>>>> Signed-off-by: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>>>
>>> tested this series on both dra7-evm and dra72-evm using mass storage ga=
dget and
>>> msc.sh
>>=20
>> both HS and SS ?
>
> yes.. but the logs here were for only SS.

cool thanks. Did you notice any speed regression or is it all the same ?

>>> Let me know if you want me to do any other testing on dra7.
>>=20
>> yeah, run testusb for a week or so, that usually catches odd bugs.
>
> Okay. I'll start the test before I go for vacation next week.

great

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWux5sAAoJEIaOsuA1yqRE7BoP/2o1MFqSZxTewo48kEM4eCjR
1+8FYRisGUxsdNq3xKbeBXRm9BXaj6ARtSs3bUo+9oHA2UC53olXUr9h3678TqJg
bnlC+IS7DVO6fLmbEsj/m1AzFFWHeiDSHNFmU+c1PdPi/4Tty1/UkYaRRpck6Tha
+0G4RX2F2pGOcyEfnVimlQ99Ujx9nKqLPRPCNAYM5ko6cift9pSt4FyXYhTXKwJ5
YseCw7JqF8ugib0evejrIO+3ARGrkIbiCWcuvZ+wHdqctDTq5vItks+U7hbr5+60
F+jEHMJCSUTV2ip3oZH7sYZBqsTTOjRkJWpIQzQWDHQFg8i/Gs1OCwAKnq2JlFlZ
V9Mb1qirgI1MVU/ErC7ipI1Diurxm0yAr1rK9manqDCbAcP0ALIIWSYsaLblXeWB
G0vpgslR4yPlbYws4r20nTaEExNeIlLnBI9jupppJJIIR207P5BrczibdHcQJeOl
WW/Cwd4FnrSoUMfAKsGeVw0XQ1vbn9JBSol64C3XrqMEiDbYBEAfn85YWct5UahS
e3XG6DJO+3Mq9wYQ5p2Fw418QF4SAOn5gYWDpllDUWHnlwL1wN0lxrLsP4flG91h
pYC1IQ4sAuRAN66lyRTPVlDhs2QH+OuKQV10VCf27MjjJRwuuJQIpLxqN/MRnsek
U89hRz/rnS7g7nP+/aAc
=S565
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
