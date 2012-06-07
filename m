From: Tony Lindgren <tony@atomide.com>
Subject: Re: [CFT 11/11] Add feature removal of old OMAP private DMA
 implementation
Date: Thu, 7 Jun 2012 10:07:05 -0700
Message-ID: <20120607170705.GJ12766@atomide.com>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk>
 <E1ScabE-0003uN-JD@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <E1ScabE-0003uN-JD@rmk-PC.arm.linux.org.uk>
Sender: linux-doc-owner@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Rob Landley <rob@landley.net>, linux-doc@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Russell King <rmk+kernel@arm.linux.org.uk> [120607 04:14]:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  Documentation/feature-removal-schedule.txt |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
> index 56000b3..1f7ba35 100644
> --- a/Documentation/feature-removal-schedule.txt
> +++ b/Documentation/feature-removal-schedule.txt
> @@ -612,3 +612,14 @@ When:	June 2013
>  Why:	Unsupported/unmaintained/unused since 2.6
>  
>  ----------------------------
> +
> +What:	OMAP private DMA implementation
> +When:	2013
> +Why:	We have a DMA engine implementation; all users should be updated
> +	to use this rather than persisting with the old APIs.  The old APIs
> +	block merging the old DMA engine implementation into the DMA
> +	engine driver.
> +Who:	Russell King <linux@arm.linux.org.uk>,
> +	Santosh Shilimkar <santosh.shilimkar@ti.com>
> +
> +----------------------------
> -- 
> 1.7.4.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
