From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 0/6] ARM: OMAP2+: preparation for clk/clkctrl support
Date: Wed, 31 May 2017 17:59:57 +0300
Message-ID: <1496242803-6101-1-git-send-email-t-kristo@ti.com>
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
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

This series is evolution of the v3b of the same series:
https://www.spinics.net/lists/arm-kernel/msg584344.html

Changes compared to v3b:

- Added patch #3 which stores the physical address for PRCM instances
  in addition to the virtual addresses
- Fixed patch #5 to use physical base address for xlate instead of
  the OMAP2_L4_IO_ADDRESS hack
- Dropped unnecessary device node passing from patch #6 which makes
  the code slightly more readable also

Integrated test branch here:
Tree: https://github.com/t-kristo/linux-pm.git
Branch: 4.12-rc1-clkctrl-integ-v4

-Tero
