From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 4/4] defconfig changes for omaps for v4.16
Date: Fri, 22 Dec 2017 10:14:27 -0800
Message-ID: <pull-1513966338-859035@atomide.com-4>
References: <pull-1513966338-859035@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1513966338-859035@atomide.com>
In-Reply-To: <pull-1513966338-859035@atomide.com>
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

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.16/defconfig-signed

for you to fetch changes up to d03366dcbffcc3754f9f8a1d8ae74f438312e07d:

  ARM: multi_v7_defconfig: Enable CONFIG_PCI_DRA7XX (Host & Device modes) (2017-12-21 07:12:44 -0800)

----------------------------------------------------------------
Two defconfig updates for omaps

These are to configure dra7 PCIe for omap2plus_defconfig and
multi_v7_defconfig.

----------------------------------------------------------------
Kishon Vijay Abraham I (2):
      ARM: omap2plus_defconfig: Enable CONFIG_PCI_DRA7XX (Host & Device modes)
      ARM: multi_v7_defconfig: Enable CONFIG_PCI_DRA7XX (Host & Device modes)

 arch/arm/configs/multi_v7_defconfig  | 6 ++++++
 arch/arm/configs/omap2plus_defconfig | 8 ++++++++
 2 files changed, 14 insertions(+)
