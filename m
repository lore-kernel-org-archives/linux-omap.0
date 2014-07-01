From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC PATCH] clk: ti: set CLK_SET_RATE_NO_REPARENT for
 ti,mux-clock
Date: Tue, 1 Jul 2014 14:48:33 -0500
Message-ID: <20140701194833.GH13396@saruman.home>
References: <1402992272-21413-1-git-send-email-tomi.valkeinen@ti.com>
 <1402992272-21413-2-git-send-email-tomi.valkeinen@ti.com>
 <53A2CA7A.60206@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IbVRjBtIbJdbeK1C"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33489 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758637AbaGATsh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Jul 2014 15:48:37 -0400
Content-Disposition: inline
In-Reply-To: <53A2CA7A.60206@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Paul Walmsley <paul@pwsan.com>, Mike Turquette <mturquette@linaro.org>, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>

--IbVRjBtIbJdbeK1C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 19, 2014 at 02:33:14PM +0300, Tero Kristo wrote:
> On 06/17/2014 11:04 AM, Tomi Valkeinen wrote:
> >When setting the rate of a clock, by default the clock framework will
> >change the parent of the clock to the most suitable one in
> >__clk_mux_determine_rate() (most suitable by looking at the clock rate).
> >
> >This is a rather dangerous default, and causes problems on AM43x when
> >using display and ethernet. There are multiple ways to select the clock
> >muxes on AM43x, and some of those clock paths have the same source
> >clocks for display and ethernet. When changing the clock rate for the
> >display subsystem, the clock framework decides to change the display mux
> >from the dedicated display PLL to a shared PLL which is used by the
> >ethernet, and then changes the rate of the shared PLL, breaking the
> >ethernet.
> >
> >As I don't think there ever is a case where we want the clock framework
> >to automatically change the parent clock of a clock mux, this patch sets
> >the CLK_SET_RATE_NO_REPARENT for all ti,mux-clocks.
> >
> >Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> >---
> >  drivers/clk/ti/mux.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/drivers/clk/ti/mux.c b/drivers/clk/ti/mux.c
> >index 0197a478720c..e9d650e51287 100644
> >--- a/drivers/clk/ti/mux.c
> >+++ b/drivers/clk/ti/mux.c
> >@@ -160,7 +160,7 @@ static void of_mux_clk_setup(struct device_node *nod=
e)
> >  	u8 clk_mux_flags =3D 0;
> >  	u32 mask =3D 0;
> >  	u32 shift =3D 0;
> >-	u32 flags =3D 0;
> >+	u32 flags =3D CLK_SET_RATE_NO_REPARENT;
> >
> >  	num_parents =3D of_clk_get_parent_count(node);
> >  	if (num_parents < 2) {
> >
>=20
> Thanks, queued for 3.16-rc fixes.

did you skip a few -rcs by any chance? Looks like this could've been
merged on v3.16-rc3... Just checking.

--=20
balbi

--IbVRjBtIbJdbeK1C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTsxCRAAoJEIaOsuA1yqREW/MP/1O3Vz33ZQxsdgRJt0mqRXEc
oBjBPPTvGTQcBaDgtFsC6MXH9iO4q8rk8fquZQI5GWcAFU5I0vk7Q3el0xvqWCFT
3MGtlfiRQEB8K8Yj9leGwU3XTw3MiKMJLLyOY7cmoRsSXpyGnVg9AZDYrDerk69D
e64Qvu8dvQ9QwZidDWZUi7dpzwTVnXyojtOQy2O3OCQi4d9cKB/3Vt/+NVuJ2GGc
R4LOJ1xpqqwsW8J9LBFlobybEOnXDyVT6j+i2ZCmSfMGeLFwOlAIItc1JusjUSUP
EhnejZ4JySWpaNVccPWbenl1G/02Vst+ZJ7QBLP8OIgda9cv8OG7aMCbrraGB9Do
qEcZdyDaECiHDq1XM3uJKahFLL86j3OxN7tav5uKub5Uk+4HuKjO0TmSLFO9ly9H
X/Csj9j5BsP2kKIbCuGCCd0MGsVBR+EKaCEBd+IqcdO1RaVx7b3WCVR/LfeMhcI5
KokWfXItAvzW/3cVx3xBjCkWfQEIjJ+msco+iEMkKCgUWBtDpfvFoJdVuFiFjh5m
u8TqgnzdfDCc8C6zD5GRKoMY2s/+w8VIRxFX7RWcGhoJlqA3hiqbz6cvTuHqdlmN
MygbSzcyNDDAKRY/L3lB71S4TB5PJm2HsnjHy8eHIDzhz/W4KmGbIEJSZfpVVDI5
MbVm4fEsjuqmhG7YN3P/
=iIuu
-----END PGP SIGNATURE-----

--IbVRjBtIbJdbeK1C--
