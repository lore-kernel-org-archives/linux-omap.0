From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: palmas: Assign the right powerhold mask for tps65917
Date: Wed, 29 Nov 2017 11:05:06 +0000
Message-ID: <20171129110506.yw2gzggf6ryql7rj@dell>
References: <1508833296-20702-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1508833296-20702-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

On Tue, 24 Oct 2017, Keerthy wrote:

> The powerhold mask for TPS65917 is different when comapred to
> the other palmas versions. Hence assign the right mask that enables
> power off of tps65917 pmic correctly.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/mfd/palmas.c       | 10 +++++++++-
>  include/linux/mfd/palmas.h |  3 +++
>  2 files changed, 12 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
