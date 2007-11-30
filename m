From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH] [MUSB] fix bug: when no USB device is plugged into
	theport of EZKIT-BF548, USB OTG host mode got BUG()
Date: Fri, 30 Nov 2007 15:45:12 +0530
Message-ID: <010C7BAE6783F34D9AC336EE5A01A08804ED1A22@dbde01.ent.ti.com>
References: <1196417476.9628.17.camel@roc-laptop>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <1196417476.9628.17.camel@roc-laptop>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: bryan.wu@analog.com, Tony Lindgren <tony@atomide.com>, David Brownell <dbrownell@users.sourceforge.net>, linux-omap-open-source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Ack. We caught this too.

Next time, I think I should send the fix as soon as we catch it :)

--Anand


> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com=20
> [mailto:linux-omap-open-source-bounces@linux.omap.com] On=20
> Behalf Of Bryan Wu
> Sent: Friday, November 30, 2007 3:41 PM
> To: Tony Lindgren; David Brownell; linux-omap-open-source
> Subject: [PATCH] [MUSB] fix bug: when no USB device is=20
> plugged into theport of EZKIT-BF548, USB OTG host mode got BUG()
>=20
> Subject: [PATCH] [MUSB] fix bug: when no USB device is=20
> plugged into the port of EZKIT-BF548, USB OTG host mode got BUG()
>=20
> Move IRQ workqueue init before request_irq, otherwise host SUSPEND irq
> will call schedule_work() and BUG_ON() will fire because=20
> musb_irq_work did
> not initialised.
>=20
> We recorded it at
> https://blackfin.uclinux.org/gf/project/uclinux-dist/tracker/?
> action=3DTrackerItemEdit&tracker_id=3D141&tracker_item_id=3D3740
>=20
> Although the Blackfin port of MUSB is not merged, this bug should be
> common for other platform with MUSB
>=20
> Signed-off-by: Bryan Wu <bryan.wu@analog.com>
> ---
>  drivers/usb/musb/musb_core.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/usb/musb/musb_core.c=20
> b/drivers/usb/musb/musb_core.c
> index 33774a6..008f42c 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -1992,6 +1992,9 @@ musb_init_controller(struct device=20
> *dev, int nIrq, void __iomem *ctrl)
>  	if (status < 0)
>  		goto fail2;
> =20
> +	/* Init IRQ workqueue before request_irq */
> +	INIT_WORK(&musb->irq_work, musb_irq_work);
> +
>  	/* attach to the IRQ */
>  	if (request_irq (nIrq, musb->isr, 0, dev->bus_id, musb)) {
>  		dev_err(dev, "request_irq %d failed!\n", nIrq);
> @@ -2071,8 +2074,6 @@ fail:
>  		return status;
>  	}
> =20
> -	INIT_WORK(&musb->irq_work, musb_irq_work);
> -
>  #ifdef CONFIG_SYSFS
>  	status =3D device_create_file(dev, &dev_attr_mode);
>  	status =3D device_create_file(dev, &dev_attr_vbus);
> --=20
> 1.5.3
>=20
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>=20
