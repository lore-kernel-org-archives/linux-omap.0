From: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: USB regression in next-20171108 with hub spamming
Date: Thu, 09 Nov 2017 12:25:13 +0200
Message-ID: <871sl7sq9i.fsf@linux.intel.com>
References: <20171108230511.GY28152@atomide.com> <20171109080007.GA17098@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171109080007.GA17098-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> writes:
> On Wed, Nov 08, 2017 at 03:05:11PM -0800, Tony Lindgren wrote:
>> Hi Felipe & Greg,
>>=20
>> Looks like in next-20171108 USB hub is spamming console about once a
>> second after commit 7dfd74fd128 ("Merge remote-tracking branch
>> 'usb/usb-next'").
>>=20
>> Any ideas? See the log below.
>
> Any chance you can run 'git bisect'?

I wonder if it was caused by the usb_get_std_status() changes. We didn't
catch this in our testing, though. I left the patches in intel's
validation for a few days before sending out.

Let me compile that very tag and try it with one of our machines.

Tony, a bisection would be useful, indeed.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAloELQkACgkQzL64meEa
mQYG6BAA4BUV95tdYPBxbI7HlKyHrp0UghWbWdR13YhAV0sPkN/cSOkz0o+b4t4q
xtJkroES6PWUeb9+9H5pSQ8o912Cj7X4sYr/jWbEhqO1LqWmJRkPw4fFxIDHTfMW
a/Ky+Xc/blqH9PLD1TTVT+PiSStLMDi8CYGkWU9uDbmkdGuziBWMHT+lkl1eZIGQ
c4jCzKeITQbsbS9+U9nBAWJXUVCtF6lolxbrknSLBW9pfg0xGF0Bt6KPeJSoGHO1
CRrQqnHy+hrFh6XgTLfQV7lwoQV/pfLd4L+JDKw1SVa7FijrfAMvdLULt7A7bl83
prztAKNMkEBvlpTvGVTxvOUTrEoUWlOUkwFAP2VgTrHb97X03EaI8j4kGVd7seFA
N0Kqlwvp2yQtUN/QF533gCaAe2GwFItzawOPvdYQ81ZwmiGPV1thg+PySSd9e937
DnMfFJJK1JuRVokZaDZdKdGOg6goWX8I13UF3+IT7PJYiCAcsW9ZtrctPNuELFyU
L58TeepKWBu+v9b04c7I4LM83uokCuyH1xBdOJsaKL4oelKAkrwx9RPKaWQiE2KW
kyC5491u/JqLmgK76t45bNySoPOnzFpfdwEjK4WnpOgSlqVIL9+O1hFKHeXwqJX3
yQU0yly5CoOofYn9F3xVVeI8iNICF4LQECf/JHbqH+d7YtcaJ3k=
=G6yg
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
