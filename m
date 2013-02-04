From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 06/13] USB: ohci-omap3: Get platform resources by index
 rather than by name
Date: Mon, 4 Feb 2013 16:12:55 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1302041612380.1756-100000@iolanthe.rowland.org>
References: <1359993540-20780-7-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:33121 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754180Ab3BDVM4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Feb 2013 16:12:56 -0500
In-Reply-To: <1359993540-20780-7-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, b-cousson@ti.com, balbi@ti.com, linux@arm.linux.org.uk, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, rnayak@ti.com, paul@pwsan.com

On Mon, 4 Feb 2013, Roger Quadros wrote:

> Since there is only one resource per type we don't really need
> to use resource name to obtain it. This also also makes it easier
> for device tree adaptation.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>

Acked-by: Alan Stern <stern@rowland.harvard.edu>


