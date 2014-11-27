From: "Lu, Baolu" <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 06/19] usb: dwc3: host: Pass the XHCI_DRD_SUPPORT and
 XHCI_NEEDS_LHC_RESET quirk
Date: Thu, 27 Nov 2014 10:00:27 +0800
Message-ID: <547685BB.3020109@linux.intel.com>
References: <1416921115-10467-1-git-send-email-george.cherian@ti.com> <1416921115-10467-7-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1416921115-10467-7-git-send-email-george.cherian@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: George Cherian <george.cherian@ti.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org
Cc: peter.chen@freescale.com, sojka@merica.cz, mathias.nyman@intel.com, balbi@ti.com, gregkh@linuxfoundation.org, tony@atomide.com, bcousson@baylibre.com, kgene.kim@samsung.com, ben-linux@fluff.org, linux@arm.linux.org.uk, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org
List-Id: linux-omap@vger.kernel.org


On 2014=E5=B9=B411=E6=9C=8825=E6=97=A5 21:11, George Cherian wrote:
> Pass the quir flag XHCI_DRD_SUPPORT from DWC3 host to xhci platform d=
river.
"quir" to "quirk"

Regards,
Baolu

> This enables xhci driver to handle deallocation's differently while i=
n DRD mode.
> Pass the quirk flag XHCI_NEEDS_LHC_RESET from DWC3 host to xhci platf=
orm
> driver. This enables to do LHRESET during xhci_reset().
>
> Signed-off-by: George Cherian <george.cherian@ti.com>
> ---
>   drivers/usb/dwc3/host.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
> index dcb8ca0..257b5b5 100644
> --- a/drivers/usb/dwc3/host.c
> +++ b/drivers/usb/dwc3/host.c
> @@ -53,6 +53,8 @@ int dwc3_host_init(struct dwc3 *dwc)
>   #ifdef CONFIG_DWC3_HOST_USB3_LPM_ENABLE
>   	pdata.usb3_lpm_capable =3D 1;
>   #endif
> +	pdata.usb_drd_support =3D 1;
> +	pdata.usb_needs_lhc_reset =3D 1;
>  =20
>   	ret =3D platform_device_add_data(xhci, &pdata, sizeof(pdata));
>   	if (ret) {
