From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 1/5] Documentation: pinctrl: palmas: Add
 ti,palmas-powerhold-override property definition
Date: Thu, 24 Nov 2016 08:45:44 +0000
Message-ID: <20161124084544.GS10134@dell.home>
References: <1478754560-27923-1-git-send-email-j-keerthy@ti.com>
 <1478754560-27923-2-git-send-email-j-keerthy@ti.com>
 <20161115014352.5d3qwoonlo63mp5p@rob-hp-laptop>
 <23bf98ee-bcdc-e100-54ce-6f4b1e13ffcf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <23bf98ee-bcdc-e100-54ce-6f4b1e13ffcf@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: Rob Herring <robh@kernel.org>, tony@atomide.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, nm@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

On Thu, 24 Nov 2016, Keerthy wrote:

> 
> 
> On Tuesday 15 November 2016 07:13 AM, Rob Herring wrote:
> > On Thu, Nov 10, 2016 at 10:39:16AM +0530, Keerthy wrote:
> > > GPIO7 is configured in POWERHOLD mode which has higher priority
> > > over DEV_ON bit and keeps the PMIC supplies on even after the DEV_ON
> > > bit is turned off. This property enables driver to over ride the
> > > POWERHOLD value to GPIO7 so as to turn off the PMIC in power off
> > > scenarios.
> > > 
> > > Signed-off-by: Keerthy <j-keerthy@ti.com>
> > > ---
> > >  Documentation/devicetree/bindings/pinctrl/pinctrl-palmas.txt | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > 
> > Acked-by: Rob Herring <robh@kernel.org>
> 
> Tony,
> 
> Are you planning to pick this one as well?

This should be taken by LinusW.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
