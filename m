From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: Check if RPM enabled before trying to change
 state
Date: Tue, 26 Jun 2012 18:08:16 +0300
Message-ID: <1340723296.24530.68.camel@deskari>
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
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-80zzZQTrgji0x39llckN"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:46477 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757468Ab2FZPIh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jun 2012 11:08:37 -0400
Received: by lbok6 with SMTP id k6so239191lbo.4
        for <linux-omap@vger.kernel.org>; Tue, 26 Jun 2012 08:08:18 -0700 (PDT)
In-Reply-To: <CAJe_ZhcxVAUuuMDZ8p1LVae4N2aZb_vFs_nRLfb7atJ2j6j=Sg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com


--=-80zzZQTrgji0x39llckN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-06-26 at 20:19 +0530, Jassi Brar wrote:
> On 26 June 2012 17:33, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > On Tue, 2012-06-26 at 15:27 +0530, Jassi Brar wrote:
> >
> >> Seems similar, but I only tested OMAP4 HDMI.
> >
> > Would something like this one below work for you? It fixes the issues o=
n
> > my overo board.
> >
> I think this should work too (I will get to test it only tomorrow).
>=20
> Though I don't think it'll fix stack spew when run without
> CONFIG_PM_RUNTIME. Maybe we could simply remove the WARN_ON in the
> xxx_runtime_put() as Alan noted?

Yes, that's a different issue. I'll look at that also.

 Tomi


--=-80zzZQTrgji0x39llckN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP6dBgAAoJEPo9qoy8lh712mgP/1olGlAHvo/3WfArbt+lwVjF
hdHRTFLiVvvr0zmwNnARNNjDO0MzSEhOxWbeuIzJIwjLvQgUP9ZlhTct9Dh5Ch53
mCxO6NM0NvIsySdA1FgMGlYzO6+GYl4AW5RQNNlcP1Omh+0m2uJdtYXT5miFs35h
Goqbv+vv/14oUSGUAgeglFgIM1OIVm4FBl1yBsWyCVGJ6Je2gOYsuF4Z+3bQQGjy
ZSyx5lQM37Mu/Hoi746ffF/5TvBJkVqzZaNsCuTJvM8fQH9p1ICFvA6ZwVM3qPks
0lns8MDu7k1GYfa+MwtnyeLCp6mxE6dL8VnEtgPMjePdD3RjpLrIrtCfNBEr1gyu
2vep0b8eojoF/ZbnyGaByGR37qpU87pTtNu0w5ufqUIlrlB2m41TctKjREGXi+ea
HrizAgeL/xx3zIpkukGi7tcIo71PEmgNYHaYUX5zPfns5409TCP1XeGzuC7oliZG
arNol8tjw0DY2sgFTJfE2nUeZrpqYI88DZFv4SIxINyoqqrxQ7l4pvzpcCUG+zmf
2oDClrnoV8gdtyDgANf+JV9G8k4OV8aEy+lWayTNr9DrdahhsqyUzlr3+MOKRyOI
/lHQRdniVewengTJU/iP7Kpc9eVsN1EMI3Wzj6YeExyZm8rU4hd3tbDMHyhaZ4hc
j8B79RBDnCxK0q+NUAk1
=dmwQ
-----END PGP SIGNATURE-----

--=-80zzZQTrgji0x39llckN--

