From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH 01/12] omap: McBSP: Fix possible port lockout
Date: Sun, 10 Jan 2010 20:55:39 +0100
Message-ID: <201001102055.41300.jkrzyszt@tis.icnet.pl>
References: <20100107001728.21352.38471.stgit@baageli.muru.com> <20100107001844.21352.899.stgit@baageli.muru.com> <4B4767DE.4070801@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:37220 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753341Ab0AJUIY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Jan 2010 15:08:24 -0500
In-Reply-To: <4B4767DE.4070801@ru.mvista.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, Jarkko Nikula <jhnikula@gmail.com>, linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>

=46riday 08 January 2010 18:14:06 Sergei Shtylyov napisa=C5=82(a):
> Tony Lindgren wrote:
> > From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> >
> > In its current form, the omap_mcbsp_request() function can return a=
fter
> > irq_request() failure without any cleanups, effectively locking out=
 the
> > port forever with clocks left running. Fix it.
> >
> > Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> > Acked-by: Jarkko Nikula <jhnikula@gmail.com>
> > Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
>
> [...]
>
> > diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.=
c
> > index 2cc1cc3..f757672 100644
> > --- a/arch/arm/plat-omap/mcbsp.c
> > +++ b/arch/arm/plat-omap/mcbsp.c
> > @@ -436,7 +436,7 @@ int omap_mcbsp_request(unsigned int id)
> >  			dev_err(mcbsp->dev, "Unable to request TX IRQ %d "
> >  					"for McBSP%d\n", mcbsp->tx_irq,
> >  					mcbsp->id);
> > -			return err;
> > +			goto error;
> >  		}
> >
> >  		init_completion(&mcbsp->rx_irq_completion);
> > @@ -446,12 +446,26 @@ int omap_mcbsp_request(unsigned int id)
> >  			dev_err(mcbsp->dev, "Unable to request RX IRQ %d "
> >  					"for McBSP%d\n", mcbsp->rx_irq,
> >  					mcbsp->id);
> > -			free_irq(mcbsp->tx_irq, (void *)mcbsp);
> > -			return err;
> > +			goto tx_irq;
> >  		}
> >  	}
> >
> >  	return 0;
> > +tx_irq:
>
>     As if this wasn't a label for error cleanup, i.e. labels could be=
 named
> more consistently, both including 'err' or 'error'...
>
> > +	free_irq(mcbsp->tx_irq, (void *)mcbsp);
> > +error:
> > +	if (mcbsp->pdata && mcbsp->pdata->ops && mcbsp->pdata->ops->free)
> > +			mcbsp->pdata->ops->free(id);
>
>     This line is overindented.
>

Sergei,
Thanks for pointing these out.

Tony,
Since you have already sent a pull request covering this patch, I propo=
se I=20
will address both issues soon when I revisit the source while further=20
modifying this function for McBSP register cache support, OK?

Thanks,
Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
