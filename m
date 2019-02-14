From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/2] defconfig changes for omaps for v5.1
Date: Thu, 14 Feb 2019 10:13:05 -0800
Message-ID: <pull-1550167958-188990@atomide.com>
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

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.1/defconfig-signed

for you to fetch changes up to a8220ae7e740f8c568bd79ba38b6a3efe13100c1:

  ARM: omap2plus_defconfig: Update for moved options (2019-01-31 10:54:06 -0800)

----------------------------------------------------------------
Defconfig changes for omaps

Drop PROVE_LOCKING as it should not be enabled in the defconfig. It
causes quite a bit overhead as noted in the patch description.

Then let's update omap2plus_defconfig for dropped options and moved
options. That way makesavedefconfig can actually be used to generate
patches against omap2plus_defconfig.

----------------------------------------------------------------
Lukasz Luba (1):
      ARM: omap2plus_defconfig: remove PROVE_LOCKING from defconfig

Tony Lindgren (2):
      ARM: omap2plus_defconfig: Update for dropped options
      ARM: omap2plus_defconfig: Update for moved options

 arch/arm/configs/omap2plus_defconfig | 83 +++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 45 deletions(-)
