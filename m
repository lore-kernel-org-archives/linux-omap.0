From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/4] OMAPDSS: HDMI: change the timing match logic
Date: Fri, 18 Nov 2011 09:16:15 +0200
Message-ID: <1321600575.1814.14.camel@deskari>
References: <1321016977-1808-1-git-send-email-mythripk@ti.com>
	 <1321016977-1808-2-git-send-email-mythripk@ti.com>
	 <1321016977-1808-3-git-send-email-mythripk@ti.com>
	 <1321016977-1808-4-git-send-email-mythripk@ti.com>
	 <1321255999.1931.18.camel@deskari>
	 <CAP5A+B_8fm7unbvb9_=SC62v=3+XFcoOKKA2JOttQugRTPLW8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-kavR1o7cFXkq8x1RdVFQ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:38177 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751964Ab1KRHQW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Nov 2011 02:16:22 -0500
Received: by bkbzt4 with SMTP id zt4so3295830bkb.15
        for <linux-omap@vger.kernel.org>; Thu, 17 Nov 2011 23:16:19 -0800 (PST)
In-Reply-To: <CAP5A+B_8fm7unbvb9_=SC62v=3+XFcoOKKA2JOttQugRTPLW8g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: linux-omap@vger.kernel.org


--=-kavR1o7cFXkq8x1RdVFQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2011-11-16 at 11:01 +0530, K, Mythri P wrote:
> On Mon, Nov 14, 2011 at 1:03 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> w=
rote:
> > On Fri, 2011-11-11 at 18:39 +0530, mythripk@ti.com wrote:

> >> -static int get_timings_index(void)
> >> +static bool hdmi_find_code(const struct hdmi_config *timings_arr,
> >> +                     int len, struct hdmi_config *timing)
> >>  {
> >> -     int code;
> >> +     int i;
> >>
> >> -     if (hdmi.mode =3D=3D 0)
> >> -             code =3D code_vesa[hdmi.code];
> >> -     else
> >> -             code =3D code_cea[hdmi.code];
> >> +     for (i =3D 0; i < len; i++) {
> >> +             if (timings_arr[i].cm.code =3D=3D hdmi.code) {
> >> +                     *timing =3D timings_arr[i];
> >> +                     return true;
> >> +             }
> >> +     }
> >> +
> >> +     return false;
> >> +}
> >
> > You could return the hdmi_config pointer instead of making a copy and
> > returning a bool.
> In this function i'm passing the timing value and finally there needs
> to be one copy whether it is in this function or after the return,
> because the timings array is a const and dssdev->paneltimings and
> config timings are not, so do you see any benefit of doing that later
> or suggest any other method?

Well, I think it's just good design, even if it wouldn't help in this
particular case.

hdmi_find_code is a small utility function, and functions like that
should be designed to be usable in any situation. In this particular
situation you will anyway make a copy, and it doesn't matter if it's the
utility function that does the copy.

But in some other case you could perhaps be interested in only one value
in the hdmi_config that is found. In that case doing a copy is extra,
and it'd be better to return the const struct pointer.

Also, it is a standard design pattern that a "find" function returns
pointer to the found item, whereas your version returning a bool and
making a copy of the found item is not very standard.

 Tomi


--=-kavR1o7cFXkq8x1RdVFQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJOxgY/AAoJEPo9qoy8lh71E2UP/Aw6XPzoNigmNWu7jzlVIj5g
qy0jAe9k4PZ4owhPS2A39hN1fAZNITfTXrlSdeP3uWKV39QB6appI53CGUb/0zck
IUCWXzVv3anR9HAPdYKprU32S4JcYSBNAEgw74w+wDnW9Ia7z3K99ZXec/xoAeQd
I7GnUIktaUrFJBz9SKkgbXN4uYY6D2RZPmhoQ4BSdmA+tURrLV2lF05ExIKnb6N5
3ssYkwrtwa0lHNfm6RQA6Xq6vVbz1q2kfgM4LOySUZRk8g2ABaC8WkGRITbYjiOS
+pgfK0JnEtTyPPo+ySsglNlS2Z2j27KwKCyab8pNEQq3PfX5zzowAtTfKfczWhNw
ZUD3yvk2ahkv9RuYGtS9GphfaK4EChz7wLTu93GnQxHG82gHV6mUHBRF5EKqMkYo
FJjr4PHxC0fyqoUDiRvD1CqVGGWxSdTjPyjl2vTWnmyvd5jtd3FkjsFiJq4mfSUs
L6YizkQJ3TYHUccPTqczZoCCWHHMGNiKhCBOUQnyXst5HD/gf9jImuPy/KLxPcEu
X4Gs0M1Scxs5DTSXK/iZ1duUZaMRkBW5tVnsjYewmzmHyZ7Jdv/rThvmh5PLPjtI
wAMbKv/pajJ/EzlIvX6BFLT+LWapvuwUJfEWS5oUI4tuW+ah4qMjRVJ8pT38iBg5
GYBHCsv86QiWGDEEXEw+
=70xL
-----END PGP SIGNATURE-----

--=-kavR1o7cFXkq8x1RdVFQ--

