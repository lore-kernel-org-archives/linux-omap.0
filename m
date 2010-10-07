From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v1 12/16] OMAP3: hwmod DSS: DISPC Move init,exit to
 driver
Date: Thu, 7 Oct 2010 21:48:00 +0200
Message-ID: <20101007214800.632abbe6@surf>
References: <1286363699-9614-1-git-send-email-svadivu@ti.com>
	<1286363699-9614-2-git-send-email-svadivu@ti.com>
	<1286363699-9614-3-git-send-email-svadivu@ti.com>
	<1286363699-9614-4-git-send-email-svadivu@ti.com>
	<1286363699-9614-5-git-send-email-svadivu@ti.com>
	<1286363699-9614-6-git-send-email-svadivu@ti.com>
	<1286363699-9614-7-git-send-email-svadivu@ti.com>
	<1286363699-9614-8-git-send-email-svadivu@ti.com>
	<1286363699-9614-9-git-send-email-svadivu@ti.com>
	<1286363699-9614-10-git-send-email-svadivu@ti.com>
	<1286363699-9614-11-git-send-email-svadivu@ti.com>
	<1286363699-9614-12-git-send-email-svadivu@ti.com>
	<1286363699-9614-13-git-send-email-svadivu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:53636 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253Ab0JGTsL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Oct 2010 15:48:11 -0400
In-Reply-To: <1286363699-9614-13-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Guruswamy Senthilvadivu <svadivu@ti.com>
Cc: khilman@deeprootsystems.com, tomi.valkeinen@nokia.com, paul@pwsan.com, hvaibhav@ti.com, linux-omap@vger.kernel.org

Hello Senthil,

On Wed,  6 Oct 2010 16:44:55 +0530
Guruswamy Senthilvadivu <svadivu@ti.com> wrote:

>  static struct {
> +	struct platform_device *pdev;
>  	void __iomem    *base;
>  
>  	u32	fifo_size[3];
> @@ -189,11 +190,22 @@ static inline u32 dispc_read_reg(const struct dispc_reg idx)
>  /* DISPC HW IP initialisation */
>  static int omap_dispchw_probe(struct platform_device *pdev)
>  {
> -	return 0;
> +	int r;
> +	dispc.pdev = pdev;
> +
> +	r = dispc_init();
> +	if (r) {
> +		DSSERR("Failed to initialize dispc\n");
> +		goto err_dispc;
> +	}
> +
> +err_dispc:
> +	return r;
>  }
>  
>  static int omap_dispchw_remove(struct platform_device *pdev)
>  {
> +	dispc_exit();
>  	return 0;
>  }

Same comments than the one for the patch on the RFBI driver.

Regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
