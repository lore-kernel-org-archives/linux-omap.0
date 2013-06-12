From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: am335x: TSC & ADC reworking including DT pieces, take 4
Date: Wed, 12 Jun 2013 15:29:43 +0200
Message-ID: <51B877C7.8080001@linutronix.de>
References: <1370950268-7224-1-git-send-email-bigeasy@linutronix.de> <20130611142358.GG29135@zurbaran> <20130611160415.GA379@core.coreip.homeip.net> <20130611161506.GK29135@zurbaran> <1565f2fb-7f16-4910-8fa2-cd5700e8986d@email.android.com> <20130611175519.GL29135@zurbaran>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20130611175519.GL29135@zurbaran>
Sender: linux-input-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@cam.ac.uk>, Lee Jones <lee.jones@linaro.org>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 06/11/2013 07:55 PM, Samuel Ortiz wrote:
> Hi Jonathan,

Hi Samuel,

> Sebastian, please address the commit log and cosmetic issues I pointed out,
> keep the regmap code and I'll pull this patchset in.

By keep the regmap code you mean I am allowed to remove the regmap
usage in mfd (keep patch #1) or do you insist on adding its usage in
iio and input?

> Cheers,
> Samuel.

Sebastian
