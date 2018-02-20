From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] pinctrl: pinctrl-single: Fix pcs_request_gpio() when
 bits_per_mux != 0
Date: Tue, 20 Feb 2018 14:56:33 +0200
Message-ID: <CAHp75VeR2LG-qAzQs2048K3pyfRkz7OKioHDNyU8bVAPsgy8ew@mail.gmail.com>
References: <1519077427-30165-1-git-send-email-david@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1519077427-30165-1-git-send-email-david@lechnology.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: David Lechner <david@lechnology.com>
Cc: Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Feb 19, 2018 at 11:57 PM, David Lechner <david@lechnology.com> wrote:
> This fixes pcs_request_gpio() in the pinctrl-single driver when
> bits_per_mux != 0. It appears this was overlooked when the multiple
> pins per register feature was added.
>
> Fixes: 4e7e8017a80e ("pinctrl: pinctrl-single: enhance to configure multiple pins of different modules")
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>
> v2 changes:
> - don't wrap Fixes: line in commit message since it is a special machine-
>   readable line.
>
> There was some discussion in v1 about using DIV_ROUND_UP(), etc. macros, but
> the consensus was to leave it as-is since it matches existing code and that
> macros can be introduced in another patch.
>
>  drivers/pinctrl/pinctrl-single.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
> index cec7537..a7c5eb3 100644
> --- a/drivers/pinctrl/pinctrl-single.c
> +++ b/drivers/pinctrl/pinctrl-single.c
> @@ -391,9 +391,25 @@ static int pcs_request_gpio(struct pinctrl_dev *pctldev,
>                         || pin < frange->offset)
>                         continue;

>                 mux_bytes = pcs->width / BITS_PER_BYTE;
> -               data = pcs->read(pcs->base + pin * mux_bytes) & ~pcs->fmask;
> -               data |= frange->gpiofunc;
> -               pcs->write(data, pcs->base + pin * mux_bytes);
> +
> +               if (pcs->bits_per_mux) {
> +                       int byte_num, offset, pin_shift;
> +
> +                       byte_num = (pcs->bits_per_pin * pin) / BITS_PER_BYTE;
> +                       offset = (byte_num / mux_bytes) * mux_bytes;
> +                       pin_shift = pin % (pcs->width / pcs->bits_per_pin) *
> +                                   pcs->bits_per_pin;
> +
> +                       data = pcs->read(pcs->base + offset);
> +                       data &= ~(pcs->fmask << pin_shift);
> +                       data |= frange->gpiofunc << pin_shift;
> +                       pcs->write(data, pcs->base + offset);
> +               } else {

> +                       data = pcs->read(pcs->base + pin * mux_bytes);
> +                       data &= ~pcs->fmask;
> +                       data |= frange->gpiofunc;
> +                       pcs->write(data, pcs->base + pin * mux_bytes);

Just an idea, you may leave this almost untouched and do calculate
pin_shift and offset in condition, like

if (...) {
 pin_shift = ...
 offset = ...
} else {
 pin_shift = 0;
 offset = pin * mux_bytes;
}

                       data = pcs->read(pcs->base + offset);
                       data &= ~(pcs->fmask << pin_shift);
                       data |= frange->gpiofunc << pin_shift;
                       pcs->write(data, pcs->base + offset);

It's also possible to split to two changes, where first introduces
that variables and their default values (see 'else' branch) and second
one introduces an if branch override.

> +               }
>                 break;

-- 
With Best Regards,
Andy Shevchenko
