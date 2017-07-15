From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 00/11] Drop unnecessary static
Date: Sat, 15 Jul 2017 13:37:59 -0700
Message-ID: <1500151079.4457.80.camel@perches.com>
References: <1500149266-32357-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1500149266-32357-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-input-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>, linux-arm-kernel@lists.infradead.org
Cc: keescook@chromium.org, kernel-janitors@vger.kernel.org, linux-ide@vger.kernel.org, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sat, 2017-07-15 at 22:07 +0200, Julia Lawall wrote:
> These patches fix cases where there is a static on a local variable, but
> the variable is initialized before any possible use.  Thus, the static has
> no benefit.

Nice one.

