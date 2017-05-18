From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 0/3] ARM: OMAP2+: preparation for clk/clkctrl support
Date: Thu, 18 May 2017 20:16:09 +0300
Message-ID: <1495127772-7486-1-git-send-email-t-kristo@ti.com>
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

This series contains a couple of fixes for supporting clkctrl driver
for OMAP4. The patches in this series can be applied separately,
they don't have any dependency towards the clock driver related patches.
Once the clockctrl driver support itself [1] and this series have
been applied, the DTS changes can start flowing in.

Reference branch with the clkctrl driver, this series and
preliminary DTS patches pushed here:

Tree: https://github.com/t-kristo/linux-pm.git
Branch: 4.12-rc1-clkctrl-integ

Tested the integrated branch with omap4 boot, suspend-resume, and
also with the HDMI external display test (this was failing with some
older revision of the series.)

-Tero

[1] https://www.spinics.net/lists/arm-kernel/msg581685.html
