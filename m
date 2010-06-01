From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC] [PATCH v3 1/4] OMAP4: Keyboard controller support
Date: Tue, 01 Jun 2010 10:45:56 -0700
Message-ID: <87hblmbq97.fsf@deeprootsystems.com>
References: <27F9C60D11D683428E133F85D2BB4A53043E537F73@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A53043E537F73@dlee03.ent.ti.com> (Abraham Arce's message of "Mon\, 31 May 2010 16\:44\:02 -0500")
Sender: linux-input-owner@vger.kernel.org
To: "Arce, Abraham" <x0066660@ti.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
List-Id: linux-omap@vger.kernel.org

"Arce, Abraham" <x0066660@ti.com> writes:

> OMAP4 keyboard controller includes:
>   - built-in scanning algorithm
>   - debouncing feature
>
> Driver implementation is based on matrix_keypac.c
>
> Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
> Signed-off-by: Abraham Arce <x0066660@ti.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  arch/arm/plat-omap/include/plat/omap4-keypad.h |   23 ++
>  drivers/input/keyboard/Kconfig                 |   10 +
>  drivers/input/keyboard/Makefile                |    1 +
>  drivers/input/keyboard/omap4-keypad.c          |  288 ++++++++++++++++++++++++
>  4 files changed, 322 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-omap/include/plat/omap4-keypad.h
>  create mode 100644 drivers/input/keyboard/omap4-keypad.c
>
> diff --git a/arch/arm/plat-omap/include/plat/omap4-keypad.h b/arch/arm/plat-omap/include/plat/omap4-keypad.h
> new file mode 100644
> index 0000000..7a6ce70
> --- /dev/null
> +++ b/arch/arm/plat-omap/include/plat/omap4-keypad.h
> @@ -0,0 +1,23 @@
> +#ifndef ARCH_ARM_PLAT_OMAP4_KEYPAD_H
> +#define ARCH_ARM_PLAT_OMAP4_KEYPAD_H
> +
> +#include <linux/input/matrix_keypad.h>
> +
> +struct omap4_keypad_platform_data {
> +	const struct matrix_keymap_data *keymap_data;
> +
> +	u8 rows;
> +	u8 cols;
> +
> +	u16 irq;
> +	void __iomem *base;
> +
> +	int (*device_enable) (struct platform_device *pdev);
> +	int (*device_shutdown) (struct platform_device *pdev);
> +	int (*device_idle) (struct platform_device *pdev);
> +};

Abraham,

Please drop these from this driver.  First, they are not used in the driver,
and 2nd, new drivers should use the runtime PM API for this as needed.

Kevin
