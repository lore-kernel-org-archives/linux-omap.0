From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/4] OMAPDSS: Cleanup implementation of LCD channels
Date: Thu, 28 Jun 2012 14:27:26 +0300
Message-ID: <1340882846.1861.5.camel@lappyti>
References: <cover.1340874806.git.cmahapatra@ti.com>
	  <013a8d0a8698b3f971c5963115b03701141a4688.1340874806.git.cmahapatra@ti.com>
	 <1340880649.5037.39.camel@deskari> <4FEC3DA9.9010405@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-CnSJ0oVyQEFf+YZmZece"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:39094 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751036Ab2F1L1f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 07:27:35 -0400
Received: by bkcjk13 with SMTP id jk13so2025481bkc.26
        for <linux-omap@vger.kernel.org>; Thu, 28 Jun 2012 04:27:33 -0700 (PDT)
In-Reply-To: <4FEC3DA9.9010405@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-CnSJ0oVyQEFf+YZmZece
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-06-28 at 16:49 +0530, Chandrabhanu Mahapatra wrote:
> On Thursday 28 June 2012 04:20 PM, Tomi Valkeinen wrote:
> > On Thu, 2012-06-28 at 15:10 +0530, Chandrabhanu Mahapatra wrote:

> >> +	[OMAP_DSS_CHANNEL_DIGIT] =3D {
> >> +		.name		=3D "DIGIT",
> >> +		.vsync_irq	=3D DISPC_IRQ_EVSYNC_ODD | DISPC_IRQ_EVSYNC_EVEN,
> >> +		.framedone_irq	=3D DISPC_IRQ_FRAMEDONETV,
> > There's a problem with this one. FRAMEDONETV is a new thing, appeared i=
n
> > omap4. So for this we need a system to select the data depending on the
> > DSS version.
> >
> > I suggest you remove the framedone_irq entry for now, and keep the old
> > code to handle the framedone irq. Let's add it later when we can handle
> > the differences between omap versions.
> >
> > Or actually, looking at the code, perhaps you can keep the framedone_ir=
q
> > field, but set it to 0 for DIGIT mgr. This would keep the functionality
> > the same as it is now, because there's only one place in dispc.c where
> > we use FRAMEDONETV, and your patch doesn't touch it. In other places we
> > presume that TV out does not have FRAMEDONE interrupt (i.e. the irq
> > number is 0).
> The purpose of FRAMEDONETV IRQ as seen from dispc_mgr_enable_digit_out()
> looks as to interrupt when active frame related to HDMI is done and so
> DISPC is disabled. I think I misinterpreted  and used it here. Can
> please explain the exact purpose of DISPC_IRQ_FRAMEDONETV?

Yes, FRAMEDONE, for both LCD and TV outputs tells us that the DISPC
output has finished sending the last frame, when the output is being
disabled. So your use here is correct, except that the interrupt is not
present on omap2/3. Thus we cannot have it in this common table.

If you set the field to 0 in this table, everything should work as
before. If you look at the dispc_mgr_get_framedone_irq() code, you see
that it returns 0 for DIGIT channel.

 Tomi


--=-CnSJ0oVyQEFf+YZmZece
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP7D+eAAoJEPo9qoy8lh71QXEP/1DXbxTSHHfb2VpW+PA7q4FD
D7WIsFlvp/Vwkzccw9OMP+0Vay4/uV+TGLBgOtNatpx0hQxjtxvL0WZhVbPqlDEp
ONLS4E04MbwslorVdAH5QpEDPogPDeCm+19kaj1TQa7XY5apGliww/FIA4gBMV/Z
pw56oVMNTs2ikyhrXXXSM94pIugoIcoNqvOhtrprkMkTexpigUln/ztuKhuFju3R
CiOm8GlHD6Zi6MCw3F4ipmNAww53PyR/xeYJKJ5zcTiqrok0dtvFAMblPBGuSiVD
tHJLcRlEpUcmAWgaPeFCHy6aRq03r3pAfWfLfOgfo4ztqdWoW5R8CQSwxCV616eD
nmOT18cO9ZJQtmHEiZ38xJ7DgN9XHArpZNsYAaijtgzWDPCUQ615OXwj53xi37y0
1fOWqv9R1X51sTwmTNrXCJ0VBZeHsiMB1Tv8NVecrcV0iZEph4+SbAn8X0kEEufW
vCQy+MeiAEyoodRpitJQUBkAxgEDpUcv0fI1/idqMTU13xdWTj0bTAcrJX5shCiU
MMaXDVlpT1r/pZSZssVB5ptSSvd1npcnHE9sj1iUFfKtnJSBKgxymIqCfAz3RyZM
FqLJeJtF9W6SnB8J66FZorKpno+rNn9aKO3C2IHY3sPvSlB7T6h8W5QRjP9eP2lh
9ksDTfvdZrotMvM6vsiv
=VVSk
-----END PGP SIGNATURE-----

--=-CnSJ0oVyQEFf+YZmZece--

