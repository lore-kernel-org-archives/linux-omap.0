From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [RFC 1/8] RFC: CLK: OMAP: Add basic infrastructure for OMAP clocks
Date: Fri, 22 Mar 2013 09:47:56 -0700
Message-ID: <20130322164756.834.65517@quantum>
References: <1363887347-4686-1-git-send-email-t-kristo@ti.com>
 <1363887347-4686-2-git-send-email-t-kristo@ti.com>
 <20130321185051.834.97551@quantum> <1363941548.15426.181.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1363941548.15426.181.camel@sokoban>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: t-kristo@ti.comTero Kristo <t-kristo@ti.com>
Cc: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@linaro.org
List-Id: linux-omap@vger.kernel.org

Quoting Tero Kristo (2013-03-22 01:39:08)
> On Thu, 2013-03-21 at 11:50 -0700, Mike Turquette wrote:
> > Quoting Tero Kristo (2013-03-21 10:35:40)
> > > This patch adds basic infrastructure support for registering clocks
> > > under common clock framework. This patch is done in preparation for
> > > moving clock data from arch/arm/mach-omap2/ folder under /drivers/clk/omap.
> > > 
> > > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > > Cc: Mike Turquette <mturquette@linaro.org>
> > 
> > Thanks for taking a crack at this Tero!  This is a great step towards
> > getting rid of clk-private.h.
> 
> Hi Mike,
> 
> Thanks for the quick comments.
> 
> > 
> > Regarding the long-term roadmap of the omap clock code:
> > 
> > In general all of the changes to the omap clock code for using the
> > common struct clk have been very incremental.  We still have the old
> > legacy struct clk definition, the name of that struct was changed to
> > clk_hw_omap, but it is still a fairly large, monolithic structure.  Are
> > there plans to break the clock types up into smaller, more focused clock
> > types?  E.g. get rid of struct dpll_data and have a dedicated dpll clock
> > type.
> 
> I think this sounds like a fair approach to me, currently the struct is
> huge and we register almost everything under it. This RFC set only tries
> to tackle with the most immediate problem, removing the dependency to
> clk-private.h and moving the clock data out from mach-omap2.
> 
> > 
> > The question above is not reason to block this patch since it is a
> > fairly large refactoring effort, but it is something to consider.
> > 
> > Some comments below.
> > 
> > <snip>
> > 
> > > +struct omap_clk {
> > > +       u16                             cpu;
> > > +       const char                      *dev_id;
> > > +       const char                      *con_id;
> > > +       struct omap_init_clk            *clk;
> > > +};
> > > +
> > > +#define CLK(dev, con, ck, cp)          \
> > > +       {                               \
> > > +               .cpu = cp,              \
> > > +               .dev_id = dev,          \
> > > +               .con_id = con,          \
> > > +               .clk = ck,              \
> > > +       }       
> > > +
> > 
> > IS omap_clk and CLK really necessary today?  I thought that the move to
> > separate clocks out by tables got rid of this macro/structure?
> 
> Well, it looks like we have a few clocks which actually use same clock
> nodes, like dpll_mpu_ck is declared twice with different dev / con ids
> here. It is possible to get rid of this in most cases and incorporate
> the data from omap_clk to the omap_init_clk. Maybe for the special cases
> we can just add a static clk registration in the code.
> 
> > 
> > > +#define OMAP_CLK_FIXED_RATE(_name, _flags, _rate, _ignore)     \
> > > +       static struct omap_init_clk _name __initdata = {        \
> > > +               .name = #_name,                                 \
> > > +               .clk_flags = _flags,                            \
> > > +               .rate = _rate,                                  \
> > > +               .clk_register = omap_clk_register_fixed_rate,   \
> > > +       };
> > > +
> > 
> > These macros are unreadable.  They were originally born out of the nasty
> > clk-private.h stuff which included forward declarations of struct clk
> > and all sorts of ugliness.  I know it saves you LoC to use them now but
> > I really prefer to use designated initializers for the sake of
> > readability.  Do you plan to convert the OMAP clock code back to how it
> > was, pre-macros?
> 
> Yea, I think we should do this eventually once we also split the
> different clock types to their own init structs. Then we can get rid of
> these macros at the same point. However, I decided not to do this at
> this step, as this simple data conversion allows us to convert also
> omap2 / omap3 clocks rather easily, for which we don't have auto
> generation available.
> 

Cool.  As long as there is a plan to clean this stuff up in the future
then I'm happy with this incremental approach.

Hopefully I'll have time to test this out on my omap hardware next week.

Regards,
Mike

> -Tero
