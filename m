From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 05/14] mfd: twl6040: Register child device for
 twl6040-pdmclk
Date: Wed, 18 May 2016 18:30:30 -0500
Message-ID: <20160518233030.GA9813@rob-hp-laptop>
References: <1463579196-5484-1-git-send-email-peter.ujfalusi@ti.com>
 <1463579196-5484-6-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1463579196-5484-6-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: mturquette@baylibre.com, sboyd@codeaurora.org, tony@atomide.com, lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org, t-kristo@ti.com, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

On Wed, May 18, 2016 at 04:46:27PM +0300, Peter Ujfalusi wrote:
> The McPDM in OMAP4/5 is using the pdmclk from twl6040 as functional clock.
> The twl6040-pdmclk driver provides a clock which can be used to make sure
> that the pdmclk is active when the McPDM is in use.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  Documentation/devicetree/bindings/mfd/twl6040.txt | 1 +
>  drivers/mfd/twl6040.c                             | 5 +++++
>  include/linux/mfd/twl6040.h                       | 2 +-
>  3 files changed, 7 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
