From: Yinbo Zhu <yinbo.zhu@nxp.com>
Subject: RE: [PATCH v2] usb: host: Implement workaround for Erratum A-009611
Date: Mon, 11 Dec 2017 08:44:55 +0000
Message-ID: <VI1PR04MB12627472B54758ECADDC04F4E9370@VI1PR04MB1262.eurprd04.prod.outlook.com>
References: <20171208094942.46748-1-yinbo.zhu@nxp.com>
 <20171208094942.46748-2-yinbo.zhu@nxp.com> <20171208102111.GA16245@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171208102111.GA16245@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Felipe Balbi <balbi@ti.com>, Mathias Nyman <mathias.nyman@intel.com>, "open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>, "open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-omap@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Xiaobo Xie <xiaobo.xie@nxp.com>, Jerry Huang <jerry.huang@nxp.com>, Ran Wang <ran.wang_1@nxp.com>
List-Id: linux-omap@vger.kernel.org



-----Original Message-----
From: Greg Kroah-Hartman [mailto:gregkh@linuxfoundation.org]=20
Sent: Friday, December 08, 2017 6:21 PM
To: Yinbo Zhu <yinbo.zhu@nxp.com>
Cc: Felipe Balbi <balbi@ti.com>; Mathias Nyman <mathias.nyman@intel.com>; o=
pen list:DESIGNWARE USB3 DRD IP DRIVER <linux-usb@vger.kernel.org>; open li=
st:DESIGNWARE USB3 DRD IP DRIVER <linux-omap@vger.kernel.org>; open list <l=
inux-kernel@vger.kernel.org>; Xiaobo Xie <xiaobo.xie@nxp.com>; Jerry Huang =
<jerry.huang@nxp.com>; Ran Wang <ran.wang_1@nxp.com>
Subject: Re: [PATCH v2] usb: host: Implement workaround for Erratum A-00961=
1

On Fri, Dec 08, 2017 at 05:49:41PM +0800, yinbo.zhu@nxp.com wrote:
> From: "yinbo.zhu" <yinbo.zhu@nxp.com>
>=20
> Description: This is a occasional problem where the software

>No need for a "Description:" word.  That's just assumed here, right?

> issues an End Transfer command while a USB transfer is in progress,=20
> resulting in the TxFIFO  being flushed when the lower layer is waiting=20
> for data,causing the super speed (SS) transmit to get blocked.
> If the End Transfer command is issued on an IN endpoint to flush out=20
> the pending transfers when the same IN endpoint is doing transfers on=20
> the USB, then depending upon the timing of the End Transfer (and the=20
> resulting internal FIFO flush),the lower layer (U3PTL/U3MAC) could get=20
> stuck waiting for data indefinitely. This blocks the transmission path=20
> on the SS, and no DP/ACK/ERDY/DEVNOTIF packets can be sent from the=20
> device.
> Impact: If this issue happens and the transmission gets blocked, then=20
> the USB host aborts and resets/re-enumerates the device.
> This unblocks the transmitt engine and the device functions normally.
>=20
> Workaround: Software must wait for all existing TRBs to complete=20
> before issuing End transfer command.
>=20
> Configs Affected:
> LS1088-48A-R1.0, LS2081A-R1.1, LS2088-48A-R1.0, LS2088-48A-R1.1,=20
> LX2160-2120-2080A-R1.

What are these Configs?  That doesn't seem to match up with anything that i=
s in the kernel tree that I can see.

>=20
> Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
> ---
>  drivers/usb/dwc3/core.c      |  3 +++
>  drivers/usb/dwc3/core.h      |  3 +++
>  drivers/usb/dwc3/host.c      |  3 +++
>  drivers/usb/host/xhci-plat.c |  4 ++++
>  drivers/usb/host/xhci.c      | 24 ++++++++++++++++++------
>  drivers/usb/host/xhci.h      |  1 +
>  6 files changed, 32 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c index=20
> 5cb3f6795b0b..071e7cea8cbb 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1106,6 +1106,9 @@ static void dwc3_get_properties(struct dwc3=20
> *dwc)
> =20
>  	dwc->quirk_reverse_in_out =3D device_property_read_bool(dev,
>  				"snps,quirk_reverse_in_out");
> +	dwc->quirk_stop_transfer_in_block =3D device_property_read_bool(dev,
> +				"snps,quirk_stop_transfer_in_block");

>Have you documented this new DT value somewhere?
I had add some description in drivers/usb/dwc3/core.h.
Is it okay?
"  + * @quirk_stop_transfer_in_block: prevent block transmission from being
   + *                                interrupted."
