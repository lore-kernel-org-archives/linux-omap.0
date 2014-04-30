From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 51/97] ARM: l2c: remove platforms/SoCs setting early BRESP
Date: Wed, 30 Apr 2014 15:13:15 +0900
Message-ID: <20140430061315.GA5153@verge.net.au>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
 <E1WerG4-0001X4-Ic@rmk-PC.arm.linux.org.uk>
 <20140429000224.GA31083@verge.net.au>
 <535FD07D.5070801@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <535FD07D.5070801@wwwdotorg.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, linux-arm-kernel@lists.ifradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, Tony Lindgren <tony@atomide.com>, Magnus Damm <magnus.damm@gmail.com>, Viresh Kumar <viresh.linux@gmail.com>, Shiraz Hashim <shiraz.hashim@st.com>, Thierry Reding <thierry.reding@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, spear-devel@list.st.com, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 29, 2014 at 10:17:01AM -0600, Stephen Warren wrote:
> On 04/28/2014 06:02 PM, Simon Horman wrote:
> > On Mon, Apr 28, 2014 at 08:30:32PM +0100, Russell King wrote:
> >> Since we now automatically enable early BRESP in core L2C-310 code when
> >> we detect a Cortex-A9, we don't need platforms/SoCs to set this bit
> >> explicitly.  Instead, they should seek to preserve the value of bit 30
> >> in the auxiliary control register.
> >>
> >> Acked-by: Tony Lindgren <tony@atomide.com>
> >> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > 
> > I would prefer if this patch was broken out into individual patches
> > for each board or SoC file and that they were then picked up
> > by their respective platform maintainers.
> > 
> > Likewise for patch 66/97. Although it is only for shmobile
> > I would prefer it broken out.
> 
> There are far too many dependencies in this series to break out the
> board file patches to be merged separately; it'd take either a whole
> bunch of kernel releases to merge it all that way, or a twisty maze of
> tiny topic branches cross-merged all over the place. Neither option is
> realistic.

Understood, that seems reasonable to me.

For the shmobile portions this patch and 66/97.

Acked-by: Simon Horman <horms+renesas@verge.net.au>
