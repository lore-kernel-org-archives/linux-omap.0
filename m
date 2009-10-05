From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/5] OMAP PM fixes for 2.6.32
Date: Mon, 05 Oct 2009 11:02:38 -0700
Message-ID: <87r5thwwg1.fsf@deeprootsystems.com>
References: <1254507295-11381-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1254507295-11381-1-git-send-email-khilman@deeprootsystems.com>
	(Kevin Hilman's message of "Fri\, 2 Oct 2009 11\:14\:50 -0700")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Tony,

If no other review commeents, this series (incluing patch 6) is based
on v2.6.32-rc1 and available for pull.

Kevin

The following changes since commit 17d857be649a21ca90008c6dc425d849fa83db5c:
  Linus Torvalds (1):
        Linux 2.6.32-rc1

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git pm-fixes-32

Artem Bityutskiy (1):
      OMAP3: PM: introduce a new powerdomain walk helper

Jon Hunter (1):
      OMAP3: PM: Prevent hang in prcm_interrupt_handler

Kevin Hilman (1):
      OMAP3: PM: Enable GPIO module-level wakeups

Paul Walmsley (2):
      OMAP3: PM: PRCM interrupt: check MPUGRPSEL register
      OMAP3: PM: PRCM interrupt: only handle selected PRCM interrupts

Vikram Pandita (1):
      OMAP3: PM: USBHOST: clear wakeup events on both hosts

 arch/arm/mach-omap2/pm-debug.c                |    4 +-
 arch/arm/mach-omap2/pm34xx.c                  |  187 ++++++++++++++-----------
 arch/arm/mach-omap2/powerdomain.c             |   39 ++++--
 arch/arm/plat-omap/include/mach/powerdomain.h |    2 +
 4 files changed, 137 insertions(+), 95 deletions(-)
