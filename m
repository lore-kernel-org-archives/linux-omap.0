From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: dts: am335x-bone-common: Mark MAC as having
 only one PHY
Date: Fri, 10 Jun 2016 04:31:08 -0700
Message-ID: <20160610113108.GC22406@atomide.com>
References: <20160527181743.8401-1-afd@ti.com>
 <20160527181743.8401-2-afd@ti.com>
 <5751B4A8.4060706@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5751B4A8.4060706@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: "Andrew F. Davis" <afd@ti.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [160603 09:49]:
> On 05/27/2016 09:17 PM, Andrew F. Davis wrote:
> > Currently am33xx.dtsi declares the MAC controller to have two
> > slave ports, on these boards we only use one, so set the slave
> > count to one. This eliminates a console error message when
> > the non-existent PHY is not detected.
...

> Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

Applying both into omap-for-v4.8/dt thanks.

Tony
