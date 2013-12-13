From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 00/26] OMAPDSS: DT support (Christmas edition)
Date: Fri, 13 Dec 2013 12:05:20 +0200
Message-ID: <52AADBE0.3030203@ti.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com> <1824203.Ui6fpnZVmO@avalon> <52A979D8.3040604@ti.com> <1703598.NbqXAMAFOI@avalon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="X0drk33nSseiIbnqUoDJC4ri2woNkcVi5"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1703598.NbqXAMAFOI@avalon>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Archit Taneja <archit-l0cyMroinI0@public.gmane.org>, Darren Etheridge <detheridge-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Stefan Roese <stefan.roese-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Dr . H . Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--X0drk33nSseiIbnqUoDJC4ri2woNkcVi5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-12-13 05:45, Laurent Pinchart wrote:

>> I know drivers/video is in practice "fbdev", but drivers/video (the
>> words) sound like the best place for things related to video.
>=20
> That's an option as well, but I'm not sure I like the idea of mixing fb=
dev and=20
> generic video in a single directory. We could use a subdirectory of=20
> drivers/video.

Right, that's what I meant.

>> I also don't supply the same data for both endpoints, when the data is=
 about
>> the link. E.g. I think the V4L2 binding doc suggests to supply things =
like
>> bus-width for both endpoints. I only supply the data for the endpoint =
that
>> uses that data. With some encoders/panels the same data could be neede=
d on
>> both ends, but not in these patches.
>=20
> How do you handle the situation where the two drivers (for each end of =
the=20
> link) need to know the bus width for instance ?

Then I fill the bus-width for both ends, as shown in the V4L2 bindings.
That's what I mean with "I only supply the data for the endpoint that
uses that data". If both ends use the data, I supply it for both.

>> The most important thing in the DSS DT bindings for now is that they s=
hould
>> contain enough information so that any future DT bindings changes can =
be
>> handled with a boot-time conversion code.
>=20
> I'm afraid I can't give you any guarantee here. The bindings will be un=
stable=20
> for some time, and we'll have to deal with that somehow.

I'm not asking for a guarantee. Just "yes, feels fine" =3D).

> The omapdss platform data structure contains the following fields
>=20
> - get_context_loss_count: What is that used for ?

To find out if a HW block has been turned off and it has lost its
registers contents. It's an optimization, without it we need to restore
registers each time when runtime_resume() hook is called.

However, that's on its way out. I've already made new PM code for dispc
which doesn't use that. But I can't merge it before omapdrm has been
fixed to properly set things up when enabling a display.

> - num_devices, devices, default_device: What are those used for ?

Nothing anymore. They can be removed.

> - default_display_name: This should be easy to move to DT.

How? I handled it so that I assign the aliases for displays, and
display0 is always the default display. "default display name" is not
really a hw property =3D).

I think this should not be used for DT, and just use the display0 as
default (if we use aliases). If we don't use aliases, and instead use
the label properties as discussed in other thread, then there has to be
some other mechanism to tell which display should be used.

> - dsi_enable_pads, dsi_disable_pads: Those don't seem to be used in mai=
nline.=20
> What's their purpose, and how are they implemented on platforms that ma=
ke use=20
> of them ? Is the pinmux API an option ?

They are used in mainline, grep again =3D). They set pinmuxing for DSI.
Pinmux API is an option, but I think it would require a new driver. The
DSI pins for DSI1 and DSI2 are configured in a single register, where
the fields go in seemingly random order with varying widths.
pinmux-single cannot be used.

> - set_min_bus_tput: We have the same problem for the OMAP3 ISP, so a ge=
neric=20
> solution is needed here.
>=20
> - version: Given that we detect the DSS revision based on the SoC revis=
ion,=20
> I'm tempted to either explicitly encode the DSS revision in the compati=
ble=20
> string, or let the DSS driver query the SoC revision somehow. The later=
 is=20
> considered as a layering violation, but let's face it, I can't see the =
DSS=20
> being used on a non-OMAP platform.

I also would just use the compatible string, but we need to separate
between different OMAP ES versions. Doing that would mean we'd need
different .dtsi and .dts files for the different OMAP ES versions. It
would be a mess.

I have a TODO item to study this. There are only a few things that are
problematic (changed between ES versions without changing DSS HW
revision). If I can find a way around those, the compatible string
should be enough.

One example is the width of a blanking interval. Newer OMAP3 revisions
have a slightly wider field. I didn't try, but maybe I can write 1-bits
to the register, then read it, and if only part of those 1 bits "stick",
I know it's an old revision.

Anyway, I think this platform data thing is not strictly related. None
of these items affect the DT data (except the pinmuxing, but I think
it's fine to add that later). So while the above issues need to be fixed
at some point, I think they don't affect this series (well, the default
display is there which may affect).

 Tomi



--X0drk33nSseiIbnqUoDJC4ri2woNkcVi5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSqtvgAAoJEPo9qoy8lh71hdcP/0P5heLfpUUv/S+7hYFNTYrQ
19kHHt3XFEEeCOgFqUBmcbR72xk65SuK22SlO8TXx+mhm5T483Hs7r0vK65dDqHq
LPrPje+kvoyN2NO0n6n8xh2ClKJuds0a6xj5bGhN7uAgTaARx7yrxWiyb4lZXMT3
tH2QUI19EhK1RJwzYZwitKfbpqDQquJUMjYI3YiQLShPGUG65Qp/5MGxkIeeYJsA
RyeY/+XYe8NtVy2wWti77iOfHp3XeeBqd2IIdoVocYWB01HG9Yqc/KLKMnvn2ljO
ZNp5Baj23BIR5pbT2M7LFkVcqQUa081RZblwM1+7FKBYCaD6/SAK8s0Hi/MenvDX
MBsqGye6aJy71MA7rdSue9shPyci5aXnzMPhBI9xWwEb3e0JxoFbUssVLaOQW2nz
TU/aqebW1RoUwA+e6Jiq+SJ3ZpMRQel0VnoaG9qDjxb8HEWja/M33atgYbqR7MLk
dlXHhQu5rbeJPuqk7JWhXUA5/9m0JObUjYag61bUOsSiYQZ7dcf+2FR6IVg2bdh0
uiG49nqBBrRygnhf0qSRl9+Isc3KIfxUO3TItWtGgGRPcDovfbpoLIDbllgLej71
86/9DSGOBX/69e67ADrxNQ1K7OG964CppqO996S+aRSFtz6VnV/slhpt0t6jNmgf
kP/382oYk4xQiWCjJB0w
=wVm5
-----END PGP SIGNATURE-----

--X0drk33nSseiIbnqUoDJC4ri2woNkcVi5--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
