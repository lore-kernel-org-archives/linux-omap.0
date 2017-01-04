From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap fixes for v4.10-rc cycle
Date: Wed, 4 Jan 2017 07:58:37 -0800
Message-ID: <20170104155837.GE25222@atomide.com>
References: <3791843.yGbamM6pzm@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <3791843.yGbamM6pzm@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [170104 07:18]:
> On Friday, December 30, 2016 1:10:43 PM CET Tony Lindgren wrote:
> > Fist set of fixes for omaps for v4.10-rc cycle, mostly
> > to deal with various regressions noticed during the merge
> > window and to fix various device tree configurations for
> > boards. Also included is removal of mach-omap2/gpio.c that
> > is now dead code with device tree based booting that should
> > be OK for the early -rc cycle:
> > 
> > - A series of fixes to add empty chosen node to fix regressions
> >   caused for bootloaders that don't create chosen node as the
> >   decompressor needs the chosen node to merge command line and
> >   ATAGs into it
> > 
> > - Fix missing logicpd-som-lv-37xx-devkit.dtb entry in Makefile
> > 
> > - Fix regression for am437x timers
> > 
> > - Fix wrong strcat for non-NULL terminated string
> > 
> > - A series of changes to fix tps65217 interrupts to not use
> >   defines as we don't do that for interrupts
> > 
> > - Two patches to fix USB VBUS detection on am57xx-idk and force it
> >   to peripheral mode until dwc3 role detection is working
> > 
> > - Add missing dra72-evm-tps65917 missing voltage supplies
> >   accidentally left out of an earlier patch
> > 
> > - Fix n900 eMMC detection when booted on qemu
> > 
> > - Remove unwanted pr_err on failed memory allocation for
> >   prm_common.c
> > 
> > - Remove legacy mach-omap2/gpio.c that now is dead code
> >   since we boot mach-omap2 in device tree only mode
> > 
> > - Fix am572x-idk pcie1 by adding the missing gpio reset pin
> 
> I think I would have preferred to see the gpio.c removal as
> a fixes-non-critical patch for 4.11 instead, but I don't feel
> like making you respin the pull request for that, since I
> really want to get the other fixes merged for -rc3.

Sorry yeah I had that queued for v4.11 but I forgot it and then
the holidays came.. Anyways it's been sitting in Linux next since
late November so should be safe to merge.

> Pulled everything into fixes now.

Thanks,

Tony
