From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/2] dt-bindings: net: cpsw: Document cpsw-phy-sel
 usage but prefer phandle
Date: Sun, 02 Sep 2018 13:52:43 -0700 (PDT)
Message-ID: <20180902.135243.1983575431820096428.davem@davemloft.net>
References: <20180829150024.43210-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180829150024.43210-1-tony@atomide.com>
Sender: netdev-owner@vger.kernel.org
To: tony@atomide.com
Cc: netdev@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, andrew@lunn.ch, grygorii.strashko@ti.com, ivan.khoronzhuk@linaro.org, mark.rutland@arm.com, m-karicheri2@ti.com, robh+dt@kernel.org
List-Id: linux-omap@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>
Date: Wed, 29 Aug 2018 08:00:23 -0700

> The current cpsw usage for cpsw-phy-sel is undocumented but is used for
> all the boards using cpsw. And cpsw-phy-sel is not really a child of
> the cpsw device, it lives in the system control module instead.
> 
> Let's document the existing usage, and improve it a bit where we prefer
> to use a phandle instead of a child device for it. That way we can
> properly describe the hardware in dts files for things like genpd.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Applied.
