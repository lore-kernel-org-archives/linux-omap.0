From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v1 2/2] ARM: dts: am335x-shc.dts: fix wrong cd pin level
Date: Tue, 22 Jan 2019 14:59:38 -0800
Message-ID: <20190122225938.GB5720@atomide.com>
References: <20190122052623.1779840-1-hs@denx.de>
 <20190122052623.1779840-3-hs@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190122052623.1779840-3-hs@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Schocher <hs@denx.de>
Cc: devicetree@vger.kernel.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Heiko Schocher <hs@denx.de> [190121 21:27]:
> cd pin on mmc1 is GPIO_ACTIVE_LOW not GPIO_ACTIVE_HIGH

Thanks applying into omap-for-v5.0/fixes.

Tony
