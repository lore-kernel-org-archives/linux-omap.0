From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [Patch 3/3] clk: Avoid re-parenting orphan clk's having invalid
 parent index.
Date: Tue, 11 Jun 2013 15:07:44 -0700
Message-ID: <20130611220744.8816.8856@quantum>
References: <1367475929-32166-1-git-send-email-ambresh@ti.com>
 <1367475929-32166-4-git-send-email-ambresh@ti.com>
 <20130529071809.6058.24017@quantum> <51AD9450.5090107@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51AD9450.5090107@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ambresh K <ambresh@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Rajendra <rnayak@ti.com>, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Quoting Ambresh K (2013-06-04 00:16:32)
> On Wednesday 29 May 2013 12:48 PM, Mike Turquette wrote:
> > Quoting Ambresh K (2013-05-01 23:25:29)
> >> From: Ambresh K <ambresh@ti.com>
> >>
> >> Add orhan clk nodes having invalid parent index to list and use
> >> the list to skip re-parenting orphan clk having invalid parents.
> >>
> >> Signed-off-by: Ambresh K <ambresh@ti.com>
> >> ---
> >>  drivers/clk/clk.c |   21 +++++++++++++++++++--
> >>  1 files changed, 19 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> >> index f4d2c73..54d2aa3 100644
> >> --- a/drivers/clk/clk.c
> >> +++ b/drivers/clk/clk.c
> >> @@ -32,6 +32,7 @@ static int enable_refcnt;
> >>  
> >>  static HLIST_HEAD(clk_root_list);
> >>  static HLIST_HEAD(clk_orphan_list);
> >> +static HLIST_HEAD(clk_orphan_invalid_parent);
> > 
> > Why not re-use the clk_orphan_list?  Having an invalid value programmed
> > into the hardware for selecting a parent essetially orphans a clock
> > from a software point of view.  Is there a specific need for the new
> > list?
> 
> Sorry for not being descriptive in commit message.  
> 
> a) Avoids unnecessary re-parenting cycle for orphan clock's with invalid parent for every clock
> 

True, but this is a minor optimisation.  If this is a big optimization
for you then you really need to fix your bootloader.  We shouldn't be
optimizing slow error paths just because we refuse to fix the errors.

> b) With patch [1/3], after a clk with invalid parent was encountered, for every clk registered thereafter seeing following logs. 
> <Snippet>
> [    0.000000] __clk_init: orphan clk(gpu_core_gclk_mux) invalid parent
> [    0.000000] __clk_init: orphan clk(gpu_core_gclk_mux) invalid parent
> [    0.000000] __clk_init: orphan clk(gpu_core_gclk_mux) invalid parent
> [    0.000000] __clk_init: orphan clk(gpu_core_gclk_mux) invalid parent
> [    0.000000] __clk_init: orphan clk(gpu_core_gclk_mux) invalid parent
> [    0.000000] __clk_init: orphan clk(gpu_core_gclk_mux) invalid parent
> [    0.000000] __clk_init: orphan clk(gpu_core_gclk_mux) invalid parent
> [    0.000000] __clk_init: orphan clk(gpu_core_gclk_mux) invalid parent  
> 
> Please advice, if can be handled better. 
> 

First off, I don't think we should create new structures to work around
bugs that should be fixed.  pr_err_once() will let us know something is
wrong and won't flood the log.  Even then I'm inclined to say that
flooding the log is OK and will motivate you to fix up your bootloader.
Error prints are there for a reason.

Secondly, I spent like 10 minutes looking at this code and I'm still
confused.  For a clock with invalid parent programming, are you adding
it to BOTH the orphan list and the has_invalid_parent list?  Why?  Is
this just avoid the spurious prints?  For everyone clock registered we
walk the list of orphans to see if that orphan can be reparented.  This
patch adds another nested list walk (likely a short list) for each of
those orphans in the first list walk, so it starts to look like O(n^2).
I don't like it.

I think the first two patches in the series look good, but unless I am
misunderstanding this patch I feel that it can be dropped entirely.

Regards,
Mike

> Thanks, 
> Ambresh
> 
> 
> > 
> > Regards,
> > Mike
> > 
> >>  static LIST_HEAD(clk_notifier_list);
> >>  
> >>  /***           locking             ***/
> >> @@ -1532,8 +1533,8 @@ EXPORT_SYMBOL_GPL(clk_set_parent);
> >>   */
> >>  int __clk_init(struct device *dev, struct clk *clk)
> >>  {
> >> -       int i, ret = 0;
> >> -       struct clk *orphan;
> >> +       int i, ret = 0, skip = 0;
> >> +       struct clk *orphan, *has_invalid_parent;
> >>         struct hlist_node *tmp2;
> >>  
> >>         if (!clk)
> >> @@ -1639,11 +1640,27 @@ int __clk_init(struct device *dev, struct clk *clk)
> >>                 if (!strcmp(clk->name, orphan->name))
> >>                         continue;
> >>  
> >> +               /* Skip iteration if orphan has invalid parent */
> >> +               hlist_for_each_entry(has_invalid_parent,
> >> +                               &clk_orphan_invalid_parent, child_node) {
> >> +                       if (!strcmp(orphan->name, has_invalid_parent->name)) {
> >> +                               skip = 1;
> >> +                               break;
> >> +                       }
> >> +               }
> >> +
> >> +               if (skip) {
> >> +                       skip = 0;
> >> +                       continue;
> >> +               }
> >> +
> >>                 if (orphan->ops->get_parent) {
> >>                         i = orphan->ops->get_parent(orphan->hw);
> >>                         if (i < 0) {
> >>                                 pr_err("%s: orphan clk(%s) invalid parent\n",
> >>                                                 __func__, orphan->name);
> >> +                               hlist_add_head(&orphan->child_node,
> >> +                                               &clk_orphan_invalid_parent);
> >>                                 continue;
> >>                         }
> >>                         if (!strcmp(clk->name, orphan->parent_names[i]))
> >> -- 
> >> 1.7.4.1
> >
