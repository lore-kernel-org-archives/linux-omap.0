From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding
 names, pre-calibration, flipping and rotation
Date: Sun, 19 Feb 2017 21:15:16 +0100
Message-ID: <20170219201516.qw22o66t6zbolbgt@earth>
References: <cover.1482936802.git.hns@goldelico.com>
 <9830dd21e6425e3a866fac6ed4cc73ddd58b719f.1482936802.git.hns@goldelico.com>
 <20170128193342.GB38136@dtor-ws>
 <1F6355E1-A5E3-41A6-908F-619A15581BEF@goldelico.com>
 <20170217204041.GE13050@dtor-ws>
 <20170218032233.3qh5xdjbx5kkq5hm@earth>
 <95E59EB0-6F96-40BB-B74C-9CD56DDD7783@goldelico.com>
 <20170218234422.vza3toc3bphixsdn@earth>
 <FA96689F-AFD0-4FC9-95D9-639299341C8B@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zulpmivijevx4q4s"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <FA96689F-AFD0-4FC9-95D9-639299341C8B-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>, Eric Engestrom <eric-op+oiCINJLTt9jDmeYuA0g@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Petr
List-Id: linux-omap@vger.kernel.org


--zulpmivijevx4q4s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Feb 19, 2017 at 01:07:26PM +0100, H. Nikolaus Schaller wrote:
> I don't really remember when we noticed it first. Maybe it was
> back in tslib times some years ago where setting the sensitivity
> threshold made problems. We then carried along our patch for a
> long time in our local repo (and modified it several times) and
> only started upstreaming some months ago. [...]
>=20
> AFAIK, GIMP and for example https://sourceforge.net/projects/xournal/ app=
ear
> to be able to handle X pressure, but I haven't running and tested either =
one
> on our devices. Pressure is used in such drawing tools to simulate that s=
ome
> physical pens make wider strokes on higher pressure.
>=20
> This seems to indicate that X can handle pressure in a non-boolean way, b=
ut rarely does.
> Especially I think the usual menu, click, drag, scroll gestures are only =
based
> on BTN_TOUCH status and not on ABS_PRESSURE. So it is rarely noticed to m=
ake
> a difference.

ok.

> >>> I suggest to put the resistance vs pressure thing in its own patch,
> >>> that also fixes tsc200x-core and merge it to linux-next after the
> >>> merge window.
>=20
> Ok. I will propose a patch.

Thanks. I suggest to add this in the patch description:

While this patch changes the values reported to userspace,
ABS_PRESSURE is used rarely by userspace. Most software only
relies on BTN_TOUCH (boolean), which is not affected by this
patch. Some graphics software makes use of the interface and
does not work correctly with the currently used inverted
behaviour.

-- Sebastian

--zulpmivijevx4q4s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlip/NIACgkQ2O7X88g7
+pqbxw/+M2raWSxha1mcTTVRuTyPtu5cQsdkJo/WvFia03fMJnvsL5BBzHaYnaoJ
wBNZUWGthQY1NOw0C9vCyjP7cslKK8V+2JwdlrHF7v7fbwsRLnwGYuS0dqpJbeZH
dtrA6DYvT10w5nHWlxeObh/eiK0Q4yMPq7D1Ku2wugi2k6Y1QKeQd6pBEd5jlhUM
7zkWcl0llKDYY1Ly0+ayi+DhBrcw9Q09hE7Jf9lrE/4mLrtdReLCZFY5naGScDBi
fVSaNmW3Upx6YLfI/ZUPUnVXmoUEEB3JnKZHLRe0pvaDyI90PNXL9j3S+EAyIlTG
+T6s2FVwo0twGs6lu5vD+AkISCFe9XPSTaSaOT32VcuPjtgaQBVX/O4vCLqfT/Jy
yo5NqswAiRn316yw42A5TtakoXg9RHhXTxFSG+IjIp0a2N9/iY4zpkvF2sBfxBge
p01b4WyqYtMVWAeCcQySoTNRexdiiDe0IXapec0fsUgzzvmzunRMdWu0AA1skM8M
G08oguPyFK541ZSsRD1abEmPqRUUckic60Fvlks3Xj3YDPswPmzGSdvL73kpc9bh
RRoOMcL4pVqAkgPJ55GY7UQOko4xAL5DABiEPfoK0uibpWAXDP785/diAXPrdWn9
rvIGisEtqz5YccmM80zrdHhtSwOYxeEv/7/JgdWKRH7/d92FfXg=
=wT++
-----END PGP SIGNATURE-----

--zulpmivijevx4q4s--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
