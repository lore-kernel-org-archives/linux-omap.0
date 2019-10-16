From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 06/10] ARM: dts: imx: Rename "iram" node to "sram"
Date: Wed, 16 Oct 2019 19:18:34 +0300
Message-ID: <CAJKOXPccVj3KJTzzxvQpzFeBYHX1onoh+DfApr8AA-QxvPzWLg@mail.gmail.com>
References: <20191002164316.14905-1-krzk@kernel.org> <20191002164316.14905-6-krzk@kernel.org>
 <20191014113240.GN12262@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191014113240.GN12262@dragon>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene@kernel.org>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@bootlin.com>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Santosh Shilimkar <ssantosh@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm-ker
List-Id: linux-omap@vger.kernel.org

On Mon, 14 Oct 2019 at 14:33, Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Wed, Oct 02, 2019 at 06:43:12PM +0200, Krzysztof Kozlowski wrote:
> > The device node name should reflect generic class of a device so rename
> > the "iram" node to "sram".  This will be also in sync with upcoming DT
> > schema.  No functional change.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> Acked-by: Shawn Guo <shawnguo@kernel.org>
>
> Let me know if you want it go through IMX tree.

Yes please, I think each of these should go through soc maintainers.

Best regards,
Krzysztof
