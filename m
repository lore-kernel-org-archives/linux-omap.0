From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] arm: dts: DRA7: Add IVA and DSPEVE thermal domain
 data
Date: Tue, 9 Feb 2016 07:58:11 -0800
Message-ID: <20160209155811.GH19432@atomide.com>
References: <1454922990-7501-1-git-send-email-j-keerthy@ti.com>
 <20160208195704.GW19432@atomide.com>
 <56B95EF7.9080107@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56B95EF7.9080107@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <a0393675@ti.com>
Cc: Keerthy <j-keerthy@ti.com>, edubezval@gmail.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com
List-Id: linux-omap@vger.kernel.org

* Keerthy <a0393675@ti.com> [160208 19:38]:
> 
> 
> On Tuesday 09 February 2016 01:27 AM, Tony Lindgren wrote:
> >* Keerthy <j-keerthy@ti.com> [160208 01:19]:
> >>OMAP5 has 3 thermal zones cpu, core and multimedia.
> >>On the other hand DRA7 has 5 thermal zones cpu, gpu, core, dspeve
> >>and iva. Currently cpu, core and multimedia are being added via dt
> >>and the other 2 are getting added via kernel. Add the missing thermal
> >>domains in dt so as give the correct trip numbers, type and temperatures.
> >>
> >>Tested on DRA7-EVM.
> >
> >Are these critical fixes to have for v4.5-rc cycle or can they
> >wait for v4.6 merge window?
> 
> Driver configures some default thresholds that are a bit higher but there
> are some thresholds already for dspeve and iva too. So guess these can wait
> if its already too late.

OK let's rather wait then.

Regards,

Tony
