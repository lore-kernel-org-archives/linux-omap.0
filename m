From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] ARM: OMAP5: DSS hwmod data
Date: Mon, 17 Mar 2014 15:28:51 +0200
Message-ID: <5326F893.3080607@ti.com>
References: <1394619996-3525-1-git-send-email-tomi.valkeinen@ti.com>
 <532037E0.1080309@ti.com> <53258DDA.50005@compulab.co.il>
 <532692A7.7000509@ti.com> <5326F71C.1060602@compulab.co.il>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6658681571632780294=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5326F71C.1060602@compulab.co.il>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Lifshitz <lifshitz@compulab.co.il>
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Archit Taneja <archit@ti.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============6658681571632780294==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="OvdUtE0xRS9VGSbO9RnJWmS897KrIPFvw"

--OvdUtE0xRS9VGSbO9RnJWmS897KrIPFvw
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 17/03/14 15:22, Dmitry Lifshitz wrote:
> Hi Tomi,
>=20
> Thank you for the feedback.
>=20
> We have OMAP5 based board with no ESD & Level Translator chip.
> So, I made a quick hack in tpd12s015 driver to skip using un-relevant
> GPIOs.

If you don't have tpd12s015 on your board, don't modify it. Remove it
from your board's dts file totally.

> I've copied DSS DT structure from uEmv board *.dts.
> However the HDMI output is not activate yet.
>=20
> Here is some debug output:
>=20
> root@cm-debian:~# dmesg | grep -i dss
> [    0.040554] omap_hwmod: dss_dispc: cannot be enabled for reset (3)
> [    0.043135] omap_hwmod: dss_dsi1: cannot be enabled for reset (3)
> [    0.045725] omap_hwmod: dss_dsi2: cannot be enabled for reset (3)
> [    0.048311] omap_hwmod: dss_hdmi: cannot be enabled for reset (3)
> [    0.050888] omap_hwmod: dss_rfbi: cannot be enabled for reset (3)
> [    0.325392] DSS: set fck to 192000000
> [    0.325400] DSS: dss_runtime_get
> [    0.325427] DSS: dss_restore_context
> [    0.325445] OMAP DSS rev 6.1
> [    0.325450] DSS: dss_runtime_put
> [    0.325456] DSS: dss_save_context
> [    0.325461] DSS: context saved
> [    0.325707] DSS: dss_restore_context
> [    0.325711] DSS: context restored
> [    0.325746] omapdss_dispc 58001000.dispc: OMAP DISPC rev 5.1
> [    0.325838] DSS: dss_save_context
> [    0.325843] DSS: context saved
>=20
>=20
> I do not use uEvm BSP u-Boot. I'm forking from this source:
> git://git.denx.de/u-boot-ti.git
>=20
> Perhaps I'm missing some clocks initialization?
> What are the correct bootargs for activating HDMI video output?

HDMI is the only output on the uevm, and if your board is similar, no
boot args are needed. But, of course, you need omapfb or omapdrm to
manage the display.

 Tomi



--OvdUtE0xRS9VGSbO9RnJWmS897KrIPFvw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTJviTAAoJEPo9qoy8lh71ZDgQAIaxZ38x1f5ZvRjowgBnPgna
6EyjLruxxiVeKbcmvjg4/1pnukOcZw76QgFW91F0MlP3huGjcJqIsEEv8xlGWIxw
LGdlSsoP/MJ/6lApnIiFNGY5iWfSDq/vf1F3TanjiCVKgDqr3WdRfuOgo6QQ0BMn
yWM2o3/iK7PRCig+RBD/phCKvc4QL+mDlW6c0q8fuGtadrHm6erfUE1SRLrjbUDY
vI1WYY1zGIuitlcVpt+hS7SxdEqWpZ54e685gm9xXsqe/h3Hc8TcB4b1bgC/Trwg
Jo4ENuikHpeml8GvrurjmZ1XbXCPZgw01890kpunoRReqCZ3sbyvWdNuvfcvYnA2
VkpQU7qXCgPQkRcEf7G7DB/4MDtCAxawWv/AzC7zr81KsjKVBpGUph5ZiZ3CTWjL
F6ceb6hZtb98VSyH3YjKR9cjlxmib7a9iQzDwJSI67igIt31k7DvMh9UGwtQ5GEL
ytN+ob2kHHPkvcYfIkcxlV1uYIslQyrzb42rXZpXo6SmtZOQc9cGDf8qzckW4vIw
vWQC68JvSqdhZhrnYEEtCoHlI4HRjZtbVrycaBzPqzu2dElsZUqSssyomPWQiE+F
O9VzOgafeGUaX3s7ouwcjHiMJSmUIZplB/po3cgPb75t/zRkWH0Gx7SJ9lWRzg3i
NQamtetdCF8VjM2upewx
=ivRn
-----END PGP SIGNATURE-----

--OvdUtE0xRS9VGSbO9RnJWmS897KrIPFvw--


--===============6658681571632780294==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6658681571632780294==--
