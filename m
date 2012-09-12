From: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv7 20/23] i2c: omap: switch to threaded IRQ support
Date: Wed, 12 Sep 2012 11:55:39 +0530
Message-ID: <50502AE3.7040300@ti.com>
References: <1347356538-23835-1-git-send-email-shubhrajyoti@ti.com> <1347356538-23835-21-git-send-email-shubhrajyoti@ti.com> <20120911215112.GA27031@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120911215112.GA27031-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wednesday 12 September 2012 03:21 AM, Wolfram Sang wrote:
>> -omap_i2c_isr(int this_irq, void *dev_id)
>> > +omap_i2c_isr(int irq, void *dev_id)
>> >  {
>> >  	struct omap_i2c_dev *dev = dev_id;
>> > +	irqreturn_t ret = IRQ_HANDLED;
> Shouldn't that be IRQ_NONE?
Actually we are processing it so I thought it to be ok.
Also a similar discussion.
 
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-June/104422.html
