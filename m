From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/4] counter: new TI eQEP driver
Date: Tue, 30 Jul 2019 14:35:23 +0200
Message-ID: <20190730123523.cjtmr3tpttn6r3pt@pengutronix.de>
References: <20190722154538.5314-1-david@lechnology.com>
 <20190722154538.5314-3-david@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190722154538.5314-3-david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Lechner <david@lechnology.com>
Cc: linux-iio@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, William Breathitt Gray <vilhelm.gray@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 22, 2019 at 10:45:36AM -0500, David Lechner wrote:
> This adds a new counter driver for the Texas Instruments Enhanced
> Quadrature Encoder Pulse (eQEP) module.
> 
> Only very basic functionality is currently implemented - only enough to
> be able to read the position. The actual device has many more features
> which can be added to the driver on an as-needed basis.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>  MAINTAINERS               |   6 +
>  drivers/counter/Kconfig   |  12 ++
>  drivers/counter/Makefile  |   1 +
>  drivers/counter/ti-eqep.c | 381 ++++++++++++++++++++++++++++++++++++++
>  drivers/pwm/Kconfig       |   2 +-

It's not obvious why the change to drivers/pwm/Kconfig is needed. Can
you please motivate that in the change log?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
