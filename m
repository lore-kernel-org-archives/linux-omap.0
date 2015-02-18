From: Mathias Nyman <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 1/5] xhci: add a quirk for device disconnection errata
 for Synopsis Designware USB3 core
Date: Wed, 18 Feb 2015 10:47:45 +0200
Message-ID: <54E451B1.8020401@intel.com>
References: <1424151697-2084-1-git-send-email-Sneeker.Yeh@tw.fujitsu.com> <1424151697-2084-2-git-send-email-Sneeker.Yeh@tw.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1424151697-2084-2-git-send-email-Sneeker.Yeh-l16TxrwUIHTQFUHtdCDX3A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sneeker Yeh <sneeker.yeh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sneeker Yeh <Sneeker.Yeh-l16TxrwUIHTQFUHtdCDX3A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi

This looks correct, but if you are still going to make a new series fixing
Felipe's comments then the following tiny nitpicks could be fixed as well. 

Otherwise

Acked-by: Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Felipe, Do you want to take this series through your tree?

On 17.02.2015 07:41, Sneeker Yeh wrote:
>  
> +static void xhci_try_to_clear_csc(struct usb_hcd *hcd, int dev_port_num)

Either add a function description explaining something like "Late clearing of connect status.
Some quirky hardware will suspend the controller when CSC bit is cleared and leave URBs unhandled"

Or change the function name to something like xhci_late_csc_clear_quirk() or xhci_deferred_csc_clear_quirk()

Maybe the name should be changed anyways. 
The "try to" makes it look like some non-blocking version of a csc clear function.
 
> +{
> +	int max_ports;
> +	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
> +	__le32 __iomem **port_array;
> +	u32 status;
> +
> +	/* print debug info */

Remove this comment

> +	if (hcd->speed == HCD_USB3) {
> +		max_ports = xhci->num_usb3_ports;
> +		port_array = xhci->usb3_ports;
> +	} else {
> +		max_ports = xhci->num_usb2_ports;
> +		port_array = xhci->usb2_ports;
> +	}
> +
> +	if (dev_port_num > max_ports) {
> +		xhci_err(xhci, "%s() port number invalid", __func__);
> +		return;
> +	}
> +	status = readl(port_array[dev_port_num - 1]);
> +
> +	/* write 1 to clear */

Not really a helpful comment either, either remove or change to something like 
"clearing the connect status bit will now immediately suspend these quirky controllers"

-Mathias
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
