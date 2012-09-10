From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [RFC PATCH v2] OMAPDSS: Fix IRQ unregister race
Date: Mon, 10 Sep 2012 10:49:05 +0300
Message-ID: <1347263345.8127.22.camel@deskari>
References: <201209071742.11735.dinuxbg@gmail.com>
	 <1347116753-17064-1-git-send-email-dinuxbg@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-XT+gQZxWSO/ukPTt/Jn/"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:55651 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751772Ab2IJHtL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Sep 2012 03:49:11 -0400
Received: by lagy9 with SMTP id y9so904165lag.19
        for <linux-omap@vger.kernel.org>; Mon, 10 Sep 2012 00:49:08 -0700 (PDT)
In-Reply-To: <1347116753-17064-1-git-send-email-dinuxbg@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dimitar Dimitrov <dinuxbg@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-XT+gQZxWSO/ukPTt/Jn/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2012-09-08 at 18:05 +0300, Dimitar Dimitrov wrote:
> Very rare kernel crashes are reported on a custom OMAP4 board. Kernel
> panics due to corrupted completion structure while executing
> dispc_irq_wait_handler(). Excerpt from kernel log:
>=20
>   Internal error: Oops - undefined instruction: 0 [#1] PREEMPT SMP
>   Unable to handle kernel paging request at virtual address 00400130
>   ...
>   PC is at 0xebf205bc
>   LR is at __wake_up_common+0x54/0x94
>   ...
>   (__wake_up_common+0x0/0x94)
>   (complete+0x0/0x60)
>   (dispc_irq_wait_handler.36902+0x0/0x14)
>   (omap_dispc_irq_handler+0x0/0x354)
>   (handle_irq_event_percpu+0x0/0x188)
>   (handle_irq_event+0x0/0x64)
>   (handle_fasteoi_irq+0x0/0x10c)
>   (generic_handle_irq+0x0/0x48)
>   (asm_do_IRQ+0x0/0xc0)
>=20
> DISPC IRQ executes callbacks with dispc.irq_lock released. Hence
> unregister_isr() and DISPC IRQ might be running in parallel on different
> CPUs. So there is a chance that a callback is executed even though it
> has been unregistered. As omap_dispc_wait_for_irq_timeout() declares a
> completion on stack, the dispc_irq_wait_handler() callback might try to
> access a completion structure that is invalid. This leads to crashes and
> hangs.
>=20
> Solution is to divide unregister calls into two sets:
>   1. Non-strict unregistering of callbacks. Callbacks could safely be
>      executed after unregistering them. This is the case with unregister
>      calls from the IRQ handler itself.
>   2. Strict (synchronized) unregistering. Callbacks are not allowed
>      after unregistering. This is the case with completion waiting.
>=20
> The above solution should satisfy one of the original intentions of the
> driver: callbacks should be able to unregister themselves.
>=20
> Also fix DSI IRQ unregister which has similar logic to DISPC IRQ handling=
.
>=20
> Signed-off-by: Dimitar Dimitrov <dinuxbg@gmail.com>
> ---
>=20
> WARNING: This bug is quite old. The patch has been tested on v3.0. No tes=
ting
> has been done after rebasing to v3.6. Hence the RFC tag. Hopefully someon=
e
> will beat me in testing with latest linux-omap/master.
>=20
> Changes since v1 per Tomi Valkeinen's comments:
>   - Don't rename omap_dispc_unregister_isr, just introduce nosync variant=
.
>   - Apply the same fix for DSI IRQ which suffers from the same race condi=
tion.

I made a quick test and works for me, although I haven't encountered the
problem itself.

Some mostly cosmetic comments below.

This seems to apply cleanly to v3.4+ kernels, but not earlier ones. Do
you want to make the needed modifications and mail this and the modified
patches for stable kernels also? I can do that also if you don't want
to.

>  drivers/staging/omapdrm/omap_plane.c |    2 +-
>  drivers/video/omap2/dss/apply.c      |    2 +-
>  drivers/video/omap2/dss/dispc.c      |   45 ++++++++++++++++++++++++++++=
+-----
>  drivers/video/omap2/dss/dsi.c        |   19 ++++++++++++++
>  include/video/omapdss.h              |    1 +
>  5 files changed, 61 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/staging/omapdrm/omap_plane.c b/drivers/staging/omapd=
rm/omap_plane.c
> index 7997be7..8d8aa5b 100644
> --- a/drivers/staging/omapdrm/omap_plane.c
> +++ b/drivers/staging/omapdrm/omap_plane.c
> @@ -82,7 +82,7 @@ static void dispc_isr(void *arg, uint32_t mask)
>  	struct omap_plane *omap_plane =3D to_omap_plane(plane);
>  	struct omap_drm_private *priv =3D plane->dev->dev_private;
> =20
> -	omap_dispc_unregister_isr(dispc_isr, plane,
> +	omap_dispc_unregister_isr_nosync(dispc_isr, plane,
>  			id2irq[omap_plane->ovl->id]);
> =20
>  	queue_work(priv->wq, &omap_plane->work);
> diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/ap=
ply.c
> index 0fefc68..9386834 100644
> --- a/drivers/video/omap2/dss/apply.c
> +++ b/drivers/video/omap2/dss/apply.c
> @@ -847,7 +847,7 @@ static void dss_unregister_vsync_isr(void)
>  	for (i =3D 0; i < num_mgrs; ++i)
>  		mask |=3D dispc_mgr_get_framedone_irq(i);
> =20
> -	r =3D omap_dispc_unregister_isr(dss_apply_irq_handler, NULL, mask);
> +	r =3D omap_dispc_unregister_isr_nosync(dss_apply_irq_handler, NULL, mas=
k);
>  	WARN_ON(r);
> =20
>  	dss_data.irq_enabled =3D false;
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/di=
spc.c
> index ee9e296..a67d92c 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -2421,8 +2421,8 @@ static void dispc_mgr_enable_digit_out(bool enable)
>  					enable ? "start" : "stop");
>  	}
> =20
> -	r =3D omap_dispc_unregister_isr(dispc_disable_isr, &frame_done_completi=
on,
> -			irq_mask);
> +	r =3D omap_dispc_unregister_isr(dispc_disable_isr,
> +			&frame_done_completion, irq_mask);

