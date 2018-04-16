From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2] mfd: twl-core: Fix clock initialization
Date: Mon, 16 Apr 2018 15:07:43 +0100
Message-ID: <20180416140743.fv5njvszyw6umz3b@dell>
References: <20180409084539.14365-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180409084539.14365-1-peter.ujfalusi@ti.com>
Sender: stable-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, hns@goldelico.com, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, 09 Apr 2018, Peter Ujfalusi wrote:

> When looking up the clock we must use the client->dev as device since that
> is the one which is probed via DT.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: stable@vger.kernel.org # 4.16+
> ---
> Hi,
> 
> Changes since v1:
> - Removed the Fixes line and add tag only for v4.16 to avoid possible breakage
>   in pre v4.16.
>  
> Regards,
> Peter
> 
>  drivers/mfd/twl-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
