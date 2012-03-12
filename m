From: Kevin Hilman <khilman@ti.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: PM: core support for SMPS regulators for v3.4
Date: Mon, 12 Mar 2012 16:28:31 -0700
Message-ID: <87pqchv1pc.fsf@ti.com>
References: <877gywjhht.fsf@ti.com> <20120308021843.GQ12083@atomide.com>
	<87399jc6cj.fsf@ti.com> <20120309003217.GB12083@atomide.com>
	<20120309114731.GA3273@opensource.wolfsonmicro.com>
	<87zkbp4wtj.fsf@ti.com>
	<20120311204232.GC3171@opensource.wolfsonmicro.com>
	<87399dzq5e.fsf@ti.com>
	<20120312173215.GL3110@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:43370 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753643Ab2CLX2Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Mar 2012 19:28:25 -0400
Received: by iahk25 with SMTP id k25so11819170iah.27
        for <linux-omap@vger.kernel.org>; Mon, 12 Mar 2012 16:28:24 -0700 (PDT)
In-Reply-To: <20120312173215.GL3110@opensource.wolfsonmicro.com> (Mark Brown's
	message of "Mon, 12 Mar 2012 17:32:16 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

> On Mon, Mar 12, 2012 at 10:26:53AM -0700, Kevin Hilman wrote:
>> Mark Brown <broonie@opensource.wolfsonmicro.com> writes:
>
>> > The branch itself is essentially stable but I'm not enthused about the
>> > idea of merging the whole thing via the OMAP tree.  
>
>> Right, I wasn't suggesting we merge it via OMAP tree.   I was just
>> looking for a stable point we could use as s dependency when merging
>> everything together for the arm-soc tree.
>
> Well, if you don't base the OMAP changes that depend on it off the
> regulator changes then you'll break bisection as you'll have a bunch of
> commits which won't have all their dependencies present on a branch
> (since they're not present in the branch point and aren't otherwise
> merged in), if bisect goes down that branch it'll be miserable.  That
> seems bad and while I've not run into it with OMAP in particular it's
> rather painful when it does happen.
>
> It's much better if the branch has the required changes merged into it
> prior to their being used.

OK.

Tony, updated pull request below.  This includes all the TWL depencies
merged from the 'topic/twl' tag in Mark's tree.

Kevin


The following changes since commit b01543dfe67bb1d191998e90d20534dc354de059:

  Linux 3.3-rc4 (2012-02-18 15:53:33 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.4/pm/smps-regulator

for you to fetch changes up to 39358f2b57f37fe079eff4159307c844a0bfb176:

  Merge branch 'pm-wip/smps-regulator' into for_3.4/pm/smps-regulator (2012-03-12 15:36:45 -0700)

----------------------------------------------------------------

Kevin Hilman (3):
      ARM: OMAP2+: voltage: ensure voltage used is exact voltage from OPP table
      Merge tag 'topic/twl' into for_3.4/pm/smps-regulator
      Merge branch 'pm-wip/smps-regulator' into for_3.4/pm/smps-regulator

Laxman Dewangan (1):
      regulator: twl6030: Fix voltage selection logic

Peter Ujfalusi (2):
      regulator: twl-regulator: Add fixed LDO for V1V8, V2V1 supply
      mfd: twl-core: regulator configuration for twl6030 V1V8, V2V1 SMPS

Rajendra Nayak (1):
      regulator: twl: adapt twl-regulator driver to dt

Tero Kristo (6):
      arm: omap3: voltage: fix channel configuration
      arm: omap3: add common twl configurations for vdd1 and vdd2
      arm: omap3: twl: add external controllers for core voltage regulators
      arm: omap4: add common twl configurations for vdd1, vdd2 and vdd3
      regulator: twl4030: add support for external voltage get/set
      regulator: twl6030: add support for vdd1, vdd2 and vdd3 regulators

 .../bindings/regulator/twl-regulator.txt           |   68 ++++
 arch/arm/mach-omap2/twl-common.c                   |  147 +++++++++
 arch/arm/mach-omap2/vc3xxx_data.c                  |    1 +
 arch/arm/mach-omap2/voltage.c                      |   21 +-
 drivers/mfd/twl-core.c                             |   41 ++-
 drivers/regulator/twl-regulator.c                  |  327 +++++++++++++++-----
 include/linux/i2c/twl.h                            |   14 +-
 7 files changed, 532 insertions(+), 87 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/twl-regulator.txt
