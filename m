From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 0/7] mfd: Use devm_mfd_add_devices and
 devm_regmap_add_irq_chip
Date: Mon, 25 Apr 2016 12:56:25 +0200
Message-ID: <571DF7D9.8050500@samsung.com>
References: <1461241558-26983-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1461241558-26983-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>, lee.jones@linaro.org, milo.kim@ti.com, cw00.choi@samsung.com
Cc: sbkim73@samsung.com, tony@atomide.com, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 04/21/2016 02:25 PM, Laxman Dewangan wrote:
> This series is an effort to reduce the code in error path and need of
> remove callback by using the devm_mfd_add_devices() and 
> devm_regmap_add_irq_chip() or devm_request_threaded_irq APIs for interrupt
> support.
> 
> This is tested with build and comiplation only with arm64 defconfig and enabling
> the required MFD CONFIGs.

Please compile it also on ARMv7. The changes look trivial but one
compilation without testing might not be sufficient.

Best regards,
Krzysztof
