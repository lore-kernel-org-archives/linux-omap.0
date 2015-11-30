From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/5] arm: dts: complete dm816x device tree
Date: Mon, 30 Nov 2015 10:22:40 -0800
Message-ID: <20151130182240.GI2517@atomide.com>
References: <56449D1D.4030803@baylibre.com>
 <20151112174706.GN3218@atomide.com>
 <5645AD6D.8010706@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5645AD6D.8010706@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, fisaksen@baylibre.com, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Neil Armstrong <narmstrong@baylibre.com> [151113 01:30]:
> On 11/12/2015 06:47 PM, Tony Lindgren wrote:
> > * Neil Armstrong <narmstrong@baylibre.com> [151112 06:08]:
> >> In order to fix support for the dm816x platform, add missing bits in
> >> the dm816x dtsi and cleanup OCP.
> > 
> > Which ones are needed as fixes for the v4.4-rc kernel?
> > 
> > Regards,
> > 
> > Tony
> > 
> >> The last patch adds support for the omap4-hwspinlock.
> >>
> >> v2: add ocp hwmod cleanup
> >>
> >> Neil Armstrong (5):
> >>   arm: dts: add dm816x missing #mbox-cells
> >>   arm: dts: add dm816x missing spi DT dma handles
> Tony,
> 
> The two first are fixes for v4.4-rc.

OK applying first two into omap-for-v4.4/fixes, the rest
into omap-for-v4.5/dt.

Regards,

Tony
