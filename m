From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH] usb: isp1301-omap: Convert timers to use timer_setup()
Date: Tue, 17 Oct 2017 12:42:31 +0300
Message-ID: <87d15mjek8.fsf@linux.intel.com>
References: <20171016232923.GA101254@beast> <87376ikxez.fsf@linux.intel.com> <20171017085243.GA9776@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171017085243.GA9776@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <keescook@chromium.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>> Kees Cook <keescook@chromium.org> writes:
>> > In preparation for unconditionally passing the struct timer_list point=
er to
>> > all timer callbacks, switch to using the new timer_setup() and from_ti=
mer()
>> > to pass the timer pointer explicitly.
>> >
>> > Cc: Felipe Balbi <balbi@kernel.org>
>> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> > Cc: linux-usb@vger.kernel.org
>> > Cc: linux-omap@vger.kernel.org
>> > Signed-off-by: Kees Cook <keescook@chromium.org>
>> > Acked-by: Tony Lindgren <tony@atomide.com>
>>=20
>> do you want me to take this through my tree?
>>=20
>> If you wanna take through yours, here's my ack:
>>=20
>> Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>
>
> I'll just take it through mine, thanks :)

thanks for confirming. Dropped from my queue.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlnl0IcACgkQzL64meEa
mQZsqRAAuTwaibtx+l0AGHlmAhQAhUc/CiPVA7x83+AZVR8B0rcwSU4Moydbqu77
piO7dAJ/fpqbcCE/A5l7wxvtdeCnNortOjHsRxR9PGXlg8Jwm0BVBPCJTjQuNV0B
h/PT5mZRdSogsqYUy4N2LNlTL27W3l13LTBe1NxjOzczZ4h8mEzQZ4Mw09ilv566
QPLQ9Gt965p3+H3ftlUsqXWCOmRBps0hYzqLoWFSRnKHlFZFiE6WIo17O5BNCoin
GMIz9lDcsCZB18zc+aqJHCgmQf1LpIwbvKlA780/gai36hL1yZUIkMWpQ6QkugPE
3MDHPrm1Ne0BGphvDznwKyZb5ZWmXqZxbiNizB7iaaGwB1Odv5xUPD+cFB3sr74w
5YEfyoalqT45wI537C2Zxrm7pUOSq6ydl0gF0glU8TFFgvxJTP3fwJ+VRxrp7DPj
cEjXgtI0Q/O0XNmzIhpw0dCDgYvayOErHL1pedZxMIDitxgCTweMt96HA0VGPII8
f3McSxg1kdXG+Gwt+3QZQgiAGDAkyGRreAfeP/g7uJyWLAORKVg8vN65BFB4UOTG
3ligxPU13qxq835BHtUSfrzqw+ZmSv4KnMpqBY9i9WbBg5RdjmtMYvK7q8ITBHxd
pouHpJ2u1/mxbXGNgD2ZR81JLItGtTb0dreRFifrb1LeHaPtw34=
=Xpzb
-----END PGP SIGNATURE-----
--=-=-=--
