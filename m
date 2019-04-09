From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] ARM: dts: omap2420-n810: Use new CODEC reset pin name
Date: Tue, 9 Apr 2019 08:10:04 -0700
Message-ID: <20190409151004.GI2839@atomide.com>
References: <20190329181313.21009-1-afd@ti.com>
 <20190329181313.21009-4-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190329181313.21009-4-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Andrew F. Davis <afd@ti.com> [190329 11:13]:
> The correct DT property for specifying a GPIO used for reset
> is "reset-gpios", the driver now accepts this name, use it here.

I'll apply this patch into omap-for-v5.2/dt thanks.

Tony
