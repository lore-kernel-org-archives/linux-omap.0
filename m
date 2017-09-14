From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/2] mfd: tps65218: Introduce dependency on CONFIG_OF
Date: Thu, 14 Sep 2017 10:28:25 +0100
Message-ID: <20170914092825.4ycuuxxspnzef5jq@dell>
References: <1505305030-13263-1-git-send-email-j-keerthy@ti.com>
 <1505305030-13263-2-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1505305030-13263-2-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: tony@atomide.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, 13 Sep 2017, Keerthy wrote:

> Currently the driver boots only via device tree hence add a
> dependency on CONFIG_OF. This leaves with a bunch of unused code
> so clean that up.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/mfd/Kconfig    | 2 +-
>  drivers/mfd/tps65218.c | 8 --------
>  2 files changed, 1 insertion(+), 9 deletions(-)

Applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
