From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: MUSB peripheral DMA regression caused by driver core runtime PM change
Date: Wed, 28 Oct 2015 12:16:16 -0500
Message-ID: <878u6m52xr.fsf@saruman.tx.rr.com>
References: <20151021234134.GQ3078@atomide.com> <20151022180216.GT3078@atomide.com> <20151022230133.GV3078@atomide.com> <562A2D0D.3060104@ti.com> <20151023163957.GW3078@atomide.com> <877fmdcyzi.fsf@saruman.tx.rr.com> <20151028171441.GE3078@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151028171441.GE3078-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> writes:
> * Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> [151023 09:48]:
>>=20
>> Hi,
>>=20
>> Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> writes:
>> > From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>> > Date: Fri, 23 Oct 2015 09:03:22 -0700
>> > Subject: [PATCH] usb: musb: omap2430: Fix regression caused by driver =
core
>> >  change
>> >
>> > Commit ddef08dd00f5 ("Driver core: wakeup the parent device before try=
ing
>> > probe") started automatically ensuring the parent device is enabled wh=
en
>> > the child gets probed.
>> >
>> > This however caused a regression for MUSB omap2430 interface as the
>> > runtime PM for the parent device needs the child initialized to access
>> > the MUSB hardware registers.
>> >
>> > Let's delay the enabling of PM runtime for the parent until the child
>> > has been properly initialized as suggested in an earlier patch by
>> > Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>.
>> >
>> > In addition to delaying pm_runtime_enable, we now also need to make su=
re
>> > the parent is enabled during omap2430_musb_init. We also want to propa=
gate
>> > an error from omap2430_runtime_resume if struct musb is not initialize=
d.
>> >
>> > Note that we use pm_runtime_put_noidle here for both the child and par=
ent
>> > to prevent an extra runtime_suspend/resume cycle.
>> >
>> > Let's also add some comments to avoid confusion between the
>> > two different devices.
>> >
>> > Fixes: ddef08dd00f5 ("Driver core: wakeup the parent device before
>> > trying probe")
>> > Suggested-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
>> > Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>>=20
>> I'm fine with this patch to fix this v4.3 regression. Greg, do you want
>> a pull request or can you take this in as a patch ? In any case:
>>=20
>> Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>
> OK no response for a few days, so I'll pick this up into
> omap-for-v4.3/fixes as I have another fix there too.

all right, thanks


=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWMQLhAAoJEIaOsuA1yqREAsMP/3keiEkk4z6XtCqfFigi0VB0
mm0U7mcj0VghfwLxNPCq2NLtHGJPFL3bPZ4rk2zpqCJ2+ryfvLJ7tvM8UtAY1pIP
ObTbU0TBhRPpZEhkTQMsLMdvq1DyMbuGfXJlxxIq0Ipe0dLHO5qP2DmX2PVJfDpP
SBK4GMaE33jqJhGf1RIIaejci+eDpGWovMx+UFyjUlkE1koaW6Hc9i2SJeyBsGKI
zqDoWI2By9FxdOoV1CfKXV/mmzP4b+lwI67oZ0I6zbSmtFJzJNDAkLYvOiJTCzQw
6JGmhmqW9T646kD2nuuxweb3XB2nGlLHOsNPRE/L+6hKhwlpSlpF3PRbZXuRnZYg
wXjETGxGtXFKXuqdw4PKFamxIJdRO54cmcq18OW0LXa8X+IMAh8fex/8whf+Xw0/
TGlrqNhLuOl753jPAOi5N+VGhzvhx9jiUtqff+k7kExPFG79X04K9wjsWAnkPjfj
kAZSrdybIiR8pVlg8I2yLhGgum5ZROszjqDLKmqQZnCwN9KTp33Bml+kZ8gIV42N
S9iPdZXteIxpstNe7gh7nZG+FONVTJf3DSakmu5HL9Qk2sod9UyoNjIb7pWDVqgO
g17hToET4W2Qdjb5itD7fjUIUxbPL8ts6qhV2tpZvQmCeGG8H+la++9Ely/kEsFU
T4vNwZhpOzrtLAA5xFqP
=jJM0
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
