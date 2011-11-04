From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 2/4] regulator: adapt fixed regulator driver to dt
Date: Fri, 4 Nov 2011 22:23:23 +0000
Message-ID: <20111104222323.GB16978@opensource.wolfsonmicro.com>
References: <1319702185-16108-1-git-send-email-rnayak@ti.com>
 <1319702185-16108-3-git-send-email-rnayak@ti.com>
 <20111104203422.GB3918@quad.lixom.net>
 <20111104210151.GA2541@opensource.wolfsonmicro.com>
 <20111104211824.GA5608@quad.lixom.net>
 <20111104212538.GA8266@opensource.wolfsonmicro.com>
 <CAOesGMh2_C+yx=_5PjqoKxZmAMvx-puRjq45s+G2kz2EaEEtqw@mail.gmail.com>
 <20111104215733.GD8266@opensource.wolfsonmicro.com>
 <CAOesGMh-fpUSMvOGkq_b4DVzFUby6pnMmKDXQ=sFJpn+g4FzOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOesGMh-fpUSMvOGkq_b4DVzFUby6pnMmKDXQ=sFJpn+g4FzOw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Rajendra Nayak <rnayak@ti.com>, grant.likely@secretlab.ca, patches@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 04, 2011 at 03:09:32PM -0700, Olof Johansson wrote:

> But even things like allowing (optional) attributes such as
> startup-delay on non-fixed regulators could make sense. Keep in mind
> that the device tree should focus on describing the hardware, not just
> what the linux driver needs from it. So maybe instead of
> startup-delay, specifying ramp-up speed instead of time needed until
> power is good could be the way to go there.

This is in general something that a driver should know as a result of
knowing which regulator it's dealing with - in many cases these are
properties which can be varied at runtime on hardware which has register
control.  Replicating this into the device tree would make things more
error prone.
