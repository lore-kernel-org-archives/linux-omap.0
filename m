From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] memory: Convert to using %pOFn instead of device_node.name
Date: Wed, 29 Aug 2018 09:44:59 +0200
Message-ID: <CAJKOXPdtVA14+DFmL_LYy-UZ1Enq06TxazDLW8c8ihn_+vw8Gw@mail.gmail.com>
References: <20180828015252.28511-1-robh@kernel.org> <20180828015252.28511-29-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180828015252.28511-29-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh@kernel.org
Cc: linux-kernel@vger.kernel.org, rogerq@ti.com, tony@atomide.com, kgene@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, 28 Aug 2018 at 03:54, Rob Herring <robh@kernel.org> wrote:
>
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
>
> Cc: Roger Quadros <rogerq@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: linux-omap@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-tegra@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/memory/omap-gpmc.c           | 18 +++++++-----------
>  drivers/memory/samsung/exynos-srom.c |  4 ++--

For Samsung:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
