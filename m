From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] tty: serial: 8250: omap: Add pinctrl support for suspend
Date: Thu, 6 Nov 2014 13:15:13 -0600
Message-ID: <545BC8C1.4070503@ti.com>
References: <1415300850-21452-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34268 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133AbaKFTP1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Nov 2014 14:15:27 -0500
In-Reply-To: <1415300850-21452-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-serial@vger.kernel.org, "tony@atomide.com" <tony@atomide.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>

On 11/06/2014 01:07 PM, Sebastian Andrzej Siewior wrote:
> This is mostly an equivalent for the 8250-omap driver based on a patch
> of Dave Gerlach for the omap-serial driver (which is not yet merged).
> 
> From his changelog:
> |By optionally putting the pins into sleep state in the suspend callback
> |we can accomplish two things.
> |- minimize current leakage from pins and thus save power,
> |- prevent the IP from driving pins output in an uncontrolled manner,
> |  which may happen if the power domain drops the domain regulator.
> 
> The pinctlr change is put before enable_wakeup logic as per Nishanth
> Menon (slightly reworded):
> |When wakeup is enabled, I/O daisy chain based wakeup is used by
> |reconfiguring the padconfig register. However, this gets overriden by
> |sleep/wakeup configuration. Therefore we need first to allow pinctrl to
> |play with the wakeup bits as needed beyond the sleep configuration.
> 
> Cc: Dave Gerlach <d-gerlach@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/tty/serial/8250/8250_omap.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index 57a8b1241b85..1681875f2996 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -1156,6 +1156,7 @@ static int omap8250_suspend(struct device *dev)
>  	serial8250_suspend_port(priv->line);
>  	flush_work(&priv->qos_work);
>  
> +	pinctrl_pm_select_sleep_state(dev);
>  	if (device_may_wakeup(dev))
>  		omap8250_enable_wakeup(priv, true);
>  	else
> @@ -1167,6 +1168,7 @@ static int omap8250_resume(struct device *dev)
>  {
>  	struct omap8250_priv *priv = dev_get_drvdata(dev);
>  
> +	pinctrl_pm_select_default_state(dev);
>  	if (device_may_wakeup(dev))
>  		omap8250_enable_wakeup(priv, false);
>  
> 
sounds good to me *IF* omap8250_enable_wakeup (wakeirq handling) is
the way we want to continue doing things for daisychain? -> Tony, can
you comment?
http://marc.info/?l=linux-omap&m=141222144402707&w=2

I wonder if wakeirq explicit handling is valid anymore and something
given the potential race and alternate approach proposed?

-- 
Regards,
Nishanth Menon
