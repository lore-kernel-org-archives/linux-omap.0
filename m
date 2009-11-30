From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap3: mux: add shorthands for OUTPUT_PULL{UP,DOWN}
Date: Mon, 30 Nov 2009 13:12:55 -0800
Message-ID: <20091130211255.GZ4348@atomide.com>
References: <cover.1259481545.git.mike@compulab.co.il>
 <1b6ff0b31e4c22532659749282e0dcf4dccdf5e4.1259481545.git.mike@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61259 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556AbZK3VMu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Nov 2009 16:12:50 -0500
Content-Disposition: inline
In-Reply-To: <1b6ff0b31e4c22532659749282e0dcf4dccdf5e4.1259481545.git.mike@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: linux-omap@vger.kernel.org

* Mike Rapoport <mike@compulab.co.il> [091129 00:10]:
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> ---
>  arch/arm/mach-omap2/mux.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
> index e09c5d2..02a1b53 100644
> --- a/arch/arm/mach-omap2/mux.h
> +++ b/arch/arm/mach-omap2/mux.h
> @@ -37,6 +37,8 @@
>  
>  /* Active pin states */
>  #define OMAP_PIN_OUTPUT			0
> +#define OMAP_PIN_OUTPUT_PULLUP		(OMAP_PULL_ENA | OMAP_PULL_UP)
> +#define OMAP_PIN_OUTPUT_PULLDOWN	OMAP_PULL_ENA
>  #define OMAP_PIN_INPUT			OMAP_INPUT_EN
>  #define OMAP_PIN_INPUT_PULLUP		(OMAP_PULL_ENA | OMAP_INPUT_EN \
>  						| OMAP_PULL_UP)

Hmm, isn't this same as configuring as GPIO with up or
down value?

Or is there's some need doing it with mux only? Like
power savings?

Regards,

Tony
