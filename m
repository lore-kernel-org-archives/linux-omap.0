From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: Check if RPM enabled before trying to change
 state
Date: Thu, 28 Jun 2012 10:58:42 +0300
Message-ID: <1340870322.5037.15.camel@deskari>
References: <1340438771-25587-1-git-send-email-jaswinder.singh@linaro.org>
	 <1340605221.12683.30.camel@lappyti>
	 <CAJe_Zhf-H0dLtFsFAcryDy3av60RjmWmP+d3GSaxq8dNZKiXWw@mail.gmail.com>
	 <1340616643.3395.19.camel@deskari>
	 <CAJe_ZhftuNggxH+269-ZJbWJo5nSzSjo1dDCTQGMbsjPWoUpyg@mail.gmail.com>
	 <1340628094.3395.63.camel@deskari>
	 <CAJe_ZhetdEwrgDEfV9rLHU1_fmb3O+954hCKcoENBgQ6Bi6BXQ@mail.gmail.com>
	 <1340632161.3395.100.camel@deskari>
	 <CAJe_ZheHoCikVzy6zJoKHuL8_oQ0ZnPASUUWimvbPRr+AZ4zWg@mail.gmail.com>
	 <1340695166.2093.22.camel@lappyti>
	 <CAJe_Zhev3V85K1jhj+W+d+0kv132MZ=-7rChhCLgtWO7WN4u1w@mail.gmail.com>
	 <1340701660.24530.17.camel@deskari>
	 <CAJe_Zhd-LA67yO-H_7pacB_T8_z6=Zf47QuoHSJcsXDZ9S+byw@mail.gmail.com>
	 <1340712213.24530.21.camel@deskari>
	 <CAJe_ZhcxVAUuuMDZ8p1LVae4N2aZb_vFs_nRLfb7atJ2j6j=Sg@mail.gmail.com>
	 <1340723296.24530.68.camel@deskari>
	 <CAJe_ZheMN_sqaANSMepmhDDp2a2sQAVPYD1-owBWpwwbxqAtHQ@mail.gmail.com>
	 <1340723514.24530.70.camel@deskari>
	 <CAJe_ZheXSquxOtOD9iPyQjZ-jxWKzVGZHYkjM=wC37qgMZeJug@mail.gmail.com>
	 <1340736243.24530.98.camel@deskari>
	 <CAJe_ZheovnRsJ6opMPkMxwjLSv-OKBPCHu5rsAX_KNz1mb64ZQ@mail.gmail.com>
	 <1340776683.1972.41.camel@lappyti>
	 <CAJe_Zhdz5mAZbyer8fL4YfvcQ8xMF31cPG2zr3AbBNWv8nctnw@mail.gmail.com>
	 <1340784821.2649.17.camel@deskari>
	 <CAJe_ZhdOiv8NgMB37h5_X_reK+urxVykW1tHDF9S50VVUvX=4g@mail.gmail.com>
	 <1340865706.2090.27.camel@lappyti>
	 <CAJe_Zhf+Yihu+tJbUxYYoKhW9uvKdEoaVk0v_Goz-oATz+Jncw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-alXAkbkSlXqdh/vaCFt8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:49326 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751400Ab2F1H6s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 03:58:48 -0400
Received: by lbgc1 with SMTP id c1so2491022lbg.15
        for <linux-omap@vger.kernel.org>; Thu, 28 Jun 2012 00:58:45 -0700 (PDT)
In-Reply-To: <CAJe_Zhf+Yihu+tJbUxYYoKhW9uvKdEoaVk0v_Goz-oATz+Jncw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com


--=-alXAkbkSlXqdh/vaCFt8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-06-28 at 13:16 +0530, Jassi Brar wrote:
> On 28 June 2012 12:11, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > On Wed, 2012-06-27 at 20:23 +0530, Jassi Brar wrote:
> >> On 27 June 2012 13:43, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> >> >
> >> > I don't like it at all that omapdss disables and enables the panels =
in
> >> > omapdss's suspend/resume hooks. But I'm not sure how this should wor=
k...
> >> > Should panel drivers each have their own suspend/resume hooks, and
> >> > handle it themselves? Or should the call to suspend/resume come from
> >> > upper layers, like omapfb or omapdrm.
> >> >
> >> > I made a prototype patch a few weeks ago to move the suspend to omap=
fb,
> >> > and it feels better than the current one, but I'm still not sure...
> >> >
> >> IIUC, I have similar opinion.
> >> Each panel having its own suspend/resume sounds like inter-dependency =
trouble.
> >
> > What do you mean with that? If we just consider omapdss and the panel
> > drivers, I see no dependency trouble. Panels are independent of each
> > other, and omapdss is supposed to handle any locking & refcounting
> > related to multiple panels already, as from omapdss's point of view
> > panel suspend is the same as panel disable.
> >
> > And if we take omapfb/omapdrm into equation, well, in any case it
> > couldn't be any worse than the current one where suspend is handled by
> > omapdss.
> >
> I just anticipate it not trivial keeping  omap_dss_device.state in
> sync with omap_dss_driver.suspend/resume
> when the latter is made system suspend/resume and former still
> affected by hdmi_panel_disable/enable.

