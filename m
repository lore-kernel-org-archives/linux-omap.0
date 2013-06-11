From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 01/22] mfd/ti_am335x_tscadc: remove regmap
Date: Tue, 11 Jun 2013 16:23:36 +0200
Message-ID: <20130611142336.GE29135@zurbaran>
References: <1370950268-7224-1-git-send-email-bigeasy@linutronix.de>
 <1370950268-7224-2-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1370950268-7224-2-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Lee Jones <lee.jones@linaro.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Jonathan Cameron <jic23@cam.ac.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Sebastian,

On Tue, Jun 11, 2013 at 01:30:47PM +0200, Sebastian Andrzej Siewior wrote:
> The MFD part uses regmap without caching and is the only user of the
> regmap. The child drivers, that is input(touch) and iio(adc), use direct
> reg access.
> There is a patch which converts them to use regmap as well but I see no
> benefit at all doing this. There is a direct MMIO bus access with no
> need to cache values like for I2C or SPI devices. Furthermore, most (if
> not all) of the access done by the touch & ADC driver read volatile
> register.
> Therefore this patch removes regmap part of the driver.
NAK. Using regmap is better than open coding your register accesses, and
the children not using this API is not a reason for the MFD driver to do
the same.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
