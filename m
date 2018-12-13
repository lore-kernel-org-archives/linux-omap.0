From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: [PATCH 0/9] Clean up ARM SMP/CPU hotplug implementations
Date: Thu, 13 Dec 2018 17:59:52 +0000
Message-ID: <20181213175952.GC26090@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org, linux-oxnas@groups.io, linux-samsung-soc@vger.kernel.org, linux-soc@vger.kernel.org
Cc: Barry Song <baohua@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Neil Armstrong <narmstrong@baylibre.com>, Tony Lindgren <tony@atomide.com>, Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Patrice Chotard <patrice.chotard@st.com>, Krzysztof Kozlowski <krzk@kernel.org>, David Brown <david.brown@linaro.org>, Kukjin Kim <kgene@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Andy Gross <andy.gross@linaro.org>, Shiraz Hashim <shiraz.linux.kernel@gmail.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
List-Id: linux-omap@vger.kernel.org

There is a lot of apparent copied code in arch/arm for handling SMP/
CPU hotplug, much of which is inappropriate or plain buggy.  This
seems to be a topic that occasionally comes up.

The "pen_release" thing was created for ARM Ltd development platforms
where there was no way to individually control secondary CPUs leaving
the boot loader - they all jumped to whatever physical code address
was supplied at the same time.  This made it necessary for _these_
platforms to have a "holding pen" for the CPUs while the kernel
initialised.

The "boot_lock" thing was also created for ARM Ltd development
platforms which had restricted bus bandwidth, and which used the
loops_per_jiffy delay mechanism, which was calibrated for each
secondary CPU.  With the restricted bus bandwidth, activity from the
boot CPU would affect the delay calibration adversely.

Lastly, the Versatile CPU hotplug implementation is an entirely
ficticious one - these platforms do _not_ support CPU hotplug as
there is no way to actually disable any of the secondary CPUs, or
reset them.  Such an implementation is not acceptable when supporting
features such as suspend or kexec.  As the Versatile platforms are
ARM development platforms which do not have suspend support, this is
acceptable there, but not for production hardware.

None of these three facilities/implementations should be used on
modern production hardware, yet we have a number of copies of this
code.

This series addresses that by removing the inappropriate copies of
some Realview/Versatile Express specific workarounds, and makes it
(hopefully) more clear that introducing this code is really not
acceptable.

To discourage copying the Versatile code, further comments are added
and the functions renamed for CPU hotplug to be "immitation" to make
it clear that it's not a real implementation.

We tried reducing the duplication in the past with ideas around
consolidating the pen_release/boot_lock/immitation hotplug stuff,
but I nacked that because it's not an acceptable implementation for
production hardware.  However, we did decide to consolidate the
"pen_release" definition.  In hind sight, that was a mistake,
because that gave more credence to that way of doing things, and
also gave rise to buggy implementations which only read from that
variable - meaning it served no useful purpose.

There are some rather complex cases that remain, and those need the
SoC folk to fix.

I have left the Actions Semi patch in place since following patches
depend on it, but there is a five-patch series from Linus Walleij
that address this platform which should replace this patch - with
the patch concerned marked as "RFT" - request for testing.

 arch/arm/include/asm/smp.h                         |   1 -
 arch/arm/kernel/smp.c                              |   6 --
 arch/arm/mach-actions/platsmp.c                    |  15 ---
 arch/arm/mach-exynos/headsmp.S                     |   2 +-
 arch/arm/mach-exynos/platsmp.c                     |  31 +++---
 arch/arm/mach-omap2/omap-smp.c                     |  20 ----
 arch/arm/mach-oxnas/Makefile                       |   1 -
 arch/arm/mach-oxnas/hotplug.c                      | 109 --------------------
 arch/arm/mach-oxnas/platsmp.c                      |   4 -
 arch/arm/mach-prima2/common.h                      |   2 +
 arch/arm/mach-prima2/headsmp.S                     |   2 +-
 arch/arm/mach-prima2/hotplug.c                     |   3 +-
 arch/arm/mach-prima2/platsmp.c                     |  17 ++--
 arch/arm/mach-qcom/platsmp.c                       |  26 -----
 arch/arm/mach-realview/Makefile                    |   1 -
 arch/arm/mach-realview/hotplug.c                   | 111 ---------------------
 arch/arm/mach-realview/hotplug.h                   |   1 -
 arch/arm/mach-realview/platsmp-dt.c                |   8 +-
 arch/arm/mach-spear/generic.h                      |   2 +
 arch/arm/mach-spear/headsmp.S                      |   2 +-
 arch/arm/mach-spear/hotplug.c                      |   4 +-
 arch/arm/mach-spear/platsmp.c                      |  27 +++--
 arch/arm/mach-sti/Makefile                         |   2 +-
 arch/arm/mach-sti/headsmp.S                        |  43 --------
 arch/arm/mach-sti/platsmp.c                        |  62 +-----------
 arch/arm/mach-vexpress/Makefile                    |   1 -
 arch/arm/mach-vexpress/core.h                      |   2 -
 arch/arm/mach-vexpress/platsmp.c                   |   7 ++
 arch/arm/plat-versatile/Makefile                   |   1 +
 arch/arm/plat-versatile/headsmp.S                  |   2 +-
 .../{mach-vexpress => plat-versatile}/hotplug.c    |  47 ++++-----
 arch/arm/plat-versatile/include/plat/platsmp.h     |   2 +
 arch/arm/plat-versatile/platsmp.c                  |  47 ++++++---
 33 files changed, 132 insertions(+), 479 deletions(-)
 delete mode 100644 arch/arm/mach-oxnas/hotplug.c
 delete mode 100644 arch/arm/mach-realview/hotplug.c
 delete mode 100644 arch/arm/mach-realview/hotplug.h
 delete mode 100644 arch/arm/mach-sti/headsmp.S
 rename arch/arm/{mach-vexpress => plat-versatile}/hotplug.c (56%)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
