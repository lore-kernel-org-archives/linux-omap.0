From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 0/2] arm: omap2: AM43xx: enable ARM TWD timer
Date: Mon, 14 Dec 2015 22:34:04 +0200
Message-ID: <1450125246-17249-1-git-send-email-grygorii.strashko@ti.com>
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
To: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, linux-omap@vger.kernel.org, nsekhar@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <ssantosh@kernel.org>
List-Id: linux-omap@vger.kernel.org

Now ARM TWD timer can be enabled for AM437x devices since all prerequisite
patches have been merged already [1] [2].

But before finally enable ARM TWD timer for UP AM437x devices - 
the Broadcast event source and infrustructure need to be enabled properly.
Otherwise CPUIdle will be broken.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-August/363989.html
[2] http://www.spinics.net/lists/linux-omap/msg123940.html
Felipe Balbi (1):
  arm: omap2: AM43xx: select ARM TWD timer

Grygorii Strashko (1):
  ARM: OMAP: am43xx: enable GENERIC_CLOCKEVENTS_BROADCAST

 arch/arm/mach-omap2/Kconfig | 2 ++
 arch/arm/mach-omap2/timer.c | 6 ++++++
 2 files changed, 8 insertions(+)

-- 
2.6.4
