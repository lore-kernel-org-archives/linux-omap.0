From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 10/22] mfd/ti_am335x_tscadc: Add DT support
Date: Tue, 11 Jun 2013 17:41:52 +0200
Message-ID: <51B74540.2020608@linutronix.de>
References: <1370950268-7224-1-git-send-email-bigeasy@linutronix.de> <1370950268-7224-11-git-send-email-bigeasy@linutronix.de> <20130611142347.GF29135@zurbaran> <51B73756.5010004@linutronix.de> <20130611150505.GI29135@zurbaran>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130611150505.GI29135@zurbaran>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <b-cousson-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>, Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 06/11/2013 05:05 PM, Samuel Ortiz wrote:
> Hi Sebastian,

Hi Samuel,

> On Tue, Jun 11, 2013 at 04:42:30PM +0200, Sebastian Andrzej Siewior wrote:
>> In the end I would like not to post a patch with "From: != me" and
>> don't make change which the original author did not do. Also dropping
>> their authorship isn't nice. What could we agree on?
> You probably don't want to change authorship unless the final patch is
> really far from the original one. In which case you can change it and
> mention the original author name in the commit log.
> If you have only made a few changes on top of the original patch, please
> say so explicitely in the commit log. Don't bother if we're talking
> about small changes or cosmetic ones. But your commit log has to be
> readable and clear.

Commit 06c9494 on of many examples where cosmetic are recorded. But to
make some progress I rewrite the commit log to resolve this and don't
add anything to the sign-off area.

> Cheers,
> Samuel.

Sebastian