This change is not needed.

>  	if (r)
>  		DSSERR("failed to unregister %x isr\n", irq_mask);
> =20
> @@ -3320,7 +3320,8 @@ err:
>  }
>  EXPORT_SYMBOL(omap_dispc_register_isr);
> =20
> -int omap_dispc_unregister_isr(omap_dispc_isr_t isr, void *arg, u32 mask)
> +/* WARNING: callback might be executed even after this function returns!=
 */
> +int omap_dispc_unregister_isr_nosync(omap_dispc_isr_t isr, void *arg, u3=
2 mask)
>  {
>  	int i;
>  	unsigned long flags;
> @@ -3352,7 +3353,37 @@ int omap_dispc_unregister_isr(omap_dispc_isr_t isr=
, void *arg, u32 mask)
> =20
>  	return ret;
>  }
> -EXPORT_SYMBOL(omap_dispc_unregister_isr);
> +EXPORT_SYMBOL(omap_dispc_unregister_isr_nosync);
> +
> +/*
> + * Ensure that callback <isr> will NOT be executed after this function
> + * returns. Must be called from sleepable context, though!
> + */
> +int omap_dispc_unregister_isr(omap_dispc_isr_t isr, void *arg, u32 mask)
> +{
> +	int ret;
> +
> +	ret =3D omap_dispc_unregister_isr_nosync(isr, arg, mask);
> +
> +	/* Task context is not really needed. But if we're called from atomic
> +	 * context, it is probably from DISPC IRQ, where we will deadlock.
> +	 * So use might_sleep() to catch potential deadlocks.
> +	 */

Use the kernel multi-line comment style, i.e.:

/*
 * foobar
 */

> +	might_sleep();
> +
> +#if defined(CONFIG_SMP)
> +	/* DISPC IRQ executes callbacks with dispc.irq_lock released. Hence
> +	 * unregister_isr() and DISPC IRQ might be running in parallel on
> +	 * different CPUs. So there is a chance that a callback is executed
> +	 * even though it has been unregistered. Add a barrier, in order to
> +	 * ensure that after returning from this function, the new DISPC IRQ
> +	 * will use an updated callback array, and NOT its cached copy.
> +	 */

Comment style here also.

> +	synchronize_irq(dispc.irq);
> +#endif

Why do you use #if defined(CONFIG_SMP)? synchronize_irq is defined
with !CONFIG_SMP also. In that case it becomes just barrier().

> +
> +	return ret;
> +}
> =20
>  #ifdef DEBUG
>  static void print_irq_status(u32 status)
> @@ -3567,7 +3598,8 @@ int omap_dispc_wait_for_irq_timeout(u32 irqmask, un=
signed long timeout)
> =20
>  	timeout =3D wait_for_completion_timeout(&completion, timeout);
> =20
> -	omap_dispc_unregister_isr(dispc_irq_wait_handler, &completion, irqmask)=
;
> +	omap_dispc_unregister_isr(dispc_irq_wait_handler, &completion,
> +			irqmask);

