From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/2] ti-sysc driver changes for v5.5
Date: Wed, 23 Oct 2019 10:54:49 -0700
Message-ID: <pull-1571853258-16998@atomide.com-2>
References: <pull-1571853258-16998@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1571853258-16998@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: soc@kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit c7d8669f46ba97f6a8e14d6e9b8d6c39e2c07727:

  bus: ti-sysc: Fix watchdog quirk handling (2019-10-18 08:45:32 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.5/ti-sysc-signed

for you to fetch changes up to 1819ef2e2d12d5b1a6ee54ac1c2afe35cffc677c:

  bus: ti-sysc: Use swsup quirks also for am335x musb (2019-10-21 14:15:55 -0700)

----------------------------------------------------------------
Changes for ti-sysc interconnect target module driver for v5.5

A series of changes from Tero Kristo for rpm reset control
driver to deal with the ordering requirements between clocks
and resets, and two changes to deal with quirks for musb otg
device.

----------------------------------------------------------------
Tero Kristo (3):
      bus: ti-sysc: re-order reset and main clock controls
      bus: ti-sysc: drop the extra hardreset during init
      bus: ti-sysc: avoid toggling power state of module during probe

Tony Lindgren (3):
      Merge branch 'watchdog-fix' into omap-for-v5.5/ti-sysc
      bus: ti-sysc: Handle mstandby quirk and use it for musb
      bus: ti-sysc: Use swsup quirks also for am335x musb

 drivers/bus/ti-sysc.c | 87 +++++++++++++++++++--------------------------------
 1 file changed, 33 insertions(+), 54 deletions(-)
