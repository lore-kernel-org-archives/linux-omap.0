From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: Check if RPM enabled before trying to change
 state
Date: Wed, 27 Jun 2012 08:58:03 +0300
Message-ID: <1340776683.1972.41.camel@lappyti>
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
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-Y+k2tI8dvwJj2CQ4/F/N"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:38050 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756080Ab2F0F6J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Jun 2012 01:58:09 -0400
Received: by lbbgj10 with SMTP id gj10so1349853lbb.23
        for <linux-omap@vger.kernel.org>; Tue, 26 Jun 2012 22:58:06 -0700 (PDT)
In-Reply-To: <CAJe_ZheovnRsJ6opMPkMxwjLSv-OKBPCHu5rsAX_KNz1mb64ZQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com


--=-Y+k2tI8dvwJj2CQ4/F/N
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-06-27 at 10:12 +0530, Jassi Brar wrote:

> > True. But the HW could also be in disabled state. And that would lead t=
o
> > a crash when accessing the registers.
> >
> > It is not a fatal error if pm_runtime_get returns -EACCES, but we sure
> > shouldn't ignore it (or avoid it with pm_runtime_enabled()), but handle
> > it. In some rare cases it could be ok to get -EACCES, but that's a
> > special case, not standard.
> >
> You are mixing up generic concepts with what we have in omapdss.
> Believe me, I do understand it's bad to proceed without caring for
> returned _errors_.
> The way omapdss is organized -EACCESS is _not_ an  error, it just
> denotes PM is disabled on the device and that DISPC is in RPM_ACTIVE
> is backed by the fact that HDMI always hold a reference between
> resume-suspend and DISPC goes to suspend last and resume first.

I'm not arguing that your solution would not work with the omapdss code
we have now, and presuming the underlying frameworks work fine. But I
want omapdss to have code that works also in the future, when other
parts of omapdss change.

It doesn't matter how omapdss is organized, -EACCES _is_ an error. It
tells us that something unexpected happened, and we should react to it
somehow.

When we call, for example, dispc_runtime_get(), we normally expect that
runtime PM is enabled, and it 1) "gets" it, increasing the use count,
and 2) makes sure the HW is enabled so it can be used. Your patch breaks
both of these if runtime PM is disabled.

Sure, in the current omapdss neither is a breaking problem, because 1)
the matching dispc_runtime_put() is called also with runtime PM
disabled, and thus we don't decrease the use count, and 2) the HW
happens to be already enabled. But that's just by "luck", and tomorrow
omapdss could be different.=20

If, for some reason, we need to call dispc_runtime_get/put during
suspend, the caller should either 1) realize that we're suspending,
runtime PM is disabled, but the HW is anyway enabled, and thus skip
calling both get and put, or 2) call both get and put, but handle the
-EACCES, understanding what it means and knowing the HW is anyway
enabled.

 Tomi


--=-Y+k2tI8dvwJj2CQ4/F/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP6qDrAAoJEPo9qoy8lh71CtgP/jslQ04zEyEB9jPrgUUEio4L
Jpvi6xc24Yai8T+f0u4RNeov5s5EQRNj/XOB9tWMe1yY2/x4abrLjYfxHE8molwb
Ltdd5r8D2APPjo2Rz/Mpdb5d4hweKV97Op4iZBVWO+UbQ5KwyvsAd/YBC9jMXuaW
fucEV2V9mZI3TxXcsK/tJnzN064jkjpzxxXeyPC2T8OBQocskzGbuCt3OWjuqu8K
wOqc5bZg8Dvmtt7qnmY+erqCLGbxBi08iJM9JIcQI4BdYvBaqoph8phyzl3b/i5b
8g/+sQ0P1yA4d09v9Axf27OrIQZTEgdhMFLrziAYbf0tGuYZ2MPN+iKetrN8m4HO
befuLinQ8aBw/WCsRXVCajgmi4zXrktMi9gRae90JJygxS2VV3SnsxYxuhPH5tha
1vSC0F4tXKOAjkIMWqVJ+AZHMMo4sNiktVuoI22NBJNf///GIrSBSvlGMOV/z1Fn
rZPYOumFqwMW/ytSVL8P4B+RfFOuGApKFgfQm5YvTuPrB8vZjNK751fGM5rSP6yT
5waq4f4RHdAsIvd6DdDpyJrsc59rMV4nSvudiH5sP8zw59R/HYPIoc2z5k73r+DD
V0mv8MbAtVT9SP7bw0JaAzbNoWNmV3aPGg04EMBll6UOcJlQ6635K9v91JMWvIuj
Z6nc6c3Ozn/wA7l8IzFZ
=wNud
-----END PGP SIGNATURE-----

--=-Y+k2tI8dvwJj2CQ4/F/N--

