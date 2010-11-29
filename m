From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 4/8] omap: clock: add clkdev aliases for EHCI clocks
Date: Mon, 29 Nov 2010 11:40:18 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1011291139560.2515@utopia.booyaka.com>
References: <1291051537-23743-1-git-send-email-gadiyar@ti.com> <1291051537-23743-5-git-send-email-gadiyar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60794 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422Ab0K2SkT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Nov 2010 13:40:19 -0500
In-Reply-To: <1291051537-23743-5-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Greg KH <gregkh@suse.de>

On Mon, 29 Nov 2010, Anand Gadiyar wrote:

> Add clkdev aliases for the USBHOST and USBTLL clocks on OMAP3 and
> OMAP4, so that the driver can refer to the clocks using a common alias.
> 
> This will disappear when the driver is converted to use the hwmod
> database, but until then this patch is needed.
> 
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>

Acked-by: Paul Walmsley <paul@pwsan.com>


- Paul
