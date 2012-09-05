From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 12/17] OMAPDSS: clean up dss_mgr_set_timings
Date: Wed, 05 Sep 2012 14:41:16 +0300
Message-ID: <1346845276.32747.11.camel@deskari>
References: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
	  <1346833555-31258-13-git-send-email-tomi.valkeinen@ti.com>
	  <5047182F.3030507@ti.com> <1346841713.32747.6.camel@deskari>
	 <504738C4.7060005@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-wsgbFg7+e1soYe15jiaL"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:53847 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751990Ab2IELlW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 07:41:22 -0400
Received: by lagy9 with SMTP id y9so236921lag.19
        for <linux-omap@vger.kernel.org>; Wed, 05 Sep 2012 04:41:19 -0700 (PDT)
In-Reply-To: <504738C4.7060005@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-wsgbFg7+e1soYe15jiaL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-09-05 at 17:04 +0530, Archit Taneja wrote:
> On Wednesday 05 September 2012 04:11 PM, Tomi Valkeinen wrote:
> > On Wed, 2012-09-05 at 14:45 +0530, Archit Taneja wrote:
> >> On Wednesday 05 September 2012 01:55 PM, Tomi Valkeinen wrote:
> >>> dss_mgr_set_timings() can only be called when the output is not activ=
e.
> >>> This means that most of the code in the function is extra, as there's=
 no
> >>> need to write the values to registers, etc, because that will be hand=
led
> >>> when the output will be enabled.
> >>
> >> We need to fix dpi_set_timings() before we can make this change. DPI
> >> still tries to change timings on the fly, i.e, with manager enabled. W=
e
> >> need to disable and enable the DPI output like we do for other outputs=
.
> >
> > Yep, and for HDMI also (I didn't check the others yet).
>=20
> I don't think HDMI is impacted, we do the full power off and power on=20
> for HDMI, so the manager would be disabled when we set the timings.

Ah right.

> > I think the simplest way to handle this is to only write the dpi.timing=
s
> > in omapdss_dpi_set_timings, and remove the call to dss_mgr_set_timings.
> > This is not perfect, as a call to omapdss_dpi_set_timings when the
> > display is enabled would result in changing the dpi.timings, but the
> > changes wouldn't be actually in use.
>=20
> The simplest way would be to do what other outputs do, disable the=20
> output and re-enable the output with the new timings value, if the panel=
=20
> is enabled.

Not quite, as there's the mutex in dpi so we can't call enable/disable
from set_timings. I could create separate non-locked internal functions
for enable and disable, but that feels more complex than just removing
the enable & disable from set_timings.

In the end we'll anyway only allow changing timings when the output is
disabled.

The only change I had to do, in addition to removing code from
set_timings functions, was to add display disable & enable calls to the
"timings" sysfs write. omapfb already only calls set_timings when the
output is disabled, and omapdrm does the same.

 Tomi


--=-wsgbFg7+e1soYe15jiaL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQRzpcAAoJEPo9qoy8lh71HvUQAK6KNQxvbYGdJhK499ZtM+Vl
CLLgPVeLNXw2wuFFVCTuTYCJml2Ykz5yn+Ep7TJ+y0Ogga/CXUhnjBdbZg74MVPL
fya9usj3WGcM1VOCd2/6x5HTFz2wIU2hTAIFouMV8xe574SUBqEMxWXzc45nrFFf
2Fat3/uwuEfUNATXUa1L5rWqcu5Lt/WX0pOeqfbfMdqiQFW5XyiIflHGMMQD/5xT
s1I5XVNMozvHwLbvstcao0GoHATpEAv8zDS8NF2YZJQdHOc1+jaSLBPv7bykgS3Y
Xgb/60S+pPoXBwb2G66p1RF+CuSm0DjsoAAuUMvOp1m8gwRWQZBM4fyQ0xl/i61X
0XyIMI3FlvM2PoyDqYNIZKZwckiEX6JI96+71c3yXUb2+W2z1nIYSvEquNfPsM1V
HTrg/zJ/t7M6Fm0N7Cw+KfSiJSHco0G3qYiTm87a5gUnpBYj5OMBCPA4rE9fq88x
aL+C7UIiwatyCZ/+mLx5rMVPRMaGiyjjOARRE5jMQeBICDf4LkMpR9opmh3u9NOo
9p0CxcsT6OixSQr0vvaxrnf3Cxk5j6EoENMXT8WnTLEmCPXQpceoS5u6BcyRKNnR
16Vnr+fuT2QD7LRMn0R/+2D/o8rhdkWK2OldH6O225V73NQYHRIiITudUFYcOupx
RMIO3MK/6KOOi5bRQ9Th
=YFds
-----END PGP SIGNATURE-----

--=-wsgbFg7+e1soYe15jiaL--

