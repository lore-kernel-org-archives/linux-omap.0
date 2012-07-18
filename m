From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: am3517: issue with omap3_l3_app_irq during heavy USB load
Date: Wed, 18 Jul 2012 11:26:48 -0700
Message-ID: <20120718182648.GC27904@animalcreek.com>
References: <5006656C.9010602@visionsystems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:39334 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753246Ab2GRS0t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Jul 2012 14:26:49 -0400
Content-Disposition: inline
In-Reply-To: <5006656C.9010602@visionsystems.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Yegor Yefremov <yegor_sub1@visionsystems.de>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Porter, Matt" <mporter@ti.com>, grinberg@compulab.co.il

On Wed, Jul 18, 2012 at 09:27:40AM +0200, Yegor Yefremov wrote:
> My system: am3517 based board with SMSC9514 attached to EHCI port 0 (not OTG), the rest of the USB ports are marked as disabled - OMAP_USBHS_PORT_MODE_UNUSED.
> Kernel: 3.3-rc7 from linux-omap (so far the latest kernel, where all hardware is supported)
> 
> When performing network test only (nuttcp over SMSC9514's network interface) the system work reliably. But as soon as I start other USB activities (talking to a 3G modem/FTDI serial interfaces) I get following error:

> Any idea?

Nope, sorry...
