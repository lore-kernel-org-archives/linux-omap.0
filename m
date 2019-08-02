From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: counter: new bindings for TI eQEP
Date: Fri, 2 Aug 2019 07:34:42 -0600
Message-ID: <CAL_JsqLA+m5vKZQ1WwWusnVHwX+nnuApiwKXUnmP6ti-PvMZ-g@mail.gmail.com>
References: <20190722154538.5314-1-david@lechnology.com> <20190722154538.5314-2-david@lechnology.com>
 <20190727204836.1514265d@archlinux> <20190802072513.GA30522@icarus>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190802072513.GA30522@icarus>
Sender: linux-kernel-owner@vger.kernel.org
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: David Lechner <david@lechnology.com>, "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Jonathan Cameron <jic23@jic23.retrosnub.co.uk>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Thierry Reding <thierry.reding@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PWM List <linux-pwm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 2, 2019 at 1:25 AM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
>
> On Sat, Jul 27, 2019 at 08:48:36PM +0100, Jonathan Cameron wrote:
> > On Mon, 22 Jul 2019 10:45:35 -0500
> > David Lechner <david@lechnology.com> wrote:
> >
> > > This documents device tree binding for the Texas Instruments Enhanced
> > > Quadrature Encoder Pulse (eQEP) Module found in various TI SoCs.
> > >
> > > Signed-off-by: David Lechner <david@lechnology.com>
> >
> > Up to William given it is a counter binding, (unless Rob overrules)
> > but new bindings are generally preferred as yaml.
> >
> > Content looks fine to me.
> >
> > Thanks,
> >
> > Jonathan
>
> Rob,
>
> Would you prefer these bindings as yaml, or shall I accept them as they
> are now?

Still up to you at this point, but I certainly prefer them to be DT schema.

Rob
