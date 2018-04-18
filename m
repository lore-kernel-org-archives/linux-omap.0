From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH v2] regulator: Don't return or expect -errno from of_map_mode()
Date: Wed, 18 Apr 2018 09:15:33 +0200
Message-ID: <CABxcv=kx9KVJYPyRFBR5mzGgezoSmjrXpGa214E2v85YJYd1+Q@mail.gmail.com>
References: <20180418033143.208986-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180418033143.208986-1-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, David Collins <collinsd@codeaurora.org>, evgreen@chromium.org, swboyd@chromium.org, linux-omap@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Doug,

Patch looks good to me, I just have some minor comments.

On Wed, Apr 18, 2018 at 5:31 AM, Douglas Anderson <dianders@chromium.org> wrote:
> In of_get_regulation_constraints() we were taking the result of
> of_map_mode() (an unsigned int) and assigning it to an int.  We were
> then checking whether this value was -EINVAL.  Some implementers of
> of_map_mode() were returning -EINVAL (even though the return type of
> their function needed to be unsigned int) because they needed to to

s/to to/to

> signal an error back to of_get_regulation_constraints().
>
> In general in the regulator framework the mode is always referred to
> as an unsigned int.  While we could fix this to be a signed int (the
> highest value we store in there right now is 0x8), it's actually
> pretty clean to just define the regulator mode 0x0 (the lack of any
> bits set) as an invalid mode.  Let's do that.
>
> Suggested-by: Javier Martinez Canillas <javier@dowhile0.org>
> Fixes: 5e5e3a42c653 ("regulator: of: Add support for parsing initial and suspend modes")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v2:
> - Use Javier's suggestion of defining 0x0 as invalid
>
>  drivers/regulator/cpcap-regulator.c |  2 +-
>  drivers/regulator/of_regulator.c    | 15 +++++++++------
>  drivers/regulator/twl-regulator.c   |  2 +-
>  include/linux/regulator/consumer.h  |  1 +
>  4 files changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/regulator/cpcap-regulator.c b/drivers/regulator/cpcap-regulator.c
> index f541b80f1b54..bd910fe123d9 100644
> --- a/drivers/regulator/cpcap-regulator.c
> +++ b/drivers/regulator/cpcap-regulator.c
> @@ -222,7 +222,7 @@ static unsigned int cpcap_map_mode(unsigned int mode)
>         case CPCAP_BIT_AUDIO_LOW_PWR:
>                 return REGULATOR_MODE_STANDBY;
>         default:
> -               return -EINVAL;
> +               return REGULATOR_MODE_INVALID;
>         }
>  }
>
> diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
> index f47264fa1940..22c02b7a338b 100644
> --- a/drivers/regulator/of_regulator.c
> +++ b/drivers/regulator/of_regulator.c
> @@ -124,11 +124,12 @@ static void of_get_regulation_constraints(struct device_node *np,
>
>         if (!of_property_read_u32(np, "regulator-initial-mode", &pval)) {
>                 if (desc && desc->of_map_mode) {
> -                       ret = desc->of_map_mode(pval);
> -                       if (ret == -EINVAL)
> +                       unsigned int mode = desc->of_map_mode(pval);

I think the convention is to always declare local variables at the
start of the function? Although I couldn't find anything in the coding
style document...

> +
> +                       if (mode == REGULATOR_MODE_INVALID)
>                                 pr_err("%s: invalid mode %u\n", np->name, pval);
>                         else
> -                               constraints->initial_mode = ret;
> +                               constraints->initial_mode = mode;
>                 } else {
>                         pr_warn("%s: mapping for mode %d not defined\n",
>                                 np->name, pval);
> @@ -163,12 +164,14 @@ static void of_get_regulation_constraints(struct device_node *np,
>                 if (!of_property_read_u32(suspend_np, "regulator-mode",
>                                           &pval)) {
>                         if (desc && desc->of_map_mode) {
> -                               ret = desc->of_map_mode(pval);
> -                               if (ret == -EINVAL)
> +                               unsigned int mode = desc->of_map_mode(pval);
> +
> +                               mode = desc->of_map_mode(pval);

You are calling .of_map_mode and assigning the return value twice here.

If you post a new version, feel free to add:

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
Javier
