From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 2/2] TWL4030: convert old-style function documentation to
 current kerneldoc
Date: Fri, 18 Jul 2008 03:47:13 -0500
Message-ID: <ba4b7ed08a5ba4da520421fa7273074f@felipebalbi.com>
References: <20080718021356.31884.9848.stgit@localhost.localdomain> <20080718021550.31884.69436.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:51363 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284AbYGRIrP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jul 2008 04:47:15 -0400
In-Reply-To: <20080718021550.31884.69436.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org



On Thu, 17 Jul 2008 20:15:51 -0600, Paul Walmsley <paul@pwsan.com> wrote:
> Several functions use old-style function documentation; convert those to
> use the current kerneldoc style.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
> 
>  drivers/i2c/chips/twl4030-core.c |   54
> ++++++++++++++++++--------------------
>  1 files changed, 26 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/i2c/chips/twl4030-core.c
> b/drivers/i2c/chips/twl4030-core.c
> index 54e392b..4104fd2 100644
> --- a/drivers/i2c/chips/twl4030-core.c
> +++ b/drivers/i2c/chips/twl4030-core.c
> @@ -389,17 +389,18 @@ static struct irq_chip twl4030_irq_chip = {
>  };
> 
>  /* Global Functions */
> -/*
> - * @brief twl4030_i2c_write - Writes a n bit register in TWL4030
> +
> +/**
> + * twl4030_i2c_write - Writes a n bit register in TWL4030
> + * @mod_no: module number
> + * @value: an array of num_bytes+1 containing data to write
> + * @reg: register address (just offset will do)
> + * @num_bytes: number of bytes to transfer
>   *
> - * @param mod_no - module number
> - * @param *value - an array of num_bytes+1 containing data to write
> - * IMPORTANT - Allocate value num_bytes+1 and valid data starts at
> - *		 Offset 1.
> - * @param reg - register address (just offset will do)
> - * @param num_bytes - number of bytes to transfer
> + * IMPORTANT: for 'value' parameter: Allocate value num_bytes+1 and
> + * valid data starts at Offset 1.
>   *
> - * @return result of operation - 0 is success
> + * Results the result of operation - 0 is success

I suppose you mean Returns here.

-- 
Best Regards,

Felipe Balbi
http://blog.felipebalbi.com
me@felipebalbi.com

