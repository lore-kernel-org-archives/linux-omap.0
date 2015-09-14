From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 0/2] OMAP hwspinlock hwmod cleanup
Date: Mon, 14 Sep 2015 15:49:19 -0500
Message-ID: <1442263761-16757-1-git-send-email-s-anna@ti.com>
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
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Paul,

Following are couple of hwmod cleanup patches for HwSpinlock IP. 
Patches based on 4.3-rc1. The legacy platform device instantiation 
logic has been cleaned up in 4.2 kernel when DT-support was added
to the OMAP HwSpinlock driver.

regards
Suman

Suman Anna (2):
  ARM: OMAP4: hwmod data: Remove spinlock hwmod addrs
  ARM: DRA7: hwmod data: Remove spinlock hwmod addrs

 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 10 ----------
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c  | 10 ----------
 2 files changed, 20 deletions(-)

-- 
2.5.0
