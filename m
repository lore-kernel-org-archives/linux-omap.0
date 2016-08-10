From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [RFT RESEND PATCH v3 2/3] ARM: Fix *MIGHT_HAVE_PCI* config from
 being selected redundantly
Date: Wed, 10 Aug 2016 15:08:05 +0200
Message-ID: <e2e7e471-190d-a685-e496-1ab3e1d3a333@samsung.com>
References: <1470832400-11929-1-git-send-email-kishon@ti.com>
 <1470832400-11929-3-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1470832400-11929-3-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Russell King <linux@armlinux.org.uk>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Shawn Guo <shawnguo@kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, nsekhar@ti.com, Rob Herring <robh+dt@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Kukjin Kim <kgene@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Santosh Shilimkar <ssantosh@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Krzysztof Halasa <khalasa@piap.pl>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Shiraz Hashim <shiraz.linux.kernel@gmail.com>, Viresh Kumar <vireshk@kernel.org>
List-Id: linux-omap@vger.kernel.org

On 08/10/2016 02:33 PM, Kishon Vijay Abraham I wrote:
> *MIGHT_HAVE_PCI* config is already selected in ARCH_MULTIPLATFORM.
> Fix it from getting redundantly selected in all

I don't like the "fix" here and in subject. There is no error, no
warning, no issue to be fixed. Fix might be a candidate to backport
(stable, vendor etc) but this just removes something which is not needed.

With the change in subject, for exynos:
Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
