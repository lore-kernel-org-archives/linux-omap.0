From: Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 1/2] clocksource: Remove outdated comments
Date: Thu, 23 Jan 2014 15:12:27 +0800
Message-ID: <1390461147-36256-1-git-send-email-wangyijing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mips-bounce@linux-mips.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Russell King <linux@arm.linux.org.uk>, David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Mike Frysinger <vapier@gentoo.org>, Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>, Jonas Bonn <jonas@southpole.se>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Daniel Lezcano <danie>
List-Id: linux-omap@vger.kernel.org

clocksource_register() and __clocksource_register_scale()
always return 0, so the comment is just pointless, it's
outdated, remove it.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 kernel/time/clocksource.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index ba3e502..9951575 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -779,8 +779,6 @@ EXPORT_SYMBOL_GPL(__clocksource_updatefreq_scale);
  * @scale:	Scale factor multiplied against freq to get clocksource hz
  * @freq:	clocksource frequency (cycles per second) divided by scale
  *
- * Returns -EBUSY if registration fails, zero otherwise.
- *
  * This *SHOULD NOT* be called directly! Please use the
  * clocksource_register_hz() or clocksource_register_khz helper functions.
  */
@@ -805,7 +803,6 @@ EXPORT_SYMBOL_GPL(__clocksource_register_scale);
  * clocksource_register - Used to install new clocksources
  * @cs:		clocksource to be registered
  *
- * Returns -EBUSY if registration fails, zero otherwise.
  */
 int clocksource_register(struct clocksource *cs)
 {
-- 
1.7.1
