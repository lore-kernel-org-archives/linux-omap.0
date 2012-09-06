From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 15/17] OMAPDSS: remove extra_info completion code
Date: Thu, 06 Sep 2012 16:42:06 +0300
Message-ID: <1346938926.2737.71.camel@deskari>
References: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
	  <1346833555-31258-16-git-send-email-tomi.valkeinen@ti.com>
	  <50475444.2080509@ti.com> <1346936681.2737.61.camel@deskari>
	 <5048A6AA.50009@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-k1dO498gXmWpAI+Bggdm"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:36391 "EHLO
	na3sys009aog132.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754864Ab2IFNmM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Sep 2012 09:42:12 -0400
Received: by lagy9 with SMTP id y9so1100086lag.19
        for <linux-omap@vger.kernel.org>; Thu, 06 Sep 2012 06:42:09 -0700 (PDT)
In-Reply-To: <5048A6AA.50009@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-k1dO498gXmWpAI+Bggdm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-09-06 at 19:05 +0530, Archit Taneja wrote:
> On Thursday 06 September 2012 06:34 PM, Tomi Valkeinen wrote:
> > On Wed, 2012-09-05 at 19:01 +0530, Archit Taneja wrote:
> >> On Wednesday 05 September 2012 01:55 PM, Tomi Valkeinen wrote:
> >>> Now that fifo merge has been removed, nobody uses the extra_info rela=
ted
> >>> completion code, which can be removed.
> >>
> >> I think this might come into use when we fix the usage of channel out
> >> field. That is, since channel out is an immediate write field, when we
> >> set a new manager for an overlay, we may need to wait till the overlay
> >> disable kicks in, only then we should change channel out.
> >>
> >> For this, we would need some wait for extra_info, right?
> >
> > Hmm, yes, I think you are right. Previously the ovl_disable waited unti=
l
> > the overlay is not used anymore, but now it doesn't.
> >
> > So I think I need to add wait_pending_extra_info_updates() call to the
> > beginning of dss_ovl_set_manager(). Or, should it be in unset_manager..=
.
> > I think unset is better, then a "free" overlay always disabled also in
> > the HW level.
>=20
> Yes, I also think it should be in unset_manager. One option could be to=
=20
> leave the wait_pending_extra_info_updates() in ovl_disable itself, as it=
=20
> was before. But that would force us to use mutexes there, and we'd=20
> rather have overlay enabling and disabling as a non blocking thing.

Actually, we do have mutexes there. You are thinking about the prototype
API I have. (I also thought we didn't have mutex there =3D).

So, in fact, we can have the wait at ovl_disable like it was before. The
prototype API, which cannot block, will not have the wait, but there the
caller (i.e. omapdrm) will have to manage the proper wait.

 Tomi


--=-k1dO498gXmWpAI+Bggdm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQSKguAAoJEPo9qoy8lh710bAQAKRXFUayjbiPiH0c2QDBgcBj
Ja2uONBh4layOAhQAmc/2QJTms3HS9nmbGCAWx9SLqkx7UZjt2UUyEZmea3SZciG
D3i2ojuSx0kCp5SA00HyjF24gb+oLpIa7Ijidl7beB2pmZcutVR2KYHlldyM0twU
C9WM/mH3oTlq4cfRN1+8kB0eFVLelkkhIxmb+ce2PcaXNEMMm8sLpCpXGOAxc83K
vbHYA371VfixhWhRIBInrVZm1Ct2nMy1wiCATJJiTALCta6olSQp62Dk7RhANfho
9AiDL3OWyWxSX1zQS6M/TfPwmuRTTvhpyZGYkBnjcjaVpd0Xq66LpiyrmM8fW3PZ
Rhoi4kesZ70SzElwitnp8Y4JpfN2oJI6eBNybgxr41jXfIFzv+Cr6197BqDXvBJQ
ob2vlffqpQ527y3RYMOsDHtX858FJdMPKjvq1PgJp7pDeuYvsAdXV5wpPUiqSs33
VPhaEjda+4fwLfvZmkrvkHC+5oIxnKE/RqY2hH6jLNsPM91Qm88HAh5vsodt1Iv9
Kaa5yhjeHTEyrrE7PXJOQpaMfvpFWPhr0UDtRMnOTjDaXwuta6e6KzlU2iwnvR0m
87woBQ2vkE48kUn1xGozDs4LqkFw+Ti8t+GhcI9FHeQbSVG2PvNm1ISk7UL588qi
qlssneeQSgw9cHMl6YmG
=aKf8
-----END PGP SIGNATURE-----

--=-k1dO498gXmWpAI+Bggdm--

