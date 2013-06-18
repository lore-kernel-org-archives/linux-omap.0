From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/7] omap voltdomain clean-up for v3.11 merge window
Date: Tue, 18 Jun 2013 11:07:25 -0700
Message-ID: <E1Up0Jv-0007pf-QB@merlin.infradead.org>
References: <pull-1371578847-800598>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1371578847-800598>
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

The following changes since commit 7d132055814ef17a6c7b69f342244c410a5e000f:

  Linux 3.10-rc6 (2013-06-15 11:51:07 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.11/pm-voltdomain-signed

for you to fetch changes up to 8bfdfc87dc3d00eb2f33e972b4177c36ca0e3d54:

  Merge tag 'omap-pm-v3.11/voltdm' of git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm into omap-for-v3.11/pm-voltdomain (2013-06-18 01:08:39 -0700)

----------------------------------------------------------------

PM voltage domain clean-up via Kevin Hilman <khilman@linaro.org>:

OMAP: PM: remove requirement for voltage domain data; remove dummy data

----------------------------------------------------------------
Rajendra Nayak (2):
      ARM: OMAP2+: Powerdomain: Remove the need to always have a voltdm associated to a pwrdm
      ARM: AM33xx: Remove the unused voltagedomain data

Tony Lindgren (1):
      Merge tag 'omap-pm-v3.11/voltdm' of git://git.kernel.org/.../khilman/linux-omap-pm into omap-for-v3.11/pm-voltdomain

 arch/arm/mach-omap2/Makefile                  |  1 -
 arch/arm/mach-omap2/io.c                      |  1 -
 arch/arm/mach-omap2/powerdomain.c             |  5 ++++
 arch/arm/mach-omap2/powerdomain.h             |  2 ++
 arch/arm/mach-omap2/prm33xx.c                 |  7 +++++
 arch/arm/mach-omap2/voltage.h                 |  1 -
 arch/arm/mach-omap2/voltagedomains33xx_data.c | 43 ---------------------------
 7 files changed, 14 insertions(+), 46 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/voltagedomains33xx_data.c
