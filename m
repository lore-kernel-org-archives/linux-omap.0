From: kishon <kishon@ti.com>
Subject: Re: [PATCH 04/13] mfd: omap-usb-tll: Add device tree support
Date: Tue, 5 Feb 2013 11:34:15 +0530
Message-ID: <5110A0DF.7050609@ti.com>
References: <1359993540-20780-1-git-send-email-rogerq@ti.com> <1359993540-20780-5-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59475 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751070Ab3BEGEc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Feb 2013 01:04:32 -0500
In-Reply-To: <1359993540-20780-5-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, b-cousson@ti.com, balbi@ti.com, stern@rowland.harvard.edu, linux@arm.linux.org.uk, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, rnayak@ti.com, paul@pwsan.com, Samuel Ortiz <sameo@linux.intel.com>

On Monday 04 February 2013 09:28 PM, Roger Quadros wrote:
> Enable this driver to probe in device tree boot.
>
> CC: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>   .../devicetree/bindings/mfd/omap-usb-tll.txt       |   17 +++++++++++++++++
>   drivers/mfd/omap-usb-tll.c                         |    9 +++++++++
>   2 files changed, 26 insertions(+), 0 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/mfd/omap-usb-tll.txt
>
> diff --git a/Documentation/devicetree/bindings/mfd/omap-usb-tll.txt b/Documentation/devicetree/bindings/mfd/omap-usb-tll.txt
> new file mode 100644
> index 0000000..835cf4f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/omap-usb-tll.txt
> @@ -0,0 +1,17 @@
> +OMAP HS USB Host TLL (Transceiver-Less Interface)
> +
> +Required properties:
> +
> +- compatible : should be "ti,usbhs-tll"
> +- reg : should contain one register range i.e. start and length
> +- interrupts : should contain the TLL module's interrupt
> +- ti,hwmod : must contain "usb_tll_hs"
> +
> +Example:
> +
> +	usbhstll: usbhstll@0x4a062000 {
The node name shouldn't have 0x. This comment applies to all your 
patches adding device tree support.

Thanks
Kishon
