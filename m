From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/3] Add closures to clkdm_for_each and pwrdm_for_each.
Date: Tue, 14 Oct 2008 13:50:46 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0810141348320.8581@utopia.booyaka.com>
References: <1223995198-19985-1-git-send-email-peter.de-schrijver@nokia.com> <1223995198-19985-2-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43957 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753924AbYJNTus (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2008 15:50:48 -0400
In-Reply-To: <1223995198-19985-2-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

Hello Peter,

one very minor comment:

On Tue, 14 Oct 2008, Peter 'p2' De Schrijver wrote:

> diff --git a/arch/arm/plat-omap/include/mach/powerdomain.h b/arch/arm/plat-omap/include/mach/powerdomain.h
> index 52663fc..6271d85 100644
> --- a/arch/arm/plat-omap/include/mach/powerdomain.h
> +++ b/arch/arm/plat-omap/include/mach/powerdomain.h
> @@ -119,6 +119,11 @@ struct powerdomain {
>  
>  	int state;
>  	unsigned state_counter[4];
> +
> +#ifdef CONFIG_PM_DEBUG
> +	s64 timer;
> +	s64 state_timer[4];
> +#endif
>  };

this probably goes best in patch 2/3?

Other than that, looks good to me.


- Paul
