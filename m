From: Mathias Nyman <mathias.nyman@intel.com>
Subject: Re: [PATCH v3 1/5] xhci: add a quirk for device disconnection errata
 for Synopsis Designware USB3 core
Date: Fri, 13 Feb 2015 11:08:38 +0200
Message-ID: <54DDBF16.2080807@intel.com>
References: <1422173608-24355-1-git-send-email-Sneeker.Yeh@tw.fujitsu.com> <1422173608-24355-2-git-send-email-Sneeker.Yeh@tw.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:43805 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753113AbbBMJHd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Feb 2015 04:07:33 -0500
In-Reply-To: <1422173608-24355-2-git-send-email-Sneeker.Yeh@tw.fujitsu.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sneeker Yeh <sneeker.yeh@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@linaro.org>, Huang Rui <ray.huang@amd.com>, Kishon Vijay Abraham I <kishon@ti.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Andy Green <andy.green@linaro.org>, Jassi Brar <jaswinder.singh@linaro.org>, Sneeker Yeh <Sneeker.Yeh@tw.fujitsu.com>

On 25.01.2015 10:13, Sneeker Yeh wrote:

Oh, and one more thing:

>  
> +static void xhci_try_to_clear_csc(struct usb_hcd *hcd, int dev_port_num)
> +{
> +	int max_ports;
> +	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
> +	__le32 __iomem **port_array;
> +	u32 status;
> +
> +	/* print debug info */
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
> +	if (!(status & PORT_CONNECT) && (status & PORT_CSC))
> +		writel(status & PORT_CSC, port_array[0]);

We don't want to write back all the bits we read from the PORTSC register.
Use the xhci_put_state_to_neutral(status) helper function to mask out some RW1C bits.

This in addition to writing to the correct PORTSC register as I previously mentioned.

-Mathias 
