From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 6/6] OMAPDSS: VENC: Maintian copy of video output
 polarity in private data
Date: Thu, 16 Aug 2012 16:09:54 +0300
Message-ID: <1345122594.2534.49.camel@deskari>
References: <343817088-29645-1-git-send-email-archit@ti.com>
	  <1345102594-6222-1-git-send-email-archit@ti.com>
	  <1345102594-6222-7-git-send-email-archit@ti.com>
	 <1345117118.15132.7.camel@lappyti> <502CE727.6070906@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-y+LUQN4Ztx7Ame+L5E6v"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:50956 "EHLO
	na3sys009aog134.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756184Ab2HPNKB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Aug 2012 09:10:01 -0400
Received: by lbok6 with SMTP id k6so1686250lbo.37
        for <linux-omap@vger.kernel.org>; Thu, 16 Aug 2012 06:09:58 -0700 (PDT)
In-Reply-To: <502CE727.6070906@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-y+LUQN4Ztx7Ame+L5E6v
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-08-16 at 17:57 +0530, Archit Taneja wrote:
> On Thursday 16 August 2012 05:08 PM, Tomi Valkeinen wrote:
> > On Thu, 2012-08-16 at 13:06 +0530, Archit Taneja wrote:
> >> The VENC driver currently relies on the omap_dss_device struct to conf=
igure the
> >> video output polarity. This makes the VENC interface driver dependent =
on the
> >> omap_dss_device struct.
> >>
> >> Make the VENC driver data maintain it's own polarity field. A panel dr=
iver
> >> is expected to call omapdss_venc_set_vid_out_polarity() before enablin=
g the
> >> interface.
> >>
> >> Signed-off-by: Archit Taneja <archit@ti.com>
> >> ---
> >>   drivers/video/omap2/dss/dss.h        |    2 ++
> >>   drivers/video/omap2/dss/venc.c       |   13 ++++++++++++-
> >>   drivers/video/omap2/dss/venc_panel.c |    6 ++++++
> >>   3 files changed, 20 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/d=
ss.h
> >> index c17d298..b2cf5530 100644
> >> --- a/drivers/video/omap2/dss/dss.h
> >> +++ b/drivers/video/omap2/dss/dss.h
> >> @@ -479,6 +479,8 @@ u32 omapdss_venc_get_wss(struct omap_dss_device *d=
ssdev);
> >>   int omapdss_venc_set_wss(struct omap_dss_device *dssdev, u32 wss);
> >>   void omapdss_venc_set_type(struct omap_dss_device *dssdev,
> >>   		enum omap_dss_venc_type type);
> >> +void omapdss_venc_set_vid_out_polarity(struct omap_dss_device *dssdev=
,
> >> +		enum omap_dss_signal_level vid_out_pol);
> >>   int venc_panel_init(void);
> >>   void venc_panel_exit(void);
> >>
> >> diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/=
venc.c
> >> index 2d90fcf..8cb372f 100644
> >> --- a/drivers/video/omap2/dss/venc.c
> >> +++ b/drivers/video/omap2/dss/venc.c
> >> @@ -303,6 +303,7 @@ static struct {
> >>
> >>   	struct omap_video_timings timings;
> >>   	enum omap_dss_venc_type type;
> >> +	enum omap_dss_signal_level vid_out_pol;
> >>   } venc;
> >>
> >>   static inline void venc_write_reg(int idx, u32 val)
> >> @@ -447,7 +448,7 @@ static int venc_power_on(struct omap_dss_device *d=
ssdev)
> >>   	else /* S-Video */
> >>   		l |=3D (1 << 0) | (1 << 2);
> >>
> >> -	if (dssdev->phy.venc.invert_polarity =3D=3D false)
> >> +	if (venc.vid_out_pol =3D=3D OMAPDSS_SIG_ACTIVE_HIGH)
> >>   		l |=3D 1 << 3;
> >
> > Are you sure this is correct? I know practically nothing about analog
> > TV, but the TRM doesn't seem to say much about that bit, except it can
> > be used to "invert the video output". It doesn't say there's an
> > active/inactive level for the signal.
>=20
> Well, the code works :), I'm also not totally sure about whether it=20

