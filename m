From: Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCHv3 2/8] mailbox/omap: add support for parsing dt devices
Date: Wed, 7 Aug 2013 10:40:17 -0500
Message-ID: <BB39592C-0DAC-49A4-A782-583D7EB858AF@codeaurora.org>
References: <1375825216-18119-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:58599 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412Ab3HGPkN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Aug 2013 11:40:13 -0400
In-Reply-To: <1375825216-18119-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <benoit.cousson@linaro.org>, Paul Walmsley <paul@pwsan.com>, Ohad Ben-Cohen <ohad@wizery.com>, Jassi Brar <jaswinder.singh@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org


On Aug 6, 2013, at 4:40 PM, Suman Anna wrote:

> Logic has been added to the OMAP2+ mailbox code to
> parse the mailbox dt nodes and construct the different
> mailboxes associated with the instance. The design is
> based on gathering the same information that was being
> passed previously through the platform data, except for
> the interrupt type configuration information.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
> .../devicetree/bindings/mailbox/omap-mailbox.txt   |  43 +++++++
> drivers/mailbox/mailbox-omap2.c                    | 130 ++++++++++++++++++---
> 2 files changed, 158 insertions(+), 15 deletions(-)
> create mode 100644 Documentation/devicetree/bindings/mailbox/omap-mailbox.txt
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/omap-mailbox.txt b/Documentation/devicetree/bindings/mailbox/omap-mailbox.txt
> new file mode 100644
> index 0000000..8ffb08a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/omap-mailbox.txt
> @@ -0,0 +1,43 @@
> +OMAP2+ Mailbox Driver
> +
> +Required properties:
> +- compatible:		Should be one of the following,
> +			    "ti,omap2-mailbox" for
> +				OMAP2420, OMAP2430, OMAP3430, OMAP3630 SoCs
> +			    "ti,omap4-mailbox" for
> +				OMAP44xx, OMAP54xx, AM33xx, AM43xx, DRA7xx SoCs
> +- reg:			Contains the mailbox register address range (base address
> +			and length)
> +- interrupts: 		Contains the interrupt information for the mailbox
> +			device. The format is dependent on which interrupt
> +			controller the OMAP device uses
> +- ti,hwmods:		Name of the hwmod associated with the mailbox
> +- ti,mbox-num-users:	Number of targets (processor devices) that the mailbox device
> +			can interrupt
> +- ti,mbox-num-fifos:	Number of h/w fifos within the mailbox device

Isn't "ti,mbox-num-users", "ti,mbox-num-fifos" this SoC specific, why do we need to encode in the device tree.  Can we not have a more SoC specific compatiable and encode such info in the driver as part of the .data field in of_device_id ?

> +- ti,mbox-names:	Array of the names of the mailboxes
> +- ti,mbox-data:		Mailbox descriptor data private to each mailbox. The 4
> +			cells represent the following data,
> +			  Cell #1 (tx_id) - mailbox fifo id used for
> +						transmitting messages
> +			  Cell #2 (rx_id) - mailbox fifo id on which messages
> +						are received
> +			  Cell #3 (irq_id) - irq identifier index number to use
> +						from the interrupts data
> +			  Cell #4 (usr_id) - mailbox user id for identifying the
> +						interrupt into the MPU interrupt
> +						controller.
> +

ti,mbox-data really seems like it should be encoded in the driver and not in the device tree.  Is it specific to the SoC?

> +Example:
> +
> +/* OMAP4 */
> +mailbox: mailbox@4a0f4000 {
> +	compatible = "ti,omap4-mailbox";
> +	reg = <0x4a0f4000 0x200>;
> +	interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
> +	ti,hwmods = "mailbox";
> +	ti,mbox-num-users = <3>;
> +	ti,mbox-num-fifos = <8>;
> +	ti,mbox-names = "mbox-ipu", "mbox-dsp";
> +	ti,mbox-data = <0 1 0 0>, <3 2 0 0>;
> +};

[snip]

- k

--
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

