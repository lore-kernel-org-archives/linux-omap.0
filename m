From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 0/6] counter: new TI eQEP driver
Date: Thu, 5 Sep 2019 07:10:53 -0700
Message-ID: <20190905141053.GU52127@atomide.com>
References: <20190901225827.12301-1-david@lechnology.com>
 <20190905133721.GA728346@icarus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190905133721.GA728346@icarus>
Sender: linux-kernel-owner@vger.kernel.org
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: David Lechner <david@lechnology.com>, Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* William Breathitt Gray <vilhelm.gray@gmail.com> [190905 13:38]:
> On Sun, Sep 01, 2019 at 05:58:21PM -0500, David Lechner wrote:
> > This series adds device tree bindings and a new counter driver for the Texas
> > Instruments Enhanced Quadrature Encoder Pulse (eQEP).
> > 
> > As mentioned in one of the commit messages, to start with, the driver only
> > supports reading the current counter value and setting the min/max values.
> > Other features can be added as the counter subsystem gains support for them.
...

> I'm satisfied with this version of the patchset.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> 
> Jonathan, if you have no objections please pick up this up so that it
> can make it to the 5.4 merge window coming in soon. Alternatively, I can
> merge it into my repository instead and hold it for a while longer
> there, if you prefer that route.

Looks good to me too:

Acked-by: Tony Lindgren <tony@atomide.com>
