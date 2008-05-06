From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] PRM: Fixed comments on global PRM register usage.
Date: Tue, 6 May 2008 15:13:11 -0700
Message-ID: <20080506221310.GF18682@atomide.com>
References: <1210059181-18192-1-git-send-email-ext-kalle.jokiniemi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:56575 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764215AbYEFWNN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 May 2008 18:13:13 -0400
Content-Disposition: inline
In-Reply-To: <1210059181-18192-1-git-send-email-ext-kalle.jokiniemi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Cc: linux-omap@vger.kernel.org

* Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com> [080506 00:33]:
> Signed-off-by: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
> ---
>  arch/arm/mach-omap2/prm.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
> index 125d1e2..6715d6f 100644
> --- a/arch/arm/mach-omap2/prm.h
> +++ b/arch/arm/mach-omap2/prm.h
> @@ -33,7 +33,7 @@
>  
>  /*
>   * Architecture-specific global PRM registers
> - * Use prm_{read,write}_reg() with these registers.
> + * Use __raw_{read,write}l() with these registers.
>   *
>   * With a few exceptions, these are the register names beginning with
>   * PRCM_* on 24xx, and PRM_* on 34xx.  (The exceptions are the

Thanks, pushing.

Tony