You could put there APPLE and ORANGE enum values, and it'd still work =3D)

> should be represented as a 2-level signal, it seemed like it would be=20
> nicer to give it a signal level rather than keeping it as a bool, which=
=20
> could vary for other SoC's?

It may be really a bool. TRM says "This may be used to
correct for inversion in an external video amplifier". I don't think
there are any digital on/off signals in analog video output, so I'm
guessing it's really inverting (some parts of) the analog signal. If so,
a boolean invert field sounds correct to me.

Actually, check this out:

http://books.google.fi/books?id=3DP6BlcWaizHUC&pg=3DPT81&lpg=3DPT81&dq=3Dco=
mposite+video+polarity&source=3Dbl&ots=3D-gsl0Exv5R&sig=3DgMylEnoV9ozRwM4RX=
2iQFqhRpP8&hl=3Den&sa=3DX&ei=3D0u8sUIe3KYXh4QTf9YDQBA&redir_esc=3Dy#v=3Done=
page&q=3Dcomposite%20video%20polarity&f=3Dfalse

A monster url, here's a tinyurl version: http://tinyurl.com/clceb6t

2.16 section there shows signal polarities. I'm not sure if it's the
same one that we're discussing, but sounds like it.

I don't think ACTIVE_LOW/HIGH fits into that kind of polarity. Perhaps a
bool is not quite right for it either, as I'm not sure there's a
"normal" polarity. But I'd go forward with out current bool, and fix it
when somebody who understands this stuff tells us what to do =3D).

> I am considering not to pass this via the panel driver for now, I don't=
=20
> know if all VENC IPs needs to do this, maybe it's okay to leave this=20
> dssdev reference for now?

I don't know if other VENC IPs support this or not, but the TRM refers
to external amplifier, so it sounds like a thing that would exist on
other IPs also.

 Tomi


--=-y+LUQN4Ztx7Ame+L5E6v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQLPEiAAoJEPo9qoy8lh71id0P/0478lg0w5vBbDG1vETfLY5b
d8EuIXWAyroRfMSWdst5Lnm9cauQBrr65O5At+JSnXSsq/BcPvTOFLvfczpqdzYb
7L9CmvvcXIXPPlKLs4DnpWOgBByZ3nlm2zt9i4uhwGZ5LgydqA7twT20wJxVOyLT
yYrIrEidz+3EBbqxidBPH+W0/CZ626Lpevh54J52Iwd63tgX/5Gz9JrFqypY2vx4
hx2eVZB71JCWiaT3bbYrv+Wo0ifLeDFaNdVDEL35vG5abjBW3i8nB0P69I0GsC5b
c1+iETcD6qLo9mbLdZ/4X/x5s9UmB6Yk+0L1nIFLNsBbMgbzPkhw2mHBjv4hqPmP
CJ2cFWOCP2Ga7mVWUsW5IEI/58gqkTTMWMypaOG5Cu1LPxZ5RgtjqGeS9/s9TmT/
l94vUf3u9UaMZQcXacYg1GRGuYsbeVtvmf4P66u/k1F0UhO5E4kHTbha2lqVTJkX
aSfODtqxhIJbx+QTK3PCPXA+LGj1v5CmbPBEO8fZ04Wqby8myKLa4szjWcoScae0
NGkmYFjySzhE1enSfDAuJs94s0vCtSg7+MTYhzsnLOYRw7hf5c1qPm8FrK5J8/RV
Zg5QM9MUFtBwnYEbr/p9lQKdvaHuXGRwgln37Bip5qn4icWmVj+QOu5v6Vzaz7VH
LQiPyM2oWR+PA3odbvmJ
=pSP3
-----END PGP SIGNATURE-----

--=-y+LUQN4Ztx7Ame+L5E6v--

