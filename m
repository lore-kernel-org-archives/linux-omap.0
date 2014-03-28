From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 49/75] ARM: l2c: fix register naming
Date: Fri, 28 Mar 2014 15:15:32 -0700
Message-ID: <20140328221532.GA30388@atomide.com>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYYH-0007GB-3M@rmk-PC.arm.linux.org.uk>
 <20140328160047.GD24308@atomide.com>
 <20140328210243.GT7528@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20140328210243.GT7528@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Barry Song <baohua@kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, linux-omap@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, Stephen Warren <swarren@wwwdotorg.org>, Srinivas Kandagatla <srinivas.kandagatla@st.com>, Linus Walleij <linus.walleij@linaro.org>, Anton Vorontsov <anton@enomsg.org>, spear-devel@list.st.com, Shiraz Hashim <shiraz.hashim@st.com>, Stuart Menefy <stuart.menefy@st.com>, Thierry Reding <thierry.reding@gmail.com>, Viresh Kumar <viresh.linux@gmail.com>, linux-samsung-soc@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, linux-tegra@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com
List-Id: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [140328 14:06]:
> On Fri, Mar 28, 2014 at 09:00:48AM -0700, Tony Lindgren wrote:
> > * Russell King <rmk+kernel@arm.linux.org.uk> [140328 08:22]:
> > > We have a mixture of different devices with different register layouts,
> > > but we group all the bits together in an opaque mess.  Split them out
> > > into those which are L2C-310 specific and ones which refer to earlier
> > > devices.  Provide full auxiliary control register definitions.
> > > 
> > > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > 
> > Acked-by: Tony Lindgren <tony@atomide.com>
> > 
> > > --- a/arch/arm/mach-omap2/omap4-common.c
> > > +++ b/arch/arm/mach-omap2/omap4-common.c
> > > @@ -212,15 +212,15 @@ static int __init omap_l2_cache_init(void)
> > >  		return -ENOMEM;
> > >  
> > >  	/* 16-way associativity, parity disabled, way size - 64KB (es2.0 +) */
> > > -	aux_ctrl = (1 << L2X0_AUX_CTRL_ASSOCIATIVITY_SHIFT) |
> > > -			(0x1 << 25) |
> > > -			(0x1 << L2X0_AUX_CTRL_NS_LOCKDOWN_SHIFT) |
> > > -			(0x1 << L2X0_AUX_CTRL_NS_INT_CTRL_SHIFT)) |
> > > -			(0x3 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT) |
> > > -			(1 << L2X0_AUX_CTRL_SHARE_OVERRIDE_SHIFT) |
> > > -			(1 << L2X0_AUX_CTRL_DATA_PREFETCH_SHIFT) |
> > > -			(1 << L2X0_AUX_CTRL_INSTR_PREFETCH_SHIFT) |
> > > -			(1 << L2X0_AUX_CTRL_EARLY_BRESP_SHIFT);
> > > +	aux_ctrl = L310_AUX_CTRL_ASSOCIATIVITY_16 |
> > > +		   L310_AUX_CTRL_CACHE_REPLACE_RR |
> > > +		   L310_AUX_CTRL_NS_LOCKDOWN |
> > > +		   L310_AUX_CTRL_NS_INT_CTRL |
> > > +		   L2C_AUX_CTRL_WAY_SIZE(3) |
> > > +		   L2C_AUX_CTRL_SHARED_OVERRIDE |
> > > +		   L310_AUX_CTRL_DATA_PREFETCH |
> > > +		   L310_AUX_CTRL_INSTR_PREFETCH |
> > > +		   L310_AUX_CTRL_EARLY_BRESP;
> > 
> > I guess eventually we can set up some common configuration mask
> > define for these kind of things?
> 
> The idea is that eventually platforms should just specify no changes to
> the auxctl configuration.  You will notice later patches remove a number
> of the above flags.

OK thanks great!

Tony
