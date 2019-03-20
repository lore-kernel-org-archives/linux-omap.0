From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCHv2] mfd: twl6040: Fix device init errors for ACCCTL
 register
Date: Wed, 20 Mar 2019 13:11:14 +0000
Message-ID: <20190320131114.GQ4731@dell>
References: <20190214160345.353-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190214160345.353-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Florian Vaussard <florian.vaussard@epfl.ch>, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, 14 Feb 2019, Tony Lindgren wrote:

> I noticed that we can get a -EREMOTEIO errors on at least omap4 duovero:
> 
> twl6040 0-004b: Failed to write 2d = 19: -121
> 
> And then any following register access will produce errors.
> 
> There 2d offset above is register ACCCTL that gets written on twl6040
> powerup. With error checking added to the related regcache_sync() call,
> the -EREMOTEIO error is reproducable on twl6040 powerup at least
> duovero.
> 
> To fix the error, we need to wait until twl6040 is accessible after the
> powerup. Based on tests on omap4 duovero, we need to wait over 8ms after
> powerup before register write will complete without failures. Let's also
> make sure we warn about possible errors too.
> 
> Note that we have twl6040_patch[] reg_sequence with the ACCCTL register
> configuration and regcache_sync() will write the new value to ACCCTL.
> 
> Cc: Florian Vaussard <florian.vaussard@epfl.ch>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> Changes since v1:
> 
> - Cosmetic change to improve error message as suggested by Lee
> 
> ---
>  drivers/mfd/twl6040.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
