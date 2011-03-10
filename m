From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] OMAP4: clockdomain: Follow recommended enable sequence
Date: Thu, 10 Mar 2011 13:34:54 +0000
Message-ID: <20110310133454.GF15795@trinity.fluff.org>
References: <1299245123-23444-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1103081937100.15132@utopia.booyaka.com> <4D775418.6050105@ti.com> <alpine.DEB.2.00.1103100514210.15132@utopia.booyaka.com> <4D78CAFC.4080502@ti.com> <alpine.DEB.2.00.1103100609080.15132@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1103100609080.15132-rwI8Ez+7Ko+d5PgPZx9QOdBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 10, 2011 at 06:17:02AM -0700, Paul Walmsley wrote:
> Hi Ben,
> 
> On Thu, 10 Mar 2011, Rajendra Nayak wrote:
> 
> > On Thursday 10 March 2011 05:48 PM, Paul Walmsley wrote:
> > > This patch is currently breaking boot on OMAP4430 ES2.0 Pandaboard,
> > > so I've dropped it from the integration branch until it can be
> > > debugged.  Could you check it, please?
> > > 
> > > The tag "integration-2.6.39-20110310-008" of
> > > git://git.pwsan.com/linux-integration boots fine; it's got everything
> > > but this patch.  Then when this patch is applied, I2C problems show
> > > up, and root (on MMC) doesn't mount.
> > 
> > Looks like you are missing this patch which should fix the i2c
> > timeouts..
> 
> Do you think you'll merge this patch:
> 
>    http://marc.info/?l=linux-omap&m=129924561819873&w=2
> 
> during the 2.6.39 window?  If so, then I'll add Rajendra's clockdomain 
> patch back in to my 2.6.39 queue here; it seems to depend on the I2C 
> driver patch.

see
http://git.fluff.org/gitweb?p=bjdooks/linux.git;a=shortlog;h=refs/heads/for-2639-rc7/i2c-fixes

awaiting linus.

> - Paul
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
