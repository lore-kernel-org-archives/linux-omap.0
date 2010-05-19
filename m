From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: RE: [PATCH V2] OMAP3: PM: Workaround for DPLL3 Lock issue
Date: Wed, 19 May 2010 15:42:12 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608703052701ED@dbde02.ent.ti.com>
References: <1273745535-27139-1-git-send-email-shweta.gulati@ti.com>
	<87hbmajrgh.fsf@deeprootsystems.com>
	<FCCFB4CDC6E5564B9182F639FC35608703051ADC7D@dbde02.ent.ti.com>
 <87hbm5qi98.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43308 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756997Ab0ESKMS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 May 2010 06:12:18 -0400
In-Reply-To: <87hbm5qi98.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Gulati, Shweta" <shweta.gulati@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Kevin,

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Tuesday, May 18, 2010 10:07 PM
> To: Sripathy, Vishwanath
> Cc: Gulati, Shweta; linux-omap@vger.kernel.org
> Subject: Re: [PATCH V2] OMAP3: PM: Workaround for DPLL3 Lock issue
> 
> "Sripathy, Vishwanath" <vishwanath.bs@ti.com> writes:
> 
> >> All that being said, why is the voltage level being programmed here?
> >>
> >> It seems to me that all of this errata handling should be
> >> self-contained in the voltage layer.
> >
> > I am not sure if entire errata can be contained in voltage
> > layer. This is because we are performing DVFS operation in CPU Idle
> > path which involves both Frequency and Voltage scaling. So currently
> > this has been done in resource34xx.c where DVFS is implemented.
> 
> What I mean is that there seems to be no good reason to be calling
> these from pm34xx.c, they should be called where voltage scaling is
> done.
Sorry I still do not understand how errata can be invoked from Voltage scaling. Pls note that errata has to be applied only when Core is entering retention or off which can be detected only in omap_sram_idle function. Errata is tightly coupled with CPU idle path. 

Vishwa
> 
> Kevin

