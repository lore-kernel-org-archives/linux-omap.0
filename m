From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 6/6] ARM: dts: omap4-droid4: Add LCD
Date: Thu, 23 Mar 2017 07:31:09 +0100
Message-ID: <20170323063109.qhwxj74pbfztgopt@earth>
References: <20170305054359.8293-1-tony@atomide.com>
 <20170305054359.8293-7-tony@atomide.com>
 <20170319012927.kmyqngprpip7le4m@earth>
 <20170319161030.GA20572@atomide.com>
 <20170319225542.ts53qpwdhdrmy2ac@earth>
 <9c4a5d88-4d2a-2120-9fdf-f3fbba69147c@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5cmsousfdn5ihpzw"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <9c4a5d88-4d2a-2120-9fdf-f3fbba69147c-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--5cmsousfdn5ihpzw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 20, 2017 at 09:52:20AM +0200, Tomi Valkeinen wrote:
> On 20/03/17 00:55, Sebastian Reichel wrote:
> > On Sun, Mar 19, 2017 at 09:10:30AM -0700, Tony Lindgren wrote:
> >> * Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [170318 18:31]:
> >>> On Sat, Mar 04, 2017 at 09:43:59PM -0800, Tony Lindgren wrote:
> >>>> The LCD panel on droid 4 is a command mode LCD. The binding follows
> >>>> the standard omapdrm binding and the changes needed for omapdrm comm=
and
> >>>> mode panels are posted separately.
> >>>>
> >>>> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >>>> Cc: Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>
> >>>> Cc: Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >>>> Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> >>>> Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
> >>>> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> >>>
> >>> Tested-By: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> >>>
> >>> With a non-modular kernel lcd is not working with omapdrm if HDMI
> >>> is enabled. After dropping HDMI in droid4's dts file everything
> >>> worked as expected. I assume both work properly with a modular
> >>> kernel?
> >>
> >> Yes with loadable modules both work just fine. If things do not
> >> work properly as built-in, chances are there's some unhandled
> >> dependency that needs -EPROBE_DEFER somewhere for a regulator
> >> or a clock.
> >=20
> > I think that would also result in problems with disabled HDMI.
> > I guess the problem is, that omapdrm is initialized too early.
> > AFAIK omapdrm is not hotplug-capable.
>=20
> It shouldn't matter when omapdrm is initialized. omapdrm should wait
> until it has all the displays.

I tried to trace this. I assume, that your "should wait until it has
all the displays" refers to the code in "omap_connect_dssdevs()".
Unfortunately that code does not work correctly:

droid4# dmesg | grep-interesting
[    1.222137] omapdss_dss 58000000.dss: 58000000.dss supply vdda_video not=
 found, using dummy regulator
[    1.236663] omapdss_dispc 58001000.dispc: OMAP DISPC rev 4.0
[    1.236877] omapdss_dss 58000000.dss: bound 58001000.dispc (ops dispc_co=
mponent_ops)
[    1.245208] omapdss_dsi 58004000.encoder: OMAP DSI rev 3.0
[    1.246246] omapdss_dss 58000000.dss: bound 58004000.encoder (ops dsi_co=
mponent_ops)
[    1.255462] omapdss_dss 58000000.dss: bound 58006000.encoder (ops hdmi4_=
component_ops)
[    1.264923] panel-dsi-cm 58004000.encoder:display: probe

This probe failed with -EPROBE_DEFER due to regulator not yet
available.

[    3.294586] connector-hdmi connector: connected display: hdmi

I added this to omap_connect_dssdevs(). DSI is not even in the for loop,
otherwise there would have been another print.

[    3.299560] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    3.299560] [drm] No driver support for vblank timestamp query.
[    3.313507] [drm] Cannot find any crtc or sizes - going 1024x768
[    3.342376] [drm] Enabling DMM ywrap scrolling
[    3.386871] omapdrm omapdrm.0: fb0: omapdrm frame buffer device
[    3.397460] [drm] Initialized omapdrm 1.0.0 20110917 for omapdrm.0 on mi=
nor 0
[    3.406219] panel-dsi-cm 58004000.encoder:display: probe

Here the display is probed again (this time successfully, but
omapdrm doesn't care anymore).

Note, that the EPROBE_DEFER handling in omap_connect_dssdevs() is
correct, since the connect function can also return EPROBE_DEFER.
This is because the omapdss SoC modules request their regulators
in their connect handler.

So currently all code in omapdrm/displays returning EPROBE_DEFER
in their probe function are potentially ignored by omapdrm. It
does work however, if that results in no display being initialized
at all.

The simple fix would be to move the regulator probing from
display's probe function to display's connect function (multiple
omapdrm display drivers are affected). IMHO this is ugly and
drives us further away from a common driver scheme, so I suggest
to fix omap_connect_dssdevs() instead. It should be enough to
check, that all devices have been probed either successfully or
with a fatal error at the start of the function. Also the "no
devices found" could become -ENODEV instead of -EPROBE_DEFER.
I think it may have hid this problem for others.

-- Sebastian

--5cmsousfdn5ihpzw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljTa6sACgkQ2O7X88g7
+pocqA/9GpRbQ6ffDh/hhoE4MDCLlSz/WjmnGn6A21mklQ9+wxEqhqXhBf8HEi5g
rCTiXzmHg4qbxwqMPJSSZD+bzGcdLLxt1syLtSgrWjpMELWHag5aXp4iNvy9w8LJ
x4hzLfYx+w9iNwqYDUmIMW1omrDu0zzIutjbkFFJ+VU82yxmLaa4VrvVkf1ifkRk
ZO+Asa0sTTLKTP2OyXK71Xs8uWtpG835oR4OPqurwTaF5kJh+gY4jldf6vDt21Ee
lfIzefJWoW2HWhn4GmP6v/HAT2FAnji+4ULyvd6/vIAGGCO9HiKZjcRfei09702C
Jc7B2FAu7cYKk6k5JIpqNGqK2MByR/8h2yCiTHpf5yeueiphVFwarW0bNcvCe11n
+kX7eiJPTbh2dwbi+qCOTzK1I7hAphPbS6WRdrvU8PEQRH/BDR+08W/LFc3pT2+w
MERPQWAqMH4zgRA+pJZpR7D5ezG4WLiu0BFesBl58bIyY/r6jiWhOEI/eFeYNrqk
KjnA37lnvZ9MfpfZuIJTedtHyiXcxy853pcsJyoL3N1RdgBOuIsSnD4Y/ZkuCyTj
hEhtnMxk+HEKC8s7qXC+YrHEeRSVXsKjcmow1hwWkNeQLzuhA7rXjhgfsmxKjXcn
59BrHijeMpGBo2p7sDU49cxGCwovlMq6JhLu4OYTBLi1Ps0IEHE=
=dngz
-----END PGP SIGNATURE-----

--5cmsousfdn5ihpzw--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
