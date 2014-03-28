From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 49/75] ARM: l2c: fix register naming
Date: Fri, 28 Mar 2014 21:02:43 +0000
Message-ID: <20140328210243.GT7528@n2100.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk> <E1WTYYH-0007GB-3M@rmk-PC.arm.linux.org.uk> <20140328160047.GD24308@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:41901 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752922AbaC1VD1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Mar 2014 17:03:27 -0400
Content-Disposition: inline
In-Reply-To: <20140328160047.GD24308@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, Anton Vorontsov <anton@enomsg.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Barry Song <baohua@kernel.org>, Viresh Kumar <viresh.linux@gmail.com>, Shiraz Hashim <shiraz.hashim@st.com>, Srinivas Kandagatla <srinivas.kandagatla@st.com>, Stuart Menefy <stuart.menefy@st.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, linux-omap@vger.kernel.org, spear-devel@list.st.com, kernel@stlinux.com, linux-tegra@vger.kernel.org, linux-samsung-soc@vger.kernel.org

On Fri, Mar 28, 2014 at 09:00:48AM -0700, Tony Lindgren wrote:
> * Russell King <rmk+kernel@arm.linux.org.uk> [140328 08:22]:
> > We have a mixture of different devices with different register layouts,
> > but we group all the bits together in an opaque mess.  Split them out
> > into those which are L2C-310 specific and ones which refer to earlier
> > devices.  Provide full auxiliary control register definitions.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Acked-by: Tony Lindgren <tony@atomide.com>
> 
> > --- a/arch/arm/mach-omap2/omap4-common.c
> > +++ b/arch/arm/mach-omap2/omap4-common.c
> > @@ -212,15 +212,15 @@ static int __init omap_l2_cache_init(void)
> >  		return -ENOMEM;
> >  
> >  	/* 16-way associativity, parity disabled, way size - 64KB (es2.0 +) */
> > -	aux_ctrl = (1 << L2X0_AUX_CTRL_ASSOCIATIVITY_SHIFT) |
> > -			(0x1 << 25) |
> > -			(0x1 << L2X0_AUX_CTRL_NS_LOCKDOWN_SHIFT) |
> > -			(0x1 << L2X0_AUX_CTRL_NS_INT_CTRL_SHIFT)) |
> > -			(0x3 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT) |
> > -			(1 << L2X0_AUX_CTRL_SHARE_OVERRIDE_SHIFT) |
> > -			(1 << L2X0_AUX_CTRL_DATA_PREFETCH_SHIFT) |
> > -			(1 << L2X0_AUX_CTRL_INSTR_PREFETCH_SHIFT) |
> > -			(1 << L2X0_AUX_CTRL_EARLY_BRESP_SHIFT);
> > +	aux_ctrl = L310_AUX_CTRL_ASSOCIATIVITY_16 |
> > +		   L310_AUX_CTRL_CACHE_REPLACE_RR |
> > +		   L310_AUX_CTRL_NS_LOCKDOWN |
> > +		   L310_AUX_CTRL_NS_INT_CTRL |
> > +		   L2C_AUX_CTRL_WAY_SIZE(3) |
> > +		   L2C_AUX_CTRL_SHARED_OVERRIDE |
> > +		   L310_AUX_CTRL_DATA_PREFETCH |
> > +		   L310_AUX_CTRL_INSTR_PREFETCH |
> > +		   L310_AUX_CTRL_EARLY_BRESP;
> 
> I guess eventually we can set up some common configuration mask
> define for these kind of things?

The idea is that eventually platforms should just specify no changes to
the auxctl configuration.  You will notice later patches remove a number
of the above flags.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
