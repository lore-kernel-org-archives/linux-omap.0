From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap16xx: Removes fixme no longer needed in ocpi_enable()
Date: Tue, 8 Jul 2014 01:16:07 -0700
Message-ID: <20140708081606.GC28884@atomide.com>
References: <1404351079-5117-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1404351079-5117-1-git-send-email-xerofoify@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Krause <xerofoify@gmail.com>
Cc: linux@arm.linux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Nicholas Krause <xerofoify@gmail.com> [140702 18:33]:
> This removes the FIXME message above ocpi_enable being declared
> for proper locking in this function. As of the current kernel
> verisons there is no need for locking as only one driver uses
> this function currently and therefore there is no need for real
> locking requirements.
> 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>

Thanks applying into omap-for-v3.17/fixes-not-urgent.

Tony

> ---
>  arch/arm/mach-omap1/ocpi.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap1/ocpi.c b/arch/arm/mach-omap1/ocpi.c
> index 238170c..44a3d19 100644
> --- a/arch/arm/mach-omap1/ocpi.c
> +++ b/arch/arm/mach-omap1/ocpi.c
> @@ -55,7 +55,6 @@ static struct clk *ocpi_ck;
>  
>  /*
>   * Enables device access to OMAP buses via the OCPI bridge
> - * FIXME: Add locking
>   */
>  int ocpi_enable(void)
>  {
> -- 
> 1.9.1
> 
