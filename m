From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] omap2430 musb: Make musb_otg_notification non-blocking
Date: Wed, 25 Jan 2012 10:47:49 +0200
Message-ID: <20120125084748.GD4489@legolas.emea.dhcp.ti.com>
References: <20111230123628.76720567@notabene.brown>
 <20120124085610.GI27414@legolas.emea.dhcp.ti.com>
 <20120125115954.473de6e7@notabene.brown>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="so9zsI5B81VjUb/o"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:45126 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753343Ab2AYIrz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Jan 2012 03:47:55 -0500
Content-Disposition: inline
In-Reply-To: <20120125115954.473de6e7@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org


--so9zsI5B81VjUb/o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 25, 2012 at 11:59:54AM +1100, NeilBrown wrote:
> On Tue, 24 Jan 2012 10:56:12 +0200 Felipe Balbi <balbi@ti.com> wrote:
>=20
> > On Fri, Dec 30, 2011 at 12:36:28PM +1100, NeilBrown wrote:
> > >=20
> > >=20
> > > This callback is on an 'atomic notificaitons' queue but is written
> > > as a blocking notifier.
> > >=20
> > > Convert to use a work-queue to run from non-atomic context.
> > >=20
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> >=20
> > doesn't apply.
> >=20
>=20
> It did 1 month ago when I sent it :-)
>=20
> It seems that commit 712d8efafbbcbe617f9ad706f6ca1ffea4bbf2e8
> fixed the same problem already.
>=20
> The following patch adds a few little bits
>=20
> Thanks,
> NeilBrown
>=20
>=20
>=20
> musb/omap2430 minor cleanups.
>=20
> 1/ remove incorrect comment (it is a non-blocking notifier)
> 2/ Use correct symbolic return value for notifier
> 3/ Make sure otg_notifier_work is cancelled before module exit.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>

applied, thanks

--=20
balbi

--so9zsI5B81VjUb/o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPH8G0AAoJEIaOsuA1yqREHPYP/0KXiCZUBnOGHH3GO4/H6N36
mhM7thRRm0vrsuJMIRGapGelCeTLV3fEmXrV0Hb3yB1yOrj+S+0bo00eRpin3nHs
es40L1x50o3E/Lfhh7W8uSbxIlkr4g+ISJfbNNbotARF7hzVv04NRD0J6UfX2aDK
q4S7F41dQsvWTM2wglHjJec74tbkZwt6DpIF4X7B7nAfdmTRuEL8u3BoN5NSMnMC
6d/Ie5IwWdWncgxbNxiSLKQGEprxgqFq1Kvtd94bzGjpSGnj+9OGqG/nLGjeA7d9
cqVyylt1L2cHN6YdHP+9Pa9tYlX3F1sqSGXjNWjNOO1evsTMoz7CPlt3AKSaawOl
2V+TVEDLOPgZoqttmsQiUD6riF204+/4z+FUQzqhzqrAOk7Rhb/4vMIBHNXTR3cN
VL9kuGp0fU9bl8x9omHDjLygdRddxv165Ye2bBE8AvNdX3aiLgoFskcmB45WBpUb
igTTCG/hi2yz1JGzdbfj18zNcI7Ui4z/31MfqLEgppaQmjkoI8l5XTEmphish+Lb
4QlieLHRcWoz+HDy2oIlMeIrk4+LlTJZn+CjStYGskKf5O0i6sfZwdJnoPRoR8S3
lR+AXphhU8A3GIA6+Udeo8jCsC5Or709rW9GwIpOMugphascpLa/lioZxk1wC0R4
LjVwbgTUVwixvRDGoQOU
=IJ+u
-----END PGP SIGNATURE-----

--so9zsI5B81VjUb/o--
