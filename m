From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 02/11] usb: musb: kill global and static for multi
 instance
Date: Wed, 25 Jul 2012 10:50:15 +0300
Message-ID: <20120725075014.GR3630@arwen.pp.htv.fi>
References: <1342698367-12978-1-git-send-email-ajay.gupta@ti.com>
 <1342698367-12978-3-git-send-email-ajay.gupta@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QVgWX4+QEldMe/r9"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1342698367-12978-3-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--QVgWX4+QEldMe/r9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 19, 2012 at 05:15:58PM +0530, Ajay Kumar Gupta wrote:
> Moved global variable "musb_debugfs_root" and static variable
> "old_state" to 'struct musb' to help support multi instance of
> musb controller as present on AM335x platform.
>=20
> Also removed the global variable "orig_dma_mask" and filled the
> dev->dma_mask with parent device's dma_mask.
>=20
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/usb/musb/musb_core.c    |   16 +++-------------
>  drivers/usb/musb/musb_core.h    |    4 ++++
>  drivers/usb/musb/musb_debugfs.c |   14 ++++++++------
>  3 files changed, 15 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index 3e09984..a5db4dd 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -1802,10 +1802,9 @@ static const struct attribute_group musb_attr_grou=
p =3D {
>  static void musb_irq_work(struct work_struct *data)
>  {
>  	struct musb *musb =3D container_of(data, struct musb, irq_work);
> -	static int old_state;
> =20
> -	if (musb->xceiv->state !=3D old_state) {
> -		old_state =3D musb->xceiv->state;
> +	if (musb->xceiv->state !=3D musb->xceiv_old_state) {
> +		musb->xceiv_old_state =3D musb->xceiv->state;
>  		sysfs_notify(&musb->controller->kobj, NULL, "mode");
>  	}
>  }
> @@ -2115,11 +2114,6 @@ fail0:
>  /* all implementations (PCI bridge to FPGA, VLYNQ, etc) should just
>   * bridge to a platform device; this driver then suffices.
>   */
> -
> -#ifndef CONFIG_MUSB_PIO_ONLY
> -static u64	*orig_dma_mask;
> -#endif
> -
>  static int __devinit musb_probe(struct platform_device *pdev)
>  {
>  	struct device	*dev =3D &pdev->dev;
> @@ -2138,10 +2132,6 @@ static int __devinit musb_probe(struct platform_de=
vice *pdev)
>  		return -ENOMEM;
>  	}
> =20
> -#ifndef CONFIG_MUSB_PIO_ONLY
> -	/* clobbered by use_dma=3Dn */
> -	orig_dma_mask =3D dev->dma_mask;
> -#endif
>  	status =3D musb_init_controller(dev, irq, base);
>  	if (status < 0)
>  		iounmap(base);
> @@ -2166,7 +2156,7 @@ static int __devexit musb_remove(struct platform_de=
vice *pdev)
>  	iounmap(ctrl_base);
>  	device_init_wakeup(&pdev->dev, 0);
>  #ifndef CONFIG_MUSB_PIO_ONLY
> -	pdev->dev.dma_mask =3D orig_dma_mask;
> +	pdev->dev.dma_mask =3D (&dev->dev.parent)->dma_mask;

are you sure ?? This should be:

dev->parent.dma_mask;

In fact, while doing that you could use dma_set_mask() instead ;-)

--=20
balbi

--QVgWX4+QEldMe/r9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQD6U2AAoJEIaOsuA1yqREFAAP/2NdNCbI8Yj+Mfs9t5vu6Dvc
o4k6ITxDD9u3UwivVC0axI5qgvESX0WQLu0Cd9yQ01i8WWbSeyqvwqitWAyEuc4u
uRlBtmF6MDps+RWmpAedXRbddYJLXPoAfwL0IGj3tRto8L/h3AcaNtcTj53SUhDs
TSD/fiCIybZuX1LoNkFpXJgNu+n6SQifQ6/cZHOXHlTMitsvzaHoxRF3f5n11SDf
Ls77Ol7lqWXyENqY2f8b/P1lYFmJq6f15Pr+yv1N+9vgz8zFNxAz6qqImnnwGKCN
Sgx6kSOAQexlAqGYTYxqBReK0O/DMC9YSoyyuaA4xkZxuoBKsyA7Cpo29oNSvODH
bkyWL4nJqgsN/eUMZCRsG+xCPSRSWtKc1V9DD72Et+KdAVr9Ysbklf6rjs/AMisR
3Vd5NR6/2Z39ydzv157Sn+/4+h93i+1a/eX/Z+K8koRgAHFDKTKSRjCp9WFd6CwA
YbphVRyrgTixfrFIEeeRtRdFo+09gjgobQ5goUjSDU4alGR8f1fUdtdHCJiDNphv
JJ/UmAj2exxmlOvPjVvl7egAWOzTsiXfEhrQxqKE08wlpQC6xES3EMEMrjMA+fef
h87b/fH2OKPm1ZWHAYY7LwX6x4u1gqcDaML0rJ4flP6DwzYi3wLXMJmN/lRKtz4o
EABt/SSXfp98oW5nmrKK
=APoo
-----END PGP SIGNATURE-----

--QVgWX4+QEldMe/r9--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
