From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v3 1/6] bus/ti-pwmss: move TI PWMSS driver from PWM to
 bus subsystem
Date: Thu, 17 Oct 2019 21:58:01 +0100
Message-ID: <20191017215751.7d05170c@archlinux>
References: <20190901225827.12301-1-david@lechnology.com>
        <20190901225827.12301-2-david@lechnology.com>
        <20190902150245.GE1445@ulmo>
        <20190908121524.49b4874d@archlinux>
        <20190908194447.GM52127@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190908194447.GM52127@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, David Lechner <david@lechnology.com>, linux-iio@vger.kernel.org, linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?B?QmVub8OudA==?= Cousson <bcousson@baylibre.com>, William Breathitt Gray <vilhelm.gray@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sun, 8 Sep 2019 12:44:48 -0700
Tony Lindgren <tony@atomide.com> wrote:

> * Jonathan Cameron <jic23@jic23.retrosnub.co.uk> [190908 11:16]:
> > On Mon, 2 Sep 2019 17:02:45 +0200
> > Thierry Reding <thierry.reding@gmail.com> wrote:
> >   
> > > On Sun, Sep 01, 2019 at 05:58:22PM -0500, David Lechner wrote:  
> > > > The TI PWMSS driver is a simple bus driver for providing power
> > > > power management for the PWM peripherals on TI AM33xx SoCs, namely
> > > > eCAP, eHRPWM and eQEP. The eQEP is a counter rather than a PWM, so
> > > > it does not make sense to have the bus driver in the PWM subsystem
> > > > since the PWMSS is not exclusive to PWM devices.
> > > > 
> > > > Signed-off-by: David Lechner <david@lechnology.com>
> > > > ---
> > > > 
> > > > v3 changes:
> > > > - none
> > > > v2 changes:
> > > > - new patch
> > > > 
> > > >  drivers/bus/Kconfig                           | 9 +++++++++
> > > >  drivers/bus/Makefile                          | 1 +
> > > >  drivers/{pwm/pwm-tipwmss.c => bus/ti-pwmss.c} | 0
> > > >  drivers/pwm/Kconfig                           | 9 ---------
> > > >  drivers/pwm/Makefile                          | 1 -
> > > >  5 files changed, 10 insertions(+), 10 deletions(-)
> > > >  rename drivers/{pwm/pwm-tipwmss.c => bus/ti-pwmss.c} (100%)    
> > > 
> > > Acked-by: Thierry Reding <thierry.reding@gmail.com>  
> > 
> > Do we need an immutable branch for these precursor patches to the
> > driver addition? It's not going to make 5.4 via my tree as cutting it
> > too fine so we'll be in the position of holding these in a non obvious
> > tree for a whole cycle.   
> 
> Sure an immutable branch would be nice in case of unlikely
> dts file conflicts. And yeah no need to try to rush to v5.4.
> 
> Regards,
> 
> Tony
immutable branch created based on 5.4-rc1 at:
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=ib-ti-eqep-5.4-rc1

I'll pull it into IIO in a few minutes as have one more of these
to do at the same time.  Includes patches 1-4 of this series.

Thanks,

Jonathan
