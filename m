From: Tasslehoff Kjappfot <tasskjapp@gmail.com>
Subject: Re: [PATCH] i2c: fix missing handling of errata I2C_OMAP3_1P153
Date: Thu, 09 Feb 2012 12:37:54 +0100
Message-ID: <4F33B012.1050804@gmail.com>
References: <1328538811-13097-1-git-send-email-tasskjapp@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:50020 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752360Ab2BILhg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Feb 2012 06:37:36 -0500
Received: by eekc14 with SMTP id c14so549371eek.19
        for <linux-omap@vger.kernel.org>; Thu, 09 Feb 2012 03:37:35 -0800 (PST)
In-Reply-To: <1328538811-13097-1-git-send-email-tasskjapp@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On 02/06/2012 03:33 PM, tasskjapp@gmail.com wrote:
> From: Tasslehoff Kjappfot<tasskjapp@gmail.com>
>
> i2c_prope set the dev->errata flag, but omap_i2c_init cleared the flag again. Move the errata handling to i2c_init.
>
> Signed-off-by: Tasslehoff Kjappfot<tasskjapp@gmail.com>
> ---
>   drivers/i2c/busses/i2c-omap.c |    7 ++++---
>   1 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 801df60..ecaa60d 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -473,6 +473,10 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
>   	if (dev->flags&  OMAP_I2C_FLAG_APPLY_ERRATA_I207)
>   		dev->errata |= I2C_OMAP_ERRATA_I207;
>
> +	if (dev->rev<= OMAP_I2C_REV_ON_3430)
> +		dev->errata |= I2C_OMAP3_1P153;
> +
> +
>   	/* Enable interrupts */
>   	dev->iestate = (OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
>   			OMAP_I2C_IE_ARDY | OMAP_I2C_IE_NACK |
> @@ -1058,9 +1062,6 @@ omap_i2c_probe(struct platform_device *pdev)
>
>   	dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG)&  0xff;
>
> -	if (dev->rev<= OMAP_I2C_REV_ON_3430)
> -		dev->errata |= I2C_OMAP3_1P153;
> -
>   	if (!(dev->flags&  OMAP_I2C_FLAG_NO_FIFO)) {
>   		u16 s;
>

Not the easiest patch to test, but it would be nice if someone could 
review it.

- Tasslehoff
