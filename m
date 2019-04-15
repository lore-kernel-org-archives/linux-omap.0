From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 01/12] i2c: remove use of in_atomic()
Date: Mon, 15 Apr 2019 15:40:27 +0300
Message-ID: <CAHp75VcDxjTm2Wxuwpj6vMPvhW3TvfZp_aR9TqxbjzZ=TRSvyQ@mail.gmail.com>
References: <20190403124019.8947-1-wsa+renesas@sang-engineering.com> <20190403124019.8947-2-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403124019.8947-2-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Peter Rosin <peda@axentia.se>, Stefan Lengfeld <contact@stefanchrist.eu>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-tegra@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 3, 2019 at 3:43 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Commit cea443a81c9c ("i2c: Support i2c_transfer in atomic contexts")
> added in_atomic() to the I2C core. However, the use of in_atomic()
> outside of core kernel code is discouraged and was already[1] when this
> code was added in early 2008. The above commit was a preparation for
> commit b7a3670131c7 ("i2c-pxa: Add polling transfer"). Its commit
> message says explicitly it was added "for cases where I2C transactions
> have to occur at times interrup[t]s are disabled". So, the intention was
> 'disabled interrupts'. This matches the use cases for atomic I2C
> transfers I have seen so far: very late communication (mostly to a PMIC)
> to powerdown or reboot the system. For those cases, interrupts are
> disabled then. It doesn't seem that in_atomic() adds value.
>
> After a discussion with Peter Zijlstra[2], we came up with a better set
> of conditionals to match the use case.
>
> The I2C core will soon gain an extra callback into bus drivers
> especially for atomic transfers to make them more generic. The code
> deciding which transfer to use (atomic/non-atomic) should mimic the
> behaviour which locking to use (trylock/lock). This is why we add a
> helper for it.
>
> [1] https://lwn.net/Articles/274695/
> [2] http://patchwork.ozlabs.org/patch/1067437/
>

Reviewed-by Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/i2c/i2c-core-base.c |  2 +-
>  drivers/i2c/i2c-core.h      | 10 ++++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 38af18645133..f8502064cd6b 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -1946,7 +1946,7 @@ int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
>          *    one (discarding status on the second message) or errno
>          *    (discarding status on the first one).
>          */
> -       if (in_atomic() || irqs_disabled()) {
> +       if (i2c_in_atomic_xfer_mode()) {
>                 ret = i2c_trylock_bus(adap, I2C_LOCK_SEGMENT);
>                 if (!ret)
>                         /* I2C activity is ongoing. */
> diff --git a/drivers/i2c/i2c-core.h b/drivers/i2c/i2c-core.h
> index 37576f50fe20..9d8526415b26 100644
> --- a/drivers/i2c/i2c-core.h
> +++ b/drivers/i2c/i2c-core.h
> @@ -29,6 +29,16 @@ extern int           __i2c_first_dynamic_bus_num;
>
>  int i2c_check_7bit_addr_validity_strict(unsigned short addr);
>
> +/*
> + * We only allow atomic transfers for very late communication, e.g. to send
> + * the powerdown command to a PMIC. Atomic transfers are a corner case and not
> + * for generic use!
> + */
> +static inline bool i2c_in_atomic_xfer_mode(void)
> +{
> +       return system_state > SYSTEM_RUNNING && irqs_disabled();
> +}
> +
>  #ifdef CONFIG_ACPI
>  const struct acpi_device_id *
>  i2c_acpi_match_device(const struct acpi_device_id *matches,
> --
> 2.11.0
>


-- 
With Best Regards,
Andy Shevchenko
