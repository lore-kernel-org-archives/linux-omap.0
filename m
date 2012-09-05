From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v8 1/3] ARM: OMAP2/3: hwmod data: add gpmc
Date: Wed, 5 Sep 2012 16:27:32 -0700
Message-ID: <20120905232732.GM1303@atomide.com>
References: <cover.1346846464.git.afzal@ti.com>
 <17b686d1aaf6fa6bfdbe30993804dd5a269ae6db.1346846464.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:33739 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753952Ab2IEX1f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 19:27:35 -0400
Content-Disposition: inline
In-Reply-To: <17b686d1aaf6fa6bfdbe30993804dd5a269ae6db.1346846464.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: paul@pwsan.com, jon-hunter@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Afzal Mohammed <afzal@ti.com> [120905 05:38]:
> Add gpmc hwmod and associated interconnect data
>  
> +static struct omap_hwmod_addr_space omap2420_gpmc_addrs[] = {
> +	{
> +		.pa_start	= 0x6800A000,
> +		.pa_end		= 0x6800AFFF,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +	{ }
> +};

Nit, please lowercase all the hex numbers, that's the standard
in Linux.

Tony
