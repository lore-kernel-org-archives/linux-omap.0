From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] OMAP4: clockdomain: Follow recommended enable sequence
Date: Thu, 10 Mar 2011 06:17:02 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103100609080.15132@utopia.booyaka.com>
References: <1299245123-23444-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1103081937100.15132@utopia.booyaka.com> <4D775418.6050105@ti.com> <alpine.DEB.2.00.1103100514210.15132@utopia.booyaka.com> <4D78CAFC.4080502@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4D78CAFC.4080502-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Ben,

On Thu, 10 Mar 2011, Rajendra Nayak wrote:

> On Thursday 10 March 2011 05:48 PM, Paul Walmsley wrote:
> > This patch is currently breaking boot on OMAP4430 ES2.0 Pandaboard,
> > so I've dropped it from the integration branch until it can be
> > debugged.  Could you check it, please?
> > 
> > The tag "integration-2.6.39-20110310-008" of
> > git://git.pwsan.com/linux-integration boots fine; it's got everything
> > but this patch.  Then when this patch is applied, I2C problems show
> > up, and root (on MMC) doesn't mount.
> 
> Looks like you are missing this patch which should fix the i2c
> timeouts..

Do you think you'll merge this patch:

   http://marc.info/?l=linux-omap&m=129924561819873&w=2

during the 2.6.39 window?  If so, then I'll add Rajendra's clockdomain 
patch back in to my 2.6.39 queue here; it seems to depend on the I2C 
driver patch.


- Paul
