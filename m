From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 4/5] omap pm regulator changes for v3.5 merge window
Date: Mon, 7 May 2012 15:38:43 -0700
Message-ID: <E1SRWaP-0004gj-IP@merlin.infradead.org>
References: <pull-1336430323-742388>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1336430323-742388>
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

The following changes since commit 69964ea4c7b68c9399f7977aa5b9aa6539a6a98a:

  Linux 3.4-rc5 (2012-04-29 15:19:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-pm-regulator-for-v3.5

for you to fetch changes up to a8822e2d570bc265c9fa0347710fbcc7bef8b327:

  Merge branch 'for_3.4/pm/smps-regulator' of git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm into pm-regulator (2012-04-30 10:08:29 -0700)

----------------------------------------------------------------

Add support for vdd1 and vdd2 regulators and make voltage code to use them

----------------------------------------------------------------
Kevin Hilman (3):
      ARM: OMAP2+: voltage: ensure voltage used is exact voltage from OPP table
      Merge tag 'topic/twl' into for_3.4/pm/smps-regulator
      Merge branch 'pm-wip/smps-regulator' into for_3.4/pm/smps-regulator

Tero Kristo (4):
      arm: omap3: voltage: fix channel configuration
      arm: omap3: add common twl configurations for vdd1 and vdd2
      arm: omap3: twl: add external controllers for core voltage regulators
      arm: omap4: add common twl configurations for vdd1, vdd2 and vdd3

Tony Lindgren (1):
      Merge branch 'for_3.4/pm/smps-regulator' of git://git.kernel.org/.../khilman/linux-omap-pm into pm-regulator

 arch/arm/mach-omap2/twl-common.c  |  147 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/vc3xxx_data.c |    1 +
 arch/arm/mach-omap2/voltage.c     |   21 +++++-
 3 files changed, 166 insertions(+), 3 deletions(-)
