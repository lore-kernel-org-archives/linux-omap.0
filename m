From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/3] mfd/omap-usb-tll: Return an error code only as a
 constant in usbtll_omap_probe()
Date: Mon, 22 Jan 2018 15:50:57 +0000
Message-ID: <20180122155057.7eiu53l6xjls6uga@dell>
References: <c048a681-70e4-ecdd-e0f8-48c8f1bb0ac4@users.sourceforge.net>
 <367e77d8-3a65-2c12-5e79-75a626b65f41@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <367e77d8-3a65-2c12-5e79-75a626b65f41@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, 15 Jan 2018, SF Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 15 Jan 2018 14:00:45 +0100
> 
> * Return an error code without storing it in an intermediate variable.
> 
> * Delete the label "err_clk_alloc" and local variable "ret"
>   which became unnecessary with this refactoring.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/mfd/omap-usb-tll.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)

Applied, thanks.

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
