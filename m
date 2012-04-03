From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND PATCH] ARM :OMAP2+: UART: Remove some of uart default
 pads
Date: Tue, 3 Apr 2012 11:19:26 -0700
Message-ID: <20120403181925.GH8240@atomide.com>
References: <1332324149-16058-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:24492 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754839Ab2DCST2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Apr 2012 14:19:28 -0400
Content-Disposition: inline
In-Reply-To: <1332324149-16058-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Kevin Hilman <khilman@ti.com>

* Govindraj.R <govindraj.raja@ti.com> [120321 03:06]:
> From: "Govindraj.R" <govindraj.raja@ti.com>
> 
> The following commit:
> (7496ba3  ARM: OMAP2+: UART: Add default mux for all uarts)
> added default pads for all uarts. But not all boards tend to
> use all uarts and most of unused uart pins are muxed for
> other purpose. This commit breaks the modules which where trying
> to use unused uart pins on their boards.
> 
> So remove all default pads except uart1/3 as most boards
> tend to use either uart1/3 as console port and use only tx/rx
> lines, declare only those pads for uart1/3.
> If any boards tend to use any other uart other uart1/3
> the mux data should to passed from board file and init individual
> uart port using omap_serial_init_port api.

This is still wrong. We can't mux any serial pins unless specifically
requested from the board-*.c files. So please do a fix to get back to
v3.2 behaviour where you basically revert 7496ba3.

Tony
