From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 14/14] OMAPDSS: HDMI: Implement DSS driver interface
 for audio
Date: Mon, 07 May 2012 14:43:06 +0300
Message-ID: <1336390986.2667.8.camel@deskari>
References: <1336095848-6923-1-git-send-email-ricardo.neri@ti.com>
	 <1336095848-6923-15-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-T8XEqQRkVahlSC0Ti6vQ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:54793 "EHLO
	na3sys009aog136.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755941Ab2EGLnR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 May 2012 07:43:17 -0400
Received: by laap9 with SMTP id p9so742806laa.8
        for <linux-omap@vger.kernel.org>; Mon, 07 May 2012 04:43:14 -0700 (PDT)
In-Reply-To: <1336095848-6923-15-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: mythripk@ti.com, s-chereau@ti.com, x0055901@ti.com, vaibhav.bedia@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, agraf@suse.de, research@ottomaneng.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org


--=-T8XEqQRkVahlSC0Ti6vQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 2012-05-03 at 20:44 -0500, Ricardo Neri wrote:
> Implement the DSS device driver audio support interface in the HDMI
> panel driver and generic driver. The implementation relies on the
> IP-specific functions that are defined at DSS probe time.
>=20
> At the moment, a hardirq-safe spinlock is used to protect the audio
> functions. This is because such functions might be called while
> holding a lock (this especially true for audio_start/stop). For the
> rest of the audio functions, a mutex could be used in the future as
> the enablement of resources might take too much time.

The series looks good, except locking. Granted, the locking in omapdss
is a bit bad generally also, but here I think it's a bit more broken.

For example, hdmi_panel.c:hdmi_panel_audio_supported() takes the audio
lock, and then uses variables like dssdev->state, and the hdmi video
mode. However, the video functions do not use audio lock, so effectively
the lock doesn't protect at all.

I'm not sure how to fix it, though. I think this shows the shortcomings
of the current locking strategy (or lack of =3D). What if the audio
functions that can sleep would take the hdmi panel's mutex, and also the
audio spinlock? That would at least fix some of the cases.

 Tomi


--=-T8XEqQRkVahlSC0Ti6vQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPp7VKAAoJEPo9qoy8lh71KnkQAK6rBU9QVL3YfiU/+KOBfNq9
3EKNuJSpEdpScCDlUUTimLZNihXQ9Soj60JfG3zCSe2Dx1AAMcuLqExWpROnsDvB
lR1PnI4kUOSKMP+UX8OCM4e4tvKnXRs5FLrOROHeshJpCJmhdJISnpCubEKCHGTG
8MSiI4ja5lOC+Hxba1XMM6lT3WPJ15iC3Nj/ZxW5VMiyOBvSNnMdFpmFCSpmL8Mv
4y2fc/xgvKg8uhHrKMVs19QW3w+mOk0T7JXYN2ry/orDygMTq9VizU5OVwVfF7AC
u9cFiFJ/8boV9YPMqu97Bd2ZxpjGACiCRH3zXnbyU4MlWqR06mctfe+O7uzONec1
d5O2WlVfys6SokzVWsyBqXpI6pOc/olgaD8iZ3tQqYa1EDQcyjgG9wWyuxsUUnw/
MBCZPMq+iqZOyAHRI0F48o7RCntiZLQqhAuC/+hmLAaOYxDmGpvTj/NQ1xb+Bw8O
Q3X/BML0BkoJiZDVKOe/RUYI77NVsT75zLPCaSOW9/TNqCU99HVyen/yWadPkQg1
qE/9pumrpm8+E77yleN2I0DLwHKk6nRHhiHVd6dYfoLWtPGIU2MN7OzypXOPCc8E
aYo8lchkT1VeYL1koZqhvstd5Mv+Q7Wq2ya+t4+HaBu1szFUIO0sFG5+OTKANRfq
09mwsLh1wFAWm6x48dkZ
=zznh
-----END PGP SIGNATURE-----

--=-T8XEqQRkVahlSC0Ti6vQ--

