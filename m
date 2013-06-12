From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: am335x: TSC & ADC reworking including DT pieces, take 4
Date: Wed, 12 Jun 2013 16:02:00 +0200
Message-ID: <51B87F58.9070000@linutronix.de>
References: <1370950268-7224-1-git-send-email-bigeasy@linutronix.de> <20130611142358.GG29135@zurbaran> <20130611160415.GA379@core.coreip.homeip.net> <20130611161506.GK29135@zurbaran> <1565f2fb-7f16-4910-8fa2-cd5700e8986d@email.android.com> <20130611175519.GL29135@zurbaran> <51B877C7.8080001@linutronix.de> <20130612135042.GO29135@zurbaran>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130612135042.GO29135@zurbaran>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <b-cousson-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 06/12/2013 03:50 PM, Samuel Ortiz wrote:
> Hi Sebastian,

Hi Samuel,

>> By keep the regmap code you mean I am allowed to remove the regmap
>> usage in mfd (keep patch #1) or do you insist on adding its usage in
>> iio and input?
> I insist on keeping it on the MFD driver, i.e. _not_ keeping patch #1.

This forces me redo a few things and most likely adding it to the
iio and input driver to be consistent here.

Could you please give a reason why using the regmap here is a good
thing? I mentioned a few why it is not and why is better to leave it
out.

> Cheers,
> Samuel.

Sebastian
