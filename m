From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: SPI regression in today's Linux next
Date: Tue, 17 Oct 2017 07:59:02 -0700
Message-ID: <20171017145901.GB4394@atomide.com>
References: <20171017143454.GA4394@atomide.com>
 <20171017144021.r7aydswer7anb5ha@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171017144021.r7aydswer7anb5ha-7j8lgAiuQgnQXOPxS62xeg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [171017 07:41]:
> On Tue, Oct 17, 2017 at 07:34:54AM -0700, Tony Lindgren wrote:
> > Hi Lucas and Mark,
> > 
> > Looks like commit 9ce70d49fa80 ("spi: fix IDR collision on systems with
> > both fixed and dynamic SPI bus numbers") causes the following regression
> > at least for omaps. Reverting commit 9ce70d49fa80 fixes it.
> > 
> > Any ideas?
> 
> There's a fix already.

OK so with next-20171016, revert 9ce70d49fa80 and pick
226584aedd from the spi.git tree. Seems to work for me.

Thanks,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
