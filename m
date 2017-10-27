From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCHv1 00/14] omapdrm: DSI command mode panel support
Date: Fri, 27 Oct 2017 20:00:35 +0200
Message-ID: <20171027180035.i5iwyzxt7duhvz4w@earth>
References: <20170724173311.27170-1-sebastian.reichel@collabora.co.uk>
 <20170929132649.63dy7mzjgknaevoa@earth>
 <b66ec006-e998-b8c6-8ef1-5bf19208c100@ti.com>
 <20171013171207.GO4394@atomide.com>
 <20171023220100.cso5sbxcx7itcj5r@earth>
 <d96752eb-45a0-9766-0022-7eb1594761af@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qxdfpo2r2ej5lj2t"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d96752eb-45a0-9766-0022-7eb1594761af@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--qxdfpo2r2ej5lj2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 26, 2017 at 02:59:10PM +0300, Tomi Valkeinen wrote:
> On 24/10/17 01:01, Sebastian Reichel wrote:
> > Hi,
> >=20
> > On Fri, Oct 13, 2017 at 10:12:08AM -0700, Tony Lindgren wrote:
> >> * Tomi Valkeinen <tomi.valkeinen@ti.com> [171012 01:46]:
> >>> On 29/09/17 16:26, Sebastian Reichel wrote:
> >>>> Hi Tomi & Laurent,
> >>>>
> >>>> ping?
> >>>
> >>> I've been having quick glances at this every now and then, but I'm not
> >>> sure what to do with the series.
> >>>
> >>> We have one work item that more or less overrides everything but
> >>> critical fixes: moving to common DRM encoder/panel drivers. Anything
> >>> that makes that work more difficult should be postponed.
> >>>
> >>> Especially patch 6 in this series most likely falls into that categor=
y,
> >>> and might require a very different implementation with common DRM
> >>> drivers. Also everything in panel-dsi-cm needs to be ported to a comm=
on
> >>> DRM panel driver when can use them.
> >>>
> >>> So my gut feeling is that it's best to keep this out for now, and rew=
ork
> >>> it after Laurent gets the common DRM drivers working with omapdrm.
> >>
> >> Laurent, got any other comments?
> >>
> >> Maybe some of patches can be already applied to shrink down this
> >> set a bit?
> >=20
> > I talked with Laurent at ELCE about this patchset and he is fine
> > with this series going in before his work assuming its fine
> > otherwise. He has not yet reviewed it, though and is busy the
> > next two weeks.
> >=20
> > Regarding the panel-dsi-cm porting work: I will take care of this
> > once the driver uses common DRM drivers. I don't expect major
> > problems once omapdrm implements common drm's mipi_dsi_host. I
> > do use the standard DT properties already.
> >=20
> > I do agree, that not applying this series makes Laurent's porting
> > work easier, since he can rip out all of DSI. It's not used by
> > anything except panel-dsi-cm, which is broken without this patchset.
> > I don't think that's a fair thing to do, though.
> >=20
> > P.S.: I got asked by different people about the status of this
> > patchset, which is required for display support on N9, N950 and
> > Droid 4. It's not just me and Tony, that are interested in this :)
>=20
> Ok. If you agree to help with the DSI part in the future, I have no
> problems applying these (after review and testing, of course).

Sure.

> My worry is not only with complicating Laurent's work towards common DRM
> drivers, but also with the maintenance burden this brings. Keeping DSI
> working in the future may be challenging due to the lack of users and
> (easy to use) boards. I do have a N950 and OMAP4 Blaze Tablet, though,
> so I'm able to test both command and video modes. But getting those boot
> up is not always trivial, especially for the blaze tablet.

I have N950, N9 and Droid 4 (omap4 based).
All of them have command mode panels.

> I've also spent many hours this year debugging obscure OMAP3 DSS HW
> issues, so my opinion about adding more OMAP3 DSS features may be a bit
> biased =3D).

This patchset is also for OMAP4 (Droid 4).

> I'll have a look at this series when I find a bit of spare time.

Thanks.

-- Sebastian

--qxdfpo2r2ej5lj2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlnzdEAACgkQ2O7X88g7
+pop1A/8CCgA2EfwyOwirsv0w8/CVgF1BdBPUjQO0dLySnKxaD/lAyaDOMdJWQK/
oysIbeXDqp3fRYun4BFZQzP3JIADO3uCNalHI0TjOCrWQWOac7pvsDvG1Og2X+dM
C1IS3aTgC2L+8dBdXJYnVdkOAbH6nwHMmw5BWGmj1b/RPvI1EIcwEXW47jllfzrm
MMrsxVaLN1CM/JNXBcSu/IywwgMhbZicO00mWRnAuk2BMviLq4hKQnpWIl45OZ9R
xn67caKuUboLjs8ViNhne1YyMKeKrqyAT+NV+OGYQba6t7S1Fb5RaKswfpIw5BFx
fKHJJBtfF6AOZBnK58soE34baMVesrxpCkGRgWAfiNwMG1J0IRk79S8tLws9mm+A
aUDi/Z4RympSwUwpuRxk9PCUAVwPf8TgfKQOgFHS8ylps/bGWjW5G1zkY3rwKyE4
FcPd2UleU43yBggbA6aX2i/6Gego/Nshlo2ZY7Zm9gujA60rtvSSYyEwIs5SCggW
wjYylR05/yuiJ9pYLfWSOv06hTIl03/+oRAjzt8V+SUy1TkFtI/XDGEesPABZ2rQ
SkfusIr4F4iwKoBuv6ZnbdpoyqW09hNR7tm0M5vzK/9ijbL2LOe0vIfpiBV2GoFy
KjZST8TmKxAiIG4kS4IGVjzvTMjK8l33EsOXMxcOQrNfuJdS1rA=
=yVyM
-----END PGP SIGNATURE-----

--qxdfpo2r2ej5lj2t--
