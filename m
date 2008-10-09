From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 01/05] ARM: OMAP2: Add minimal omap3430 support
Date: Thu, 9 Oct 2008 15:47:37 +0100
Message-ID: <20081009144737.GG435@flint.arm.linux.org.uk>
References: <1223035779-26306-1-git-send-email-tony@atomide.com> <1223035779-26306-2-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54517 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135AbYJIOrt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Oct 2008 10:47:49 -0400
Content-Disposition: inline
In-Reply-To: <1223035779-26306-2-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Syed Mohammed Khasim <x0khasim@ti.com>, Karthik Dasu <karthik-dp@ti.com>, Adrian Hunter <ext-adrian.hunter@nokia.com>

On Fri, Oct 03, 2008 at 03:09:35PM +0300, Tony Lindgren wrote:
> @@ -51,12 +53,39 @@ static struct map_desc omap2_io_desc[] __initdata = {
>  		.type		= MT_DEVICE
>  	},
>  	{
> -		.virtual        = L4_24XX_VIRT,
> -		.pfn            = __phys_to_pfn(L4_24XX_PHYS),
> -		.length         = L4_24XX_SIZE,
> -		.type           = MT_DEVICE
> +		.virtual	= L4_24XX_VIRT,
> +		.pfn		= __phys_to_pfn(L4_24XX_PHYS),
> +		.length		= L4_24XX_SIZE,
> +		.type		= MT_DEVICE

It would be good to transition all of the OMAP structure initializations
over to using a trailing ',' on the last initializer as per the rest of
the kernel source.  Having that additional ',' makes script based
rewriting of the contents of structures a lot easier, and reduces the
chances of patches clashing.

I'm not suggesting it as something that needs to be done now though.
