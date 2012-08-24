From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/8] OMAPDSS: HDMI: Move GPIO handling to HDMI driver
Date: Fri, 24 Aug 2012 09:28:36 +0300
Message-ID: <1345789716.9287.8.camel@lappyti>
References: <1345729514-2441-1-git-send-email-tomi.valkeinen@ti.com>
	 <1345729514-2441-2-git-send-email-tomi.valkeinen@ti.com>
	 <50371899.6030706@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-Qz/mRs70RCGo5TpgzdVz"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:60844 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753218Ab2HXG2p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Aug 2012 02:28:45 -0400
Received: by lbbgp3 with SMTP id gp3so1895223lbb.1
        for <linux-omap@vger.kernel.org>; Thu, 23 Aug 2012 23:28:42 -0700 (PDT)
In-Reply-To: <50371899.6030706@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tony Lindgren <tony@atomide.com>


--=-Qz/mRs70RCGo5TpgzdVz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-08-24 at 11:30 +0530, Archit Taneja wrote:
> On Thursday 23 August 2012 07:15 PM, Tomi Valkeinen wrote:
> > We currently manage HDMI GPIOs in the board files via
> > platform_enable/disable calls. This won't work with device tree, and in
> > any case the correct place to manage the GPIOs is in the HDMI driver.
> >
> > This patch moves the handling of the GPIOs to the HDMI driver. The GPIO
> > handling is moved to the common hdmi.c file, and this probably needs to
> > be revisited when adding OMAP5 HDMI support to see if the GPIO handling
> > needs to be moved to IP specific files.

<snip>

> >   static int __init hdmi_init_display(struct omap_dss_device *dssdev)
> >   {
> > +	int r;
> > +
> > +	struct gpio gpios[] =3D {
> > +		{ hdmi.ct_cp_hpd_gpio, GPIOF_OUT_INIT_LOW, "hdmi_ct_cp_hpd" },
> > +		{ hdmi.ls_oe_gpio, GPIOF_OUT_INIT_LOW, "hdmi_ls_oe" },
> > +		{ hdmi.hpd_gpio, GPIOF_DIR_IN, "hdmi_hpd" },
> > +	};
> > +
> >   	DSSDBG("init_display\n");
> >
> >   	dss_init_hdmi_ip_ops(&hdmi.ip_data);
> > +
> > +	r =3D gpio_request_array(gpios, ARRAY_SIZE(gpios));
> > +	if (r)
> > +		return r;
> > +
>=20
> Is there a reason to request these gpios in hdmi_init_display()? Why=20
> can't these be requested simply in the probe of the hdmi platform=20
> device. These gpios are sort of specific to the hdmi output on OMAP,=20
> aren't they?

Well, it is a bit ugly, agreed. But I'm not sure it can be helped
easily.

First, the struct omap_dss_hdmi_data where the gpios are passed from
board file, is really "panel" platform data. I.e. it's attached to the
hdmi dssdev, and thus we can't handle it in hdmi output driver's probe,
as we don't have dssdevs there.

Second, the gpios are actually not OMAP HDMI stuff. They belong to the
tpd12s015 chip, sitting between OMAP HDMI output and the HDMI connector,
which is the ESD/level shifter/whatnot (I don't remember exactly what it
does =3D). So making the GPIOs a property of the OMAP HDMI device wouldn't
be right either.

tpd12s015 is rather simple chip, but it still has the gpios and require
special handling. I think the only way to properly handle this would be
to have a chain of external display devices, and the tpd12s015 would be
handled by a separate driver. Until then, the gpio handling is quite
hacky.

We could move the gpios to omapdss's platform data, but it would still
be wrong, and I'm not sure if it'd be any cleaner hack.

 Tomi


--=-Qz/mRs70RCGo5TpgzdVz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQNx8UAAoJEPo9qoy8lh71ESQP/21lx2u9jR8HgJV0Yxv9l0sz
E3KDFmhA/owfMV6CaOxtPmv4oD82W+yB1IBbem+cZ3S61khAN4jS9yiqrFoyPed7
dIkY3ksY7uwE2aNysKwUg2ianrSBa9qPd5LzyX//mHuHYbunTfQ28l/Ev3S0H2ny
KDabHHYpG4HiXfZsX+Awr31cYOpZgs0OT6u4LD7kVBx0rIqwt+UUUO4DJuByIDlM
g0QhdmNDD0AkPAc8sZyH2WPpYR1xamswdbQPTvQM2jhn62wurBldkHsr/f475uR3
PsuyGbLIb/Bo1d7ARFHUEy0FkvEsk9nRdU7NxGWWsP/YYH9WlMx/I9yyIVjFTz/q
vQae3lG9WB8B7QIaTZfetdXYQqbNT8R1txQx5cNO4nvcXvwTeJkq8H8VQ8YpsvMA
p+7ha9HCVXqoMrwv6F8d/gTT2/z2DwbORavZ1oSLfA0KfSWrGVUUE6RrR4EUBUt3
WEDYtfhc9ryI4i4J1mOxQ6lLRSoYWWzW9coLEe7UfBO75LHTgP3zVKhQVySl1Jca
LHtN3ou5yVVQqZr42gbG7zjfE+n0OMLiOi8i1zSa25nlTp+Hz3gVkkNJdNZKIFJR
v2HAZTOrtNh/BpPoculMZWF4lBOviWousbNUWbUyG7nLm+zUkw4tZ7StZ8kxCEy4
3+7TRfu82SQKSj6ayv+L
=5B6C
-----END PGP SIGNATURE-----

--=-Qz/mRs70RCGo5TpgzdVz--

