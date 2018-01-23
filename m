From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] one ti-sysc driver fix for v4.16 merge window
Date: Tue, 23 Jan 2018 09:42:05 -0800
Message-ID: <pull-1516729268-155514@atomide.com>
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
To: arm@kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit c5a2de97fbd2979fab291fb048084d3fddd322dd:

  bus: ti-sysc: Add parsing of module capabilities (2017-12-21 07:28:54 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.16/ti-sysc-fix-signed

for you to fetch changes up to 3267c081e037e2ed1a3af65ee46825799a7ccda5:

  bus: ti-sysc: Fix smartreflex sysc mask (2018-01-22 09:32:53 -0800)

----------------------------------------------------------------
One minor fix for ti-sysc smartreflex sysc mask that prevents idling
the smartreflex interconnect target module for device tree based
probing.

----------------------------------------------------------------
Tony Lindgren (1):
      bus: ti-sysc: Fix smartreflex sysc mask

 drivers/bus/ti-sysc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
