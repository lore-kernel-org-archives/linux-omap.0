From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP MUX framework changes
Date: Thu, 18 Nov 2010 09:57:14 -0800
Message-ID: <20101118175714.GF9264@atomide.com>
References: <1290017211-2217-1-git-send-email-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:16704 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760036Ab0KRR5R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Nov 2010 12:57:17 -0500
Content-Disposition: inline
In-Reply-To: <1290017211-2217-1-git-send-email-dmurphy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, paul@pwsan.com, khilman@deeprootsystems.com

Hi Dan,

* Dan Murphy <dmurphy@ti.com> [101117 09:58]:
> @@ -81,10 +81,14 @@ void omap_mux_write(struct omap_mux_partition *partition, u16 val,
>  void omap_mux_write_array(struct omap_mux_partition *partition,
>  				 struct omap_board_mux *board_mux)
>  {
> -	while (board_mux->reg_offset != OMAP_MUX_TERMINATOR) {
> -		omap_mux_write(partition, board_mux->value,
> -			       board_mux->reg_offset);
> -		board_mux++;
> +	if (partition) {
> +		while (board_mux->reg_offset != OMAP_MUX_TERMINATOR) {
> +			omap_mux_write(partition, board_mux->value,
> +				       board_mux->reg_offset);
> +			board_mux++;
> +		}
> +	} else {
> +		pr_err("%s: Partition was NULL\n", __func__);
>  	}
>  }
>  

Can you please make this into a separate patch. And instead of
indenting the code more, just do something like:

	if (!partition)
		return -EINVAL;

Regards,

Tony
