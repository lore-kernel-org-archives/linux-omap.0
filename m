From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [Patch 1/3] clk: fix clk_mux_get_parent return's signed value
Date: Wed, 29 May 2013 00:21:18 -0700
Message-ID: <20130529072118.6058.14433@quantum>
References: <1367475929-32166-1-git-send-email-ambresh@ti.com>
 <1367475929-32166-2-git-send-email-ambresh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1367475929-32166-2-git-send-email-ambresh@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
Cc: Nishanth Menon <nm@ti.com>, Rajendra <rnayak@ti.com>, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, Ambresh K <ambresh@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Quoting Ambresh K (2013-05-01 23:25:27)
> From: Ambresh K <ambresh@ti.com>
> 
> If for some reason, the value read from clksel field return
> erroneous due to HW bug or improper configuration, then
> clk_mux_get_parent should return appropriate error's.
> 

clksel is an omap-centric term.  How about:

"clk_mux_get_parent should return an error if the value read from the
register is erroneous."

The general approach looks good to me.  Can you submit a V2 which
removes all of the clksel-isms and updates definitions for .get_parent
functions to avoid the warnings you mentioned in the cover letter?  You
might find cocinelle useful for that last task.

Regards,
Mike

> Currently if the value read is greater than the number of
> available parents clk_mux_get_parent return's signed error
> which will result in NULL pointer dereferencing in the
> calling functions.
> 
> Signed-off-by: Ambresh K <ambresh@ti.com>
> ---
>  drivers/clk/clk-mux.c        |    2 +-
>  drivers/clk/clk.c            |   12 +++++++++++-
>  include/linux/clk-provider.h |    4 ++--
>  3 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
> index 25b1734..be0857e 100644
> --- a/drivers/clk/clk-mux.c
> +++ b/drivers/clk/clk-mux.c
> @@ -29,7 +29,7 @@
>  
>  #define to_clk_mux(_hw) container_of(_hw, struct clk_mux, hw)
>  
> -static u8 clk_mux_get_parent(struct clk_hw *hw)
> +static int clk_mux_get_parent(struct clk_hw *hw)
>  {
>         struct clk_mux *mux = to_clk_mux(hw);
>         int num_parents = __clk_get_num_parents(hw->clk);
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 934cfd1..c187321 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1281,7 +1281,7 @@ EXPORT_SYMBOL_GPL(clk_get_parent);
>  static struct clk *__clk_init_parent(struct clk *clk)
>  {
>         struct clk *ret = NULL;
> -       u8 index;
> +       int index;
>  
>         /* handle the trivial cases */
>  
> @@ -1309,6 +1309,11 @@ static struct clk *__clk_init_parent(struct clk *clk)
>          */
>  
>         index = clk->ops->get_parent(clk->hw);
> +       if (index < 0) {
> +               pr_err("%s: clk(%s) invalid parent clk_sel index(%d)\n",
> +                               __func__, clk->name, index);
> +               goto out;
> +       }
>  
>         if (!clk->parents)
>                 clk->parents =
> @@ -1632,6 +1637,11 @@ int __clk_init(struct device *dev, struct clk *clk)
>         hlist_for_each_entry_safe(orphan, tmp2, &clk_orphan_list, child_node) {
>                 if (orphan->ops->get_parent) {
>                         i = orphan->ops->get_parent(orphan->hw);
> +                       if (i < 0) {
> +                               pr_err("%s: orphan clk(%s) invalid parent\n",
> +                                               __func__, orphan->name);
> +                               continue;
> +                       }
>                         if (!strcmp(clk->name, orphan->parent_names[i]))
>                                 __clk_reparent(orphan, clk);
>                         continue;
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 1186098..96337a1 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -80,7 +80,7 @@ struct clk_hw;
>   *             supported by the clock.
>   *
>   * @get_parent:        Queries the hardware to determine the parent of a clock.  The
> - *             return value is a u8 which specifies the index corresponding to
> + *             return value which specifies the index corresponding to
>   *             the parent clock.  This index can be applied to either the
>   *             .parent_names or .parents arrays.  In short, this function
>   *             translates the parent value read from hardware into an array
> @@ -127,7 +127,7 @@ struct clk_ops {
>         long            (*round_rate)(struct clk_hw *hw, unsigned long,
>                                         unsigned long *);
>         int             (*set_parent)(struct clk_hw *hw, u8 index);
> -       u8              (*get_parent)(struct clk_hw *hw);
> +       int             (*get_parent)(struct clk_hw *hw);
>         int             (*set_rate)(struct clk_hw *hw, unsigned long,
>                                     unsigned long);
>         void            (*init)(struct clk_hw *hw);
> -- 
> 1.7.4.1
