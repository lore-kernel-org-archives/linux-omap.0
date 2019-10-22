From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 10/10] ARM: dts: omap: Rename "ocmcram" node to "sram"
Date: Tue, 22 Oct 2019 09:35:50 -0700
Message-ID: <20191022163550.GB5610@atomide.com>
References: <20191002164316.14905-1-krzk@kernel.org>
 <20191002164316.14905-10-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191002164316.14905-10-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene@kernel.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@bootlin.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Santosh Shilimkar <ssantosh@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sam
List-Id: linux-omap@vger.kernel.org

* Krzysztof Kozlowski <krzk@kernel.org> [191002 09:45]:
> The device node name should reflect generic class of a device so rename
> the "ocmcram" node to "sram".  This will be also in sync with upcoming DT
> schema.  No functional change.

Applying this into omap-for-v5.5/dt thanks.

Tony
