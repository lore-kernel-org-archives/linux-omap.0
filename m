From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: counter: new bindings for TI eQEP
Date: Fri, 2 Aug 2019 22:58:30 +0900
Message-ID: <20190802135711.GA27874@icarus>
References: <20190722154538.5314-1-david@lechnology.com>
 <20190722154538.5314-2-david@lechnology.com>
 <20190727204836.1514265d@archlinux>
 <20190802072513.GA30522@icarus>
 <CAL_JsqLA+m5vKZQ1WwWusnVHwX+nnuApiwKXUnmP6ti-PvMZ-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqLA+m5vKZQ1WwWusnVHwX+nnuApiwKXUnmP6ti-PvMZ-g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Lechner <david@lechnology.com>
Cc: Rob Herring <robh+dt@kernel.org>, "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Jonathan Cameron <jic23@jic23.retrosnub.co.uk>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Thierry Reding <thierry.reding@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PWM List <linux-pwm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 02, 2019 at 07:34:42AM -0600, Rob Herring wrote:
> On Fri, Aug 2, 2019 at 1:25 AM William Breathitt Gray
> <vilhelm.gray@gmail.com> wrote:
> >
> > On Sat, Jul 27, 2019 at 08:48:36PM +0100, Jonathan Cameron wrote:
> > > On Mon, 22 Jul 2019 10:45:35 -0500
> > > David Lechner <david@lechnology.com> wrote:
> > >
> > > > This documents device tree binding for the Texas Instruments Enhanced
> > > > Quadrature Encoder Pulse (eQEP) Module found in various TI SoCs.
> > > >
> > > > Signed-off-by: David Lechner <david@lechnology.com>
> > >
> > > Up to William given it is a counter binding, (unless Rob overrules)
> > > but new bindings are generally preferred as yaml.
> > >
> > > Content looks fine to me.
> > >
> > > Thanks,
> > >
> > > Jonathan
> >
> > Rob,
> >
> > Would you prefer these bindings as yaml, or shall I accept them as they
> > are now?
> 
> Still up to you at this point, but I certainly prefer them to be DT schema.
> 
> Rob

I think YAML would be a good idea, it's simple and expressive enough
while still being human-readable, and if new bindings in other
subsystems are switching to yaml then we may as well.

David, resubmit this as yaml in version 2 and I'll pick it up.

Thanks,

William Breathitt Gray
