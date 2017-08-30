From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH v3] mfd: tps65217: Introduce dependency on CONFIG_OF
Date: Wed, 30 Aug 2017 10:05:42 +0200
Message-ID: <CABxcv=kMOJsPEC-x_eRtt-K76sF5-tFnC7ye6FuBh4WC_f2KRQ@mail.gmail.com>
References: <1504072208-28888-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1504072208-28888-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: Lee Jones <lee.jones@linaro.org>, =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-omap@vger.kernel.org

Hello Keerthy,

On Wed, Aug 30, 2017 at 7:50 AM, Keerthy <j-keerthy@ti.com> wrote:
> Currently the driver boots only via device tree hence add a
> dependency on CONFIG_OF. This leaves with a bunch of unused code
> so clean that up. This patch also makes use of probe_new function
> in place of the probe function so as to avoid passing i2c_device_id.
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>
> Changes in v3:
>
>   * Added more details to commit log.
>   * No changes in code. Rebased to latest next branch.
>
> Changes in v2:
>
>   * Cleaned up chip_id and data attached to the match.
>   * Cleaned up i2c_dev_id
>   * dropped the rest of the patches in series for now
>
> Boot tested and checked for regulator registrations on am335x-boneblack
>

Did you check building as a module? Autoload won't work if you remove
the I2C device ID table.

[snip]

>
> -static const struct i2c_device_id tps65217_id_table[] = {
> -       {"tps65217", TPS65217},
> -       { /* sentinel */ }
> -};
> -MODULE_DEVICE_TABLE(i2c, tps65217_id_table);
> -

Unfortunately this can't be removed yet. We are getting there but
still some patches need to land.

Rest of the patch looks good, so if you keep the I2C device ID table
feel free to add:

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
Javier
