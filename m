From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 4/5] omap soc changes for v3.10 merge window
Date: Mon, 8 Apr 2013 21:51:02 -0700
Message-ID: <E1UPQWr-0007y9-Sb@merlin.infradead.org>
References: <pull-1365483063-475562>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1365483063-475562>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit 31880c37c11e28cb81c70757e38392b42e695dc6:

  Linux 3.9-rc6 (2013-04-07 20:49:54 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.10/soc-signed

for you to fetch changes up to 7a9819950f47dbf319895ee78220f2761f3687a3:

  ARM: OMAP4: Enable fix for Cortex-A9 erratas (2013-04-08 16:14:51 -0700)

----------------------------------------------------------------
Changes needed for enabling SOC_BUS for the SoC revision
information. Also enable few HW errata workarounds for omap4.

----------------------------------------------------------------
Ruslan Bilovol (3):
      ARM: OMAP2+: Move common part of late init into common function
      ARM: OMAP2+: SoC name and revision unification
      ARM: OMAP2+: Export SoC information to userspace

Sricharan R (1):
      ARM: OMAP4: Enable fix for Cortex-A9 erratas

 arch/arm/mach-omap2/Kconfig  |  3 ++
 arch/arm/mach-omap2/common.h |  8 ++++
 arch/arm/mach-omap2/id.c     | 95 ++++++++++++++++++++++++++++++++++++++++----
 arch/arm/mach-omap2/io.c     | 34 ++++++++--------
 4 files changed, 114 insertions(+), 26 deletions(-)
