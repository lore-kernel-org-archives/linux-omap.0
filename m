From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/2] mfd: tps65218: Correct the config description
Date: Thu, 14 Sep 2017 10:28:15 +0100
Message-ID: <20170914092815.ogj5jigcucaqhpf4@dell>
References: <1505305030-13263-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1505305030-13263-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: tony@atomide.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, 13 Sep 2017, Keerthy wrote:

> When the initial support was added for this PMIC was added
> only regulator support was present. Now we have GPIO and Powerbutton
> support as well. Hence correct the description of MFD_TPS65218 config
> option.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/mfd/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
