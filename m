From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [11/12] ARM: OMAP2+: add missing of_node_put after
 of_device_is_available
Date: Sun, 14 Apr 2019 18:49:12 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1904141848390.2496@hadrien>
References: <1550928043-14889-12-git-send-email-Julia.Lawall@lip6.fr> <903ec107-46ed-f19f-56a7-c20031247503@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <903ec107-46ed-f19f-56a7-c20031247503@web.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org



On Sun, 14 Apr 2019, Markus Elfring wrote:

> > @@ -250,8 +250,10 @@ static int __init omapdss_init_of(void)
> >  	if (!node)
> >  		return 0;
> >
> > -	if (!of_device_is_available(node))
> > +	if (!of_device_is_available(node)) {
> > +		of_node_put(node);
> >  		return 0;
> > +	}
> >
> >  	pdev = of_find_device_by_node(node);
>
> Is there a need to put the node also in subsequent if branches
> for complete exception handling in this function implementation?

Yes, it looks like this is indeed missing.  I will try to send a better
patch when time permits.

julia
