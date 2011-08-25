From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: Re: [PATCH 3/4] usb: Introduce DesignWare USB3 DRD Driver
Date: Thu, 25 Aug 2011 12:15:09 -0700
Message-ID: <20110825191509.GB8030@xanatos>
References: <1313766659-28360-1-git-send-email-balbi@ti.com>
 <1313766659-28360-4-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:3017 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755294Ab1HYTPK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Aug 2011 15:15:10 -0400
Content-Disposition: inline
In-Reply-To: <1313766659-28360-4-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Greg KH <greg@kroah.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Fri, Aug 19, 2011 at 06:10:58PM +0300, Felipe Balbi wrote:
> +enum dwc3_link_state {
> +	/* In SuperSpeed */
> +	DWC3_LINK_STATE_U0		= 0x00, /* in HS, means ON */
> +	DWC3_LINK_STATE_U1		= 0x01,
> +	DWC3_LINK_STATE_U2		= 0x02, /* in HS, means SLEEP */
> +	DWC3_LINK_STATE_U3		= 0x03, /* in HS, means SUSPEND */
> +	DWC3_LINK_STATE_SS_DIS		= 0x04,
> +	DWC3_LINK_STATE_RX_DET		= 0x05, /* in HS, means Early Suspend */
> +	DWC3_LINK_STATE_SS_INACT	= 0x06,
> +	DWC3_LINK_STATE_POLL		= 0x07,
> +	DWC3_LINK_STATE_RECOV		= 0x08,
> +	DWC3_LINK_STATE_HRESET		= 0x09,
> +	DWC3_LINK_STATE_CMPLY		= 0x0a,
> +	DWC3_LINK_STATE_LPBK		= 0x0b,
> +	DWC3_LINK_STATE_MASK		= 0x0f,
> +};

AFAICT, the link state values are exactly the same as the xHCI link
state values in the Port Link State field in the PORTSC register.  Is
the gadget side (xDCI side) meant to be somewhat compatible with the
xHCI host controller spec?

Would it make sense to share these link state macros (and any other
similar #defines) with the xHCI driver?  We could move them into
include/linux/ch11.h.

Sarah Sharp
