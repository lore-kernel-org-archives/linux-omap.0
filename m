From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 09/23] OMAPDSS: Create links between managers,
 outputs and devices
Date: Fri, 31 Aug 2012 17:10:42 +0300
Message-ID: <1346422242.7508.18.camel@lappyti>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
	 <1346326845-16583-1-git-send-email-archit@ti.com>
	 <1346326845-16583-10-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-026/UfIt/izKG37eaYBx"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:51134 "EHLO
	na3sys009aog127.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753815Ab2HaOKv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Aug 2012 10:10:51 -0400
Received: by lagy9 with SMTP id y9so2301247lag.19
        for <linux-omap@vger.kernel.org>; Fri, 31 Aug 2012 07:10:48 -0700 (PDT)
In-Reply-To: <1346326845-16583-10-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: rob@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-026/UfIt/izKG37eaYBx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-08-30 at 17:10 +0530, Archit Taneja wrote:
> Links between DSS entities are made in dss_recheck_connections when a new=
 panel
> is probed. Rewrite the code in dss_recheck_connections to link managers t=
o
> outputs, and outputs to devices.
>=20
> The fields in omap_dss_device struct gives information on which output an=
d
> manager to connect to. The desired manager and output pointers are retrie=
ved and
> prepared(existing outputs/devices unset, if default display)) to form the
> desired links. The output is linked to the device, and then the manager t=
o the
> output. If a probed device's required manager isn't free, the required ou=
tput
> is still connected to the device so that it's easier to use the panel in =
the
> future.

I've been pondering this one, and I can't come to a conclusion. The
recheck_connections is just so ugly that I'd like to get rid of it =3D). I
guess this patch doesn't make it any more ugly, so we can include it in
the patch series.

And as I mentioned earlier, I think we should get rid of the
OMAP_DISPLAY_TYPE_* enum, as it's kinda extra now. But doing that would
require changing all board files. That's not out of the question, but I
think we should first make sure we know what we are doing with the board
files so we don't go back and forth there.

Just gathering my thoughts:

When we define a panel in DT/board file, we should also define the
output instance, because that's part of the hardware design. But there
are no hardcoded links between mgrs and outputs, so that doesn't belong
to the DT/board file. For example, omap4460's DSI1 can take input from
LCD1 or LCD2.

So who could/should make the decision which mgr to use... Well, I don't
know on what basis the decision can be made, but I still think omapdss
can't make good decisions on that, so probably the whole "chain" should
be configured in the omapfb/omapdrm level.

 Tomi


--=-026/UfIt/izKG37eaYBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQQMXiAAoJEPo9qoy8lh71sNUP/33I6noff5fEGvJkFOvoDLuL
xNFRNpSJY1+Ot/LUOblYH+6yCWNaYIbJ3P/uoztocSfllQH85LAzAAoW/6L8IX+I
uzOX+7J9uwtAIjv+1KC0AK/nz7r08HHP0Jg9TB0s7b6EwlBn+TDnsT0vdsqHjmLX
WOARcD1EqDTyE+UqIx+t4Zj+Dg/J2u3M82+bonHtQrieQ/oLZWo+8hVbBytDjaSW
FWiXuPUIZI2VHtUYzOP1NuVEQrIAau1aSLWDDT4JQQgohMe1lGsFM9ZfzwV9Ssq6
CKbNOJlr8iT0hszziRka71t5SugOQYPsG/8msgwrRc6oJxMHc9zAoSfayGDBSrUP
DP4v6CxJD7731TivkEA5+CZb6jYRBFtnJE7EwKkqONH4v0x0Q4GT1ZPX3bGh1vDd
ndsJCpz0zPQY/azxAbmRlmqdjJxg5K7hAgNPaWc3BwknivWFjO/0+u8+veQGN0lg
p3P6UVkhI8ububGmYgCABNr9f8iqqQCWksoHXBzTV2DCCZCtw8o0tJlfSx3LaTFM
6uiKpaqw1fVT4hCsSgNHbcI/SkhiC8XvaSesJRck9AihZY2Lv7gIZt3GGQ3MN2M0
haarcoUvjMlqDU3K3+KJNOVmA9mHDJSg8rfjRRFit4v+sfPKaRykVjrxzlqttYm1
RBkzogaeXJSPYDlVzSPd
=IIRG
-----END PGP SIGNATURE-----

--=-026/UfIt/izKG37eaYBx--

