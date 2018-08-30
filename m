From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 1/2] dt-bindings: net: cpsw: Document cpsw-phy-sel usage
 but prefer phandle
Date: Thu, 30 Aug 2018 03:18:49 +0200
Message-ID: <20180830011849.GA16896@lunn.ch>
References: <20180829150024.43210-1-tony@atomide.com>
 <90e0f25f-45f5-b2c0-59d9-cdf25eb06c0c@ti.com>
 <20180830004745.GU7523@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180830004745.GU7523@atomide.com>
Sender: netdev-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, David Miller <davem@davemloft.net>, netdev@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Murali Karicheri <m-karicheri2@ti.com>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org

> In the long run cpsw should be really treated as an
> interconnect instance with it's control module providing
> standard Linux framework services such as clock /
> regulator / phy / pinctrl / iio whatever for the other
> modules.

Some of us have been applying pressure for a new driver. This sounds
like another argument for such a re-write.

	   Andrew
