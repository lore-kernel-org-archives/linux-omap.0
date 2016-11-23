From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 4/5] arm: dts: am57xx-beagle-x15-common: Add overide
 powerhold property
Date: Wed, 23 Nov 2016 08:33:27 +0000
Message-ID: <20161123083327.GM10134@dell.home>
References: <1478754560-27923-1-git-send-email-j-keerthy@ti.com>
 <1478754560-27923-5-git-send-email-j-keerthy@ti.com>
 <20161115000849.GD4082@atomide.com>
 <6ac3b28e-4891-83bc-a2f7-c903541acc18@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6ac3b28e-4891-83bc-a2f7-c903541acc18@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, robh+dt@kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, nm@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

On Wed, 23 Nov 2016, Keerthy wrote:

> 
> 
> On Tuesday 15 November 2016 05:38 AM, Tony Lindgren wrote:
> > * Keerthy <j-keerthy@ti.com> [161109 21:10]:
> > > The PMICs have POWERHOLD set by default which prevents PMIC shutdown
> > > even on DEV_CTRL On bit set to 0 as the Powerhold has higher priority.
> > > So to enable pmic power off this property lets one over ride the default
> > > value and enable pmic power off.
> > 
> > This should not cause merge conflicts so probably best to merge along
> > with the driver changes:
> > 
> > Acked-by: Tony Lindgren <tony@atomide.com>
> > 
> > If you guys want me to pick up this separately let me know.
> 
> Hi Lee Jones,
> 
> Are you planning to pull DT and Documentation patches as well?

No need.  They can be safely applied to their own subsystems.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
