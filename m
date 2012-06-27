From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 17/17] OMAPDSS: DSI: Remove redundant fields in
 omap_dss_dsi_videomode_data
Date: Wed, 27 Jun 2012 15:31:14 +0300
Message-ID: <1340800274.2649.64.camel@deskari>
References: <1340703414-1915-1-git-send-email-archit@ti.com>
	  <1340703414-1915-19-git-send-email-archit@ti.com>
	 <1340798746.2649.51.camel@deskari> <4FEAFA18.3070908@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-nL3LSRCfKuhJs3mlenTJ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:48956 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757064Ab2F0MbW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Jun 2012 08:31:22 -0400
Received: by lbom4 with SMTP id m4so1630852lbo.2
        for <linux-omap@vger.kernel.org>; Wed, 27 Jun 2012 05:31:16 -0700 (PDT)
In-Reply-To: <4FEAFA18.3070908@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: rob@ti.com, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org


--=-nL3LSRCfKuhJs3mlenTJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-06-27 at 17:48 +0530, Archit Taneja wrote:
> On Wednesday 27 June 2012 05:35 PM, Tomi Valkeinen wrote:

> > The sync polarities between DISPC and DSI do not matter elsewhere, they
> > do not affect the DSI output, so why do we have them in the panel data?
> > Why doesn't dsi.c just use some hardcoded values for these.
>=20
> Ok, are you saying that unlike DPI, where a panel may request for some=
=20
> different polarities. There is no such need for DSI panels, and we can=
=20
> set the polarities of DISPC and DSI always to active high(or any other=
=20
> combination)?

Yes. There are no sync polarities in DSI bus, there are only sync
packets. So afaik, the polarities used here matter only for DISPC and
DSI communication. And there the only thing that matters is that both
DISPC and DSI have the same configuration for the polarities, so that
the communication works.

> Well, we are doing that indirectly in a way, a DSI panel driver would=20
> populate a omap_video_timings struct, and would leave hsync_level,=20
> vsync_level and de_level empty(i.e, the default values). This would be=
=20
> passed to the DSI driver, and the timings would be applied to DISPC. The=
=20
> function above would just pick up the same default values and program to=
=20
> the DSI registers.
>=20
> What we could do is ignore these fields in the omap_video_timings when=
=20
> passed from the panel driver to DSI driver, and always use a fixed value=
=20
> for them, and this way we can use the same fixed values for DSI too. Do=
=20
> you think that is better?

I think that is clearer. Optimally we wouldn't even have a video timings
struct for DSI panels, the kind that contains sync polarities and such,
but a separate timings struct that contains stuff relevant for DSI. But
for now I think we should just ignore the "extra" values in video
timings.

 Tomi


--=-nL3LSRCfKuhJs3mlenTJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP6v0SAAoJEPo9qoy8lh71rAcQAIhv+IKAzmce8oGw7fk7LmWW
b7jQSO6/M9wLf3+vG6YEv15zJk3NEv/dbSMqEj+6ydetDeMAZCOgLXsLBR0Fd4Nj
8m751RgcW/hfzFX8h8Zgd+nX8IiM9X4TpP953Ef6kqTTGIHNVtnvGIDho0zb3TwN
7G9a8oFjiTL3LWMlySADRuxu0OF1eF6Rt/tnzYMJQMMPBhUoI7GRQ0L7cmNQsAor
xD0Cbs6qFjjUrxgubuJEDjI/QK/O6g/xn+EPgjF+UGu6IJYi+pitVDzS6K4pcJ4F
hhszZqaQ40qHl1RF2SrgzlVCz824csdbQtMV8LruwAdnQnbiJaIC356TwRGD0Qi8
f5KJ8NoY50JqR0pIBRu6cbObA05zzqphVzkV2yqncZOjjZsWlxM0BDtoNTRQq3SW
4+ChuthD7b6zRC1SDEzXW0NDzSXiH45POCXeHJ8EPRDYI0hhugJYwfv2lXUh3W7o
kG7Ezm7TJDS9YKfMjwz0YemOhKPGElpCjijotOHmFirCIRHn5zedNP841o/nhneR
u2bTJAmkmwbTyiy+QWEzDO9U7V9vXRs6mE1uY2cKGPFoW9gvRRmMAVLdBJ9kGS+g
ad0YZlKgDQ5wB+ffSJCiI8XBAHvDvE0kTrhr0gOv5DBhgzHLWWXGQvGZw0+ywcBG
u2niQAcx5Je+8YL0/OKy
=WFwS
-----END PGP SIGNATURE-----

--=-nL3LSRCfKuhJs3mlenTJ--

