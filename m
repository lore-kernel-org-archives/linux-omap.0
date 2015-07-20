From: Krzysztof Opasiak <k.opasiak@samsung.com>
Subject: Re: [PATCH v3 26/46] usb: gadget: pch_ud: add ep capabilities support
Date: Mon, 20 Jul 2015 17:08:13 +0200
Message-ID: <55AD0EDD.70201@samsung.com>
References: <1436941953-1327-1-git-send-email-r.baldyga@samsung.com>
 <1436941953-1327-27-git-send-email-r.baldyga@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-reply-to: <1436941953-1327-27-git-send-email-r.baldyga@samsung.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Robert Baldyga <r.baldyga@samsung.com>, gregkh@linuxfoundation.org, balbi@ti.com
Cc: devel@driverdev.osuosl.org, linux-usb@vger.kernel.org, m.szyprowski@samsung.com, linux-arm-kernel@lists.infradead.org, johnyoun@synopsys.com, linuxppc-dev@lists.ozlabs.org, cernekee@gmail.com, nicolas.ferre@atmel.com, michal.simek@xilinx.com, haojian.zhuang@gmail.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Peter.Chen@freescale.com, dahlmann.thomas@arcor.de, andrzej.p@samsung.com, leoli@freescale.com, robert.jarzmik@free.fr, daniel@zonque.org, linux-geode@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On 07/15/2015 08:32 AM, Robert Baldyga wrote:
> Convert endpoint configuration to new capabilities model.
>
> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
> ---
>   drivers/usb/gadget/udc/pch_udc.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/gadget/udc/pch_udc.c b/drivers/usb/gadget/udc/pch_udc.c
> index 613547f..cc8fb3c 100644
> --- a/drivers/usb/gadget/udc/pch_udc.c
> +++ b/drivers/usb/gadget/udc/pch_udc.c
> @@ -2895,11 +2895,21 @@ static void pch_udc_pcd_reinit(struct pch_udc_dev *dev)
>   		ep->in = ~i & 1;
>   		ep->ep.name = ep_string[i];
>   		ep->ep.ops = &pch_udc_ep_ops;
> -		if (ep->in)
> +		if (ep->in) {
>   			ep->offset_addr = ep->num * UDC_EP_REG_SHIFT;
> -		else
> +			ep->ep.caps.dir_in = true;
> +		} else {
>   			ep->offset_addr = (UDC_EPINT_OUT_SHIFT + ep->num) *
>   					  UDC_EP_REG_SHIFT;
> +			ep->ep.caps.dir_out = true;
> +		}
> +		if (i == UDC_EP0IN_IDX || i == UDC_EP0OUT_IDX) {
> +			ep->ep.caps.type_control = true;

In all previous patches you set both dir_in and dir_out to true for ep0 
but in this patch you don't do this. Is there some reason for this or 
it's just a mistake?

> +		} else {
> +			ep->ep.caps.type_iso = true;
> +			ep->ep.caps.type_bulk = true;
> +			ep->ep.caps.type_int = true;
> +		}
>   		/* need to set ep->ep.maxpacket and set Default Configuration?*/
>   		usb_ep_set_maxpacket_limit(&ep->ep, UDC_BULK_MAX_PKT_SIZE);
>   		list_add_tail(&ep->ep.ep_list, &dev->gadget.ep_list);
>

Best Regards,

-- 
Krzysztof Opasiak
Samsung R&D Institute Poland
Samsung Electronics
