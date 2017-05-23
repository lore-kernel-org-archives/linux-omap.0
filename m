From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] mfd: lp87565: Add lp87565 PMIC support
Date: Tue, 23 May 2017 16:39:01 +0100
Message-ID: <20170523153901.d7o6la6b7hrxsrhe@dell>
References: <1495197739-17446-1-git-send-email-j-keerthy@ti.com>
 <1495197739-17446-2-git-send-email-j-keerthy@ti.com>
 <20170522174806.nnpk5jso7jhgygm3@dell>
 <26169872-1b43-88d1-3e5b-367b4d446222@ti.com>
 <20170523065742.44ytkxdagw2wwttz@dell>
 <a753fdb4-feb9-0894-6f40-a19d3f05714c@ti.com>
 <20170523084531.oanijbheozgtoufe@dell>
 <ce83f605-879b-dee0-d09e-63d01a7f66c7@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ce83f605-879b-dee0-d09e-63d01a7f66c7-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, 23 May 2017, Keerthy wrote:

> 
> 
> On Tuesday 23 May 2017 02:15 PM, Lee Jones wrote:
> > On Tue, 23 May 2017, Keerthy wrote:
> >> On Tuesday 23 May 2017 12:27 PM, Lee Jones wrote:
> >>> On Tue, 23 May 2017, Keerthy wrote:
> >>>> On Monday 22 May 2017 11:18 PM, Lee Jones wrote:
> >>>>> On Fri, 19 May 2017, Keerthy wrote:
> >>>>>
> >>>>>> The LP87565 chip is a power management IC for Portable Navigation Systems
> >>>>>> and Tablet Computing devices. It contains the following components:
> >>>>>>
> >>>>>>         - Configurable Bucks(Single and multi-phase).
> >>>>>>         - Configurable General Purpose Output Signals (GPO).
> >>>>>>
> >>>>>> The LP87565-Q1 variant device uses two 2-phase outputs configuration,
> >>>>>> Buck0 is master for Buck0/1 output and Buck2 is master for Buck2/3
> >>>>>> output.
> >>>>>>
> >>>>>> Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
> >>>>>> ---
> >>>>>>  Documentation/devicetree/bindings/mfd/lp87565.txt |  44 ++++
> >>>>>>  drivers/mfd/Kconfig                               |  14 ++
> >>>>>>  drivers/mfd/Makefile                              |   1 +
> >>>>>>  drivers/mfd/lp87565.c                             | 103 ++++++++
> >>>>>>  include/linux/mfd/lp87565.h                       | 275 ++++++++++++++++++++++
> >>>>>>  5 files changed, 437 insertions(+)
> >>>>>>  create mode 100644 Documentation/devicetree/bindings/mfd/lp87565.txt
> >>>>>>  create mode 100644 drivers/mfd/lp87565.c
> >>>>>>  create mode 100644 include/linux/mfd/lp87565.h
> >>>>>>
> >>>
> >>> [...]
> >>>
> >>>>>> +/*
> >>>>>> + * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
> >>>>>> + *
> >>>>>> + * Author: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
> >>>>>
> >>>>> We usually ask for full "first last" names.
> >>>>
> >>>> Keerthy is my full name and i do not have a surname.
> >>>
> >>> What is the 'J' for in your email address?
> >>
> >> Father's initials.
> > 
> > Okay.
> > 
> >>> [...]
> >>>
> >>>>>> +static const struct i2c_device_id lp87565_id_table[] = {
> >>>>>> +	{ "lp87565-q1", 0 },
> >>>>>> +	{ },
> >>>>>> +};
> >>>>>> +MODULE_DEVICE_TABLE(i2c, lp87565_id_table);
> >>>>>
> >>>>> Is this an OF only driver, or not?
> >>>
> >>> You didn't answer my question?
> >>
> >> Sorry i replied on top again. It will be an OF only driver.
> > 
> > Okay, then you don't need this table and you should depend on OF in
> > the Kconfig file.
> 
> Okay. Cool thanks for this info.
> 
> I am seeing this commit: 4895e493f91bff7f96f328b883c7f6448aa6abc6
> 
> mfd: Export OF module alias information in missing drivers
> 
> So no need of i2c_device_id for any of the OF-only mfd drivers?

So long as you don't depend on the .data attribute.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
