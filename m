From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 00/11] Drop unnecessary static
Date: Sat, 15 Jul 2017 23:00:36 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1707152300030.5105@hadrien>
References: <1500149266-32357-1-git-send-email-Julia.Lawall@lip6.fr> <1500151079.4457.80.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1500151079.4457.80.camel@perches.com>
Sender: linux-clk-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, linux-arm-kernel@lists.infradead.org, keescook@chromium.org, kernel-janitors@vger.kernel.org, linux-ide@vger.kernel.org, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On Sat, 15 Jul 2017, Joe Perches wrote:

> On Sat, 2017-07-15 at 22:07 +0200, Julia Lawall wrote:
> > These patches fix cases where there is a static on a local variable, but
> > the variable is initialized before any possible use.  Thus, the static has
> > no benefit.
>
> Nice one.

Thanks.  It was suggested by Kees Cook a while ago.  There seem to be many
opportunities.

julia
