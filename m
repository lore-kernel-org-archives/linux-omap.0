From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: omap-usb-host: Mark expected switch fall-throughs
Date: Mon, 12 Aug 2019 09:14:48 +0100
Message-ID: <20190812081448.GJ4594@dell>
References: <20190728235858.GA23755@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190728235858.GA23755@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Kees Cook <keescook@chromium.org>
List-Id: linux-omap@vger.kernel.org

On Sun, 28 Jul 2019, Gustavo A. R. Silva wrote:

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
> ---
>  drivers/mfd/omap-usb-host.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
