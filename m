From: Tony Lindgren <tony@atomide.com>
Subject: Re: Trouble getting Logic OMAp35x modules to boot
Date: Mon, 6 Dec 2010 11:22:17 -0800
Message-ID: <20101206192217.GL8345@atomide.com>
References: <4CEB2502.9000300@logicpd.com>
 <AANLkTi=vF-b+T59wOmg+aUARvC5wkq8ZCfYJ0LNhZJx7@mail.gmail.com>
 <4CEB5CA2.40004@logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53410 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105Ab0LFTWX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Dec 2010 14:22:23 -0500
Content-Disposition: inline
In-Reply-To: <4CEB5CA2.40004@logicpd.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peterb@logicpd.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, Peter Barada <peter.barada@logicpd.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

* Peter Barada <peterb@logicpd.com> [101122 22:09]:
> 
> Also, where in the kernel is the mux setup for the UARTs done?  I'd
> like to use UART2 and am not sure how to wire it into the
> kernel(i.e. setup the mux for it as those pins are in mode 7) and
> want to follow the same style as that for UART1/3..

I posted some patches to pass the board specific pins to serial.c
few days ago, can you please give that series a try?

The series subject is "omap: Board specific muxing using hwmod".

Regards,

Tony
