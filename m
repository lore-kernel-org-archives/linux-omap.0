From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: RE: [PATCHv2 2/3] OMAP: move arch/arm/plat-omap/include/plat/vrfb.h
Date: Tue, 09 Oct 2012 15:57:10 +0300
Message-ID: <1349787430.2409.30.camel@deskari>
References: <1349785827-27055-1-git-send-email-tomi.valkeinen@ti.com>
	 <1349785827-27055-3-git-send-email-tomi.valkeinen@ti.com>
	 <79CD15C6BA57404B839C016229A409A83EB3A082@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-YDqtaWmDJvQwacJ1mYpi"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:59736 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753676Ab2JIM5Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Oct 2012 08:57:16 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so3001654lag.19
        for <linux-omap@vger.kernel.org>; Tue, 09 Oct 2012 05:57:13 -0700 (PDT)
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EB3A082@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Taneja, Archit" <archit@ti.com>


--=-YDqtaWmDJvQwacJ1mYpi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-10-09 at 12:54 +0000, Hiremath, Vaibhav wrote:
> On Tue, Oct 09, 2012 at 18:00:25, Valkeinen, Tomi wrote:
> > Now that vrfb driver is not omap dependent anymore, we can move vrfb.h
> > from arch/arm/plat-omap/include/plat to include/video/omapvrfb.h.
> >=20
>=20
> Which baseline you are using? I tried it with linux-omap/master, patch[1/=
3] is failing -

It's based on omapdss master, which is what I've sent in the pull
request for 3.7.

> patching file arch/arm/plat-omap/include/plat/vrfb.h
> patching file drivers/media/video/omap/omap_vout.c
> Hunk #1 FAILED at 45.
> 1 out of 1 hunk FAILED -- saving rejects to file drivers/media/video/omap=
/omap_vout.c.rej
> patching file drivers/media/video/omap/omap_vout_vrfb.c
> Hunk #1 FAILED at 17.
> 1 out of 1 hunk FAILED -- saving rejects to file drivers/media/video/omap=
/omap_vout_vrfb.c.rej
> patching file drivers/media/video/omap/omap_voutdef.h
> Hunk #1 FAILED at 12.
> 1 out of 1 hunk FAILED -- saving rejects to file drivers/media/video/omap=
/omap_voutdef.h.rej
> patching file drivers/video/omap2/omapfb/omapfb-ioctl.c
> patching file drivers/video/omap2/omapfb/omapfb-main.c
> Hunk #1 succeeded at 33 with fuzz 2 (offset 1 line).
> patching file drivers/video/omap2/omapfb/omapfb-sysfs.c
> patching file drivers/video/omap2/vrfb.c
> patching file include/video/omapvrfb.h
>=20
>=20
>=20
> Note that, the directory structure has been changed in the mainline,
> Now V4L2 OMAP Display driver is in "drivers/media/platform/omap/"
>=20
> You have to rebase the patches and resend it.

Yep, I'll rebase it on top of 3.7-rc1 when that's out, so that Tony can
pull that branch into his tree also. I guess the omap_vout changes
should apply easily, as it's just include filename changes.

 Tomi


--=-YDqtaWmDJvQwacJ1mYpi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQdB8nAAoJEPo9qoy8lh71iNYP/jL9ISQ960mZGsc3j/2Uu2ms
1UsyHFjXnfWWdVhXRIyiaWQExf6czN7ByhAx3GVI6sbZSKnsw9j6nyflDNUglarX
G1XKsioHfuPN4sNiv5o0aIoai4ZK8Cgs9760Sd0JWrhDj27TOjvxBUWTW+eK3sfS
hZcB714V6IRe77/9XfCH/f66SPuqsdEKUqaYN+QDmA0jGgzylLiyT843p0kLQ2/t
ONNFd65U75jOw+yYcZ86Y/5bBX49NdG5yZUQDIejjAtJFZu5B8hUl0/d9mcE2rxN
t3luDOKkaGynbBbKShwApKTGmPGvuYUev/55NlK1HpB22YM7C5BR/4VXsKy0Sl5T
YQY0ephfJPwiIJPtvVVaFgQeAIIadaf8BpmfvPyqc053KF+wiwp38dGoamXGAuPM
dW++jpo2mxDLS/x4X3LpMacRfTpO0pWzrPL8TjTw71kpxq6QbVKFrtsjeVN3zzLs
hyxXVv1Qnx7u5efMMBH9p+q6q6IvIXKnXBwB5UxUfEKDSTBMtgulFit6ZHBwKs9E
53GDRjiiXKCVOGRTZZibgNGkbqZuAeRcUGyPcT3G+JU+jyW5kdRTJjqYk9TOKue0
VeyCCOP2Q2wHlgHhzOfkZh5X/tLI7sbSO1wmtk9K0X4gaVuEoEfIspibdW6uFx2M
iq9NybnGZaW+4JHF/HPA
=HFhz
-----END PGP SIGNATURE-----

--=-YDqtaWmDJvQwacJ1mYpi--

