From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: Check if RPM enabled before trying to change
 state
Date: Tue, 26 Jun 2012 18:11:54 +0300
Message-ID: <1340723514.24530.70.camel@deskari>
References: <1340438771-25587-1-git-send-email-jaswinder.singh@linaro.org>
	 <1340605221.12683.30.camel@lappyti>
	 <CAJe_Zhf-H0dLtFsFAcryDy3av60RjmWmP+d3GSaxq8dNZKiXWw@mail.gmail.com>
	 <1340616643.3395.19.camel@deskari>
	 <CAJe_ZhftuNggxH+269-ZJbWJo5nSzSjo1dDCTQGMbsjPWoUpyg@mail.gmail.com>
	 <1340628094.3395.63.camel@deskari>
	 <CAJe_ZhetdEwrgDEfV9rLHU1_fmb3O+954hCKcoENBgQ6Bi6BXQ@mail.gmail.com>
	 <1340632161.3395.100.camel@deskari>
	 <CAJe_ZheHoCikVzy6zJoKHuL8_oQ0ZnPASUUWimvbPRr+AZ4zWg@mail.gmail.com>
	 <1340695166.2093.22.camel@lappyti>
	 <CAJe_Zhev3V85K1jhj+W+d+0kv132MZ=-7rChhCLgtWO7WN4u1w@mail.gmail.com>
	 <1340701660.24530.17.camel@deskari>
	 <CAJe_Zhd-LA67yO-H_7pacB_T8_z6=Zf47QuoHSJcsXDZ9S+byw@mail.gmail.com>
	 <1340712213.24530.21.camel@deskari>
	 <CAJe_ZhcxVAUuuMDZ8p1LVae4N2aZb_vFs_nRLfb7atJ2j6j=Sg@mail.gmail.com>
	 <1340723296.24530.68.camel@deskari>
	 <CAJe_ZheMN_sqaANSMepmhDDp2a2sQAVPYD1-owBWpwwbxqAtHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-j3/ILLjQocy97i5AyV2l"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:58094 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757370Ab2FZPL7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jun 2012 11:11:59 -0400
Received: by lbon10 with SMTP id n10so353587lbo.27
        for <linux-omap@vger.kernel.org>; Tue, 26 Jun 2012 08:11:56 -0700 (PDT)
In-Reply-To: <CAJe_ZheMN_sqaANSMepmhDDp2a2sQAVPYD1-owBWpwwbxqAtHQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com


--=-j3/ILLjQocy97i5AyV2l
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-06-26 at 20:39 +0530, Jassi Brar wrote:
> On 26 June 2012 20:38, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > On Tue, 2012-06-26 at 20:19 +0530, Jassi Brar wrote:
> >> On 26 June 2012 17:33, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> >> > On Tue, 2012-06-26 at 15:27 +0530, Jassi Brar wrote:
> >> >
> >> >> Seems similar, but I only tested OMAP4 HDMI.
> >> >
> >> > Would something like this one below work for you? It fixes the issue=
s on
> >> > my overo board.
> >> >
> >> I think this should work too (I will get to test it only tomorrow).
> >>
> >> Though I don't think it'll fix stack spew when run without
> >> CONFIG_PM_RUNTIME. Maybe we could simply remove the WARN_ON in the
> >> xxx_runtime_put() as Alan noted?
> >
> > Yes, that's a different issue. I'll look at that also.
> >
> Well, my patch took care of that also. But I agree, that could be
> added separately as well.

Well, I don't agree that your patch is correct =3D). I don't think it's
right to skip runtime get and put when pm_runtime_enabled() returns
false.

 Tomi


--=-j3/ILLjQocy97i5AyV2l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP6dE6AAoJEPo9qoy8lh71Je0P+wdrtfhUe5FBhPiQI7KVuwh9
ATT9ObxqXUlXi6H6MP5lD54P7QYvlvYRT7dtThc9p/yV7axZbpLJkBflAmViKFu+
igiWY1p3FMc/eYjseQvZootXiLnNLBLS4LkWLpzltL2bCDc+moAgIj7hc7pJeQZ4
UOWXnd0nYFyeZ6NpPECg29PnnIFEGyIttqKTA3A+6QOjj1VTe9Fc1RuNifPnrPg+
sTmSb1EjHDm4Y5VedabBttxszd2snl06fqOwP+34J+oF3nAh0feZiA7NzrWlB7sc
QRNOlgR6EEozwY8O7RsAnzKHI3lwAjbgnKFn+fJ6UDX6l4ZYGD/9FkRlcVtrp3qW
bHnaQcI+HH7HWXbKvIZQu+9P4WZUZH3E+xWc60KKwGUFmkf7cs0pdADedmYMyheQ
59Dnpl8qSPbdoHL3USpMzWLWkc9RyZJgZqNpOub0qy1shb0QBS6JQN9nIJnaLUey
848e2TL9zL1ClTMly/Gcjdj29Gg7gba+x2uGPm+NLXsZwDScjo40mJg3WuVP+zxr
kNdy8kzvUyqcglLXlU4kwb/qwlvysT+OHsrD/MioRJdQWtipJCAUWamYOXmjwi3D
xhdr8LRIZubtiUpH59urSqTpCmvOlmHj5IPdk8ai6cGEutCp+VIXP6JxnkadMwVE
kzC5oQUSnheKkRYSEOOx
=5pAv
-----END PGP SIGNATURE-----

--=-j3/ILLjQocy97i5AyV2l--

