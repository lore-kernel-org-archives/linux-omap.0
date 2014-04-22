From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAPDSS and panel-dpi
Date: Tue, 22 Apr 2014 16:15:19 +0300
Message-ID: <1398172519.5897.5.camel@deskari>
References: <CAGhQ9VzL5fLHCNZ=y-exBAds03f8Bw_hO+KjYnwO4MgRWOfpuw@mail.gmail.com>
	 <20140417192215.GA24931@atomide.com>
	 <CAGhQ9VwM-rnXcMXNW40jbx6yDGCQwjODDyKhtbZNyCsexX2f3w@mail.gmail.com>
	 <20140417225025.GA25732@atomide.com> <20140418025024.GB25732@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="=-vmCVU5vYbx1BeSRe4Xgs"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52052 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756050AbaDVNPb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Apr 2014 09:15:31 -0400
In-Reply-To: <20140418025024.GB25732@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Joachim Eastwood <manabian@gmail.com>, linux-omap@vger.kernel.org

--=-vmCVU5vYbx1BeSRe4Xgs
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2014-04-17 at 19:50 -0700, Tony Lindgren wrote:

>  &vpll2 {
> -       /* Needed for DSS */
> -       regulator-name =3D "vdds_dsi";
> +	/* Needed for DSS */
> +	regulator-name =3D "vdds_dsi";
>  };

This vpll2 node shouldn't be needed with full DT solution.

 Tomi


--=-vmCVU5vYbx1BeSRe4Xgs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJTVmtnAAoJEPo9qoy8lh71k0UP/3p0LECRPtnR9tiukiiRTauC
IU0slF0x6i19khfyYa2UErrfkKZfzdkRNSCOvFpHzjXKNbs37ROwRD3rbtChQ88u
18Jtitpt46mOWZX7fG9KxNwhw+fQHm+yqlhb2WaDEFuTcRl8lEwrp+CkI0Y1JmtJ
PE06gc7mBgiRbZb46SmlJqA67mzesBa+TBPXW31UE2J1mZwMHjaxlBcI1js39hfQ
/PZJ851dBzj3UIanQxM4fjlF7HE/K24/8zNvmGCpBUT56Hy5BpyT0HZlAuasCzXy
xDN1npJvYaCAJ6/FpmGDghaZHgWfO+U4HU2q5C6p75fUtm8ogW9vUpQxf5WapdEX
tb3Qbg04z6slen8OXB0Shatwr1RRmuT912XhS50dRb3pF2V7YFcnPemmC1FzxzBQ
o9ZK1uUuysoNAjALGPSyic32viDsaZAMcvBpiont1jlXlxuoS6dVaE7HJX578hgn
v6NIQrlkPtCNgFvawrOCRkllH8o2Jz/2Xu8RzfhnamwuQ2EXk5i2mW7MtWlcXzcC
CYzh8l0XfXIYHvVIuZkVJDk4P+m6pG5eWtr116TMT2ICGugk3wlAcUM6C1JbkaH9
8sJsMOJ0K/e1rYGtr9j64AQFxmLnEPYzBW3phkJxfcpYSRkYfnYuoQom+A70yGaJ
H7UZ7O9p8IN/gJdain7v
=yFR8
-----END PGP SIGNATURE-----

--=-vmCVU5vYbx1BeSRe4Xgs--
