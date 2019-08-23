From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/2] dts changes for omap variants for v5.4
Date: Fri, 23 Aug 2019 15:24:42 -0700
Message-ID: <pull-1566599057-142651@atomide.com-2>
References: <pull-1566599057-142651@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1566599057-142651@atomide.com>
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

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.4/dt-take2-signed

for you to fetch changes up to a27401cecf7795cda7e0c17751feb98fedbaa99d:

  ARM: dts: am335x-boneblue: Use of am335x-osd335x-common.dtsi (2019-08-13 04:51:31 -0700)

----------------------------------------------------------------
dts changes for omap variants for v5.4

Remove regulator-boot-off properties that we never had in the mainline
kernel so they won't do anything. We add stdout-path for gta04, and
make am335x-boneblue use am335x-osd335x-common.dtsi file.

----------------------------------------------------------------
David Lechner (1):
      ARM: dts: am335x-boneblue: Use of am335x-osd335x-common.dtsi

Ezequiel Garcia (2):
      ARM: dts: am335x-cm-t335: Remove regulator-boot-off property
      ARM: dts: omap3-n950-n9: Remove regulator-boot-off property

H. Nikolaus Schaller (1):
      ARM: dts: gta04: define chosen/stdout-path

 arch/arm/boot/dts/am335x-boneblue.dts | 92 +----------------------------------
 arch/arm/boot/dts/am335x-cm-t335.dts  |  1 -
 arch/arm/boot/dts/omap3-gta04.dtsi    |  4 ++
 arch/arm/boot/dts/omap3-n950-n9.dtsi  |  1 -
 4 files changed, 6 insertions(+), 92 deletions(-)
