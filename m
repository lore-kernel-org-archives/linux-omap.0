From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] ARM: dts: am335x-evm/evmsk: Fix PHY mode for ethernet
Date: Tue, 19 Feb 2019 08:52:31 -0800
Message-ID: <20190219165231.GK15711@atomide.com>
References: <20190218143629.28392-1-peter.ujfalusi@ti.com>
 <20190218144430.GE15711@atomide.com>
 <a9eea4d0-88d4-e903-8a9f-7f1b8b276c21@ti.com>
 <20190218162613.GH15711@atomide.com>
 <c35030fb-9107-1919-5c18-1a39ace8c036@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c35030fb-9107-1919-5c18-1a39ace8c036@ti.com>
Sender: netdev-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: bcousson@baylibre.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, grygorii.strashko@ti.com, vkoul@kernel.org, netdev@vger.kernel.org, f.fainelli@gmail.com, marc.w.gonzalez@free.fr, niklas.cassel@linaro.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [190219 08:02]:
> On 18/02/2019 18.26, Tony Lindgren wrote:
> > OK so sounds like these are OK to wait for v5.1 merge window
> > then as the dts changes alone won't fix anything?
> 
> I think it would be better to send these to 5.0 to avoid the regression
> siting in linux-next.
> 
> The patches are actually doing to the correct thing (we need rgmii-id,
> not rmgii-txid for these boards).
> It was just a matter of luck that it worked with rgmii-txid as the
> driver was broken and did not disabled the rxid when it should have.

OK applying into omap-for-v5.0/fixes-v2. I'll send a pull
request on Thursday most likely then, let's see if it makes
it for v5.0.

Regards,

Tony
