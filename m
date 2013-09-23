From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 1/5] dma: cppi41: pass around device instead of
 platform_device
Date: Mon, 23 Sep 2013 09:46:08 +0530
Message-ID: <20130923041608.GW17188@intel.com>
References: <1379861404-8250-1-git-send-email-zonque@gmail.com>
 <1379861404-8250-2-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:42157 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751835Ab3IWFGo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Sep 2013 01:06:44 -0400
Content-Disposition: inline
In-Reply-To: <1379861404-8250-2-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de, bigeasy@linutronix.de, sergei.shtylyov@cogentembedded.com, dan.j.williams@intel.com, balbi@ti.com, gregkh@linuxfoundation.org

On Sun, Sep 22, 2013 at 04:50:00PM +0200, Daniel Mack wrote:
> Instead of passing around struct plafform_device, use struct device and
> save one level of dereferencing. This affects the following functions:
> 
>  * cppi41_add_chans
>  * purge_descs
>  * deinit_cpii41
>  * init_descs
>  * init_cppi41
>  * cppi_glue_infos
> 
> It's just a cosmetic cleanup that makes the code more readable.
Applied, thanks

~Vinod
