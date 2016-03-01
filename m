From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 3/5] ARM: dts: DRA7: Add TBCLK for PWMSS
Date: Tue, 1 Mar 2016 10:05:13 -0800
Message-ID: <20160301180513.GA13417@atomide.com>
References: <1456439796-28546-1-git-send-email-fcooper@ti.com>
 <1456439796-28546-4-git-send-email-fcooper@ti.com>
 <20160229232348.GV13417@atomide.com>
 <56D59100.3060803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56D59100.3060803@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Franklin S Cooper Jr <fcooper@ti.com>, paul@pwsan.com, vigneshr@ti.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [160301 04:54]:
> On 03/01/2016 01:23 AM, Tony Lindgren wrote:
> >
> >Note for Tero, let's plan on getting rid of the duplicate
> >reg entries by using the standard clock output offset within
> >the clock register. I think we should easily be able to add
> >a binding for this and then deprecate the overlapping reg
> >entries.
> 
> Yeah, we have been discussing this offline a bit, but haven't had time to
> look at this. I believe the hwmod clock conversion is of higher priority
> still.

Yes agreed.

Tony
