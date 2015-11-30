From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/2] Initcall changes for omaps
Date: Mon, 30 Nov 2015 08:26:27 -0800
Message-ID: <1448900789-4034-1-git-send-email-tony@atomide.com>
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
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

Here are some initcall changes to initialize things a bit later.
This make it easier to make timers into drivers and allows us
to make most of the clocks into regular device drivers.

Regards,

Tony


Tony Lindgren (2):
  ARM: OMAP2+: Initialize timers later with late_time_init
  ARM: OMAP2+: Change core_initcall levels to postcore_initcall

 arch/arm/mach-omap2/omap2-restart.c |  2 +-
 arch/arm/mach-omap2/omap_device.c   |  2 +-
 arch/arm/mach-omap2/omap_hwmod.c    |  2 +-
 arch/arm/mach-omap2/serial.c        |  2 +-
 arch/arm/mach-omap2/timer.c         | 46 ++++++++++++++++++++++++++++++++-----
 5 files changed, 44 insertions(+), 10 deletions(-)

-- 
2.6.2
