From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: Low level debugging using CONFIG_EARLY_PRINTK=y, omap-debug
 branch removed
Date: Wed, 16 Dec 2009 14:37:40 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BFB58018@dbde02.ent.ti.com>
References: <20091216005337.GR4575@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55289 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761903AbZLPJHr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Dec 2009 04:07:47 -0500
In-Reply-To: <20091216005337.GR4575@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony,
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Tony
> Lindgren
> Sent: Wednesday, December 16, 2009 6:24 AM
> To: linux-omap@vger.kernel.org
> Subject: Low level debugging using CONFIG_EARLY_PRINTK=y, omap-debug branch removed
> 
> Hi all,
> 
> Recent commit 93fd03a8c6728b58879f8af20ffd55d9c32a778b added
> support for CONFIG_EARLY_PRINTK on ARM. Recent earlier kernels
> should work too by applying the patch in the commit above.
> 
> This means we can now get rid of the old printk.c hack in the
> omap-debug branch, so I've deleted that branch.
> 
> To use the earlyprintk, just do the following:
> 
> 1. Make sure you have the necessary .config options set
> 
> CONFIG_DEBUG_LL=y
> CONFIG_EARLY_PRINTK=y
> CONFIG_OMAP_LL_DEBUG_UART1=y
> # CONFIG_OMAP_LL_DEBUG_UART2 is not set
> # CONFIG_OMAP_LL_DEBUG_UART3 is not set
> 
> The LL_DEBUG_UART above is typically 1, but it's 3 on Nokia
> boards.
> 
> 2. Edit the kernel CMDLINE in your .config to have "debug earlyprintk"
> 
> Optionally if you have a JTAG console, you can use CONFIG_DEBUG_ICEDCC
> instead LL_DEBUG_UART.
> 
> I've also added these instructions to:
> 
> http://www.elinux.org/Debugging_OMAP_kernel
I tried this on couple of boards and at least it doesn't work with the options and mentioned bootargs. The low level debug prints are still not coming on console.

I haven't debugged it though.

Regards,
Santosh



