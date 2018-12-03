From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/2] iio: adc: ti_am335x_tscadc: Improve accuracy of
 measurement
Date: Mon, 3 Dec 2018 07:01:17 +0000
Message-ID: <20181203070117.GI6009@dell>
References: <20181119064236.28902-1-vigneshr@ti.com>
 <20181119064236.28902-3-vigneshr@ti.com>
 <20181128091432.GT4272@dell>
 <20181201150400.09706f47@archlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181201150400.09706f47@archlinux>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vignesh R <vigneshr@ti.com>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sat, 01 Dec 2018, Jonathan Cameron wrote:

> On Wed, 28 Nov 2018 09:14:32 +0000
> Lee Jones <lee.jones@linaro.org> wrote:
> 
> > On Mon, 19 Nov 2018, Vignesh R wrote:
> > 
> > > When performing single ended measurements with TSCADC, its recommended
> > > to set negative input (SEL_INM_SWC_3_0) of ADC step to ADC's VREFN in the
> > > corresponding STEP_CONFIGx register.
> > > Also, the positive(SEL_RFP_SWC_2_0) and negative(SEL_RFM_SWC_1_0)
> > > reference voltage for ADC step needs to be set to VREFP and VREFN
> > > respectively in STEP_CONFIGx register.
> > > Without these changes, there may be variation of as much as ~2% in the
> > > ADC's digital output which is bad for precise measurement.
> > > 
> > > Signed-off-by: Vignesh R <vigneshr@ti.com>
> > > ---
> > >  drivers/iio/adc/ti_am335x_adc.c      | 5 ++++-  
> > 
> > >  include/linux/mfd/ti_am335x_tscadc.h | 4 ++++  
> > 
> > Acked-by: Lee Jones <lee.jones@linaro.org>
> > 
> I'll leave this for v2 given changes in the first patch.
> 
> My assumption is at the moment that both will go through mfd.
> Shout Lee if you have other plans.

I'm fine with that.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
