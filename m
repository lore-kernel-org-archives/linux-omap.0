From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP1: devices: configure omap1_spi100k only on
 OMAP7xx
Date: Thu, 29 Nov 2018 12:07:38 -0800
Message-ID: <20181129200738.GF53235@atomide.com>
References: <20181119194943.351-1-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181119194943.351-1-aaro.koskinen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [181119 11:49]:
> Configure omap1_spi100k only on OMAP7xx. This allows running multiboard
> kernels on non-OMAP7xx HW with CONFIG_SPI_OMAP_100K enabled.

Applying into omap-for-v4.21/omap1 thanks.

Tony
