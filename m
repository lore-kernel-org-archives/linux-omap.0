From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v3] usb: musb: Enable DMA mode1 RX for USB-Mass-Storage
Date: Tue, 19 Jul 2011 08:21:17 -0700
Message-ID: <87pql6jnyq.fsf@ti.com>
References: <1311065534-8300-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:45680 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751522Ab1GSPVX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Jul 2011 11:21:23 -0400
In-Reply-To: <1311065534-8300-1-git-send-email-vikram.pandita@ti.com> (Vikram
	Pandita's message of "Tue, 19 Jul 2011 01:52:14 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikram Pandita <vikram.pandita@ti.com>
Cc: balbi@ti.com, linux-usb@vger.kernel.org, gadiyar@ti.com, linux-omap@vger.kernel.org, Moiz Sonasath <m-sonasath@ti.com>

Vikram Pandita <vikram.pandita@ti.com> writes:

> From: Anand Gadiyar <gadiyar@ti.com>
>
> This patch enables the DMA mode1 RX support.
> This feature is enabled based on the short_not_ok flag passed from
> gadget drivers.
>
> This will result in a thruput performance gain of around
> 40% for USB mass-storage/mtp use cases.
>
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> Signed-off-by: Moiz Sonasath <m-sonasath@ti.com>
> Tested-by: Vikram Pandita <vikram.pandita@ti.com>

As you are on the delivery path now, it also needs your signoff.

Kevin
