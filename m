From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [RFC 00/17] OMAPDSS: Change way of passing timings from panel
 driver to interface
Date: Wed, 08 Aug 2012 10:27:15 +0300
Message-ID: <1344410835.17575.54.camel@lappyti>
References: <1343817088-29645-1-git-send-email-archit@ti.com>
	  <1344349948.7216.82.camel@lappyti> <502201B7.9030205@ti.com>
	 <1344407158.17575.21.camel@lappyti> <50220B94.5040303@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-/wcsUTT9vrCBqj2l2CR1"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:56819 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757369Ab2HHH1X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Aug 2012 03:27:23 -0400
Received: by lahd3 with SMTP id d3so231889lah.0
        for <linux-omap@vger.kernel.org>; Wed, 08 Aug 2012 00:27:18 -0700 (PDT)
In-Reply-To: <50220B94.5040303@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, sumit.semwal@ti.com, rob@ti.com


--=-/wcsUTT9vrCBqj2l2CR1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-08-08 at 12:17 +0530, Archit Taneja wrote:
> On Wednesday 08 August 2012 11:55 AM, Tomi Valkeinen wrote:
> > On Wed, 2012-08-08 at 11:35 +0530, Archit Taneja wrote:
> >> On Tuesday 07 August 2012 08:02 PM, Tomi Valkeinen wrote:
> >>> On Wed, 2012-08-01 at 16:01 +0530, Archit Taneja wrote:
> >>>> This series tries to make interface drivers less dependent on omap_d=
ss_device
> >>>> which represents a panel/device connected to that interface. The cur=
rent way of
> >>>> configuring an interface is to populate the panel's omap_dss_device =
instance
> >>>> with parameters common to the panel and the interface, they are eith=
er populated
> >>>> in the board file, or in the panel driver. Panel timings, number of =
lanes
> >>>> connected to interface, and pixel format are examples of such parame=
ters, these
> >>>> are then extracted by the interface driver to configure itself.
> >>>
> >>> The series looks good. I had only a few comments to make, but obvious=
ly
> >>> this needs quite a bit of testing. I'll try it out.
> >>
> >> One thing I'm not sure about is whether these new functions should be
> >> aware of the state of the output. For example, if we call set_timings(=
)
> >> with DSI video mode which is already enabled, the timings won't really
> >> take any impact.
> >>
> >> Similar issues would occur when we try to make other ops like
> >> set_data_lines() or set_pixel_format(). These need to be called before
> >> the output is enabled. I was wondering if we would need to add
> >> intelligence here to make panel drivers less likely to make mistakes.
> >
> > Hmm, true. It'd be nice if the functions returned -EBUSY if the
> > operation cannot be done while the output is enabled.
> >
> > We have the dssdev->state, but we should get rid of that (or leave it t=
o
> > panel drivers). It'd be good if the output drivers know whether the
> > output is enabled or not. I think this data is already tracked by
> > apply.c. It's about ovl managers, but I think that's practically the
> > same as output.
> >
> > Calling dss_mgr_enable() will set mp->enabled =3D true, which could be
> > returned via dss_mgr_is_enabled() or such.
> >
> > Then again, it wouldn't be many lines of codes to track the enable-stat=
e
> > in each output driver. So if we have any suspicions that mp->enabled
> > doesn't quite work for, say, dsi, we could just add a private "enabled"
> > member to dsi. But I don't right away see why dss_mgr_is_enabled()
> > wouldn't work.
> >
>=20
> I think we had discussed previously that it may not the best idea to see=
=20
> if a manager is enabled via mp->enabled as it's always possible that it=
=20
> changes afterwards. Same for any other parameter in APPLY's private=20
> data. This was the reason why we passed privtate data to DISPC functions=
=20
> rather than creating apply helper functions which return the value of a=
=20
> private data. For example, we pass manager timings to dispc_ovl_setup(),=
=20
> instead of DISPC using a function like dss_mgr_get_timings().

