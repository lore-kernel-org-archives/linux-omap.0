From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 01/22] mfd/ti_am335x_tscadc: remove regmap
Date: Thu, 04 Jul 2013 13:15:26 +0200
Message-ID: <51D5594E.8030809@linutronix.de>
References: <1370950268-7224-1-git-send-email-bigeasy@linutronix.de> <1370950268-7224-2-git-send-email-bigeasy@linutronix.de> <20130611142336.GE29135@zurbaran> <51B7358D.7000605@linutronix.de> <20130614135358.GR1403@sirena.org.uk> <51BEF5F4.4090600@linutronix.de> <20130617160326.GE1403@sirena.org.uk> <51D53A31.3080704@linutronix.de> <20130704104511.GU27646@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130704104511.GU27646-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <b-cousson-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 07/04/2013 12:45 PM, Mark Brown wrote:
> On Thu, Jul 04, 2013 at 11:02:41AM +0200, Sebastian Andrzej Siewior
> wrote:
> 
>> The driver here does not use atomic updates but read followed by
>> write so your locking here is futile. So the API/regmap alone
>> does not make
> 
> Doesn't that sound like the driver ought to be using a r/m/w
> primitive though?

It does this in the init phase before the child devices are created so
no harm is done. I just wanted to say that regmap alone does not help
as long as the use simply replaces all reads & writes with regmap reads
& writes.

> 
>> it right. And look: the MFD part uses regmap. Its children (IIO
>> & input) do not use it. After I told this Samuel he said that it
>> is okay.
> 
> Again I think the point here was that they probably ought to do
> so.

It didn't sound that way.

> But I guess if you're saying there's no problem that's fine...
Thank you.

Samuel, is it okay if I repost the patch? It can wait till past -rc1 if
you are willing to take it.

Sebastian
