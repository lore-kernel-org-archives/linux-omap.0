From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: omap-usb-host: Fix dts probe of children
Date: Tue, 11 Sep 2018 16:48:09 +0100
Message-ID: <20180911154809.GC4185@dell>
References: <20180425142922.128233-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180425142922.128233-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wed, 25 Apr 2018, Tony Lindgren wrote:

> It currently only works if the parent bus uses "simple-bus". We
> currently try to probe children with non-existing compatible values.
> And we're missing .probe.
> 
> I noticed this while testing devices configured to probe using ti-sysc
> interconnect target module driver. For that we also may want to rebind
> the driver, so let's remove __init and __exit.
> 
> Cc: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> This is OK to wait for v4.18 merge window as the related dts node has
> not yet been updated to probe via ti-sysc interconnect target driver.
> 
> ---
>  drivers/mfd/omap-usb-host.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
