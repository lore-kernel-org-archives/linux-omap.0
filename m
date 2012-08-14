From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 07/13] OMAPDSS: HDMI: Add a get_timing function for
 HDMI interface
Date: Tue, 14 Aug 2012 17:10:20 +0300
Message-ID: <1344953420.4845.72.camel@lappyti>
References: <1343817088-29645-1-git-send-email-archit@ti.com>
	  <1344512989-4071-1-git-send-email-archit@ti.com>
	  <1344512989-4071-8-git-send-email-archit@ti.com>
	 <1344949348.4845.46.camel@lappyti> <502A4F62.5050400@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-zC/VVrzleq2wZ/KX3tap"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:42975 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751850Ab2HNOK0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Aug 2012 10:10:26 -0400
Received: by lagu2 with SMTP id u2so216674lag.36
        for <linux-omap@vger.kernel.org>; Tue, 14 Aug 2012 07:10:23 -0700 (PDT)
In-Reply-To: <502A4F62.5050400@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org


--=-zC/VVrzleq2wZ/KX3tap
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-08-14 at 18:45 +0530, Archit Taneja wrote:
> On Tuesday 14 August 2012 06:32 PM, Tomi Valkeinen wrote:
> > Hi,
> >
> > On Thu, 2012-08-09 at 17:19 +0530, Archit Taneja wrote:
> >> Add function omapdss_hdmi_display_get_timing() which returns the timin=
gs
> >> maintained by the HDMI interface driver in it's hdmi_config field. Thi=
s
> >> prevents the need for the panel driver to configure default timings in=
 it's
> >> probe.
> >>
> >> This function is just intended to be used once during the panel driver=
's probe.
> >> It makes sense for those interfaces which can be configured to a defau=
lt timing.
> >
> > I'm not sure about this patch. So I think the basic idea here is that
> > HDMI will use VGA video mode if, for whatever reason, no better mode is
> > found out.
> >
> > After this change, the panel driver doesn't seem to do that. Instead it
> > uses whatever mode was used previously by the hdmi output driver.
> >
> > Is the only reason for this patch to clean up the hdmi_panel driver? We
> > could have a dss helper function which returns the timings for VGA
> > (well, just a public const variable would be enough), and the panel
> > driver could use that to initialize the timings struct.
>=20
> Yes, that's the only reason, basically, to sync the panel with the=20
> timings to which the hdmi output driver configured itself during it's=20
> probe. We don't use hdmi_get_timing anywhere apart from here.

Does the hdmi output driver even need to configure any defaults?
Wouldn't it be ok to presume that the panel driver configures the
timings?

I don't think it's sensible to think about default values in the output
driver generally (well, at least for things like timings). Although in
HDMI's case VGA is quite sensible default, but that's not the case for
any other output.

So I think generally we should just trust the panel driver to tell the
output driver what configuration should be used before the panel driver
enables the output.

That said, it doesn't hurt that the output drivers initialize their own
datastructures to something relatively sane to avoid any BUG() or WARN()
calls in the omapdss. Although we could also somehow track if the
timings has been set, and return an error when enabling the display if
timings hasn't been set. But that requires an extra flag, so perhaps
it's simpler to have some initial values in the output driver also.

> I thought it would be clean to retrieve the timings by taking whatever=
=20
> is stored in the hdmi output driver, but we could leave it to a=20
> hardcoded VGA as before.

My main worry is that it's not easily clear what is going on if you look
at the panel code. It looks that the panel just uses whatever is in the
output driver. It's not clear that it is always VGA. What if the
previous mode was something else?

I think it's much clearer if the panel driver sets the timings
explicitly before enabling the output. It doesn't have to be in panel's
probe, although that's perhaps the easiest place for it.

> I have done the same for venc, let me know if you think these should be=
=20
> removed.

Well, I agree that the initial timings code in hdmi and venc is a bit
ugly. I don't think it's bad as such, just that the timings are standard
ones, and instead of having all the timings numbers there, we should
have a common place for them.

 Tomi


--=-zC/VVrzleq2wZ/KX3tap
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQKlxMAAoJEPo9qoy8lh71tK0P/RvZE8O69o7AJxhR8C5zSfCb
XjSjIzwMNHeGk0P6QKCmd5vslxOIB2DyZVZwOkNkXbfZ1JI8JZhndAyOgN4EZrvV
piy5uxIKTkE53yAIHQeTlLrayGQOL/qRj1W1hkLz/zfP3lnupuNf/MMgTyb28mKr
Hqt0gGUKase/s2CUDKreQ/TbYmx4apvrdzXQliYTpA4lj+ND4JfTi8/9DtazqbxU
D7QfP1Ch97wuKDTPqhChWyZsPqkI37TJltAEVMUeetuDvv94yq4fWkYSSb5c3/+4
wDoZm2f7wOZlCRb940XcSLEg7R0JDbXr3YpKfrdKTc74HeCq6Xu+LZ4aFn8U3eXR
/1YO5WlTs+7PBNJVII/KHAzQptrEdQvbM4cN60hmWkiUf8EUP74gR0VwsB8k5Gnz
+WnOYefUXqD9XZ0XK1Z/pY/TspBefTgG8njF41iF1cwbuweGXiXY+CFF8nrSTx6w
0dXZnlHfA3sDnL9b2O+c/eoiscb43m54lEq4BFtYcJcq0RgPBXCP77sP8r2UzpFN
vitKCbBtullPv5Kw1kwuiWyOii7CFavyz09rfYMIXIdW2Gg+0morCFg8NzfIdrPI
5CBN9Y9WeWixbbXORgR79yuMNY51c503CYTgpCayjkqgZMgSBOVZ3efCgc4zGQxc
qFqeG4xU8L0N+duDXdCN
=aqBK
-----END PGP SIGNATURE-----

--=-zC/VVrzleq2wZ/KX3tap--

