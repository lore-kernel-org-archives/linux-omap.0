From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] usb: dwc3: drop FIFO resizing logic
Date: Wed, 10 Feb 2016 12:13:07 +0200
Message-ID: <87h9hgswjw.fsf@ti.com>
References: <1454588282-14383-1-git-send-email-balbi@kernel.org> <56B4C8B0.9070909@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56B4C8B0.9070909-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nm-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> writes:
> Hi Felipe,
>
> On Thursday 04 February 2016 05:48 PM, Felipe Balbi wrote:
>> That FIFO resizing logic was added to support OMAP5
>> ES1.0 which had a bogus default FIFO size. I can't
>> remember the exact size of default FIFO, but it was
>> less than one bulk superspeed packet (<1024) which
>> would prevent USB3 from ever working on OMAP5 ES1.0.
>>=20
>> However, OMAP5 ES1.0 support has been dropped by
>> commit aa2f4b16f830 ("ARM: OMAP5: id: Remove ES1.0
>> support") which renders FIFO resizing unnecessary.
>>=20
>> Signed-off-by: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>
> tested this series on both dra7-evm and dra72-evm using mass storage gadg=
et and
> msc.sh

both HS and SS ?

> dra72-evm: http://pastebin.ubuntu.com/14887997/
> dra7-evm: http://pastebin.ubuntu.com/14887975/
>
> Tested-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>
> Let me know if you want me to do any other testing on dra7.

yeah, run testusb for a week or so, that usually catches odd bugs.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWuw0zAAoJEIaOsuA1yqREpiUP/At8fiiC66kBsR0Cj453fqF9
NM1J+1ZWrECiSPEoS095ByULMe4EfUeKmJDDk1TFMJ6dqb2AYSctGmPblIMXAW7P
2dMb4v1rlppakvU3adoqwvoq5k7DEQIRcUt1ZJfqDfjw1De+s5sRm+bZXk6gsAad
DnG6HeCm5W2KiTdIgqKn2WQqYA12bLKC2LqcqzYYf9/lnvzw1ftREheUxBNdgijv
+CHEd63W2YWiNpx6Wzdvjnn4jPlERJ2ko2pz0D2WcelA66PVxBzwDg++BD9P8Un0
usmmdyhL7fZO900nEU8IMPM5NhNTsQBn/tkNWSKbf5tY9CDCeUHCA3XKmgzuZ6xA
p6ZwmzfMBFnPuWn8CaYy8/PKBaKQVDyRt8yZPVUYPxGDxnNhG6B6RGuHXH9tWKqm
SZI9JEkSllGe1F4u9NRtv8UR8HJCu1q1h9qxkID5kRhdQe5PEb8dU3Nnl4uyPSHY
X2ni+ruETTPzW3ZJXQob/ZlJeXa//KsDfoSOmw4M1Zh08gGh453Uihd+GSjMFPGC
xBpBeij7r7CHze6FFK/ujZGQnce1Jy5UMjDs+2bq7XSF8oP9iWNMJXDY6nfmOkG5
gJy0+ql5G2/R/2eL1brxXAp3CE92Y8EF6mMfqtGJMiJeaeF0V6su5SGuoxCyjzER
rSl32BmlHTQN9ICuA37K
=ZXUd
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
