From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] one bug fix and few other fixes for v4.17-rc cycle
Date: Mon, 7 May 2018 08:31:33 -0700
Message-ID: <20180507153133.GN98604@atomide.com>
References: <pull-1525448974-362873@atomide.com>
 <20180505194326.GI98604@atomide.com>
 <CAHCN7xJ8yAU=zjJuS6rPh61qNuRc7nr2e+i0z-YHCZQREcs0Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAHCN7xJ8yAU=zjJuS6rPh61qNuRc7nr2e+i0z-YHCZQREcs0Yg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Adam Ford <aford173@gmail.com>
Cc: linux-omap@vger.kernel.org, arm@kernel.org, Adam Ford <adam.ford@logicpd.com>, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Adam Ford <aford173@gmail.com> [180505 23:45]:
> On Sat, May 5, 2018 at 2:43 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Tony Lindgren <tony@atomide.com> [180504 15:51]:
> >> From: "Tony Lindgren" <tony@atomide.com>
> >>
> >> The following changes since commit fb289e3ab10c16834741bb02be740fa9d025fde0:
> >>
> >>   Merge branch 'omap-for-v4.17/fixes-ti-sysc' into omap-for-v4.17/fixes (2018-04-19 15:48:46 -0700)
> >>
> >> are available in the Git repository at:
> >>
> >>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.17/fixes-rc3
> >>
> >> for you to fetch changes up to 647efef69de483f1dd7944ede31b4cae16acb124:
> >>
> >>   ARM: dts: correct missing "compatible" entry for ti81xx SoCs (2018-05-03 10:07:47 -0700)
> >>
> >> ----------------------------------------------------------------
> >> Fixes for omap variants for v4.17-rc cycle
> >>
> >> This series of patches contains one BUG fix for trace if
> >> CONFIG_DEBUG_PREEMPT is enabled and a regression fix for omap1
> >> FIQ handling on ams-delta. Then there's a dts fix for missing SoC
> >> compatible on ti81xx board dts files that did matter until we added
> >> the clkctrl clocks and without that some clocks are now not found.
> >>
> >> Then there are three minor logicpd-som-lv specific dts fixes that
> >> fix misconfigured pins for WLAN, audio and USB.
> >>
> >> ----------------------------------------------------------------
> >> Adam Ford (3):
> >>       ARM: dts: logicpd-som-lv: Fix WL127x Startup Issues
> >>       ARM: dts: logicpd-som-lv: Fix Audio Mute
> >>       ARM: dts: logicpd-som-lv: Fix pinmux controller references
> >
> > Adam emailled that one of these has a side effect for breaking
> > USB. So let's not use this pull request if not yet merged, I'll
> > send an updated pull request early next week.
> >
> The WL127x and Audio patches are good, but pinmux controller fails on
> cold-boot, so I'd like to revert that one.

OK reverted and pushed out omap-for-v4.17/fixes. Can you please
test that branch and make sure things are OK now?

Regards,

Tony
