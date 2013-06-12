From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: am335x: TSC & ADC reworking including DT pieces, take 4
Date: Wed, 12 Jun 2013 17:00:01 +0200
Message-ID: <51B88CF1.4060708@linutronix.de>
References: <1370950268-7224-1-git-send-email-bigeasy@linutronix.de> <20130611142358.GG29135@zurbaran> <20130611160415.GA379@core.coreip.homeip.net> <20130611161506.GK29135@zurbaran> <1565f2fb-7f16-4910-8fa2-cd5700e8986d@email.android.com> <20130611175519.GL29135@zurbaran> <51B877C7.8080001@linutronix.de> <20130612135042.GO29135@zurbaran> <51B87F58.9070000@linutronix.de> <20130612144133.GP29135@zurbaran>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130612144133.GP29135@zurbaran>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@cam.ac.uk>, Lee Jones <lee.jones@linaro.org>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 06/12/2013 04:41 PM, Samuel Ortiz wrote:
>> This forces me redo a few things and most likely adding it to the
>> iio and input driver to be consistent here.
> I'm not asking for that. The current MFD code uses regmap fine without
> the iio and input using it, I don't see why you would have to add regmap
> support there.

Right. Since no reg-cache is used then this should be fine then.

>> Could you please give a reason why using the regmap here is a good
>> thing? I mentioned a few why it is not and why is better to leave it
>> out.
> Yes, and I'm not convinced obviously. regmap prevents you from open
> coding your MMIO access, and this is the right approach.

I am not convinced that adding another layer of indirection for doing
the same thing is a good approach. Pointer chasing _is_ expensive.
_None_ of the regmap features are used here.
I would understand if I would re-implement register caching or a
wrapper across multiple buses but nothing of this is the case.
The current code even ignores the return value.

So, are we going to convert all drivers to use regmap now?

> Cheers,
> Samuel.
> 

Sebastian
