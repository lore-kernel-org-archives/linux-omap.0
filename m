From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 02/20] OMAP: McBSP: Wakeups utilized
Date: Thu, 30 Jul 2009 21:56:02 +0300
Message-ID: <20090730215602.8fdcbaf1.jhnikula@gmail.com>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-2-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-3-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:45790 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbZG3SzI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jul 2009 14:55:08 -0400
In-Reply-To: <1248958183-15015-3-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>

On Thu, 30 Jul 2009 15:49:25 +0300
Eduardo Valentin <eduardo.valentin@nokia.com> wrote:

> --- a/arch/arm/plat-omap/mcbsp.c
> +++ b/arch/arm/plat-omap/mcbsp.c
> @@ -257,6 +257,23 @@ int omap_mcbsp_request(unsigned int id)
>  	clk_enable(mcbsp->iclk);
>  	clk_enable(mcbsp->fclk);
>  
> +#ifdef CONFIG_ARCH_OMAP34XX
> +	/*

I'm sure there is a way to avoid all of these added ifdefs in this patch
and in patches 7 and 8 as well.


-- 
Jarkko
