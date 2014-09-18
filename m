From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v3 2/3] nand: omap2: Remove horrible ifdefs to fix module
 probe
Date: Wed, 17 Sep 2014 23:03:36 -0700
Message-ID: <20140918060336.GE7362@norris-Latitude-E6410>
References: <1410447730-16087-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 <1410447730-16087-3-git-send-email-ezequiel@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:41439 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbaIRGDj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2014 02:03:39 -0400
Received: by mail-pa0-f51.google.com with SMTP id eu11so758184pac.10
        for <linux-omap@vger.kernel.org>; Wed, 17 Sep 2014 23:03:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1410447730-16087-3-git-send-email-ezequiel@vanguardiasur.com.ar>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Roger Quadros <rogerq@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org

On Thu, Sep 11, 2014 at 12:02:09PM -0300, Ezequiel Garcia wrote:
> The current code abuses ifdefs to determine if the selected ECC scheme
> is supported by the running kernel. As a result the code is hard to read,
> and it also fails to load as a module.

Yes, a real eyesore, with little benefit from the #ifdef's.

> This commit removes all the ifdefs and instead introduces a function
> omap2_nand_ecc_check() to check if the ECC is supported by using
> IS_ENABLED(CONFIG_xxx).
> 
> Since IS_ENABLED() is true when a config is =y or =m, this change fixes the
> module so it can be loaded with no issues.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
[...]
> diff --git a/include/linux/platform_data/elm.h b/include/linux/platform_data/elm.h
> index 780d1e9..25d1bca 100644
> --- a/include/linux/platform_data/elm.h
> +++ b/include/linux/platform_data/elm.h
> @@ -42,8 +42,22 @@ struct elm_errorvec {
>  	int error_loc[16];
>  };
>  
> +#if IS_ENABLED(CONFIG_MTD_NAND_OMAP_BCH)
>  void elm_decode_bch_error_page(struct device *dev, u8 *ecc_calc,
>  		struct elm_errorvec *err_vec);
>  int elm_config(struct device *dev, enum bch_ecc bch_type,
>  	int ecc_steps, int ecc_step_size, int ecc_syndrome_size);
> +#else
> +void elm_decode_bch_error_page(struct device *dev, u8 *ecc_calc,
> +		struct elm_errorvec *err_vec)

You should not be defining non-static functions in a header. Now these
functions will be uselessly placed in every compilation unit that
includes this header. You should probably make this function 'static
inline'.

> +{
> +}
> +
> +int elm_config(struct device *dev, enum bch_ecc bch_type,
> +	int ecc_steps, int ecc_step_size, int ecc_syndrome_size)

And same here.

> +{
> +	return -ENOSYS;
> +}
> +#endif /* CONFIG_MTD_NAND_ECC_BCH */
> +
>  #endif /* __ELM_H */

Brian
