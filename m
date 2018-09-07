From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: omap: Convert to using %pOFn instead of
 device_node.name
Date: Fri, 7 Sep 2018 10:14:14 -0700
Message-ID: <20180907171414.GL5662@atomide.com>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828154433.5693-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180828154433.5693-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Rob Herring <robh@kernel.org> [180828 08:48]:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: "Benoît Cousson" <bcousson@baylibre.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-omap@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
> - fix error in format specifier position

Thanks applying into omap-for-v4.20/soc.

Regards,

Tony
