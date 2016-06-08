From: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [balbi-usb:testing/next 64/67] phy-generic.c:undefined reference to `usb_gadget_vbus_connect'
Date: Wed, 08 Jun 2016 13:32:29 +0300
Message-ID: <87bn3c9dj6.fsf@linux.intel.com>
References: <201606062026.EQTlXIDR%fengguang.wu@intel.com> <87bn3ecwbz.fsf@linux.intel.com> <878tyicva6.fsf@linux.intel.com> <20160607015405.GB17095@shlinux2> <87wpm1basy.fsf@linux.intel.com> <20160607095008.GC17095@shlinux2> <87inxlb8nm.fsf@linux.intel.com> <20160608031732.GA5309@shlinux2> <87shwo9fge.fsf@linux.intel.com> <20160608101428.GA7653@shlinux2>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160608101428.GA7653@shlinux2>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Peter Chen <Peter.Chen-3arQi8VN3Tc@public.gmane.org>, John Youn <johnyoun-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, kbuild-all-JC7UmRfGjtg@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
>> > Would you consider only keeps vbus and pull dp API at gadget.h, and mo=
ve
>> > out others gadget APIs which is dedicated for gadget function?
>>=20
>> no, sorry :-) All these drivers depend on the gadget API to work. For
>> host-only builds, they'll still work because of the stub implemented in
>> gadget.h.
>
> Do you want these drivers to add dependency on GADGET at Kconfig
> or not? If you want, we don't need stub at gadget.h since the gadget

just look at what the patch does:

if USB_GADGET=3Dm, then NOP must be m too. if USB_GADGET=3Dy, then NOP can
be y or m.

> will be built if these driver is built. I assume you don't want, then
> that's ok, we don't need to change anything on Kconfig to fix build
> issue.

There was, anyway, a bug in my original patch in that it didn't provide
stubs for cases were USB_GADGET=3Dn. That bug is now fixed, I'll still
wait a couple days for any 0-day build problems.

>> Also, did you test the version I've apended to previous email? I noticed
>> that had one extra mistake which I correct in the version below:
>>=20
>
> Sorry, I did not try since I still have some questions for solution:)

heh. You're not even willing to try a patch, rather than complaining
about pointless stuff all day. Thanks

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXV/Q9AAoJEIaOsuA1yqREKOsP/Rp0xgGIhNnby24oyod/t6yZ
K6ExRnwc6HGqbIL3dQu7zFfqQz6AfnoQwPEpFNydaBh8gTDpcto+/5vKQPrKaXHa
Sr6VlAFMsT35hhktUlvW2JPRuXzCBLoMiEybR22FO2/GQixGw6mphvQcfxPyQvzn
oZGa4YTlJfRrwxBthtanP+6LWV7A5rvpUq5qYI7ExXk7Qt/1GV69ElSVm71a14XP
TKYikEKnhJcQsv5ZCL7QXSWDiNqJ9sd9JX3LP5Msw+sct3x4Fx7bfOxHEXqyy42S
BeL+wEKJP81nmPf07Axm6mqu9miB0HViAS0SVan63isedtUZ4/ai8QXo55j/vD+o
Dm9N5WFqqV3zBv6xMy+UPsIXG/cZsLf4KZ3n57yIHbFxqaYhWsncXY2LYte7KPTl
ofpEYq10erwQAgLCA6DHr7rDGPh9KU3FQejnr9ZM+ia0eCAnX5C5u7sj8uTknJH/
icbqlJsPRO++CqYfu1YGBOyN0UjHQhS0gdr3zSwVQuT8p1Pq2OYLB3XBqnx5MbfL
6hJwrzOuB5b2D/R0JAw13szB4mPvLAguO2XTKKF9lDfAQDMCCNjUJlG492qM/m6n
8FM6yWVMQ4KPHdxam9kEuOYsHmFoxVdD9z6cbEaJS4/ikIpPLU0UmD4OtbcCnqFI
E/Ytb9FD3Ku8/agQhZf7
=I7RE
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
