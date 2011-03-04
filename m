From: Ben Dooks <ben-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Subject: Re: [PATCH] i2c-omap: Program I2C_WE on OMAP4 to enable i2c wakeup
Date: Fri, 4 Mar 2011 17:17:23 +0000
Message-ID: <20110304171723.GF17460@trinity.fluff.org>
References: <1299245544-23790-1-git-send-email-rnayak@ti.com> <87ei6mizxr.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87ei6mizxr.fsf-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Cc: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Mar 04, 2011 at 09:00:00AM -0800, Kevin Hilman wrote:
> Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org> writes:
> 
> > For the I2C module to be wakeup capable, programming I2C_WE
> > register (which was skipped for OMAP4430) is needed
> > even on OMAP4.
> > This fixes i2c controller timeouts which were seen recently
> > with the static dependency being cleared between MPU and
> > L4PER clockdomains.
> >
> > Signed-off-by: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
> > ---
> > Patch is based on 2.6.38-rc7 kernel.
> 
> Acked-by: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
> 
> Ben, looks like another fix that should be queued for 2.6.38-rc.

I'll put together the couple of fixes I've got and send them to Linus
at the end of the weekend.

-- 
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