This state variable is something I'd like to get rid of. While I think
it could work fine if we added some locking to omap_dss_device, I'd
actually like to get rid of omap_dss_device also. (totally another
issue, let's not go there).

But anyway, the state variable should only be written by the panel
driver, so I don't see a big problem there. The panel's
disable/enable/suspend/resume touch the state, but the panel driver
should protect that with a mutex.

> Perhaps .disable and .suspend would need merging?

Yes, I already have a patch that removes suspend/resume from
omap_dss_device, as they are identical to disable/enable. I haven't
merged it yet, as there's some funny code in omapdrm that breaks after
the change, and I haven't had time to look at it.

> But as I said, it 'sounds' like.  It all may be straight forward - you
> would know better.
>=20
>=20
> >> I too would prefer suspend/resume propagating from omap-fb/drm, which
> >> imho fits better with the notion of a linux device(omapdss is only
> >> backend). Though I don't have strong feelings about how core then take
> >> various panels up/down optimally.
> >
> > One one hand, I see the combination of omapdss (or the "output" side of
> > omapdss) and a panel as a whole entity. I mean, if you just load omapds=
s
> > and a panel driver, but no omapfb/omapdrm, you already have a working
> > panel. You don't _need_ omapfb/omapdrm there. And in that sense it'd
> > make sense if the panels did handle their own suspend/resume.
> >
> Well, I would think if omapdss+panels (backend) serve none other
> omapfb/drm, they should simply lie dormant hogging no resources if the
> omapfb/drm driver isn't loaded (if that isn't already the case).

That should be the case.

I need to look more carefully what fb/drm already do. If they already
have good suspend mechanisms and expect to be the ones handling system
suspend, then I guess the choice is quite clear.

 Tomi


--=-alXAkbkSlXqdh/vaCFt8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP7A6yAAoJEPo9qoy8lh71GbAP/3l4hxg1nJdgvaKJjstq4MCz
oGlPA5wGAIn+Gmlhum+um2iTITGKPYHPN0Cip2K3IHkAdV37gIqGUXTprtaVPVT/
ZwKmD2Q5/fAlgXvUmkkh8yK4jSxKQd+8ZjRkYC6lw8eCCwkAeld/XHMeDKm2EtmY
An0Bu7CrO/De5yFGTfvnU1yc3qoeWOLNUO0ZASyT/NWXlRuFeyIpt0pdSg3Ryxlj
oOpLbskX/qBN+pEewVSzSWmvf0gL/hiCl68FclWM7gPAIv4M03WNYWwr4GLwWvIc
Ss/G+7bxAGJ5rnJV+CYnvPy4ylYNZeuSTHoTKHM+CdFs15s+Oeum0CxfZ2ln1EsP
oS3T2LPk0uWlVw3v2Idf+pDiuAKWcL+2KBq2uwYznZj+8Tm6N8e1ritXho2LIZ9K
ah9RU+oI2mSJep4EVpLBz0YGkxWPTA06jsa1zQ3i/XgCEXs+peOuWcaq0ZxmhvgO
Esuo3J++S2Q0zHD+mgPWBoGImZ2sJi9PG2zaqd5mvcFthfYPOcqdMpbKQXe8Ae4S
fG0rVPs1T02J1f3qhOT8Nrbp4oXR5CauxNdyFi0atyMv+OnhyEwxQHOO5oIb1kWY
DVV08p1k2Lut6CpDiO0lmQRrBlDicBsgmLizkFJy/mwor/ltMlkbAdUmfxl5vdO+
w7ipbgdCGg+XHn39Nzcj
=Gr0M
-----END PGP SIGNATURE-----

--=-alXAkbkSlXqdh/vaCFt8--

