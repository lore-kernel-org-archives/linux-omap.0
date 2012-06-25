From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: Check if RPM enabled before trying to change
 state
Date: Mon, 25 Jun 2012 15:50:48 +0300
Message-ID: <1340628648.3395.69.camel@deskari>
References: <1340438771-25587-1-git-send-email-jaswinder.singh@linaro.org>
		 <1340605221.12683.30.camel@lappyti>
		 <CANOLnOOodXtqV7Hs-SsEUfB3Uo1PSGb8bkaeN7M48jVpQrb-cA@mail.gmail.com>
	 <1340627459.3395.54.camel@deskari> <4FE85CCA.80903@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-ixcGel0ROyI1dY+1BcT1"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:37543 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756070Ab2FYMuq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Jun 2012 08:50:46 -0400
Received: by eaal1 with SMTP id l1so1273454eaa.6
        for <linux-omap@vger.kernel.org>; Mon, 25 Jun 2012 05:50:40 -0700 (PDT)
In-Reply-To: <4FE85CCA.80903@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, jaswinder.singh@linaro.org, mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com


--=-ixcGel0ROyI1dY+1BcT1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-06-25 at 18:12 +0530, Rajendra Nayak wrote:
> On Monday 25 June 2012 06:00 PM, Tomi Valkeinen wrote:
> > On Mon, 2012-06-25 at 15:05 +0300, Grazvydas Ignotas wrote:
> >> On Mon, Jun 25, 2012 at 9:20 AM, Tomi Valkeinen<tomi.valkeinen@ti.com>=
  wrote:
> >>> On Sat, 2012-06-23 at 13:36 +0530, jaswinder.singh@linaro.org wrote:
> >>>>
> >>>>   Currenlty HDMI fails to come up in the suspend-resume path.
> >>>> This patch helps that real-world scenario.
> >>>
> >>> What is the problem there? It'd be good to explain the problem in the
> >>> patch description. Does the pm_runtime_get return -EACCES?
> >>
> >> On slightly different but related issue, currently OMAPDSS always
> >> spits lots of backtraces when it's compiled without CONFIG_PM_RUNTIME,
> >> because pm_runtime_put* always return -ENOSYS without
> >> CONFIG_PM_RUNTIME. So something like this patch proposes is needed, or
> >> maybe WARN_ON should check for -ENOSYS, I don't know..
> >
> > Hmm. I guess I'm missing some understanding about runtime PM. omapdss
> > uses runtime PM to enable the underlying DSS hardware. If there's no
> > runtime PM, how does the driver work? Or is it the job of
> > hwmod/omap_device to keep all the hardware always enabled if runtime PM
> > is not compiled in?
>=20
> Yes, the below trick keeps all hwmods always enabled post the initial
> setup if runtime PM is disabled.
>=20
> from arch/arm/mach-omap2/io.c
>=20
> static void __init omap_hwmod_init_postsetup(void)
> {
>          u8 postsetup_state;
>=20
>          /* Set the default postsetup state for all hwmods */
> #ifdef CONFIG_PM_RUNTIME
>          postsetup_state =3D _HWMOD_STATE_IDLE;
> #else
>          postsetup_state =3D _HWMOD_STATE_ENABLED;
> #endif
>          omap_hwmod_for_each(_set_hwmod_postsetup_state, &postsetup_state=
);
>=20
>          omap_pm_if_early_init();
> }

Ah, ok, thanks.

Do you know how the drivers should handle CONFIG_PM_RUNTIME=3Dn?
Are they supposed to handle the error values returned by runtime PM
functions somehow, or should they use #ifdef CONFIG_PM_RUNTIME?

Both options sound a bit difficult to me... With the first one it's
difficult to see if there was an actual error and we should somehow
react to it, or is everything fine and we just shouldn't care about
runtime PM. The second one requires ifdefs in many places.

 Tomi


--=-ixcGel0ROyI1dY+1BcT1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP6F6oAAoJEPo9qoy8lh71xH4P/jRWTw+QkuQr8S9LAoRhHaZa
5f0YwsyVhbn9Nfjyj/E7XRYLjO7UL//ud6V8cHbDIFBvmzjpfc1Cfe0kfuIrUDPC
YhK3ZSb0B773A16Ogu8VZB1T4qP2CVZnT+xMlEsg6qFK15c986RNx61SVoSW4iTO
yAbOYvAXrbtTsbvh4S151V8QbofC9e1vQdqhHYcNwIK9El0zsZ0/EhEAuFKa6sgR
DQQTxMsBC0V+Q1cF38IHuasAWyqOuU/my2Ucj/3kTQdmt4Bt/W9dnVWoX+dGeeVS
ol/0YTFOhIRr3fDiGeE4yhQgkQzLdcV1sKIHNMYbCk8BpWlZd8LGHCYRj8j4KH00
L4RfyvXYQ25R8ZUrZG+t/i+pTM0ld40wXDx6qm79HuEuhnj9bVXSCrr9FXXhKcV4
9JOv9VjOU7t4QQ8mYHxuW/vYxixaxXxCEuAsVdR481fgQASGGBZB4dW+q00ou5ld
yNDiqxh3IQnjcxC+JuPih35KIuaaJy3M7tPvYPDeJeKvwGLnRHm+uX4T8uCpd8Ri
aSJjZDS6VZrodujiEaQt2ORZplHqOENPKxLdxEcbz3AwpO3rwUP6vxCCdVbU4yqV
kryZNz/l1ucvagQtxc/WVS338rJRRH8HO9Hu5dSkBU7Me+zjYtTnpKenwzJL4Qf/
t0wqM3Gxlhw+ecmNxGAJ
=lG9x
-----END PGP SIGNATURE-----

--=-ixcGel0ROyI1dY+1BcT1--

