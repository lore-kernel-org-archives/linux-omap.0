From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap defconfig changes for v4.17
Date: Fri, 16 Mar 2018 08:38:18 -0700
Message-ID: <pull-1521214671-54392@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: arm@kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.17/defconfig-signed

for you to fetch changes up to 740c01f76ab3712a45c2f02233c800829626e9ba:

  ARM: multi_v7_defconfig: Enable USB gadget configfs as loadable module (2018-03-06 11:25:37 -0800)

----------------------------------------------------------------
Defconfig updates for omap variants for v4.17 merge window

We need to enable MMC_SDHCI option in both omap2plus_defconfig and
multi_v7_defconfig so systems are able to mount root when the dts files
get updated for sdhci.

Then let's update omap2plus_defconfig so we can patch it easier. And as
Arnd noticed earlier, just running make savedefconfig will accidentally
drop few Kconfig options. This is happening because some options are no
longer available as loadable modules like LIRC. Or new dependencies have
been added such as SND_OSSEMUL for selecting SOUND_OSS_CORE.

So we first move the unchanged options around to their make savedefconfig
suggested place, then update the options to prevent make savedefconfig
dropping some options accidentally, and then finally drop the unused
options.

And after that we enable options DRM_OMAP and 8250_OMAP. These both have
been around for years now. And we do have 8250_OMAP warn about console
being redirected with SERIAL_8250_OMAP_TTYO_FIXUP option that is enabled
by default. Some users may need to update their inittab to use ttyS*
instead of ttyO* though. If this turns out to be a problem, we may want
to introduce a separate compatible for 8250-omap. But I think we're good
to go with the SERIAL_8250_OMAP_TTYO_FIXUP warning now. Let's not update
multi_v7_defconfig yet though and first see how 8250_OMAP change plays
out.

We also enable few new options for PM on am335x and am437x, and CEC in
omap2plus_defconfig. Naturally similar options can be later on added to
multi_v7_defconfig, but in this series we only enable OTG, MUSB and the
related PHYs in multi_v7_defconfig to make it more usable for distros.

----------------------------------------------------------------
Kishon Vijay Abraham I (2):
      ARM: multi_v7_defconfig: Enable CONFIG_MMC_SDHCI_OMAP
      ARM: omap2plus_defconfig: Enable CONFIG_MMC_SDHCI_OMAP

Tony Lindgren (13):
      ARM: omap2plus_defconfig: Update for moved options
      ARM: omap2plus_defconfig: Add SERIAL_DEV for bluetooth
      ARM: omap2plus_defconfig: Select MFD_TI_LMU
      ARM: omap2plus_defconfig: Update LIRC options
      ARM: omap2plus_defconfig: Add SND_OSSEMUL
      ARM: omap2plus_defconfig: Drop unneeded options
      ARM: omap2plus_defconfig: Enable am335x and am437x PM options
      ARM: omap2plus_defconfig: Enable CEC
      ARM: omap2plus_defconfig: Switch to use omapdrm by default
      ARM: omap2plus_defconfig: Enable 8250_OMAP
      ARM: multi_v7_defconfig: Enable OTG and MUSB as loadable modules
      ARM: multi_v7_defconfig: Enable various USB PHYs found on omap variants
      ARM: multi_v7_defconfig: Enable USB gadget configfs as loadable module

 arch/arm/configs/multi_v7_defconfig  | 36 ++++++++++++++
 arch/arm/configs/omap2plus_defconfig | 94 +++++++++++++++++++++---------------
 2 files changed, 91 insertions(+), 39 deletions(-)
