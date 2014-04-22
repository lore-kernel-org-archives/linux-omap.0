From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH v3 0/3] ARM: OMAP2+: AM437x: L2 cache support
Date: Tue, 22 Apr 2014 13:58:00 +0530
Message-ID: <cover.1398149526.git.nsekhar@ti.com>
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
To: Tony Lindgren <tony@atomide.com>, Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Sekhar Nori <nsekhar@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

This patch series adds L2 cache support for AM437x
and does some clean-ups for existing OMAP4 support
along the way (no functional changes). On OMAP4 Panda,
the Aux control value remains 0x7e470000 before and
after the series.

Tested on OMAP4 Panda and AM437x EPOS EVMs.

It is based on RMK's 75 patch series titled "l2c series" +
the patch contained in https://www.mail-archive.com/linux-omap@vger.kernel.org/msg103439.html

Sekhar Nori (3):
  ARM: OMAP2+: L2 cache: get rid of init call
  ARM: OMAP2+: L2 cache: git rid of redundant cache replacement policy
    setting
  ARM: OMAP2+: AM43x: L2 cache support

 arch/arm/mach-omap2/Kconfig        |    1 +
 arch/arm/mach-omap2/common.h       |    1 +
 arch/arm/mach-omap2/io.c           |    2 ++
 arch/arm/mach-omap2/omap4-common.c |   17 ++++-------------
 4 files changed, 8 insertions(+), 13 deletions(-)

-- 
1.7.10.1
