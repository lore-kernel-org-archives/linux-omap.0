From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] memory: Convert to using %pOFn instead of
 device_node.name
Date: Tue, 28 Aug 2018 08:33:23 -0700
Message-ID: <20180828153323.GL7523@atomide.com>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-29-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180828015252.28511-29-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Rob Herring <robh@kernel.org> [180828 01:58]:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
...
>  drivers/memory/omap-gpmc.c           | 18 +++++++-----------

Looks good to me:

Acked-by: Tony Lindgren <tony@atomide.com>
