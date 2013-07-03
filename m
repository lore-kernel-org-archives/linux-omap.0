From: Luciano Coelho <coelho@ti.com>
Subject: Re: [PATCH v2 4/9] wl12xx: use frequency instead of enumerations
 for pdata clocks
Date: Wed, 3 Jul 2013 15:14:34 +0300
Message-ID: <1372853674.21065.106.camel@cumari.coelho.fi>
References: <1372776948-24840-1-git-send-email-coelho@ti.com>
 <1372776948-24840-5-git-send-email-coelho@ti.com>
 <20130702150208.GA4233@kahuna> <1372796850.21065.93.camel@cumari.coelho.fi>
 <20130703113334.GY5523@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130703113334.GY5523@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, mark.rutland@arm.com, mturquette@linaro.org, linux-doc@vger.kernel.org, linux-wireless@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, balbi@ti.com, rob.herring@calxeda.com, grant.likely@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, 2013-07-03 at 04:33 -0700, Tony Lindgren wrote:
> * Luciano Coelho <coelho@ti.com> [130702 13:33]:
> > On Tue, 2013-07-02 at 10:02 -0500, Nishanth Menon wrote:
> > > On 17:55-20130702, Luciano Coelho wrote:
> > > > Instead of defining an enumeration with the FW specific values for the
> > > > different clock rates, use the actual frequency instead.  Also add a
> > > > boolean to specify whether the clock is XTAL or not.
> > > > 
> > > > Change all board files to reflect this.
> > > > 
> > > > Cc: Tony Lindgren <tony@atomide.com>
> > > > Cc: Sekhar Nori <nsekhar@ti.com>
> > > > Signed-off-by: Luciano Coelho <coelho@ti.com>
> > > > ---
> > > >  arch/arm/mach-davinci/board-da850-evm.c      |    3 +-
> > > >  arch/arm/mach-omap2/board-4430sdp.c          |    5 ++-
> > > ^^
> > > >  arch/arm/mach-omap2/board-omap3evm.c         |    3 +-
> > > >  arch/arm/mach-omap2/board-omap4panda.c       |    3 +-
> > > ^^
> > > Please do not add more platform data to platforms that are DT only.
> > 
> > Ah, I hadn't realized that board_omap4panda.c and board-4430sdp.c had
> > been removed in linux-next.  I base my tree on wireless-next and it
> > doesn't contain these changes yet.  I would only have noticed this when
> > I rebased my tree once the merge window is closed. ;)
> > 
> > Thanks for pointing out, I'll make sure these changes will not be there
> > when I send the pull request.
> 
> Please separate out the minimal pdata and arch/arm/mach-omap2 changes int
> a immutable branch on v3.11-rc1 that I can also pull in. For v3.12, we're
> going to be making more boards device tree only, so these changes may
> otherwise cause pointless merge conflicts.

Okay.  I don't want to freeze my work, I'll continue using my
wireless-based tree (which is based on 3.10) for now.  When the merge
window closes, I'll reorganize all this before sending pull requests, so
we can avoid conflicts.

Please ignore my changes to board files that will disappear on 3.11 and
keep reviewing the rest. ;)

--
Cheers,
Luca.
