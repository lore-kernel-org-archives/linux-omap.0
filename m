From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: Patch [1/2] DaVinci CPPI TX DMA tasklet
Date: Thu, 21 Aug 2008 17:21:31 +0300
Message-ID: <20080821142131.GY23346@gandalf.research.nokia.com>
References: <1219327101-28313-1-git-send-email-swami.iyer@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:29725 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbYHUOUa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Aug 2008 10:20:30 -0400
Content-Disposition: inline
In-Reply-To: <1219327101-28313-1-git-send-email-swami.iyer@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Swaminathan S <swami.iyer@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, felipe.balbi@nokia.com

Hi,

On Thu, Aug 21, 2008 at 07:28:21PM +0530, ext Swaminathan S wrote:
> 
>     Signed-off-by: Swaminathan S <swami.iyer@ti.com>
>     
>     This patch adds tasklet structures to musb to enable
>     polling for FIFO empty status on the Mentor TX FIFO.
>     This is requried to enable proper functioning of
              ^ typo

>     DaVinci CPPI TX DMA when performing Tx transfers.

do not indent the comments.
Signed-off-by line should come after those comments, like the following:

This patch adds tasklet structures to musb to enable
polling for FIFO empty status on the Mentor TX FIFO.
This is required to enable proper functioning of
DaVinci CPPI TX DMA when performing Tx transfers.

Signed-off-by: Swaminathan S <swami.iyer@ti.com>

> +#ifdef CONFIG_ARCH_DAVINCI
> +extern void musb_fifo_check_tasklet(unsigned long data);
> +#endif

points to nothing... meld both patches together.

-- 
balbi
