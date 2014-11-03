From: Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH 0/4] Touchscreen performance related fixes
Date: Mon, 3 Nov 2014 19:09:21 +0100
Message-ID: <20141103180920.GA20779@localhost.localdomain>
References: <1414408111-2631-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1414408111-2631-1-git-send-email-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Samuel Ortiz <sameo@linux.intel.com>, Jan Kardell <jan.kardell@telliq.com>, linux-iio@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Peter Meerwald <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, linux-arm
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 27, 2014 at 04:38:27PM +0530, Vignesh R wrote:
> This series of patches fix TSC defects related to lag in touchscreen
> performance and cursor jump at touch release. The lag was result of
> udelay in TSC interrupt handler. Cursor jump due to false pen-up event.
> The patches implement Advisory 1.0.31 in silicon errata of am335x-evm
> to avoid false pen-up events and remove udelay.

That advisory has two workarounds. You have chosen the second one?

The text of the second workaround says it only works on 4 wire setups,
so I wonder how 5 wire designs will be affected.

> The advisory says to use
> steps 1 to 4 for ADC and 5 to 16 for TSC (assuming 4 wire TSC and 4 channel
> ADC).

No, it doesn't say that. (sprz360f.pdf)

> Further the X co-ordinate must be the last one to be sampled just
> before charge step. The first two patches implement the required changes. 

FWIW, I implemented the first workaround and removed the udelay not
too long ago. Like Sebastian, I saw the TSC unit hang after about
50000 interrupts when running with the workaround.

Did you test you patch for very long?

Thanks,
Richard
