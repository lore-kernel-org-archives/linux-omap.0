From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH 0/5] ARM: OMAP1: Fix dpll1 reprogramming related issues
Date: Sun, 27 Nov 2011 04:32:26 +0100
Message-ID: <1322364751-29980-1-git-send-email-jkrzyszt@tis.icnet.pl>
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
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, linux-kernel@vger.kernel.org, Sameer Nanda <snanda@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

After dpll1 reprogramming has been moved from setup_arch() to
kernel_init(), I've been observing several issues, resulting in
undesired system behaviour on my Amstrad Delta. This series fixes
those issues.

Janusz Krzysztofik (5):
  ARM: OMAP1: Fix dpll1 default rate reprogramming method
  ARM: OMAP1: Fix ckctl value used for dpll1 defualt rate
  ARM: OMAP1: Fix dpll1 reprogramming not actually allowed
  init/calibrate.c: allow for recalibration of loops per jiffy
  ARM: OMAP1: recalibrate loops per jiffy after dpll1 reprogram

 arch/arm/mach-omap1/clock.c      |   10 +---------
 arch/arm/mach-omap1/clock_data.c |    9 +++++++--
 arch/arm/plat-omap/sram.c        |    3 +++
 include/linux/delay.h            |    4 +++-
 init/calibrate.c                 |    6 ++++--
 5 files changed, 18 insertions(+), 14 deletions(-)

-- 
1.7.3.4
