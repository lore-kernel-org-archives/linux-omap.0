From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] AM57xx: Fix bugs in device tree files
Date: Tue, 17 Dec 2019 10:23:53 -0800
Message-ID: <20191217182353.GC35479@atomide.com>
References: <20191217085124.22480-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191217085124.22480-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Kishon Vijay Abraham I <kishon@ti.com> [191217 00:50]:
> This series
>  *) Removes gpio property from endpoint device tree node (since it's
>     used for driving PERST# line)
>  *) Fix gpio used for driving PERST# line in AM571x IDK
>  *) Model 5V0 regulator which is used for deriving the regulator
>     connected to COMQ port in beagle x15

Thanks applying all into fixes.

Tony
