From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH RESEND 2/2] mfd: twl6040: Register child device for
 twl6040-pdmclk
Date: Tue, 27 Sep 2016 19:50:21 +0100
Message-ID: <20160927185021.GH21388@dell>
References: <20160831114621.6301-1-peter.ujfalusi@ti.com>
 <20160831114621.6301-3-peter.ujfalusi@ti.com>
 <20160831143943.GN9415@dell>
 <3edeea3c-e9a0-f397-e1ec-204393383823@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3edeea3c-e9a0-f397-e1ec-204393383823@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, 27 Sep 2016, Peter Ujfalusi wrote:

> On 08/31/16 17:39, Lee Jones wrote:
> > On Wed, 31 Aug 2016, Peter Ujfalusi wrote:
> > 
> >> The McPDM in OMAP4/5 is using the pdmclk from twl6040 as functional clock.
> >> The twl6040-pdmclk driver provides a clock which can be used to make sure
> >> that the pdmclk is active when the McPDM is in use.
> >>
> >> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >> Acked-by: Rob Herring <robh@kernel.org>
> >> ---
> >>  Documentation/devicetree/bindings/mfd/twl6040.txt | 1 +
> >>  drivers/mfd/twl6040.c                             | 5 +++++
> >>  include/linux/mfd/twl6040.h                       | 2 +-
> >>  3 files changed, 7 insertions(+), 1 deletion(-)
> > 
> > Applied, thanks.
> 
> Lee, for some reason this patch is not found in linux-next (20160927). I can
> see patch 1, but this one is missing.

You're right, it had been dropped.  My apologies.

It's been applied now.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
