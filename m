From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 02/10] dt-bindings: sram: Convert Samsung Exynos
 SYSRAM bindings to json-schema
Date: Thu, 10 Oct 2019 14:33:56 -0500
Message-ID: <20191010193356.GA9975@bogus>
References: <20191002164316.14905-1-krzk@kernel.org>
 <20191002164316.14905-2-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20191002164316.14905-2-krzk@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Tony Lindgren <tony@atomide.com>, Thierry Reding <thierry.reding@gmail.com>, Fabio Estevam <festevam@gmail.com>, linux-samsung-soc@vger.kernel.org, Gregory Clement <gregory.clement@bootlin.com>, Jonathan Hunter <jonathanh@nvidia.com>, Kukjin Kim <kgene@kernel.org>, NXP Linux Team <linux-imx@nxp.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Sascha Hauer <s.hauer@pengutronix.de>, Santosh Shilimkar <ssantosh@kernel.org>, linux-tegra@vger.kernel.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 02, 2019 at 06:43:08PM +0200, Krzysztof Kozlowski wrote:
> Convert Samsung Exynos SYSRAM bindings to DT schema format using
> json-schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v2:
> 1. Use sram as name of node in example.
> 
> Changes since v1:
> 1. Indent example with four spaces (more readable).
> ---
>  .../devicetree/bindings/sram/samsung-sram.txt | 38 ------------
>  .../bindings/sram/samsung-sram.yaml           | 58 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 59 insertions(+), 39 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sram/samsung-sram.txt
>  create mode 100644 Documentation/devicetree/bindings/sram/samsung-sram.yaml


> diff --git a/Documentation/devicetree/bindings/sram/samsung-sram.yaml b/Documentation/devicetree/bindings/sram/samsung-sram.yaml
> new file mode 100644
> index 000000000000..3e77c434ecca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sram/samsung-sram.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sram/samsung-sram.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung Exynos SoC SYSRAM for SMP bringup
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzk@kernel.org>
> +
> +description: |+
> +  Samsung SMP-capable Exynos SoCs use part of the SYSRAM for the bringup
> +  of the secondary cores. Once the core gets powered up it executes the
> +  code that is residing at some specific location of the SYSRAM.
> +
> +  Therefore reserved section sub-nodes have to be added to the mmio-sram
> +  declaration. These nodes are of two types depending upon secure or
> +  non-secure execution environment.
> +
> +allOf:
> +  - $ref: "sram.yaml#"
> +
> +properties:
> +  $nodename:
> +    pattern: "^sysram(@.*)?"

As you are renaming all the node names, this will no longer work. If you 
change it to 'sram', that's going to match others, but would still work 
as long as the child node names are unique to Samsung. If you change 
them to '*-sram' then, you'd have to come up with something else. That 
probably means using 'compatible' strings. At that point, it's kind of 
silly to just be validating what your are using to select the schema. It 
may be better to just add the compatible strings into sram.yaml if 
that's the only difference.

> +
> +patternProperties:
> +  "^([a-z]*-)?sysram@[a-f0-9]$":
> +    type: object
> +
> +    properties:
> +      compatible:
> +        description:
> +          Depending upon boot mode
> +        enum:
> +          - samsung,exynos4210-sysram                 # for Secure SYSRAM
> +          - samsung,exynos4210-sysram-ns              # for Non-secure SYSRAM
> +
