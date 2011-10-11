From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v6 15/16] OMAP2+: UART: Enable back uart clocks with runtime API for early console
Date: Tue, 11 Oct 2011 14:06:16 -0700
Message-ID: <87pqi3z19z.fsf@ti.com>
References: <1317380561-661-1-git-send-email-govindraj.raja@ti.com>
	<1317380561-661-6-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:36558 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751188Ab1JKVGX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Oct 2011 17:06:23 -0400
In-Reply-To: <1317380561-661-6-git-send-email-govindraj.raja@ti.com>
	(Govindraj R.'s message of "Fri, 30 Sep 2011 16:32:40 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

"Govindraj.R" <govindraj.raja@ti.com> writes:

> For the early console probing we had avoided hwmod reset and idling
> and uart was idled using hwmod API and enabled back using omap_device API
> after omap_device registration.
>
> Now since we are using runtime API's to enable back uart, move hwmod
> idling and use runtime API to enable back UART.
>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>

Now that the driver is using runtime PM.  Why do we still need
HWMOD_INIT_NO_IDLE and HWMOD_INIT_NO_RESET?

The comment in the code says:

		/*
		 * During UART early init, device need to be probed
		 * to determine SoC specific init before omap_device
		 * is ready.  Therefore, don't allow idle here
		 */

This was true when using the 8250 driver because it was not using
runtime PM so could not know how to (re)enable the device.

However, since the driver is now runtime PM adapted, any device access
should be contained within a runtime PM get/put block, so there should
no longer be a reason not allow the IP blocks to be reset during boot.

Kevin

