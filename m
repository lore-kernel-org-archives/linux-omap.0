From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/7] [OMAP] gpio: Allow for extended GPIO space
Date: Mon, 2 Aug 2010 13:51:50 +0300
Message-ID: <20100802105150.GB12293@atomide.com>
References: <1279598741-18607-1-git-send-email-darkstar6262@gmail.com>
 <1279598741-18607-2-git-send-email-darkstar6262@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62951 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016Ab0HBKv0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Aug 2010 06:51:26 -0400
Content-Disposition: inline
In-Reply-To: <1279598741-18607-2-git-send-email-darkstar6262@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: linux-omap@vger.kernel.org

* Cory Maccarrone <darkstar6262@gmail.com> [100720 06:59]:
> This change copies from the s3c24xx the ability for a board to specify
> if it wants 64 or 128 more GPIOs in the board space.  This is needed
> to get the HTC Herald board's extra htcpld gpios to work as actual
> gpios.

<snip>
  
> +config OMAP_GPIO_EXTRA
> +	int
> +	default 128 if OMAP_GPIO_EXTRA128
> +	default 64 if OMAP_GPIO_EXTRA64
> +	default 0
> +
> +config OMAP_GPIO_EXTRA64
> +	bool
> +	help
> +	  Add an extra 64 gpio numbers to the available GPIO pool. This is
> +	  available for boards that need extra gpios for external devices.
> +
> +config OMAP_GPIO_EXTRA128
> +	bool
> +	help
> +	  Add an extra 128 gpio numbers to the available GPIO pool. This is
> +	  available for boards that need extra gpios for external devices.
> +

Let's wait on this and the following patch a a little, I believe there
are already patches in the works to deal with this for the multi-arm
support. So this should get solved eventually in a generic way.

Regards,

Tony