I think that's slightly different problem. The dispc case has an issue
with locking. If dispc_ovl_setup() is called with the apply's spinlock
taken, neither dispc_ovl_setup() nor dss_mgr_get_timings() can take the
lock. But if dispc_ovl_setup() is called from somewhere else, it should
take the lock. Also, if dispc_ovl_setup() would call a function in
apply, it'd be calling "upwards" to a higher level component.

With the output driver calling apply, none of those problems is present,
I believe.

> I also don't see why dss_mgr_is_enabled() wouldn't work. The only places=
=20
> where the manager's state will change are the output's enable and=20
> disable ops. The mutex maintained by the output would ensure=20
> sequential-ity between the output's enable() and set_timings() op, and=
=20
> hence ensure the manager's state we see is fine.
>=20
> If we manage the 'enabled' state for each output interface, we would be=
=20
> a bit more consistent with respect to other parameters. For example,=20
> timings is maintained by both manager and the output. Also, if we need=
=20
> to separate out manager configurations from outputs in the future, it=20
> would probably be better for the output to query it's own state rather=
=20
> than depending on the manager, which could be configured either earlier=
=20
> or later.

Two things that came to my mind:

If the output driver uses dss_mgr_is_enabled(), if both DPI and DSI
output drivers use the same manager, they'd both see themselves as
enabled. Of course only one can work at a time, so I'm not sure if
that's a practical problem. And if we had some kind of link between the
mgr and the output driver this would not be an issue.

The second thing is that we're not strictly required to have DISPC
connected to DSI or RFBI. We could use CPU/sDMA to output the image.
This is quite theoretical, though.

So, I think using dss_mgr_is_enabled() would work, but I'm still not
100% sure...

Well, perhaps the code should be such that dss_mgr_is_enabled() is used
to see if the mgr is enabled, not if the output is enabled. What I mean
with this is that if, say, set_data_lines() calls dispc to set the data
lines, we are really interested in if the dispc's mgr is enabled, not if
the DSI is enabled.

And if some other function changes DSI configuration (but doesn't touch
dispc), then we're not really interested in if the mgr is enabled, but
if the DSI is enabled.

That's a bit more complex than using only dss_mgr_is_enabled() or using
only output specific enable-flag, but I think it's more correct. In
DPI's case only dss_mgr_is_enabled() is probably needed. For DSI we may
need a separate private enable-flag.

 Tomi


--=-/wcsUTT9vrCBqj2l2CR1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQIhTTAAoJEPo9qoy8lh71ufoP/0yP1ItI1xLHBFQkiJ5h/lFh
FMJQJqOgAg8Xkb2tNXHO2fPTumOr1EbWla5K66tbBb+sUdKc5a0wmWcVavNpwlGM
OGVmcZMXPDy2n+wmymhT8zp0cg6IU+lhox2EF/QbWD0ViIP9ZlnvOXH3zE51zXA+
PF8eLkRPIL15W3Cas8vQSGlUOTYirrNx4OGpYWwYDTtnQvrZ4KfUTXDdrsFVXemH
1DMyeEaY8ONxjPny9JfEH5SK4UX824ya7YV0SBGuOWgsamH+nzvRw6KHGxYP/84J
T8QdSlLWvru1MXx22Yl/E0C/JZ5cgL9/2JM0Gh498HxArIBEaoEslw1AWLzFS06g
6t8Fu23Ux3Y5hst3a/VGdFV7WM8XVEH6tMvJVUkcAcpEHwUN41qndxKB1Mf7f7Gw
72IbBdrvdZ7e+DhmgIv0tr/qvq7O4FpsXGiZi4rHMoQeLozoHdhez8xZS8Sz6CTH
fc5/OHMQk5b/hePJUoWHjmQHvgtPOD5s0PrhyOidMKIU01bi2a6g0RonEiwgMQhY
HZaFGa1Jjf4HZr6kROyoyeX0/gu4Z3cpI2E0NZctbzX7iajrErEkPWQXDjcR6tfD
F0XsnLcraHxSxbvHADzqOTEdqEf4Of4HV+MRUYAbxcVwxiUYHB8Rjl+p4p3iO/9F
KPdWOwH8GctdBAwMzx9e
=wRCw
-----END PGP SIGNATURE-----

--=-/wcsUTT9vrCBqj2l2CR1--

