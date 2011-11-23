From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 42/65] OMAPDSS: DSI: call mgr_enable/disable for cmd
 mode displays
Date: Wed, 23 Nov 2011 12:42:57 +0200
Message-ID: <1322044977.28917.57.camel@deskari>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
	 <1321953724-6350-43-git-send-email-tomi.valkeinen@ti.com>
	 <4ECCC68C.7070106@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-zYfjCvmJNk3D+hndusZF"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:55720 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752076Ab1KWKnE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Nov 2011 05:43:04 -0500
In-Reply-To: <4ECCC68C.7070106@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, archit@ti.com


--=-zYfjCvmJNk3D+hndusZF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2011-11-23 at 15:40 +0530, Archit Taneja wrote:
> On Tuesday 22 November 2011 02:51 PM, Tomi Valkeinen wrote:
> > The current code uses dsi_video_mode_enable/disable functions to
> > enable/disable DISPC output for video mode displays. For command mode
> > displays we have no notion in the DISPC side of whether the panel is
> > enabled, except when a dss_start_update() call is made.
> >
> > However, to properly maintain the DISPC state in apply.c, we need to
> > know if a manager used for a manual update display is currently in use.
> >
> > This patch achieves that by changing dsi_video_mode_enable/disable to
> > dsi_enable/disable_video_output, which is called by both video and
> > command mode displays. For video mode displays it starts the actual
> > pixel stream, as it did before. For command mode displays it doesn't do
> > anything else than mark that the manager is currently in use.
>=20
> dsi_video_mode_enable() doesn't only enable the DISPC output, it also=20
> sends the long packet header to start video mode transfer.
>=20
> I think it would be better if we had 2 separate functions, one which=20
> starts/stops DSI video mode, and the other which enables/disables the=20
> DISPC video port.
>=20
> This way, a manual update panel would need to call only=20
> dsi_enable/disable_video_output(which just enables or disables the=20
> manager), whereas a video mode panel will need to call both.
>=20
> This is just a suggestion though. It's probably okay to have both in the=
=20
> same function too. We might have to separate them out later if we were=
=20
> planning to standardise mipi dsi across SoCs.

If you think from the panel driver's point of view, it doesn't know
about DISPC. It just wants to enable the video stream (on video mode
displays).

If we had two functions, could only the first be used? I.e. is it
possible to just enable the video mode transfer, without enabling DISPC?
If not, I'm not sure what would be the use for two separate functions.
And even if it can, I'm not sure what use it would be to enable only the
video mode output without the actual pixel data from DISPC.

It is true that the function in thsi patch is not the best one. For
command mode display it's more about reserving the ovl manager for use
than actually enabling it. Then again, how I thought the function's
purpose was that it enables the DSI video output, but because for
command mode there's need to trigger the actual frame transfer later,
the function doesn't start the pixel feed for command mode displays. It
just "prepares" the output.

But even if we had the functions separated, the function called by video
mode and command mode displays would be different, as for the former one
it enables the pixel stream, and for latter one it just reserves the
output.

So, I'm fine with changing the function, but the reasoning for what
functions we have and what they do should come from the panel driver's
perspective, not because of OMAP DSS's HW details.

 Tomi


--=-zYfjCvmJNk3D+hndusZF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJOzM4xAAoJEPo9qoy8lh71XMYP/jyNA7Gr/w0FrrHvrqYRUmPQ
RlM6tWwqJk809iC6Yjdn0UseN0GqXaT1nogGjC1T1NgZF9DHWgweshYlERe38tv2
y3WOoM2ydgnui+yot7RXyAQU51q4CbrIKuSVnaTR8/FTFvnxBVqCE4VYsnZZdXb1
XacAOW65bHioP+VlCKyXJkofkCOyCTFpzx+4g33p4C2tCOh9fyxILKznsAXj3f/u
er6l6Cx3mNEOrnRWUbdvx5kn5Gon3aK5idVnOh9/mO/snG0CabKdkvXjKaBKWlWk
ffxQVNsJEoG2ggaSQ8ujlFtQp3bdpMDp/qgs2bimpiJV8kuKZktB1nWmx2wIxwks
P7IfGKgAAHYv/BLM18edhP8u7b08pNtyaAR9AWa+MoMSxbz32ZlGrD/TgWFSWZ8r
ETVxFlgr1kg5faSEK1fDfMb0Mm5fc2besPn4T+m0dsou3LLb44TXf/OmRHggod9T
EdYOoDNm756HhC1GVcoeq+5SNCe4YIFdor5PKSovtKca/7ZFuLRcO/9/yJa3mIZA
M6CcupvXAF64tIRboAlJFKPcSgaG639OTT6NN+5S5E8lok6Tbqr41uiR+ADM6PY5
NKYia5mSJUy3petV0y+L6uGMBmPj2P+C6qb4pc+pvWbDAR0cj1CFWtI3DqkMz3at
/afBNTtaS+LTHM5ZW3OC
=8bhc
-----END PGP SIGNATURE-----

--=-zYfjCvmJNk3D+hndusZF--

