From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/3] mfd: lp87565: Add lp87565 PMIC support
Date: Tue, 23 May 2017 09:45:31 +0100
Message-ID: <20170523084531.oanijbheozgtoufe@dell>
References: <1495197739-17446-1-git-send-email-j-keerthy@ti.com>
 <1495197739-17446-2-git-send-email-j-keerthy@ti.com>
 <20170522174806.nnpk5jso7jhgygm3@dell>
 <26169872-1b43-88d1-3e5b-367b4d446222@ti.com>
 <20170523065742.44ytkxdagw2wwttz@dell>
 <a753fdb4-feb9-0894-6f40-a19d3f05714c@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a753fdb4-feb9-0894-6f40-a19d3f05714c@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: broonie@kernel.org, robh+dt@kernel.org, t-kristo@ti.com, tony@atomide.com, mark.rutland@arm.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, 23 May 2017, Keerthy wrote:
> On Tuesday 23 May 2017 12:27 PM, Lee Jones wrote:
> > On Tue, 23 May 2017, Keerthy wrote:
> >> On Monday 22 May 2017 11:18 PM, Lee Jones wrote:
> >>> On Fri, 19 May 2017, Keerthy wrote:
> >>>
> >>>> The LP87565 chip is a power management IC for Portable Navigation Systems
> >>>> and Tablet Computing devices. It contains the following components:
> >>>>
> >>>>         - Configurable Bucks(Single and multi-phase).
> >>>>         - Configurable General Purpose Output Signals (GPO).
> >>>>
> >>>> The LP87565-Q1 variant device uses two 2-phase outputs configuration,
> >>>> Buck0 is master for Buck0/1 output and Buck2 is master for Buck2/3
> >>>> output.
> >>>>
> >>>> Signed-off-by: Keerthy <j-keerthy@ti.com>
> >>>> ---
> >>>>  Documentation/devicetree/bindings/mfd/lp87565.txt |  44 ++++
> >>>>  drivers/mfd/Kconfig                               |  14 ++
> >>>>  drivers/mfd/Makefile                              |   1 +
> >>>>  drivers/mfd/lp87565.c                             | 103 ++++++++
> >>>>  include/linux/mfd/lp87565.h                       | 275 ++++++++++++++++++++++
> >>>>  5 files changed, 437 insertions(+)
> >>>>  create mode 100644 Documentation/devicetree/bindings/mfd/lp87565.txt
> >>>>  create mode 100644 drivers/mfd/lp87565.c
> >>>>  create mode 100644 include/linux/mfd/lp87565.h
> >>>>
> > 
> > [...]
> > 
> >>>> +/*
> >>>> + * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
> >>>> + *
> >>>> + * Author: Keerthy <j-keerthy@ti.com>
> >>>
> >>> We usually ask for full "first last" names.
> >>
> >> Keerthy is my full name and i do not have a surname.
> > 
> > What is the 'J' for in your email address?
> 
> Father's initials.

Okay.

> > [...]
> > 
> >>>> +static const struct i2c_device_id lp87565_id_table[] = {
> >>>> +	{ "lp87565-q1", 0 },
> >>>> +	{ },
> >>>> +};
> >>>> +MODULE_DEVICE_TABLE(i2c, lp87565_id_table);
> >>>
> >>> Is this an OF only driver, or not?
> > 
> > You didn't answer my question?
> 
> Sorry i replied on top again. It will be an OF only driver.

Okay, then you don't need this table and you should depend on OF in
the Kconfig file.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
