From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND PATCH v3 1/3] ARM: dts: DRA7: Add "linux,pci-domain"
 property for pci dt nodes
Date: Tue, 30 Aug 2016 11:47:03 -0700
Message-ID: <20160830184702.hgn2vgxlts4pgkyy@atomide.com>
References: <1470832400-11929-1-git-send-email-kishon@ti.com>
 <1470832400-11929-2-git-send-email-kishon@ti.com>
 <20160826153035.h6uyplc4mjlbc3v3@atomide.com>
 <57C5687C.8030805@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <57C5687C.8030805@ti.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Russell King <linux@armlinux.org.uk>, Benoit Cousson <bcousson@baylibre.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Krzysztof Halasa <khalasa@piap.pl>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Santosh Shilimkar <ssantosh@kernel.o>
List-Id: linux-omap@vger.kernel.org

* Kishon Vijay Abraham I <kishon@ti.com> [160830 04:06]:
> Hi Tony,
> 
> On Friday 26 August 2016 09:00 PM, Tony Lindgren wrote:
> > * Kishon Vijay Abraham I <kishon@ti.com> [160810 05:34]:
> >> Since DRA7 has multiple PCIe Rootcomplex, add "linux,pci-domain"
> >> property to assign a PCI domain number to each of the host
> >> bridges.
> > 
> > Is this patch safe to apply without the other changes?
> 
> Yes. I verified pcie on dra7x by applying only this patch and it doesn't break
> anything.

OK thanks for testing, I'm picking the dts change into omap-for-v4.9/dt
branch.

The other patches you probably should upload to RMKs patch system
if no more comments.

Regards,

Tony
