From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: am335x: TSC & ADC reworking including DT pieces, take 4
Date: Tue, 11 Jun 2013 15:53:23 +0200
Message-ID: <51B72BD3.4000200@metafoo.de>
References: <1370950268-7224-1-git-send-email-bigeasy@linutronix.de> <20130611120530.GF3330@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130611120530.GF3330@laptop>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, =?UTF-8?B?QmVub8OudCBDb3Vzc29u?= <b-cousson-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 06/11/2013 02:05 PM, Lee Jones wrote:
>> I believe the whole thing should go via the MFD tree. It touches also
>> input & iio subsystem. I collected ACKs where I got some in the meantime.
>>
>> I added Lee Jones because I hear no sign of life from Samuel.
> 
> Unfortunately I can't be of any added help here, as I also send my
> pull-requests though Sam.
> 
> Sorry I couldn't be of any more use Sebastian.
> 

It sometimes takes him a week or two to respond, but Samuel is pretty reliable
when it comes to merging patches, so I wouldn't worry about it.

- Lars
