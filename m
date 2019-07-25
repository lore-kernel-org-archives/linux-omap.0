From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH 0/4] new driver for TI eQEP
Date: Thu, 25 Jul 2019 21:40:37 +0900
Message-ID: <20190725124037.GA4802@icarus>
References: <20190722154538.5314-1-david@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190722154538.5314-1-david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Lechner <david@lechnology.com>
Cc: linux-iio@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 22, 2019 at 10:45:34AM -0500, David Lechner wrote:
> This series adds device tree bindings and a new counter driver for the Texas
> Instruments Enhanced Quadrature Encoder Pulse (eQEP).
> 
> As mentioned in one of the commit messages, to start with, the driver only
> supports reading the current counter value and setting the min/max values.
> Other features can be added on an as-needed basis.
> 
> The only other feature I am interested in is adding is getting time data in
> order to calculate the rotational speed of a motor. However, there probably
> needs to be a higher level discussion of how this can fit into the counter
> subsystem in general first.

I believe exposing some sort of time data has merit. Quadrature counter
devices in particular are commonly used for position tracking of
automation systems, and such systems would benefit from velocity/speed
information. So let's try to introduce that sort of functionality in this
driver if possible.

First, let's discuss your specific use case and requirements, and hopefully we
can generalize it enough to be of use for future drivers. From your description,
it sounds like you're attaching some sort of rotary encoder to the eQEP device.
Is that correct? What sort of time data are you hoping to use; does the eQEP
device provide a clock value, or would you be grabbing a timestamp from the
system?

I'm not sure yet if it would make sense to expose rotational speed directly as
an attribute. If we were to expose just the count value and timestamp since the
last read, that should be enough for a user to compute the delta and derive
speed. I'll think more about this since some devices may simplify that case if
the hardware is able to compute the speed for us.

William Breathitt Gray
