From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH/RFC] ARM: OMAP: MUSB: disable omap_device auto-suspend
Date: Wed, 7 Dec 2011 08:49:56 +0200
Message-ID: <20111207064954.GD32368@legolas.emea.dhcp.ti.com>
References: <1322528190-9274-1-git-send-email-khilman@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RhUH2Ysw6aD5utA4"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:36515 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752165Ab1LGGt7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Dec 2011 01:49:59 -0500
Received: by mail-lpp01m010-f49.google.com with SMTP id h2so86421laa.36
        for <linux-omap@vger.kernel.org>; Tue, 06 Dec 2011 22:49:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1322528190-9274-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org


--RhUH2Ysw6aD5utA4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 28, 2011 at 04:56:30PM -0800, Kevin Hilman wrote:
> The MUSB driver does not currently implment suspend/resume callbacks,

this is not entirelly true, actually. Such methods are missing for
omap2430 glue layer, not for MUSB itself. And the fact is that it's only
missing because we failed to use UNIVERSAL_DEV_PM_OPS for declaring
dev_pm_ops structure.

Can you see if this patch helps:

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index fd5dd46..d89caec 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -525,10 +525,8 @@ static int omap2430_runtime_resume(struct device *dev)
 	return 0;
 }
=20
-static struct dev_pm_ops omap2430_pm_ops =3D {
-	.runtime_suspend =3D omap2430_runtime_suspend,
-	.runtime_resume =3D omap2430_runtime_resume,
-};
+static UNIVERSAL_DEV_PM_OPS(omap2430_pm_ops, omap2430_runtime_suspend,
+		omap2430_runtime_resume, NULL);
=20
 #define DEV_PM_OPS	(&omap2430_pm_ops)
 #else

You also have to remember that for host side PM to work, you depend on
your class driver supporting autosuspend feature. If it doesn't, then
its interface will never call usb_autopm_put_interface() and thus pm
counter will never decrease. Be sure to use a device whose driver
supports autosuspend feature.

--=20
balbi

--RhUH2Ysw6aD5utA4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJO3wySAAoJEIaOsuA1yqREVJAP/RX/dMoElhvQ3YP0WhMQ7oeb
JN+wfgxifOvy3uTA5ed0u+LJhwg6JpahTmjWYPA0NZRD1L8b4xhpSvbDE4QQi+Ph
gZz/5h/BRUcwLbW5yrYBEJ5/roykbyH4IQCoSXoFCRywo9y4gWD/nuXGiiAEoSPX
SKjvDoyg39+pOwrjSAQMMTZboFc/oDZ6/b9cxudqFzt+kk77D9JDt2Dej2lcroOQ
8VFSgRZrNWVQ6To8VG8V6XiO+2MZVQQaQPDG9Yj/JgKeNIw/xulAsMRL+EKO9ZrD
bcOz6FQFKYC9yAWYNbDL0PR4MSsGMDDaKXxE8+6HS10bJCdPdSodviBsGfKTiOKX
FrAzRC0ub6FuHCUz12/jga44xyeAwQJEgETaB0QmsyVVIjOBGFqMrVIQu2cHAdu6
npcDWnqUE5V25gOvHoUY6mj11jLbsk49WAiLpXyB9PSmDhfvDtxLe8/sLwiDw4Kn
/hcCarfYOuKGCONY9+KgUJ3yVT8cfJr5H6HXDti0SABuJPggjqP5dESD7zxjoTjX
G6sjz3QnnCFDPuv/OFMc8HTchI7vGSvZm2OgTVVobWwzO5YHubExr8oUflmppFcR
Cv/GeeR7sfoxoKaxinKaS/gBTa9g0kBfuJ38xR8DgZ1lxgLw+NKWpaabjWhPKis2
8fjrgAIgzxX/CISfT2AR
=7aSA
-----END PGP SIGNATURE-----

--RhUH2Ysw6aD5utA4--
