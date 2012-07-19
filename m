From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] OMAP: USB : Fix the EHCI enumeration and core retention
 issue
Date: Thu, 19 Jul 2012 13:20:14 +0300
Message-ID: <20120719102013.GJ14302@arwen.pp.htv.fi>
References: <1340286132-20634-1-git-send-email-keshava_mgowda@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVh9lyqKgK19OcEf"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:34609 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752386Ab2GSKXQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jul 2012 06:23:16 -0400
Received: by lbon10 with SMTP id n10so6215519lbo.27
        for <linux-omap@vger.kernel.org>; Thu, 19 Jul 2012 03:23:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1340286132-20634-1-git-send-email-keshava_mgowda@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keshava Munegowda <keshava_mgowda@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, khilman@ti.com, balbi@ti.com, sameo@linux.intel.com, notasas@gmail.com, Alan Stern <stern@rowland.harvard.edu>, Greg KH <gregkh@linuxfoundation.org>


--EVh9lyqKgK19OcEf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 21, 2012 at 07:12:12PM +0530, Keshava Munegowda wrote:
> This commit 354ab8567ae3107a8cbe7228c3181990ba598aac titled
> "Fix OMAP EHCI suspend/resume failure (i693)" is causing
> the usb hub and device detection fails in beagle XM
> causeing NFS not functional. This affects the core retention too.
> The same commit logic needs to be revisted adhering to hwmod and
> device tree framework.
> for now, this commit id 354ab8567ae3107a8cbe7228c3181990ba598aac
> titled "Fix OMAP EHCI suspend/resume failure (i693)" reverted.
>=20
> This patch is validated on BeagleXM with NFS support over
> usb ethernet and USB mass storage and other device detection.
>=20
> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>

Acked-by: Felipe Balbi <balbi@ti.com>

turns out this is causing other issues and another version of the patch
will be provided.

Greg, Alan, this is basically a git revert of the commit id listed
above.

--=20
balbi

--EVh9lyqKgK19OcEf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQB99dAAoJEIaOsuA1yqREoB0P/A9xODEb/OQXip5zo5IYnfMe
tbNkcAepo4U6gsMxnxmrI7KnHEd76UeemYpghzpaap2YdxxXb1FiFa7nmAnX09jm
URzPJwJeGx1cFjmFPTILEz7II3yYY4q62hj+2+qq2QKd0HV/dkZmQ9kgxERLvkmA
TRQUhomNHasKoFQYtFMR0R7mqNN2xivQK3tXt1q3+bwPP+b7XICazfYAYDMW+4Ei
PXoTJvzTmGw59ngspNQHaXGdXV4b1YoIMvmYwodv5KYuuoRPpbaxa4ulYPvpbmXc
Jyq8GAR0TMMWjNKaKCOzdtNMue2E20xjms8brCkvNKyz0UUtwO0p21CjHqOv1XTJ
6KZdLDAVYfJTh9sTKPi0mrl2o84rr8cKRRzfkdkHKi56QInDvIIqMEKGkJfggeeE
bIWi03zNoc2wfKADzDwOASivZj8Zzx6oDOtVNAjT+JhVm53/dhqeZkF/DbAQisis
7JaqL1yX5poQo81uryPNa09lGvEHUUEDGanQHPJuPJhlocuaBkbE1efT4KoMcq3k
g2RbwqBW2To5xoHharUfy0UaWMxZK8L8oli9cDERzhsP3shy4LHCsZVvjAu7JcMS
IY1avJztmAT4TJqIEPdFhU/tcFB/CN7R2Ka/Ujdypj0DFvUCYwlOsMk4Rh3hb4eB
ocbbpjq7RRQHs5PkgdlL
=SEtw
-----END PGP SIGNATURE-----

--EVh9lyqKgK19OcEf--
