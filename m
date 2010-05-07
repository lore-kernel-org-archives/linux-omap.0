From: Aaro Koskinen <aaro.koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH]i2c-omap: pass scll, sclh through board file for Errata
 i585
Date: Fri, 07 May 2010 12:28:22 +0300
Message-ID: <4BE3DD36.10308@nokia.com>
References: <1273214105-22894-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1273214105-22894-1-git-send-email-balajitk-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "ext balajitk-l0cyMroinI0@public.gmane.org" <balajitk-l0cyMroinI0@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "nm-l0cyMroinI0@public.gmane.org" <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

balajitk-l0cyMroinI0@public.gmane.org wrote:
> From: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
> 
> Errata ID: i535 - I2C1 to 3 SCL low period is shorter in FS mode
> Due to IO cell influence, I2C1 to 3 SCL low period can be shorter than expected.
> As a result, I2C AC timing (SCL minimum low period) in FS mode may not meet
> the timing configured by software.
> 
> I2C1 to 3, SCL low period is programmable and proper adjustments
> to the SCLL/HSSCLL values can avoid the issue.
> 
> This patch provides flexibility to control tLOW, tHIGH for different boards.
> scll, sclh values are to be provide in board data
> for differents modes (standard, fast and high speed mode)
> as the scl rate (I2C bus speed) can be changed by bootargs.

This patch is very much needed, because these values are highly board specific.
At the moment we are forced to patch the i2c bus driver when finetuning the I2C
timings for a certain board, which is ugly.

However, I have comment one about the implementation:

> @@ -451,24 +458,47 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
> 
>                         /* For first phase of HS mode */
>                         scl = internal_clk / 400;
> -                       fsscll = scl - (scl / 3) - 7;
> -                       fssclh = (scl / 3) - 5;
> +                       if ((pdata->hs_phase1.scll > 7) &&
> +                                       (pdata->hs_phase1.sclh > 5)) {
> +                               fsscll = pdata->hs_phase1.scll - 7;
> +                               fssclh = pdata->hs_phase1.sclh - 5;
> +                       } else {
> +                               fsscll = scl - (scl / 3) - 7;
> +                               fssclh = (scl / 3) - 5;
> +                       }
>                         /* For second phase of HS mode */
>                         scl = fclk_rate / dev->speed;
> -                       hsscll = scl - (scl / 3) - 7;
> -                       hssclh = (scl / 3) - 5;
> +                       if ((pdata->hs_phase2.scll > 7) &&
> +                                       (pdata->hs_phase2.sclh > 5)) {
> +                               hsscll = pdata->hs_phase2.scll - 7;
> +                               hssclh = pdata->hs_phase2.sclh - 5;
> +                       } else {
> +                               hsscll = scl - (scl / 3) - 7;
> +                               hssclh = (scl / 3) - 5;
> +                       }
>                 } else if (dev->speed > 100) {
>                         unsigned long scl;
> 
>                         /* Fast mode */
>                         scl = internal_clk / dev->speed;
> -                       fsscll = scl - (scl / 3) - 7;
> -                       fssclh = (scl / 3) - 5;
> +                       if ((pdata->fast.scll > 7) && (pdata->fast.sclh > 5)) {
> +                               fsscll = pdata->fast.scll - 7;
> +                               fssclh = pdata->fast.sclh - 5;
> +                       } else {
> +                               fsscll = scl - (scl / 3) - 7;
> +                               fssclh = (scl / 3) - 5;
> +                       }
>                 } else {
>                         /* Standard mode */
> -                       fsscll = internal_clk / (dev->speed * 2) - 7;
> -                       fssclh = internal_clk / (dev->speed * 2) - 5;
> +                       if ((pdata->standard.scll > 7) &&
> +                                       (pdata->standard.sclh > 5)) {
> +                               fsscll = pdata->standard.scll - 7;
> +                               fssclh = pdata->standard.sclh - 5;
> +                       } else {
> +                               fsscll = internal_clk / (dev->speed * 2) - 7;
> +                               fssclh = internal_clk / (dev->speed * 2) - 5;
> +                       }

I think it would be simpler if we move these calcuations into a function.
E.g. something like:

	if (dev->speed > 400) {
		/* HS mode */
		pdata->set_scl(internal_clk, 400, &fsscll, &fssclh);
		pdata->set_scl(fclk_rate, dev->speed, &hsscll, &hssclh);
	} else {
		/* Fast & standard mode */
		pdata->set_scl(internal_clk, dev->speed, &fsscll, &fssclh);
	}

Then the default function would be something like:

static void omap_i2c_default_scl(unsigned clk, unsigned speed, u16 *scll, u16 *sclh)
{
	if (speed > 100) {
		/* Fast & HS modes */
		unsigned scl = clk / speed;

		*scll = scl - (scl / 3) - 7;
		*sclh = (scl / 3) - 5;
	} else {
		/* Standard mode */
		*scll = clk / (speed * 2) - 7;
		*scll = clk / (speed * 2) - 5;
	}
}

And the platform data would just provide a board-specific function if needed.

A.
