From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: Check if RPM enabled before trying to change
 state
Date: Wed, 27 Jun 2012 11:13:41 +0300
Message-ID: <1340784821.2649.17.camel@deskari>
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
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-1uoi3fgK/Gn5/cy4ErLx"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:33531 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756138Ab2F0INv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Jun 2012 04:13:51 -0400
Received: by lbbgm6 with SMTP id gm6so1393310lbb.5
        for <linux-omap@vger.kernel.org>; Wed, 27 Jun 2012 01:13:47 -0700 (PDT)
In-Reply-To: <CAJe_Zhdz5mAZbyer8fL4YfvcQ8xMF31cPG2zr3AbBNWv8nctnw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com


--=-1uoi3fgK/Gn5/cy4ErLx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-06-27 at 13:11 +0530, Jassi Brar wrote:
> On 27 June 2012 11:28, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> >
> > It doesn't matter how omapdss is organized, -EACCES _is_ an error. It
> > tells us that something unexpected happened, and we should react to it
> > somehow.
> >
>   $ git show 5025ce070
> Exactly how omapdss is organised is the reason -EBUSY isn't an error ther=
e :)
> Otherwise, omapdss should panic that somehow 'imbalance' has been
> introduced in rpm.

There's no imbalance there, as each get() is still matched by a put(),
and the use count is correct. Your patch may cause either get or put to
be skipped.

In 5025ce070 the function in question is dss_runtime_put(), and -EBUSY
_is_ an error there. Normally if you call pm_runtime_put_sync() and the
use count drops to zero, the device should be suspended. In this case,
however, it won't be suspended as a child device is still enabled. Thus,
the framework informs about this with -EBUSY.

It's ok to ignore -EBUSY, because we're not really interested about if
the device is actually suspended or not.

However, dispc_runtime_get() is a different matter, because there we
_are_ interested about the state of the HW. If we skip
dispc_runtime_get() because runtime PM is disabled, we don't know
whether the HW is enabled or not.

And even if your patch was modified to check the HW status after
pm_runtime_enabled(), and return 0 is HW is enabled and an error if HW
is disabled, it'd be wrong, because you skip the pm_runtime_get() call.
This means that the use count is not increased, and there's no guarantee
that the HW would be functional after dispc_runtime_get() returns.

> > Sure, in the current omapdss neither is a breaking problem, because 1)
> > the matching dispc_runtime_put() is called also with runtime PM
> > disabled, and thus we don't decrease the use count, and 2) the HW
> > happens to be already enabled. But that's just by "luck", and tomorrow
> > omapdss could be different.
> >
> It's no 'luck', but it's because today omapdss takes proper care of PM
> enable/disable and get/put.
> Rather, if tomorrow that stops working, it would hint that we managed
> to screw up the balance.
> Because if omapdss suspended and disabled PM on DISPC, and still HDMI
> attempted to access dss regs, that clearly means HDMI hasn't been duly
> made aware of the DISPC status.

There are two different things here. First one is how
dispc_runtime_get/put & co. should work. The second is how they are
used.

As I see, you are arguing that it's ok to have dispc_runtime_get/put
broken, as long as they are used in a way that causes no problems.

> Just as preemption and suspend/resume don't introduce any race in
> locking, RPM won't introduce new imbalance in get/put of omapdss.
>=20
> I am afraid, we won't reach any eureka moment on this, so I would
> leave us to our conditions. This patch and discussion made me look
> deep into rpm, I thank you for that and for your patience.

Yes, same here. I think this discussion and related code digging has
really improved my understanding of runtime PM =3D). Perhaps I'll get it
correct this time with this new information.

There's still the system suspend, which I think is quite broken. The
patch I gave fixes it for the time being, but I see it as a temporary
solution.

I don't like it at all that omapdss disables and enables the panels in
omapdss's suspend/resume hooks. But I'm not sure how this should work...
Should panel drivers each have their own suspend/resume hooks, and
handle it themselves? Or should the call to suspend/resume come from
upper layers, like omapfb or omapdrm.

I made a prototype patch a few weeks ago to move the suspend to omapfb,
and it feels better than the current one, but I'm still not sure...

 Tomi


--=-1uoi3fgK/Gn5/cy4ErLx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP6sC1AAoJEPo9qoy8lh71cq4P/3GF3lCSWKZOY7Bo5+gAA4rE
iagXNvYgg1J5hIjAkAn/leMkCUs0Y35Y7GfdLfJTJ7G6clRV6OB44w7oQuEYcZIT
xSZpi10BLKbrsAS6t1jofAV0XsJAdxQ5Shkt5wIgCe+w59qH6c/i47hLg2jkp64p
vZuSt7ww56QJbLFloALgxGhnhyTg6Ylq/qi1Vfb/PIYclvPZqHsm1/h58shEjUI9
qFKcYAXvB4SLnQjWUmmnTuWAlOq8UrnFS+PoItYP7eJ8FRhKSyCsrLP6zKzf1xRZ
EYD53R3PHjZZQDDxp0zEZx7nuvse1BHvlw5Vy1rClaEDFQVwLddF9LAa6/LLw5PC
ga3IV8EZh+JFnknnWZxOft4/kBowj1a3cNZO9mtGZI9QB1izsPe+X/AnBn3oAYZy
TZS6bdNeM7w3z+SKidX9Syv3dfeMSwVuFnYHUn+J8qoJO/ilfyjF/y7jGX7rvDgW
1YNcCI7yCxRqjqXfzefgc6MhRPO+Q4a3Z+UlQwneEKm6DxMthicWqQfxb/qi2s+a
weUgcVM4evB/ZOQq/zypj2gYK9JfFGpN5ojef0yM/YiMi01ixTBUbrza1ReyMAlu
p3q69aBxF5vidn3MdAx7i9wnNnv5c9vJ6yJBpdgRpkAa8soKlyuWN0zlS43cWxe+
rPeDxUbmScQu+0mRSzlo
=b/57
-----END PGP SIGNATURE-----

--=-1uoi3fgK/Gn5/cy4ErLx--

