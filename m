From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 14/14] OMAPDSS: HDMI: Implement DSS driver interface
 for audio
Date: Wed, 09 May 2012 11:28:01 +0300
Message-ID: <1336552081.3962.15.camel@deskari>
References: <1336095848-6923-1-git-send-email-ricardo.neri@ti.com>
	  <1336095848-6923-15-git-send-email-ricardo.neri@ti.com>
	 <1336390986.2667.8.camel@deskari> <4FA9B289.5000101@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-vU/UqySzAPwAc1aDTg/9"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:55834 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751641Ab2EII2H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 04:28:07 -0400
Received: by lahj13 with SMTP id j13so10190lah.11
        for <linux-omap@vger.kernel.org>; Wed, 09 May 2012 01:28:04 -0700 (PDT)
In-Reply-To: <4FA9B289.5000101@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: mythripk@ti.com, s-chereau@ti.com, x0055901@ti.com, vaibhav.bedia@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, agraf@suse.de, research@ottomaneng.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org


--=-vU/UqySzAPwAc1aDTg/9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-05-08 at 18:55 -0500, Ricardo Neri wrote:
> Hi Tomi,
>=20
> Thanks for taking the time to comment.
>=20
> On 05/07/2012 06:43 AM, Tomi Valkeinen wrote:
> > Hi,
> >
> > On Thu, 2012-05-03 at 20:44 -0500, Ricardo Neri wrote:
> >> Implement the DSS device driver audio support interface in the HDMI
> >> panel driver and generic driver. The implementation relies on the
> >> IP-specific functions that are defined at DSS probe time.
> >>
> >> At the moment, a hardirq-safe spinlock is used to protect the audio
> >> functions. This is because such functions might be called while
> >> holding a lock (this especially true for audio_start/stop). For the
> >> rest of the audio functions, a mutex could be used in the future as
> >> the enablement of resources might take too much time.
> >
> > The series looks good, except locking. Granted, the locking in omapdss
> > is a bit bad generally also, but here I think it's a bit more broken.
> >
> > For example, hdmi_panel.c:hdmi_panel_audio_supported() takes the audio
> > lock, and then uses variables like dssdev->state, and the hdmi video
> > mode. However, the video functions do not use audio lock, so effectivel=
y
> > the lock doesn't protect at all.
>=20
> Yes, it does not protect.
> >
> > I'm not sure how to fix it, though. I think this shows the shortcomings
> > of the current locking strategy (or lack of =3D). What if the audio

Btw, I meant shortcomings in the general DSS locking strategy, not the
locking in this particular patch.

> > functions that can sleep would take the hdmi panel's mutex, and also th=
e
> > audio spinlock? That would at least fix some of the cases.
>=20
> But if the function can sleep, protecting it with the HDMI panel's mutex=
=20
> should be enough, shouldn't it? Wouldn't it be pointless to also hold=20
> the spinlock?

If the start/stop functions use the spinlock, but not the mutex, then
the sleeping functions should also use the spinlock to prevent touching
the same data at the same time.

> Ideally, I think, only one lock, the HDMI panel's mutex, should be=20
> enough to protect the HDMI panel's functions, including the audio=20
> functions. Reusing the HDMI panel's mutex for the audio functions would=
=20
> prevent the situation you describe regarding=20
> hdmi_panel.c:hdmi_panel_audio_supported()... and the spinlock would not=
=20
> be required.
>=20
> The only functions that cause problems with this approach are=20
> audio_start/stop as ALSA calls them while holding a spinlock. The=20
> spinlock could be used for these as they dont read or write the panel's=
=20
> variables.

Locks always protect a particular piece of data. What is the data in
this case, if not panel's variables? DSS registers?

> However, holding a spinlock only when start/stopping audio would fail,=
=20
> for instance, if someone starts/stops audio while enabling or=20
> configuring audio; but that would be an issue in the design of the=20
> component using DSS HDMI audio, wouldn't be? To prevent that, an=20

I guess it's up to us to decide what is the supposed use-patter of the
functions =3D). For dss functions in general it's pretty vague and
non-defined. But we could start here with audio functions and define
that the audio functions may not be called from multiple threads at the
same time. That would remove any issues with concurrent calls to audio
functions, presuming the audio side actually conforms to this =3D).

But the video and audio paths are probably always separate, and for
those we need protection. As you said, using the mutex for the may-sleep
audio functions solves the issue for those, leaving start/stop as the
only problem case.

However, even if we could protect start/stop with locks, we still have a
problem (which is general problem related to dss locking): we don't have
any protection between the function calls. So basically this could
happen:

[video thread] setup video & enable
[audio thread] check that all is ok, and configure audio
[video thread] change video config or disable video
[audio thread] start_audio -> fails, because video config no longer
valid for audio

But I guess we have to accept that the locking is not perfect, and try
to solve it properly later, as it's a bigger, dss-wide change.

 Tomi


--=-vU/UqySzAPwAc1aDTg/9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPqiqRAAoJEPo9qoy8lh71zZ4P/0Kga9n+ywloz6fjZxMdBhD1
S+HPMVC8vhe7yiP8T86aq8B0o1BmsNqKPuGcBAZAwY0eJaI6zAhO7fnHgZM5YCYV
dyMUpJkjJt90b1Z1YJmkL+veMQc8+CysX4LjERbPGrAr2eVr2V4fFWySYZtMk0Ly
WEJ7fSxPvrs0f8CmJmrT27EiTTxgh/Q5BkP6TVZYBeVuXm2g5DBeiaOYUwADavJ7
KoweJDAY1RrnrfwgPZlJ6s0xFR67CLeLVi3CdgE9XnZwZayKSmOp+O1FtljCoyzv
Xki/12ZnH8qz+X4VALQu2vj8U8A47OIXOyLrDvbHpPGKx4FE/IR3GCy2ZQqVXyUb
tuhj7tJDhdLUgfH2GZNgwm+QwmQLDraBxsh2ct+ef1h0FngKBx2nIZBN6gIvOhx1
jJCvb31wbCCYCV16XAEhbId5tIViGWo4yMmJJRcB13ShF35x86SPUhpHLYhh229e
v9f72Gk3SqK6+PylpygaBWqHWz9WdRAPdR7vf5W+ORh+FrQchmvdwVCv5PbxvTcC
phZ1y7Duz4Q/R9sgqUAijqTZggVOAoFFmpIgIOdSWWE8ZqYdfjUkKjL6gxnH8dTv
cZAZBrP4AhAwGKXrlFSzcvhZJCZldRS/jDS4Zd80Giroy9VDSlIdULuNeuNKfc42
jcoDqUaW/n0I/qbmk7sl
=PD9V
-----END PGP SIGNATURE-----

--=-vU/UqySzAPwAc1aDTg/9--

