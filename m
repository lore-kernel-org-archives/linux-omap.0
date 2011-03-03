From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 4/4] OMAP3 and 4 I2C use cpu type consistently for new
 register availability
Date: Thu, 3 Mar 2011 22:45:25 +0100
Message-ID: <4D700BF5.8090308@ti.com>
References: <20110303134744.30648.91218.stgit@otae.warmcat.com> <20110303135044.30648.27273.stgit@otae.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57724 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752628Ab1CCVpc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Mar 2011 16:45:32 -0500
In-Reply-To: <20110303135044.30648.27273.stgit@otae.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Green <andy@warmcat.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, Andy Green <andy.green@linaro.org>

On 3/3/2011 2:50 PM, Andy Green wrote:
> The driver makes the choice about which register layout to
> use based on cpu, however it then tries to use the probed
> peripheral unit version register to decide whether to access
> registers that only exist in the 4430 unit.
>
> Unfortunately, the unit with the smaller register map on the
> OMAP3530 has the same peripheral unit version number, leading
> the OMAP3530 to dereference the register map beyond the bounds
> of its array, and then to access a 'random' register offset taken
> from whatever happens to be sitting beyond the register map
> array, as reported here
>
> https://bugs.launchpad.net/linux-linaro/+bug/645324
>
> This patch makes both the choice of register map and the decision
> to use a register only present in the larger map both do so based
> on cpu type, which correctly reflects register availability.
>
> Cc: patches@linaro.org
> Reported-by: Peter Maydell<peter.maydell@linaro.org>
> Signed-off-by: Andy Green<andy.green@linaro.org>
> ---
>
>   drivers/i2c/busses/i2c-omap.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index e09c62d..c82e1bb5 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -309,7 +309,7 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
>   	pdata = pdev->dev.platform_data;
>
>   	dev->iestate = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
> -	if (dev->rev>= OMAP_I2C_REV_ON_4430)
> +	if (cpu_is_omap44xx())

As explained before, you should not add any cpu_is_XXX in the driver. 
That rev field is the way to go, except that it should be populated 
using hwmod data information instead of inaccurate I2C register revision 
field.

Regards,
Benoit

