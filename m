From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] mfd: omap-usb-host: Mark expected switch fall-throughs
Date: Mon, 29 Jul 2019 09:35:24 -0700
Message-ID: <201907290935.F99432D6@keescook>
References: <20190728235858.GA23755@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190728235858.GA23755@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-omap@vger.kernel.org

On Sun, Jul 28, 2019 at 06:58:58PM -0500, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warnings:
> 
> drivers/mfd/omap-usb-host.c: In function 'usbhs_runtime_resume':
> drivers/mfd/omap-usb-host.c:303:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     if (!IS_ERR(omap->hsic480m_clk[i])) {
>        ^
> drivers/mfd/omap-usb-host.c:313:3: note: here
>    case OMAP_EHCI_PORT_MODE_TLL:
>    ^~~~
> drivers/mfd/omap-usb-host.c: In function 'usbhs_runtime_suspend':
> drivers/mfd/omap-usb-host.c:345:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     if (!IS_ERR(omap->hsic480m_clk[i]))
>        ^
> drivers/mfd/omap-usb-host.c:349:3: note: here
>    case OMAP_EHCI_PORT_MODE_TLL:
>    ^~~~
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/mfd/omap-usb-host.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
> index 792b855a9104..4798d9f3f9d5 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -308,7 +308,7 @@ static int usbhs_runtime_resume(struct device *dev)
>  					 i, r);
>  				}
>  			}
> -		/* Fall through as HSIC mode needs utmi_clk */
> +		/* Fall through - as HSIC mode needs utmi_clk */
>  
>  		case OMAP_EHCI_PORT_MODE_TLL:
>  			if (!IS_ERR(omap->utmi_clk[i])) {
> @@ -344,7 +344,7 @@ static int usbhs_runtime_suspend(struct device *dev)
>  
>  			if (!IS_ERR(omap->hsic480m_clk[i]))
>  				clk_disable_unprepare(omap->hsic480m_clk[i]);
> -		/* Fall through as utmi_clks were used in HSIC mode */
> +		/* Fall through - as utmi_clks were used in HSIC mode */
>  
>  		case OMAP_EHCI_PORT_MODE_TLL:
>  			if (!IS_ERR(omap->utmi_clk[i]))
> -- 
> 2.22.0
> 

-- 
Kees Cook
