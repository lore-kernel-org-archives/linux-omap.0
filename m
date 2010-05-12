From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 3/5] musb: add function to check if Inventra DMA used
Date: Wed, 12 May 2010 20:52:26 +0300
Message-ID: <20100512175225.GB3285@gandalf>
References: <1273664979-493-1-git-send-email-ajay.gupta@ti.com>
 <1273664979-493-2-git-send-email-ajay.gupta@ti.com>
 <1273664979-493-3-git-send-email-ajay.gupta@ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:53931 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756969Ab0ELRvm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 May 2010 13:51:42 -0400
Content-Disposition: inline
In-Reply-To: <1273664979-493-3-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On Wed, May 12, 2010 at 05:19:37PM +0530, Ajay Kumar Gupta wrote:
> Added is_inventra_dma_enabled() funtion which would be required
> for adding workaround for Inventra DMA issues. It can also be
> used at other places instead of #ifdefs.
> 
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>

[..]

> +#ifdef CONFIG_USB_INVENTRA_DMA
> +#define	is_inventra_dma_enabled()	1
> +#else
> +#define	is_inventra_dma_enabled()	0
> +#endif

actually I wanted to get rid of those...

-- 
balbi
