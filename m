From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 5/5] wlcore: move wl12xx_platform_data up and make
 it truly optional
Date: Fri, 25 Jan 2013 09:09:03 -0800
Message-ID: <20130125170903.GZ22517@atomide.com>
References: <1358952038-5982-6-git-send-email-coelho@ti.com>
 <1359108334-18459-1-git-send-email-coelho@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1359108334-18459-1-git-send-email-coelho@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luciano Coelho <coelho@ti.com>
Cc: linux-wireless@vger.kernel.org, balbi@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Luciano Coelho <coelho@ti.com> [130125 02:09]:
> The platform data is used not only by wlcore-based drivers, but also
> by wl1251.  Move it up in the directory hierarchy to reflect this.
> 
> Additionally, make it truly optional.  At the moment, disabling
> platform data while wl1251_sdio or wlcore_sdio are enabled doesn't
> work, but it will be necessary when device tree support is
> implemented.
> 
> Signed-off-by: Luciano Coelho <coelho@ti.com>
> Reviewed-by: Felipe Balbi <balbi@ti.com>
> ---
> 
> In v2:
>    * Fix ti/Makefile
>    * Modify board_omap3evm.c which was still using the old Kconfig define
> 
> Tony, is it okay if I add this change in the omap3evm board in this
> patch and queue it via wireless so that the whole thing is in sync?

OK, this should not cause additional merge conflicts:

Acked-by: Tony Lindgren <tony@atomide.com> 
