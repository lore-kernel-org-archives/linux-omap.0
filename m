From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Questions about DSS device tree adaptation
Date: Wed, 22 Feb 2012 14:07:23 +0200
Message-ID: <1329912443.2070.58.camel@deskari>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-o4ZzGsI8jgYV6queOeQm"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:42940 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751845Ab2BVMHa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Feb 2012 07:07:30 -0500
Received: by lags15 with SMTP id s15so416879lag.10
        for <linux-omap@vger.kernel.org>; Wed, 22 Feb 2012 04:07:25 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap mailing list <linux-omap@vger.kernel.org>


--=-o4ZzGsI8jgYV6queOeQm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I'd like to get some feedback for the DSS DT work.

I have currently this in omap4.dtsi, under ocp. It's still a hack, for
example there's sdi for testing even though omap4 doesn't have SDI
output.

dss {
	compatible =3D "ti,omap4-dss";
	ti,hwmods =3D "dss_core";
                                              =20
	dispc {
		compatible =3D "ti,omap4-dispc";
		ti,hwmods =3D "dss_dispc";
	};
                                              =20
	dpi: dpi {
		compatible =3D "ti,omap4-dpi";
	};
                                              =20
	sdi: sdi {
		compatible =3D "ti,omap3-sdi";
	};
                                              =20
	dsi1: dsi@1 {
		compatible =3D "ti,omap4-dsi";
		ti,hwmods =3D "dss_dsi1";
		id =3D <0>;
		vdds_dsi-supply =3D <&vcxio>;
	};
                                              =20
	dsi2: dsi@2 {
		compatible =3D "ti,omap4-dsi";
		ti,hwmods =3D "dss_dsi2";
		id =3D <1>;
		vdds_dsi-supply =3D <&vcxio>;
	};
                                              =20
	hdmi {
		compatible =3D "ti,omap4-hdmi";
		ti,hwmods =3D "dss_hdmi";
                                              =20
		hpd_gpio =3D <0>;
		ls_oe =3D <0>;
	};
                                              =20
	rfbi: rfbi {
		compatible =3D "ti,omap4-rfbi";
		ti,hwmods =3D "dss_rfbi";
	};
                                              =20
	venc {
		compatible =3D "ti,omap4-venc";
		ti,hwmods =3D "dss_venc";
	};
};

And in omap4-panda.dtsi I have:

&dpi {
	dvi {
		compatible =3D "ti,tfp410";
		data-lines =3D <24>;
		channel =3D <2>;
		enable-gpio =3D <0>;
		ddc =3D <&dviddc>;
	};
};


A few notes/questions about the above:

dispc is not an output interface (so it won't have any children), it
doesn't have anything to customize in the dt data, and it's present on
all OMAPs. Should it still be present in the DT data, or should the
device be created dynamically in platform code?

dpi and sdi are not hwmods as the rest of the nodes. They are, from HW
point of view, more or less parts of DSS or perhaps DISPC.

dsi nodes have the id property, which is used by the driver to choose
between DSI1 and DSI2 HW modules. Is there a better way to do this than
a custom property?

Who/where/when should the devices for dss submodules be created? The
device for dss-node is created automatically by the of-platform code(?),
but the rest of the submodules need to be handled by me somehow.

I'm currently using of_platform_populate() in the probe of ti,omap4-dss
driver to create the subdevices, but this approach doesn't feel right.
Shouldn't the devices be created already at the boot time by platform
code, not by the driver code?

Is the "simple-bus", that ocp node also uses, something that I could use
here? If I define the dss node to be compatible with simple-bus also,
does it mean that the of-platform code creates the submodules for me?
Are there any side-effects?

How about the actual panel devices. Above there's the "ti,tfp410"
device. The panel devices are not plain platform devices, so I need to
handle those myself. Can I somehow handle that in the platform code,
creating omap_dss_devices at boot time, or do I need to create those
devices in, for example in this case, dpi-driver's probe?

 Tomi


--=-o4ZzGsI8jgYV6queOeQm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPRNp6AAoJEPo9qoy8lh71fl4P/2nJxIEujOjztRfrKork2228
659F5y+BT1yvh50TiIScq7zU4lQQP2H3NrhOFk/xSkDruoIElvqQYZTgoyLUA1ak
4/9enenKR8YX4JC2zyK6XDpP5zbLXJQWjtzd2Yk/RdkeB7aKQRvZfckiyHfSb5KA
Og8UjIkzUBbBqoOJdS05oFkOdzOmak6qG4NQpyXYt1GfDspXO2nBsf2Gx0g76QGT
t7oDAcqGttM2aV4Fkwx869ySGljA8JNqo3XxSWTCtlLHKz4mHWYjFv16YZS4/S6w
NsCrGFeJqLpmm6bw7NIaDf6xrHBf8P+0FZBTY8Z5p5S189Q+vezTjdDMaANlMt1c
7bCnMTukSBkjE4R4OOumWu75RbgSbFrPmQ3KiKkyJ1TJf263B6D88iv6NsKY37VR
crwJ2vpMYjC/nZYSwAfKUgjDYK2XUOQpYxk7Vliu0PkHcYC82AMNzy5tBwx/1Y5k
MrXmECm4PWu1iKUszpynR0fXqeWhmxtTGuiqCDUGvf7vAYcFEeK1wMzotTEyvUHV
IHXCLhvrl1yfuUuGPsu+L6gHI2Y3gaKTaJFPsncbse/Pe5tsJzg5k8o62/bCaMOf
N48i+3Ow5rZURQpSobHd6/uFueDCnjVdjQR183YWokCxXOZWnCz+t0YrARiZ6fVW
qJpWBgzkPZsK2CXdzQJ7
=SWWX
-----END PGP SIGNATURE-----

--=-o4ZzGsI8jgYV6queOeQm--

