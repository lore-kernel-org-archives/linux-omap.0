From: Stefan Lengfeld <contact@stefanchrist.eu>
Subject: Re: [PATCH 01/12] i2c: remove use of in_atomic()
Date: Mon, 15 Apr 2019 23:55:46 +0200
Message-ID: <20190415215546.xr7aftkahcu4ygak@porty>
References: <20190403124019.8947-1-wsa+renesas@sang-engineering.com>
 <20190403124019.8947-2-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190403124019.8947-2-wsa+renesas@sang-engineering.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-i2c@vger.kernel.org, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, Peter Rosin <peda@axentia.se>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Wolfram,

On Wed, Apr 03, 2019 at 02:40:08PM +0200, Wolfram Sang wrote:
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
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Tested-by: Stefan Lengfeld <contact@stefanchrist.eu>

snipped

> diff --git a/drivers/i2c/i2c-core.h b/drivers/i2c/i2c-core.h
> index 37576f50fe20..9d8526415b26 100644
> --- a/drivers/i2c/i2c-core.h
> +++ b/drivers/i2c/i2c-core.h
> @@ -29,6 +29,16 @@ extern int		__i2c_first_dynamic_bus_num;
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
> +	return system_state > SYSTEM_RUNNING && irqs_disabled();
> +}

I agree that this code is a lot better than the previous
'irqs_disabled() || in_atomic()'. It also makes clear that the atomic
I2C transfers is only meant for late shutdown I2C communcation.


After I read the article https://lwn.net/Articles/274695/ again I
nevertheless cannot really say whether the usage of 'irqs_disabled()' is
the theoretical correct approach. The article states explicitly that
only the caller can really decided whether the operation should be
atomic or not.

Recap from previous discussions:

But then you have to patch every call site to use either a new function
like 'i2c_transfer_atomic()' or the extend I2C message flags. And mostly
also supported this trough regmap and maybe other translation layers,
which seems unpractical, may breaking existing usages and maybe not
worth the hassle.

For me this patch seems good and I don't know better.

Kind regards,
Stefan
