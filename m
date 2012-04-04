From: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv5 16/18] I2C: OMAP: fix missing handling of errata I2C_OMAP3_1P153
Date: Wed, 4 Apr 2012 11:32:00 -0500
Message-ID: <4F7C7780.7040807@ti.com>
References: <1333468957-5999-1-git-send-email-shubhrajyoti@ti.com> <1333468957-5999-17-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1333468957-5999-17-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Tasslehoff Kjappfot <tasskjapp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Shubhro,

On 04/03/2012 11:02 AM, Shubhrajyoti D wrote:
> From: Tasslehoff Kjappfot<tasskjapp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> i2c_probe set the dev->errata flag, but omap_i2c_init cleared the flag again.
> Move the errata handling to i2c_probe.
>
> Signed-off-by: Tasslehoff Kjappfot<tasskjapp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Shubhrajyoti D<shubhrajyoti-l0cyMroinI0@public.gmane.org>
> ---
>   drivers/i2c/busses/i2c-omap.c |   10 +++++-----
>   1 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index c113f41..51576d6 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -431,11 +431,6 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
>   	/* Take the I2C module out of reset: */
>   	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
>
> -	dev->errata = 0;
> -
> -	if (dev->flags&  OMAP_I2C_FLAG_APPLY_ERRATA_I207)
> -		dev->errata |= I2C_OMAP_ERRATA_I207;
> -
>   	/* Enable interrupts */
>   	dev->iestate = (OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
>   			OMAP_I2C_IE_ARDY | OMAP_I2C_IE_NACK |
> @@ -1056,6 +1051,11 @@ omap_i2c_probe(struct platform_device *pdev)
>
>   	dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG)&  0xff;
>
> +	dev->errata = 0;
> +
> +	if (dev->flags&  OMAP_I2C_FLAG_APPLY_ERRATA_I207)
> +		dev->errata |= I2C_OMAP_ERRATA_I207;
> +
>   	if (dev->rev<= OMAP_I2C_REV_ON_3430_3530)
>   		dev->errata |= I2C_OMAP3_1P153;

The errata ID is not correct. I believe that 1P153 is referring to the 
section number in the errata doc and not the errata ID. The errata ID 
should be i451 in the latest OMAP34xx and OMAP36xx docs.

Please can you update this? The section number changed in the latest 
errata docs and it took me a minute to find this.

Cheers
Jon
