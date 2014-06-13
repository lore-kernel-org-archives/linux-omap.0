From: satish kumar <gsatish10@gmail.com>
Subject: Re: [PATCH 3/3] ASoC: simple-card: Add system-clock-id
 DT parameter to dai nodes
Date: Fri, 13 Jun 2014 17:54:37 +0530
Message-ID: <CAE0hQF1Xpu2VJDA7u6JtQLTukHnaHQfu=aHADcaOmhJcLxOcJw@mail.gmail.com>
References: <cover.1402653217.git.jsarha@ti.com>
 <c0281e720e9ef2056d3460047cf5bc5e75684abf.1402653217.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <c0281e720e9ef2056d3460047cf5bc5e75684abf.1402653217.git.jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, liam.r.girdwood@linux.intel.com, peter.ujfalusi@ti.com, detheridge@ti.com, broonie@kernel.org, bcousson@baylibre.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi

I have panda board (omap4430 <http://www.ti.com/product/omap4430>) , I am
trying to debug omap4430 <http://www.ti.com/product/omap4430> board using
trace32 [Lauterbach].

Can you please provide procedure to debug u-boot code kernel code.

I had installed trace32 and PC is identifying trace32 through serial cable.

I wants to know steps to follow for debugging the boot code and kernel code.

I have gone through net, I came to know ,  need CMM scripts [board specfic
CMM scripts]

can you please provide the same and further steps to debug the code.


Thank you in advance.

Regards

Satish.G


On Fri, Jun 13, 2014 at 3:34 PM, Jyri Sarha <jsarha@ti.com> wrote:

> Select clk_id parameters for set_sysclk calls in the card init phase.
>
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>  .../devicetree/bindings/sound/simple-card.txt      |    2 ++
>  include/sound/simple_card.h                        |    1 +
>  sound/soc/generic/simple-card.c                    |    6 +++++-
>  3 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt
> b/Documentation/devicetree/bindings/sound/simple-card.txt
> index 8460744..8877130 100644
> --- a/Documentation/devicetree/bindings/sound/simple-card.txt
> +++ b/Documentation/devicetree/bindings/sound/simple-card.txt
> @@ -72,6 +72,8 @@ Optional CPU/CODEC subnodes properties:
>                                           clock node (= common clock), or
> "system-clock-frequency"
>                                           (if system doens't support
> common clock)
>  - system-clock-direction               : "in" or "out", default "in"
> +- system-clock-id                      : u32, clk_id parameter for
> set_sysclk,
> +                                         default 0
>
>  Example 1 - single DAI link:
>
> diff --git a/include/sound/simple_card.h b/include/sound/simple_card.h
> index 6d74fef..f3c7a30 100644
> --- a/include/sound/simple_card.h
> +++ b/include/sound/simple_card.h
> @@ -19,6 +19,7 @@ struct asoc_simple_dai {
>         unsigned int fmt;
>         unsigned int sysclk;
>         int sysclk_dir;
> +       int sysclk_id;
>         int slots;
>         int slot_width;
>  };
> diff --git a/sound/soc/generic/simple-card.c
> b/sound/soc/generic/simple-card.c
> index 8dd7957..f840d9c 100644
> --- a/sound/soc/generic/simple-card.c
> +++ b/sound/soc/generic/simple-card.c
> @@ -64,7 +64,7 @@ static int __asoc_simple_card_dai_init(struct
> snd_soc_dai *dai,
>         }
>
>         if (set->sysclk) {
> -               ret = snd_soc_dai_set_sysclk(dai, 0, set->sysclk,
> +               ret = snd_soc_dai_set_sysclk(dai, set->sysclk_id,
> set->sysclk,
>                                              set->sysclk_dir);
>                 if (ret && ret != -ENOTSUPP) {
>                         dev_err(dai->dev, "simple-card: set_sysclk
> error\n");
> @@ -150,6 +150,10 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
>                         return -EINVAL;
>         }
>
> +       ret = of_property_read_u32(np, "system-clock-id", &val);
> +       if (ret == 0)
> +               dai->sysclk_id = val;
> +
>         /*
>          * dai->sysclk come from
>          *  "clocks = <&xxx>" (if system has common clock)
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
