From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 2/2] mfd: tps65218.c: Add input voltage options
Date: Thu, 17 Jan 2019 08:07:43 +0000
Message-ID: <20190117080743.GI23399@dell>
References: <1546523226-358-1-git-send-email-Christian.Hohnstaedt@wago.com>
 <1547453794-18770-3-git-send-email-Christian.Hohnstaedt@wago.com>
 <20190116141336.GG23399@dell>
 <20190117055436.GA4213@wago.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190117055436.GA4213@wago.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Cc: Keerthy <j-keerthy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, 17 Jan 2019, Christian Hohnstaedt wrote:

> On Wed, Jan 16, 2019 at 02:13:36PM +0000, Lee Jones wrote:
> > On Mon, 14 Jan 2019, Christian Hohnstaedt wrote:
> > 
> > > These options apply to all regulators in this chip.
> > > 
> > > ti,strict-supply-voltage-supervision:
> > >   Set STRICT flag in CONFIG1
> > > ti,under-voltage-limit-microvolt:
> > >   Select 2.75, 2.95, 3.25 or 3.35 V UVLO in CONFIG1
> > > ti,under-voltage-hyst-microvolt:
> > >   Select 200mV or 400mV UVLOHYS in CONFIG2
> > > 
> > > Signed-off-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
> > > Tested-by: Keerthy <j-keerthy@ti.com>
> > > Reviewed-by: Keerthy <j-keerthy@ti.com>
> > > ---
> > >  drivers/mfd/tps65218.c       | 89 ++++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/mfd/tps65218.h |  4 ++
> > >  2 files changed, 93 insertions(+)
> > 
> > This looks like regulator code.
> > 
> > Why aren't you placing it into the regulator driver?
> 
> This code manages properties of the chip, affecting all regulators.
> 
> The regulator-driver has no hook to be called once for the chip.
> Even if I put this code into the regulator driver file,
> I will have to call it from here.
> 
> This would introduce a dependency from the mfd to the regulator code.

Sounds reasonable.  Thanks for the explanation.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
