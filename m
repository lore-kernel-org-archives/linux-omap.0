From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/4] Get kexec working on SMP omap variants
Date: Tue, 21 Jun 2016 00:52:41 -0700
Message-ID: <1466495565-17480-1-git-send-email-tony@atomide.com>
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
To: linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Tero Kristo <t-kristo@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Here are some patches to make kexec work for SMP omaps. To test
these you need to use the latest kexec-tools.git kexec with
Russell's recent patches in "[PATCH 0/2] Simple fix to the ARM
kexec tools implementation" thread fixed for 6x. Or else you
need to use appended DTB.

I've tested these so far on 4430 duovero, omap5-uevm, and
beagle-x15.

Regards,

Tony


Tony Lindgren (4):
  ARM: OMAP4+: Initialize SAR RAM base early for proper CPU1 reset for
    kexec
  ARM: OMAP4+: Prevent CPU1 related hang with kexec
  ARM: OMAP4+: Reset CPU1 properly for kexec
  ARM: OMAP4+: Allow kexec on SMP variants

 arch/arm/mach-omap2/Makefile              |  4 +-
 arch/arm/mach-omap2/common.h              |  8 ++-
 arch/arm/mach-omap2/io.c                  |  3 +
 arch/arm/mach-omap2/omap-hotplug.c        |  6 ++
 arch/arm/mach-omap2/omap-mpuss-lowpower.c | 29 ++++++++--
 arch/arm/mach-omap2/omap-smp.c            | 96 ++++++++++++++++++++++---------
 arch/arm/mach-omap2/omap4-common.c        | 14 ++---
 7 files changed, 118 insertions(+), 42 deletions(-)

-- 
2.8.1
