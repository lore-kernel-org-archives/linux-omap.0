From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/4] ti-sysc driver changes for v5.3
Date: Thu, 13 Jun 2019 00:10:52 -0700
Message-ID: <pull-1560399818-512977@atomide.com-3>
References: <pull-1560399818-512977@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1560399818-512977@atomide.com>
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

The following changes since commit 4ee23cd76c0ce8622976b3da0e2bc89e6d94f6d4:

  Merge branch 'omap-for-v5.2/ti-sysc' into fixes (2019-05-20 08:33:03 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.3/ti-sysc-signed

for you to fetch changes up to 4e23be473e3063a9d3bc06bb0aee89885fffab0e:

  bus: ti-sysc: Add support for module specific reset quirks (2019-06-10 04:52:22 -0700)

----------------------------------------------------------------
ti-sysc interconnect target module driver changes for v5.3

This series of changes improves probing devices with ti-sysc to the
point where we can now probe most devices without the custom dts
property "ti,hwmods" and no legacy platform data :)

We add support for platform data callbacks for idling and unidling the
clockdomain the module belongs to. The rest of the series mostly adds
handling for the various quirks needed by old legacy modules such as
i2c and watchdog. Some quirk handling is still missing for few modules,
but those will be added as they get tested.

The related platform data and dts changes will be sent separately.

----------------------------------------------------------------
Tony Lindgren (12):
      bus: ti-sysc: Add support for missing clockdomain handling
      bus: ti-sysc: Support 16-bit writes too
      bus: ti-sysc: Make OCP reset work for sysstatus and sysconfig reset bits
      bus: ti-sysc: Allow QUIRK_LEGACY_IDLE even if legacy_mode is not set
      bus: ti-sysc: Enable interconnect target module autoidle bit on enable
      bus: ti-sysc: Handle clockactivity for enable and disable
      bus: ti-sysc: Handle swsup idle mode quirks
      bus: ti-sysc: Set ENAWAKEUP if available
      bus: ti-sysc: Add support for disabling module without legacy mode
      bus: ti-sysc: Do rstctrl reset handling in two phases
      bus: ti-sysc: Detect uarts also on omap34xx
      bus: ti-sysc: Add support for module specific reset quirks

 arch/arm/mach-omap2/omap_hwmod.c      |  39 +--
 arch/arm/mach-omap2/pdata-quirks.c    |  60 +++++
 drivers/bus/ti-sysc.c                 | 454 ++++++++++++++++++++++++++++------
 include/linux/platform_data/ti-sysc.h |  12 +
 4 files changed, 456 insertions(+), 109 deletions(-)
