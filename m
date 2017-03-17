From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 5/9] ARM: OMAP2+: hwmod: assign main clock from DT if
 available
Date: Fri, 17 Mar 2017 15:17:29 -0700
Message-ID: <20170317221728.GX20572@atomide.com>
References: <1489741781-12816-1-git-send-email-t-kristo@ti.com>
 <1489741781-12816-6-git-send-email-t-kristo@ti.com>
 <20170317154126.GU20572@atomide.com>
 <f7c795dc-13db-9157-cdcc-b61892cc73f9@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <f7c795dc-13db-9157-cdcc-b61892cc73f9@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>
Cc: mturquette@baylibre.com, linux-omap@vger.kernel.org, sboyd@codeaurora.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [170317 14:42]:
> On 17/03/17 17:41, Tony Lindgren wrote:
> > * Tero Kristo <t-kristo@ti.com> [170317 02:12]:
> > > -static int _init_main_clk(struct omap_hwmod *oh)
> > > +static int _init_main_clk(struct omap_hwmod *oh, struct device_node *np)
> > >  {
> > >  	int ret = 0;
> > > -	char name[MOD_CLK_MAX_NAME_LEN];
> > > -	struct clk *clk;
> > > -	static const char modck[] = "_mod_ck";
> > > -
> > > -	if (strlen(oh->name) >= MOD_CLK_MAX_NAME_LEN - strlen(modck))
> > > -		pr_warn("%s: warning: cropping name for %s\n", __func__,
> > > -			oh->name);
> > > +	struct clk *clk = NULL;
> > > +	int i;
> > > +	int count;
> > > +	const char *name;
> > > +	char clk_name[strlen("clkctrl-x") + 1];
> > > 
> > > -	strlcpy(name, oh->name, MOD_CLK_MAX_NAME_LEN - strlen(modck));
> > > -	strlcat(name, modck, MOD_CLK_MAX_NAME_LEN);
> > > +	if (np) {
> > > +		clk = of_clk_get_by_name(np, "clkctrl");
> > > +		if (IS_ERR(clk)) {
> > > +			/* Try matching by hwmod name */
> > > +			count = of_property_count_strings(np, "ti,hwmods");
> > > +			for (i = 0; i < count; i++) {
> > > +				ret = of_property_read_string_index(np,
> > > +								    "ti,hwmods",
> > > +								    i, &name);
> > > +				if (ret)
> > > +					continue;
> > > +				if (!strcmp(name, oh->name)) {
> > > +					sprintf(clk_name, "clkctrl-%d", i);
> > > +					clk = of_clk_get_by_name(np, clk_name);
> > > +				}
> > > +			}
> > > +		}
> > > +		if (!IS_ERR(clk)) {
> > > +			pr_debug("%s: mapped main_clk %s for %s\n", __func__,
> > > +				 __clk_get_name(clk), oh->name);
> > > +			oh->main_clk = __clk_get_name(clk);
> > > +			oh->_clk = clk;
> > > +			soc_ops.disable_direct_prcm(oh);
> > > +		}
> > > +	}
> > 
> > You should bail out and do nothing here if legacy "ti,hwmods" property is
> > not found. Eventually it will be the interconnect target IP wrapper module
> > that will manage the clock and populate the rest of the hwmod data
> > dynamically.
> 
> This is only for transitional support of hwmod, this patch will not be
> needed for anything later on; or you probably need to do something similar
> within the interconnect driver itself. The code still needs to care for the
> cases where we want to find the main clock based on the clock link within
> hwmod data, so bailing out early will break any boards that don't support
> the new clkctrl clocks yet.

Well we really don't want hwmod code parsing anything out of the dtb
unless "ti,hwmods" property is set. That makes moving driver like features
to live under drivers much harder.

I don't quite follow you, what breaks if you fall back to the old clock
lookup if no "ti,hwmods" is set?

Regards,

Tony
