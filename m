From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v1 11/16] OMAP3: hwmod DSS: RFBI Move init,exit to
 driver
Date: Thu, 7 Oct 2010 21:47:22 +0200
Message-ID: <20101007214722.16799b9a@surf>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:53598 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258Ab0JGTrc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Oct 2010 15:47:32 -0400
In-Reply-To: <1286363699-9614-12-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Guruswamy Senthilvadivu <svadivu@ti.com>
Cc: khilman@deeprootsystems.com, tomi.valkeinen@nokia.com, paul@pwsan.com, hvaibhav@ti.com, linux-omap@vger.kernel.org

Hello Senthil,

On Wed,  6 Oct 2010 16:44:54 +0530
Guruswamy Senthilvadivu <svadivu@ti.com> wrote:

> diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
> index 23598ea..9bee39d 100644
> --- a/drivers/video/omap2/dss/rfbi.c
> +++ b/drivers/video/omap2/dss/rfbi.c
> @@ -100,6 +100,7 @@ static int rfbi_convert_timings(struct rfbi_timings *t);
>  static void rfbi_get_clk_info(u32 *clk_period, u32 *max_clk_div);
>  
>  static struct {
> +	struct platform_device *pdev;
>  	void __iomem	*base;
>  
>  	unsigned long	l4_khz;
> @@ -142,11 +143,22 @@ static inline u32 rfbi_read_reg(const struct rfbi_reg idx)
>  /* RFBI HW IP initialisation */
>  static int omap_rfbihw_probe(struct platform_device *pdev)
>  {
> -	return 0;
> +	int r;
> +	rfbi.pdev = pdev;
> +
> +	r = rfbi_init();
> +	if (r) {
> +		DSSERR("Failed to initialize rfbi\n");
> +		goto err_rfbi;
> +	}
> +
> +err_rfbi:
> +	return r;
>  }
>  
>  static int omap_rfbihw_remove(struct platform_device *pdev)
>  {
> +	rfbi_exit();
>  	return 0;
>  }
>  

Instead of having probe() and remove() functions that call the existing
init() and exit(), why not making your driver look like most Linux
drivers here, and directly do the initialization in probe() and the
cleanup in remove() ?

Concerning the added pdev field to the rfbi structure, do you really it
at this point ?

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
