From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/9] ARM: dts: Add generic ti, sysc compatible in
 addition to the custom ones
Date: Sat, 16 Dec 2017 11:54:19 -0800
Message-ID: <20171216195419.GI3875@atomide.com>
References: <20171215180900.3243-1-tony@atomide.com>
 <20171215180900.3243-3-tony@atomide.com>
 <20171216183414.24ycqj7q2beehiiq@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171216183414.24ycqj7q2beehiiq@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Dave Gerlach <d-gerlach@ti.com>, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Rob Herring <robh@kernel.org> [171216 18:36]:
> On Fri, Dec 15, 2017 at 10:08:53AM -0800, Tony Lindgren wrote:
> > Otherwise we cannot use generic OF_DEV_AUXDATA match without listing
> > all the compatibles separately for OF_DEV_AUXDATA. Let's also update the
> > binding accordingly.
> 
> Your subject has a space in "ti,sysc".

Oops thanks for noticing, will fix.

> > Let's also fix omap4.dtsi to use "ti,sysc-omap4-sr" compatible as we
> > have documented in the binding. This was not noticed earlier as we're
> > still probing SmartReflex driver with platform data.
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  Documentation/devicetree/bindings/bus/ti-sysc.txt |  1 +
> >  arch/arm/boot/dts/dra7.dtsi                       |  4 ++--
> >  arch/arm/boot/dts/omap4.dtsi                      | 20 ++++++++++----------
> >  3 files changed, 13 insertions(+), 12 deletions(-)
> 
> Otherwise,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks for looking,

Tony
