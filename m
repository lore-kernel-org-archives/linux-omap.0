From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 10/22] mfd/ti_am335x_tscadc: Add DT support
Date: Tue, 11 Jun 2013 17:05:05 +0200
Message-ID: <20130611150505.GI29135@zurbaran>
References: <1370950268-7224-1-git-send-email-bigeasy@linutronix.de>
 <1370950268-7224-11-git-send-email-bigeasy@linutronix.de>
 <20130611142347.GF29135@zurbaran>
 <51B73756.5010004@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51B73756.5010004@linutronix.de>
Sender: linux-input-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Lee Jones <lee.jones@linaro.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Jonathan Cameron <jic23@cam.ac.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, "Patil, Rachna" <rachna@ti.com>, Pantelis Antoniou <panto@antoniou-consulting.com>
List-Id: linux-omap@vger.kernel.org

Hi Sebastian,

On Tue, Jun 11, 2013 at 04:42:30PM +0200, Sebastian Andrzej Siewior wrote:
> In the end I would like not to post a patch with "From: != me" and
> don't make change which the original author did not do. Also dropping
> their authorship isn't nice. What could we agree on?
You probably don't want to change authorship unless the final patch is
really far from the original one. In which case you can change it and
mention the original author name in the commit log.
If you have only made a few changes on top of the original patch, please
say so explicitely in the commit log. Don't bother if we're talking
about small changes or cosmetic ones. But your commit log has to be
readable and clear.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