Change not needed.

> =20
>  	if (timeout =3D=3D 0)
>  		return -ETIMEDOUT;
> @@ -3598,7 +3630,8 @@ int omap_dispc_wait_for_irq_interruptible_timeout(u=
32 irqmask,
>  	timeout =3D wait_for_completion_interruptible_timeout(&completion,
>  			timeout);
> =20
> -	omap_dispc_unregister_isr(dispc_irq_wait_handler, &completion, irqmask)=
;
> +	omap_dispc_unregister_isr(dispc_irq_wait_handler, &completion,
> +			irqmask);

Change not needed.

> =20
>  	if (timeout =3D=3D 0)
>  		return -ETIMEDOUT;
> diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.=
c
> index b07e886..24b4a3e 100644
> --- a/drivers/video/omap2/dss/dsi.c
> +++ b/drivers/video/omap2/dss/dsi.c
> @@ -960,6 +960,13 @@ static int dsi_unregister_isr(struct platform_device=
 *dsidev,
> =20
>  	spin_unlock_irqrestore(&dsi->irq_lock, flags);
> =20
> +	might_sleep();
> +
> +#if defined(CONFIG_SMP)
> +	/* See notes for dispc.c:omap_dispc_unregister_isr() . */
> +	synchronize_irq(dsi->irq);
> +#endif
> +

Same SMP comment as with dispc.

 Tomi


--=-XT+gQZxWSO/ukPTt/Jn/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQTZtxAAoJEPo9qoy8lh71jL8P/1850Ih787T20PjHJrq2AC2X
tfBeN/fGdpQp0JhoWdWg994NYoyfW4fnoaOgNnMqT64EDjNqHfQvWk8Z0lqfWnDo
zlFjG5PcaoNmYhlg0mhYfpbnollGpXQxyIVPa7HJBIIZq9OCK3gAgx7bmSe2fOQz
3Risk+pthEnUh4GfA17MNpsQTJ6ZDjJeJSvJLjvUsl6YqXxt6QuhzpFSkywOjX9m
ZQ6BXnVm5zOVnKXv2JiN/pj70CYo/qXqL09WPmT5glDlt7Z69N4969m8p6RtDlGX
x3UA6inlq8r4ORX3mHBSP53kzJMYmgF1NteGqrXJZJ9gaMuR88aCcGJXSra4GJmb
zMdoNxa3TS4nTxOxzFEFLEoJQEbMMUdNyAhG3OG7+h3yHuKjATdYIq+S4RAMkRFa
yBpbnzRzP3Vyk+GmHm9bb2FGEO1M7GtTeUOehLoZEI3eO3DnFX0T3kfcA7VO3+ji
NI+rUzOSIkadvNrv8lGYjYVFSLIF60CgiLT6psKEdUy5Ntebq/pxdzqhmzYPlgQH
pwYGBsvxw4wK/D4+ohb53nxIRyVJ9Jaj4cKWBGHuk0H9oOyJzR3j542JLuzXvx09
Fj36KuV7vIoN117U3LAi9QPjpsV6hOx28RWK+Q0X7KVGsg9Jw2ClfXgg1p05Vx6j
i9+ggtqThsETTXDMOo40
=wdiY
-----END PGP SIGNATURE-----

--=-XT+gQZxWSO/ukPTt/Jn/--

