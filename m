From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 5/8] dt-bindings: mfd: Provide human readable defines
 for TPS65217 interrupts
Date: Fri, 18 Nov 2016 07:10:52 -0800
Message-ID: <20161118151051.GV4082@atomide.com>
References: <20161028123702.21849-1-woogyom.kim@gmail.com>
 <20161028123702.21849-6-woogyom.kim@gmail.com>
 <20161118145353.GE2301@dell.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161118145353.GE2301@dell.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Milo Kim <woogyom.kim@gmail.com>, bcousson@baylibre.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>
List-Id: linux-omap@vger.kernel.org

* Lee Jones <lee.jones@linaro.org> [161118 06:51]:
> On Fri, 28 Oct 2016, Milo Kim wrote:
> 
> > TPS65217 supports three interrupt sources. This patch enables assigning
> > each IRQ number in the charger and power button node. Then corresponding
> > IRQ will be requested by each driver.
> > 
> > Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
> > ---
> >  include/dt-bindings/mfd/tps65217.h | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >  create mode 100644 include/dt-bindings/mfd/tps65217.h
> > 
> > diff --git a/include/dt-bindings/mfd/tps65217.h b/include/dt-bindings/mfd/tps65217.h
> > new file mode 100644
> > index 0000000..cafb9e6
> > --- /dev/null
> > +++ b/include/dt-bindings/mfd/tps65217.h
> > @@ -0,0 +1,26 @@
> > +/*
> > + * This header provides macros for TI TPS65217 DT bindings.
> > + *
> > + * Copyright (C) 2016 Texas Instruments
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful, but
> > + * WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + * General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License along with
> > + * this program.  If not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#ifndef __DT_BINDINGS_TPS65217_H__
> > +#define __DT_BINDINGS_TPS65217_H__
> > +
> > +#define TPS65217_IRQ_USB	0
> > +#define TPS65217_IRQ_AC		1
> > +#define TPS65217_IRQ_PB		2
> 
> What are "AC" and "PB".  Seeing as these are meant to be "human
> readable", let's make them more human friendly.

Good idea. Milo, please do an incremental single follow-up patch as
I already have applied this and the dts changes using it.

Regards,

Tony
