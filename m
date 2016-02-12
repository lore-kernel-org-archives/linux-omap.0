From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: dts: OMAP3-N950-N9: Add ssi idle pinctrl state
Date: Fri, 12 Feb 2016 14:08:46 -0800
Message-ID: <20160212220845.GL19432@atomide.com>
References: <1454201558-31285-1-git-send-email-sre@kernel.org>
 <1454201558-31285-2-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1454201558-31285-2-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [160130 16:53]:
> This adds an idle pinctrl state, which will be used
> by the driver to avoid incoming data during clock
> rate changes or data flushing.

Picking this patch into omap-for-v4.6/dt thanks.

Tony
