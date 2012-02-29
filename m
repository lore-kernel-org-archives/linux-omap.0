From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/5] First set of omap SoC related changes
Date: Wed, 29 Feb 2012 12:15:06 -0800
Message-ID: <E1S2pve-0004SY-RX@merlin.infradead.org>
References: <pull-1330546506-268554>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1330546506-268554>
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


This contains two changes that were too late
for the previous merge window so let's get these
out of the way first.

Regards,

Tony


The following changes since commit dcd6c92267155e70a94b3927bce681ce74b80d1f:
  Linus Torvalds (1):
        Linux 3.3-rc1

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap soc

Tony Lindgren (1):
      Merge branch 'soc-part2' into soc

Vaibhav Hiremath (2):
      ARM: OMAP2+: Make cpu_rev static global variable
      ARM: OMAP2+: split omap2/3/4_check_revision function

 arch/arm/mach-omap2/id.c              |  186 ++++++++++++++-------------------
 arch/arm/mach-omap2/io.c              |    9 ++-
 arch/arm/plat-omap/include/plat/cpu.h |    7 +-
 3 files changed, 92 insertions(+), 110 deletions(-)
