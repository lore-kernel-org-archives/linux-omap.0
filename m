From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: am335x: TSC & ADC reworking including DT pieces, take 4
Date: Tue, 11 Jun 2013 09:04:16 -0700
Message-ID: <20130611160415.GA379@core.coreip.homeip.net>
References: <1370950268-7224-1-git-send-email-bigeasy@linutronix.de>
 <20130611142358.GG29135@zurbaran>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130611142358.GG29135@zurbaran>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Samuel,

On Tue, Jun 11, 2013 at 04:23:58PM +0200, Samuel Ortiz wrote:
> Hi Sebastian,
> 
> On Tue, Jun 11, 2013 at 01:30:46PM +0200, Sebastian Andrzej Siewior wrote:
> > I believe the whole thing should go via the MFD tree. It touches also
> > input & iio subsystem. I collected ACKs where I got some in the meantime.
> Please fix your commit logs, and your subject lines. It should be e.g.
> mfd: input: ti_am335x_adc: Blablabla
> 
> if it's mostly an mfd patch that also touches an input driver.
> 
> Then, this is a pretty big patchset, with iio, input and mfd all mixed
> together and it is likely to create merge conflicts.
> From what I can see from it, and please correct me if I'm
> wrong, the iio and input changes depend on the mfd ones, and not the
> other way around. If that's so, I'm going to ask you to reshuffle your
> patch set and separate the MFD changes from the iio and input ones. I'll
> take the MFD ones and will create an immutable branch for Jonathan and
> Dmitry to pull from and apply the iio and input changes on top of it.
> Merge conflicts should be mostly avoided that way.

I purposely left this driver alone as I expected it would be merged
through MFD tree, so there should not be any merging issues on my side.

Thanks.

-- 
Dmitry
