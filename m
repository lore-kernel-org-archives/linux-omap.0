From: Mike Turquette <mturquette@ti.com>
Subject: Re: [PATCH] Don't mark shared helper functions as inline
Date: Mon, 26 Nov 2012 11:57:42 -0800
Message-ID: <20121126195742.21126.16500@nucleus>
References: <1353957609-1295-1-git-send-email-Russ.Dill@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1353957609-1295-1-git-send-email-Russ.Dill@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Russ Dill <Russ.Dill@ti.com>
List-Id: linux-omap@vger.kernel.org

Quoting Russ Dill (2012-11-26 11:20:09)
> The helper functions that access the opaque struct clk should
> not be marked inline since they are contained in clk.c, but expected
> to be used by other compilation units. This causes compile errors
> under gcc-4.7
>=20
> In file included from arch/arm/mach-omap2/clockdomain.c:25:0:
> arch/arm/mach-omap2/clockdomain.c: In function =E2=80=98clkdm_clk_dis=
able=E2=80=99:
> include/linux/clk-provider.h:338:12: error: inlining failed in call t=
o always_inline =E2=80=98__clk_get_enable_count=E2=80=99: function body=
 not available
> arch/arm/mach-omap2/clockdomain.c:1001:28: error: called from here
> make[1]: *** [arch/arm/mach-omap2/clockdomain.o] Error 1
> make: *** [arch/arm/mach-omap2] Error 2
>=20

Hi Russ,

A fix for this was merged into rc7.  See 93532c8a, "clk: remove inline
usage from clk-provider.h".

Regardless, I'm still considering this patch.  I've heard many times
that we should trust the compiler to optimize for us and some folks loo=
k
down on inlining in general.  If anyone has an opinion on removing
inlines from the common clk core then please do speak up.

Russ, can you update to the latest rc and verify if that fix is enough
for you?

Regards,
Mike

>=20
> Signed-off-by: Russ Dill <Russ.Dill@ti.com>
> ---
>  drivers/clk/clk.c            | 14 +++++++-------
>  include/linux/clk-provider.h |  4 ++--
>  2 files changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 56e4495e..ed01746 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -249,32 +249,32 @@ late_initcall(clk_disable_unused);
> =20
>  /***    helper functions   ***/
> =20
> -inline const char *__clk_get_name(struct clk *clk)
> +const char *__clk_get_name(struct clk *clk)
>  {
>         return !clk ? NULL : clk->name;
>  }
> =20
> -inline struct clk_hw *__clk_get_hw(struct clk *clk)
> +struct clk_hw *__clk_get_hw(struct clk *clk)
>  {
>         return !clk ? NULL : clk->hw;
>  }
> =20
> -inline u8 __clk_get_num_parents(struct clk *clk)
> +u8 __clk_get_num_parents(struct clk *clk)
>  {
>         return !clk ? -EINVAL : clk->num_parents;
>  }
> =20
> -inline struct clk *__clk_get_parent(struct clk *clk)
> +struct clk *__clk_get_parent(struct clk *clk)
>  {
>         return !clk ? NULL : clk->parent;
>  }
> =20
> -inline int __clk_get_enable_count(struct clk *clk)
> +int __clk_get_enable_count(struct clk *clk)
>  {
>         return !clk ? -EINVAL : clk->enable_count;
>  }
> =20
> -inline int __clk_get_prepare_count(struct clk *clk)
> +int __clk_get_prepare_count(struct clk *clk)
>  {
>         return !clk ? -EINVAL : clk->prepare_count;
>  }
> @@ -300,7 +300,7 @@ out:
>         return ret;
>  }
> =20
> -inline unsigned long __clk_get_flags(struct clk *clk)
> +unsigned long __clk_get_flags(struct clk *clk)
>  {
>         return !clk ? -EINVAL : clk->flags;
>  }
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provide=
r.h
> index c127315..f9f5e9e 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -335,8 +335,8 @@ const char *__clk_get_name(struct clk *clk);
>  struct clk_hw *__clk_get_hw(struct clk *clk);
>  u8 __clk_get_num_parents(struct clk *clk);
>  struct clk *__clk_get_parent(struct clk *clk);
> -inline int __clk_get_enable_count(struct clk *clk);
> -inline int __clk_get_prepare_count(struct clk *clk);
> +int __clk_get_enable_count(struct clk *clk);
> +int __clk_get_prepare_count(struct clk *clk);
>  unsigned long __clk_get_rate(struct clk *clk);
>  unsigned long __clk_get_flags(struct clk *clk);
>  int __clk_is_enabled(struct clk *clk);
> --=20
> 1.8.0
