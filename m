From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 3/7] mfd: max77686: Use devm_mfd_add_devices and
 devm_regmap_add_irq_chip
Date: Mon, 25 Apr 2016 12:57:01 +0200
Message-ID: <571DF7FD.8020209@samsung.com>
References: <1461241558-26983-1-git-send-email-ldewangan@nvidia.com>
 <1461241558-26983-4-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1461241558-26983-4-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>, lee.jones@linaro.org, milo.kim@ti.com, cw00.choi@samsung.com
Cc: sbkim73@samsung.com, tony@atomide.com, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 04/21/2016 02:25 PM, Laxman Dewangan wrote:
> Use devm_mfd_add_devices() for adding MFD child devices and
> devm_regmap_add_irq_chip() for IRQ chip registration.
> 
> This reduces the error code path and .remove callback for removing
> MFD child devices and deleting IRQ chip data.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> CC: Chanwoo Choi <cw00.choi@samsung.com>
> CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/mfd/max77686.c | 31 ++++++++-----------------------
>  1 file changed, 8 insertions(+), 23 deletions(-)

Switching existing code to devm-like interface doesn't bring huge
benefits but looks okay and I'm fine with it:

Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
