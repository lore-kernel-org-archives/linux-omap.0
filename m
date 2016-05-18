From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 14/14] ASoC: omap-mcpdm: Add support for pdmclk clock
 handling
Date: Wed, 18 May 2016 18:31:41 -0500
Message-ID: <20160518233141.GA10395@rob-hp-laptop>
References: <1463579196-5484-1-git-send-email-peter.ujfalusi@ti.com>
 <1463579196-5484-15-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1463579196-5484-15-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: mturquette@baylibre.com, sboyd@codeaurora.org, tony@atomide.com, lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org, t-kristo@ti.com, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

On Wed, May 18, 2016 at 04:46:36PM +0300, Peter Ujfalusi wrote:
> McPDM module receives it's functional clock from external source. This
> clock is the pdmclk provided by the twl6040 audio IC. If the clock is not
> available all register accesses to McPDM fails and the module is not
> operational.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  Documentation/devicetree/bindings/sound/omap-mcpdm.txt | 10 ++++++++++
>  sound/soc/omap/omap-mcpdm.c                            | 17 +++++++++++++++++
>  2 files changed, 27 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
