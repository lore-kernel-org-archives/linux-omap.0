From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 1/4] ARM: dts: imx6: RDU2: Use new CODEC reset pin name
Date: Thu, 11 Apr 2019 10:42:51 +0800
Message-ID: <20190411024250.GL26817@dragon>
References: <20190329181313.21009-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190329181313.21009-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Mar 29, 2019 at 01:13:10PM -0500, Andrew F. Davis wrote:
> The correct DT property for specifying a GPIO used for reset
> is "reset-gpios", the driver now accepts this name, use it here.
> 
> Note the GPIO polarity in the driver was ignored before and always
> assumed to be active low, when all the DTs are fixed we will start
> respecting the specified polarity. Switch polarity in DT to the
> currently assumed one, this way when the driver changes the
> behavior will not change.
> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>

I fixed up the prefix to use board name, and applied patch #1 ~ #3.

Shawn
