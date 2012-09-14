From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/7] omap device changes for v3.7 merge window
Date: Thu, 13 Sep 2012 19:18:43 -0700
Message-ID: <E1TCLVE-0003B1-0L@merlin.infradead.org>
References: <pull-1347589125-283636>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1347589125-283636>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit 55d512e245bc7699a8800e23df1a24195dd08217:

  Linux 3.6-rc5 (2012-09-08 16:43:45 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/devel-omap-device-for-v3.7

for you to fetch changes up to 47d85ec2a23552fd3d8b56778a23a5a843c5b9b1:

  Merge tag 'for_3.7-omap_device' of git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm into devel-omap-device (2012-09-12 21:17:56 -0700)

----------------------------------------------------------------

Kevin Hilman <khilman@ti.com>:

Updates for omap_device layer for v3.7.

Allows omap_device layer to keep track of driver bound status in order
to make more intelligent decisions about idling unused devices.

----------------------------------------------------------------
Kevin Hilman (3):
      ARM: OMAP: omap_device: keep track of driver bound status
      ARM: OMAP: omap_device: don't attempt late suspend if no driver bound
      ARM: OMAP: omap_device: idle devices with no driver bound

Tony Lindgren (1):
      Merge tag 'for_3.7-omap_device' of git://git.kernel.org/.../khilman/linux-omap-pm into devel-omap-device

 arch/arm/plat-omap/include/plat/omap_device.h |    2 +
 arch/arm/plat-omap/omap_device.c              |   56 ++++++++++++++++++++++---
 2 files changed, 53 insertions(+), 5 deletions(-)
