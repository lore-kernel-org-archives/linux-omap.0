From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 07/20] OMAP: McBSP: Add transmit/receive threshold
	handler
Date: Thu, 6 Aug 2009 15:10:39 +0300
Message-ID: <20090806121039.GL2358@atomide.com>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com> <1248958183-15015-2-git-send-email-eduardo.valentin@nokia.com> <1248958183-15015-3-git-send-email-eduardo.valentin@nokia.com> <1248958183-15015-4-git-send-email-eduardo.valentin@nokia.com> <1248958183-15015-5-git-send-email-eduardo.valentin@nokia.com> <1248958183-15015-6-git-send-email-eduardo.valentin@nokia.com> <1248958183-15015-7-git-send-email-eduardo.valentin@nokia.com> <1248958183-15015-8-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49428 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754863AbZHFMNx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Aug 2009 08:13:53 -0400
Content-Disposition: inline
In-Reply-To: <1248958183-15015-8-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org, Jarkko Nikula <jhnikula@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>

* Eduardo Valentin <eduardo.valentin@nokia.com> [090730 16:01]:
> This patch adds a way to handle transmit/receive threshold.
> It export to mcbsp users a callback registration procedure.
> 
> Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
> ---
>  arch/arm/plat-omap/include/mach/mcbsp.h |   13 ++++++++
>  arch/arm/plat-omap/mcbsp.c              |   50 +++++++++++++++++++++++++++++++
>  2 files changed, 63 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
> index e3b300c..26bcab8 100644
> --- a/arch/arm/plat-omap/include/mach/mcbsp.h
> +++ b/arch/arm/plat-omap/include/mach/mcbsp.h
> @@ -259,6 +259,10 @@
>  #define ENAWAKEUP		0x0004
>  #define SOFTRST			0x0002
>  
> +/********************** McBSP IRQSTATUS bit definitions ********************/
> +#define IRQST_XRDY		(1<<10)
> +#define IRQST_RRDY		(1<<3)
> +
>  /********************** McBSP WAKEUPEN bit definitions *********************/
>  #define XEMPTYEOFEN		0x4000
>  #define XRDYEN			0x0400

Please add spaces around << defines above.

Regards,

Tony
