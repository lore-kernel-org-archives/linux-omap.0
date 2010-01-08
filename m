From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 01/12] omap: McBSP: Fix possible port lockout
Date: Fri, 08 Jan 2010 20:14:06 +0300
Message-ID: <4B4767DE.4070801@ru.mvista.com>
References: <20100107001728.21352.38471.stgit@baageli.muru.com> <20100107001844.21352.899.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:25795 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1753455Ab0AHROK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 12:14:10 -0500
In-Reply-To: <20100107001844.21352.899.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, Jarkko Nikula <jhnikula@gmail.com>, linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

Tony Lindgren wrote:
> From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

> In its current form, the omap_mcbsp_request() function can return after
> irq_request() failure without any cleanups, effectively locking out the port
> forever with clocks left running. Fix it.

> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> Acked-by: Jarkko Nikula <jhnikula@gmail.com>
> Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

[...]

> diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
> index 2cc1cc3..f757672 100644
> --- a/arch/arm/plat-omap/mcbsp.c
> +++ b/arch/arm/plat-omap/mcbsp.c
> @@ -436,7 +436,7 @@ int omap_mcbsp_request(unsigned int id)
>  			dev_err(mcbsp->dev, "Unable to request TX IRQ %d "
>  					"for McBSP%d\n", mcbsp->tx_irq,
>  					mcbsp->id);
> -			return err;
> +			goto error;
>  		}
>  
>  		init_completion(&mcbsp->rx_irq_completion);
> @@ -446,12 +446,26 @@ int omap_mcbsp_request(unsigned int id)
>  			dev_err(mcbsp->dev, "Unable to request RX IRQ %d "
>  					"for McBSP%d\n", mcbsp->rx_irq,
>  					mcbsp->id);
> -			free_irq(mcbsp->tx_irq, (void *)mcbsp);
> -			return err;
> +			goto tx_irq;
>  		}
>  	}
>  
>  	return 0;
> +tx_irq:

    As if this wasn't a label for error cleanup, i.e. labels could be named 
more consistently, both including 'err' or 'error'...

> +	free_irq(mcbsp->tx_irq, (void *)mcbsp);
> +error:
> +	if (mcbsp->pdata && mcbsp->pdata->ops && mcbsp->pdata->ops->free)
> +			mcbsp->pdata->ops->free(id);

    This line is overindented.

WBR, Sergei
