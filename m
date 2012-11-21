From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/5] ARM: OMAP: Move plat/omap-serial.h to
 include/linux/platform_data/serial-omap.h
Date: Wed, 21 Nov 2012 10:41:32 -0800
Message-ID: <20121121184131.GA18567@atomide.com>
References: <20121121174201.25576.61961.stgit@muffinssi.local>
 <20121121174230.25576.64507.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:29318 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755667Ab2KUSli (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Nov 2012 13:41:38 -0500
Content-Disposition: inline
In-Reply-To: <20121121174230.25576.64507.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@ti.com>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, Alan Cox <alan@linux.intel.com>

* Tony Lindgren <tony@atomide.com> [121121 09:44]:
> We need to move this file to allow ARM multiplatform configurations
> to build for omap2+. This can now be done as this file now only
> contains platform_data.

Russell, this one depends on your commit fd9980c7 (SERIAL: omap:
remove OMAP_UART_SYSC_RESET and OMAP_UART_FIFO_CLR).

Is that commit immutable and OK to merge as a dependency to my
branch?

Regards,

Tony
