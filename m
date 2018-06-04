From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 02/33] mfd: omap-usb-host: use match_string() helper
Date: Mon, 4 Jun 2018 07:15:54 +0100
Message-ID: <20180604061554.GE25455@dell>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
 <1526903890-35761-3-git-send-email-xieyisheng1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1526903890-35761-3-git-send-email-xieyisheng1@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, 21 May 2018, Yisheng Xie wrote:

> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded variant.
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: linux-omap@vger.kernel.org
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
>  drivers/mfd/omap-usb-host.c | 24 ++----------------------
>  1 file changed, 2 insertions(+), 22 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
