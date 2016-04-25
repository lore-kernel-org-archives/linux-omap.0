From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 5/7] mfd: sec: Use devm_mfd_add_devices and
 devm_regmap_add_irq_chip
Date: Mon, 25 Apr 2016 14:45:04 +0200
Message-ID: <571E1150.5030306@samsung.com>
References: <1461241558-26983-1-git-send-email-ldewangan@nvidia.com>
 <1461241558-26983-6-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1461241558-26983-6-git-send-email-ldewangan@nvidia.com>
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
> CC: Sangbeom Kim <sbkim73@samsung.com>
> CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> CC: linux-samsung-soc@vger.kernel.org
> ---
>  drivers/mfd/sec-core.c | 20 +++-----------------
>  drivers/mfd/sec-irq.c  | 14 +++++---------
>  2 files changed, 8 insertions(+), 26 deletions(-)


Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