> +
>  	dwc->needs_fifo_resize =3D of_property_read_bool(node,=20
> "tx-fifo-resize");
> =20
>  	dwc->configure_gfladj =3D
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h index=20
> 6c530cbedf49..b2425799ecb6 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -900,6 +900,8 @@ struct dwc3_scratchpad_array {
>   * 	3	- Reserved
>   * @disable_devinit_u1u2_quirk: disable device-initiated U1/U2 request.
>   * @quirk_reverse_in_out: prevent tx fifo reverse the data direction.
> + * @quirk_stop_transfer_in_block: prevent block transmission from being
> + *                                interrupted.
>   * @imod_interval: set the interrupt moderation interval in 250ns
>   *                 increments or 0 to disable.
>   */
> @@ -1063,6 +1065,7 @@ struct dwc3 {
>  	unsigned		tx_de_emphasis:2;
>  	unsigned		disable_devinit_u1u2_quirk:1;
>  	unsigned                quirk_reverse_in_out:1;
> +	unsigned                quirk_stop_transfer_in_block:1;
> =20
>  	u16			imod_interval;
>  };
> diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c index=20
> 2cd48633d3fa..a9ccbf1b9871 100644
> --- a/drivers/usb/dwc3/host.c
> +++ b/drivers/usb/dwc3/host.c
> @@ -110,6 +110,9 @@ int dwc3_host_init(struct dwc3 *dwc)
>  	if (dwc->quirk_reverse_in_out)
>  		props[prop_idx++].name =3D "quirk-reverse-in-out";
> =20
> +	if (dwc->quirk_stop_transfer_in_block)
> +		props[prop_idx++].name =3D "quirk-stop-transfer-in-block";
> +
>  	if (dwc->usb3_lpm_capable)
>  		props[prop_idx++].name =3D "usb3-lpm-capable";
> =20
> diff --git a/drivers/usb/host/xhci-plat.c=20
> b/drivers/usb/host/xhci-plat.c index d1c1e882e6d7..5721d4ece625 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -272,6 +272,10 @@ static int xhci_plat_probe(struct platform_device *p=
dev)
>  	if (device_property_read_bool(&pdev->dev, "quirk-reverse-in-out"))
>  		xhci->quirks |=3D XHCI_REVERSE_IN_OUT;
> =20
> +	if (device_property_read_bool(&pdev->dev,
> +				"quirk-stop-transfer-in-block"))
> +		xhci->quirks |=3D XHCI_STOP_TRANSFER_IN_BLOCK;
> +
>  	if (device_property_read_bool(&pdev->dev, "quirk-broken-port-ped"))
>  		xhci->quirks |=3D XHCI_BROKEN_PORT_PED;
> =20
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c index=20
> 21dd1d98508f..925c8d171c0b 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -1515,13 +1515,25 @@ static int xhci_urb_dequeue(struct usb_hcd *hcd, =
struct urb *urb, int status)
>  			ret =3D -ENOMEM;
>  			goto done;
>  		}
> -		ep->ep_state |=3D EP_STOP_CMD_PENDING;
> -		ep->stop_cmd_timer.expires =3D jiffies +
> +		/*
> +		 *A-009611: Issuing an End Transfer command on an IN endpoint.
> +		 *when a transfer is in progress on USB blocks the transmission
> +		 *Workaround: Software must wait for all existing TRBs to
> +		 *complete before issuing End transfer command.

>What is "A-009611:" mean?

>Also please properly format your comments (look at other ones for examples=
 of how to do it.)
A-009611 is erratum name, about the comments that I will had a change. Than=
ks.

> +		 */
> +		if ((ep_ring->enqueue =3D=3D ep_ring->dequeue &&
> +				(xhci->quirks & XHCI_STOP_TRANSFER_IN_BLOCK)) ||
> +				!(xhci->quirks & XHCI_STOP_TRANSFER_IN_BLOCK)) {
> +			ep->ep_state |=3D EP_STOP_CMD_PENDING;
> +			ep->stop_cmd_timer.expires =3D jiffies +
>  			XHCI_STOP_EP_CMD_TIMEOUT * HZ;
> -		add_timer(&ep->stop_cmd_timer);
> -		xhci_queue_stop_endpoint(xhci, command, urb->dev->slot_id,
> -					 ep_index, 0);
> -		xhci_ring_cmd_db(xhci);
> +			add_timer(&ep->stop_cmd_timer);
> +			xhci_queue_stop_endpoint(xhci, command,
> +					urb->dev->slot_id,
> +					ep_index, 0);
> +			xhci_ring_cmd_db(xhci);
> +		}
> +
>  	}
>  done:
>  	spin_unlock_irqrestore(&xhci->lock, flags); diff --git=20
> a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h index=20
> 78d14ff0b811..bff47d6582a8 100644
> --- a/drivers/usb/host/xhci.h
> +++ b/drivers/usb/host/xhci.h
> @@ -1836,6 +1836,7 @@ struct xhci_hcd {
>  /* Reserved. It was XHCI_U2_DISABLE_WAKE */
>  #define XHCI_ASMEDIA_MODIFY_FLOWCONTROL	(1 << 28)
>  #define XHCI_HW_LPM_DISABLE	(1 << 29)
> +#define XHCI_STOP_TRANSFER_IN_BLOCK    (1 << 30)

>Meta-comment, why are these not using the BIT() macro?

>thanks,

>greg k-h
Okay , I will use the BIT() .

Thanks=20
yinbo
