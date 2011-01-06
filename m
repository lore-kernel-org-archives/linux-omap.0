From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/5] omap2+: pm_bus: make functions used as pointers as
	static
Date: Thu, 6 Jan 2011 14:43:26 -0800
Message-ID: <20110106224326.GC7771@atomide.com>
References: <1294171634-13943-1-git-send-email-nm@ti.com>
	<1294171634-13943-6-git-send-email-nm@ti.com>
	<87zkrg2nfa.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <87zkrg2nfa.fsf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@ti.com>
Cc: Nishanth Menon <nm@ti.com>, l-o <linux-omap@vger.kernel.org>, l-a <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@ti.com> [110104 16:39]:
> Nishanth Menon <nm@ti.com> writes:
> 
> > omap_pm_runtime_suspend and omap_pm_runtime_resume are used
> > as function pointers and does not really need to be exposed
> > to the world.
> >
> > Fixes sparse warnings:
> > arch/arm/mach-omap2/pm_bus.c:23:5: warning: symbol 'omap_pm_runtime_suspend' was not declared. Should it be static?
> > arch/arm/mach-omap2/pm_bus.c:40:5: warning: symbol 'omap_pm_runtime_resume' was not declared. Should it be static?
> >
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> 
> Thanks, will queue this one in my pm-fixes branch for 2.6.38-rc.

I'll take patches 1 - 4.

Tony
