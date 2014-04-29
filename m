From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 51/97] ARM: l2c: remove platforms/SoCs setting early
	BRESP
Date: Tue, 29 Apr 2014 01:21:41 +0100
Message-ID: <20140429002140.GP27282@n2100.arm.linux.org.uk>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk> <E1WerG4-0001X4-Ic@rmk-PC.arm.linux.org.uk> <20140429000224.GA31083@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140429000224.GA31083@verge.net.au>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, Tony Lindgren <tony@atomide.com>, Magnus Damm <magnus.damm@gmail.com>, Viresh Kumar <viresh.linux@gmail.com>, Shiraz Hashim <shiraz.hashim@st.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, spear-devel@list.st.com, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 29, 2014 at 09:02:27AM +0900, Simon Horman wrote:
> On Mon, Apr 28, 2014 at 08:30:32PM +0100, Russell King wrote:
> > Since we now automatically enable early BRESP in core L2C-310 code when
> > we detect a Cortex-A9, we don't need platforms/SoCs to set this bit
> > explicitly.  Instead, they should seek to preserve the value of bit 30
> > in the auxiliary control register.
> > 
> > Acked-by: Tony Lindgren <tony@atomide.com>
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> I would prefer if this patch was broken out into individual patches
> for each board or SoC file and that they were then picked up
> by their respective platform maintainers.
> 
> Likewise for patch 66/97. Although it is only for shmobile
> I would prefer it broken out.

Oh fuck that.

Okay, I'm dropping the whole patch set right now and forgetting the whole
damned thing.  The L2 cache code can damned well stay as it is and remain
an unmaintainable mess.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
