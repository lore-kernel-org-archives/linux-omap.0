From: adharmap@codeaurora.org
Subject: [PATCH 0/5] Arm Gic Changes
Date: Wed, 27 Jan 2010 11:32:24 -0800
Message-ID: <1264620749-24527-1-git-send-email-adharmap@codeaurora.org>
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
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kalle Valo <kalle.valo@iki.fi>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@stericsson.com>, Jean Pihet <jpihet@mvista.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Abhijeet Dharmapurikar <adharmap@quicinc.com>, linux-kernel@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Andrea Gallo <andrea.gallo@stericsson.com>, Colin Tuckley <colin.tuckley@arm.com>, Ingo Molnar <mingo@elte.hu>, linux-omap@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, Philby John <pjohn@in.mvista.com>, Alessandro Rubini <rubini@unipv.it>
List-Id: linux-omap@vger.kernel.org

From: Abhijeet Dharmapurikar <adharmap@quicinc.com>

Few fixes and improvements to arch/arm/common/gic.c file.

Abhijeet Dharmapurikar (5):
  gic: prevent gic from crossing NR_IRQ
  gic: add callback for mask_ack
  gic: Add set_type callback
  gic: dont disable INT in ack callback
  gic: initialize interrupts as per argument

 arch/arm/common/gic.c                    |  114 ++++++++++++++++++++++++-----
 arch/arm/include/asm/hardware/gic.h      |    3 +-
 arch/arm/mach-omap2/board-4430sdp.c      |    3 +-
 arch/arm/mach-realview/realview_eb.c     |   10 ++-
 arch/arm/mach-realview/realview_pb1176.c |    7 ++-
 arch/arm/mach-realview/realview_pb11mp.c |    7 ++-
 arch/arm/mach-realview/realview_pba8.c   |    4 +-
 arch/arm/mach-realview/realview_pbx.c    |    5 +-
 arch/arm/mach-ux500/cpu-u8500.c          |    2 +-
 9 files changed, 122 insertions(+), 33 deletions(-)
