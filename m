From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: am335x: TSC & ADC reworking including DT pieces, take 4
Date: Tue, 11 Jun 2013 19:02:54 +0100
Message-ID: <51B7664E.9070708@kernel.org>
References: <1370950268-7224-1-git-send-email-bigeasy@linutronix.de> <20130611142358.GG29135@zurbaran>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130611142358.GG29135@zurbaran>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <b-cousson-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 06/11/2013 03:23 PM, Samuel Ortiz wrote:
> Hi Sebastian,
> 
> On Tue, Jun 11, 2013 at 01:30:46PM +0200, Sebastian Andrzej Siewior wrote:
>> I believe the whole thing should go via the MFD tree. It touches also
>> input & iio subsystem. I collected ACKs where I got some in the meantime.
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

I'd just like to note for future reference that I would prefer Samuels
approach of such a branch for future cases where things touch on iio
and another subsystem.

Now as I've expressed I am happy with this set going through mfd
but there is never anything wrong with agreeing how things 'should'
be done ;)

> AFAICT, only patch #2 should be kept with input and iio bits mixed
> together with MFD as otherwise this would introduce functional breakage.
> Otherwise, all MFD bits from the other patches could be either separated
> or merged together (e.g. MFD bits from patches #6 and #8, and #16 and
> #17).

> 
> Does that sound doable to you ?
> 
> Cheers,
> Samuel.
> 
