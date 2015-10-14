From: Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH 0/4] ARM: handle imprecise aborts from firmware in common code
Date: Wed, 14 Oct 2015 16:48:29 +0200
Message-ID: <1444834113-18122-1-git-send-email-l.stach@pengutronix.de>
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
To: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>, Tony Lindgren <tony@atomide.com>, Hauke Mehrtens <hauke@hauke-m.de>, patchwork-lst@pengutronix.de, Gregory Clement <gregory.clement@free-electrons.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This series implements the handling of a pending imprecise abort left behind
by the bootloader/firmware running before Linux in the common ARM startup code.

It turns pending imprecise aborts that may signal during the first unmasking
of such aborts on the boot CPU into a non-faulting event and warns the user
that the firmware of the machine might be buggy.

Handling this in the common code makes sure that we only ignore already pending
aborts and not those that may happen later during system boot/usage. It also
allows to remove the custom fault handler from the 3 architectures that are
known to have bad firmware/bootloaders.

The patches changing OMAP, MVEBU and BCM5301X are only build tested as I have
no hardware to test on. So I would appreciate a tested-by for those.

Regards,
Lucas

Lucas Stach (4):
  ARM: catch pending imprecise abort on unmask
  ARM: OMAP2+: remove custom abort handler for t410
  ARM: mvebu: remove the workaround imprecise abort fault handler
  ARM: BCM5301X: remove workaround imprecise abort fault handler

 arch/arm/mach-bcm/bcm_5301x.c      | 35 -----------------------------------
 arch/arm/mach-mvebu/board-v7.c     | 35 -----------------------------------
 arch/arm/mach-omap2/pdata-quirks.c | 29 -----------------------------
 arch/arm/mm/fault.c                | 15 +++++++++++++++
 arch/arm/mm/fault.h                |  2 ++
 arch/arm/mm/mmu.c                  | 19 ++++++++++++++++++-
 6 files changed, 35 insertions(+), 100 deletions(-)

-- 
2.6.1
