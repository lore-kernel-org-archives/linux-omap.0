From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 4/5] usb: musb: dsps: add support for suspend and resume
Date: Mon, 25 Nov 2013 13:48:04 -0600
Message-ID: <20131125194804.GB18046@saruman.home>
References: <1385408393-19707-1-git-send-email-zonque@gmail.com>
 <1385408393-19707-5-git-send-email-zonque@gmail.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sk6NRVTC9kZ6Mrgo"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1385408393-19707-5-git-send-email-zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, neumann-SRDuVqtxQLSzQB+pC5nmwQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--sk6NRVTC9kZ6Mrgo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2013 at 08:39:52PM +0100, Daniel Mack wrote:
> The dsps platform needs to save save some registers at suspend time and
> restore them after resume. This patch adds a struct for these registers,
> and also lets the musb core know that the core registers need to be
> saved as well.
>=20
> We also have to call musb_port_reset() for this platform upon resume, so
> this function has to be made non-static.
>=20
> Signed-off-by: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/usb/musb/musb_core.h    |  1 +
>  drivers/usb/musb/musb_dsps.c    | 59 +++++++++++++++++++++++++++++++++++=
++++++
>  drivers/usb/musb/musb_host.h    |  2 ++
>  drivers/usb/musb/musb_virthub.c |  2 +-
>  4 files changed, 63 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
> index 29f7cd7..a423037 100644
> --- a/drivers/usb/musb/musb_core.h
> +++ b/drivers/usb/musb/musb_core.h
> @@ -295,6 +295,7 @@ struct musb {
> =20
>  	irqreturn_t		(*isr)(int, void *);
>  	struct work_struct	irq_work;
> +
>  	u16			hwvers;
> =20
>  	u16			intrrxe;
> diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
> index e57d712..361ddf8 100644
> --- a/drivers/usb/musb/musb_dsps.c
> +++ b/drivers/usb/musb/musb_dsps.c
> @@ -112,6 +112,19 @@ struct dsps_musb_wrapper {
>  	u8		poll_seconds;
>  };
> =20
> +/*
> + * register shadow for suspend
> + */
> +struct dsps_context {
> +	u32 control;
> +	u32 epintr;
> +	u32 coreintr;
> +	u32 phy_utmi;
> +	u32 mode;
> +	u32 tx_mode;
> +	u32 rx_mode;
> +};
> +
>  /**
>   * DSPS glue structure.
>   */
> @@ -121,6 +134,8 @@ struct dsps_glue {
>  	const struct dsps_musb_wrapper *wrp; /* wrapper register offsets */
>  	struct timer_list timer;	/* otg_workaround timer */
>  	unsigned long last_timer;    /* last timer data for each instance */
> +
> +	struct dsps_context context;
>  };
> =20
>  static void dsps_musb_try_idle(struct musb *musb, unsigned long timeout)
> @@ -506,6 +521,7 @@ static int dsps_create_musb_pdev(struct dsps_glue *gl=
ue,
>  	}
>  	pdata.config =3D config;
>  	pdata.platform_ops =3D &dsps_ops;
> +	pdata.restore_after_suspend =3D 1;
> =20
>  	config->num_eps =3D get_int_prop(dn, "mentor,num-eps");
>  	config->ram_bits =3D get_int_prop(dn, "mentor,ram-bits");
> @@ -632,11 +648,54 @@ static const struct of_device_id musb_dsps_of_match=
[] =3D {
>  };
>  MODULE_DEVICE_TABLE(of, musb_dsps_of_match);
> =20
> +#ifdef CONFIG_PM
> +static int dsps_suspend(struct device *dev)
> +{
> +	struct dsps_glue *glue =3D dev_get_drvdata(dev);
> +	const struct dsps_musb_wrapper *wrp =3D glue->wrp;
> +	struct musb *musb =3D platform_get_drvdata(glue->musb);
> +	void __iomem *mbase =3D musb->ctrl_base;
> +
> +	glue->context.control =3D dsps_readl(mbase, wrp->control);
> +	glue->context.epintr =3D dsps_readl(mbase, wrp->epintr_set);
> +	glue->context.coreintr =3D dsps_readl(mbase, wrp->coreintr_set);
> +	glue->context.phy_utmi =3D dsps_readl(mbase, wrp->phy_utmi);
> +	glue->context.mode =3D dsps_readl(mbase, wrp->mode);
> +	glue->context.tx_mode =3D dsps_readl(mbase, wrp->tx_mode);
> +	glue->context.rx_mode =3D dsps_readl(mbase, wrp->rx_mode);
> +
> +	return 0;
> +}
> +
> +static int dsps_resume(struct device *dev)
> +{
> +	struct dsps_glue *glue =3D dev_get_drvdata(dev);
> +	const struct dsps_musb_wrapper *wrp =3D glue->wrp;
> +	struct musb *musb =3D platform_get_drvdata(glue->musb);
> +	void __iomem *mbase =3D musb->ctrl_base;
> +
> +	dsps_writel(mbase, wrp->control, glue->context.control);
> +	dsps_writel(mbase, wrp->epintr_set, glue->context.epintr);
> +	dsps_writel(mbase, wrp->coreintr_set, glue->context.coreintr);
> +	dsps_writel(mbase, wrp->phy_utmi, glue->context.phy_utmi);
> +	dsps_writel(mbase, wrp->mode, glue->context.mode);
> +	dsps_writel(mbase, wrp->tx_mode, glue->context.tx_mode);
> +	dsps_writel(mbase, wrp->rx_mode, glue->context.rx_mode);
> +
> +	musb_port_reset(musb, false);
> +
> +	return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(dsps_pm_ops, dsps_suspend, dsps_resume);
> +
>  static struct platform_driver dsps_usbss_driver =3D {
>  	.probe		=3D dsps_probe,
>  	.remove         =3D dsps_remove,
>  	.driver         =3D {
>  		.name   =3D "musb-dsps",
> +		.pm	=3D &dsps_pm_ops,
>  		.of_match_table	=3D musb_dsps_of_match,
>  	},
>  };
> diff --git a/drivers/usb/musb/musb_host.h b/drivers/usb/musb/musb_host.h
> index e660af9..7436c24 100644
> --- a/drivers/usb/musb/musb_host.h
> +++ b/drivers/usb/musb/musb_host.h
> @@ -93,6 +93,7 @@ extern void musb_root_disconnect(struct musb *musb);
>  extern void musb_host_resume_root_hub(struct musb *musb);
>  extern void musb_host_poke_root_hub(struct musb *musb);
>  extern void musb_port_suspend(struct musb *musb, bool do_suspend);
> +extern void musb_port_reset(struct musb *musb, bool do_reset);
>  #else
>  static inline struct musb *hcd_to_musb(struct usb_hcd *hcd)
>  {
> @@ -123,6 +124,7 @@ static inline void musb_host_resume_root_hub(struct m=
usb *musb)	{}
>  static inline void musb_host_poll_rh_status(struct musb *musb)	{}
>  static inline void musb_host_poke_root_hub(struct musb *musb)	{}
>  static inline void musb_port_suspend(struct musb *musb, bool do_suspend)=
 {}
> +static inline void musb_port_reset(struct musb *musb)		{}
>  #endif
> =20
>  struct usb_hcd;
> diff --git a/drivers/usb/musb/musb_virthub.c b/drivers/usb/musb/musb_virt=
hub.c
> index e977441..24e46c0 100644
> --- a/drivers/usb/musb/musb_virthub.c
> +++ b/drivers/usb/musb/musb_virthub.c
> @@ -109,7 +109,7 @@ void musb_port_suspend(struct musb *musb, bool do_sus=
pend)
>  	}
>  }
> =20
> -static void musb_port_reset(struct musb *musb, bool do_reset)
> +void musb_port_reset(struct musb *musb, bool do_reset)

NAK, this should not be called from the glue layers at all. If anything
call from musb_core's resume callback. That will only be called after
parent's resume has been called anyway.

--=20
balbi

--sk6NRVTC9kZ6Mrgo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSk6lzAAoJEIaOsuA1yqREO2QP/2MSG8s+0iC4xrbfBVjwKk5M
SsCMbtPJ+6SC8/XW2OqcWQ9axb0r44THgwJDhu9a8taiXCPXb/edSCyr4GgzoDT3
mVz6nm+AfZSx30zXv2ZaYg0Y9yGlQd7Nv0RghFU6o7sNOiXvq29FEPWiGgrBCiTk
/s/kcgDIs1tqqYiSdTRYzekXhlO+v9OIEaTNnaz2NhaUjWBEFScR/7t4FNEm6cmV
kbhigVUMl3FcyLt/IZWlfdNhJOg8uIO+xSpAOFGTzgqa0LocxWg20e7qW4TrD0yr
qJ7dicy6Ssfjd/gab1gxsDy45slVvh8dOycKjoc2th4iNLqiPwBgkxDy+eysF26q
5MOp6QZNeTCwAovYqeEB4Mh780fEK45R7AB86AASJLSTkMx84+N1frJe+vrPhYto
EFABm+dwoE3pdppkr3RxWSGtBM+xYr6hcNxX8+8zeMf3U8YVn60TzvmHHbfKKFBO
jKhIwifzYP2xsgRBYy2BF8Md33BuuHq7Cm70swd3NRP/X7hoaAZ5KQM9h9GRCe96
Z3CvjXeul+aWKRHQboTYjzAI89nYJcPa3C6cPVtIoKIqoxCUFw9ESb8XUwxz0bbN
dN5w4huBfwFj8trqmIySs7sF6thjobcFtYrKdFdnrbxjtYFD2IujgPh3xOeBuV1E
gKDXId7et593FRmVlGzv
=FNBt
-----END PGP SIGNATURE-----

--sk6NRVTC9kZ6Mrgo--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
