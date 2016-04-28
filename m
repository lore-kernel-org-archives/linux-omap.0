From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/3] omap defconfig changes for v4.7 merge window
Date: Thu, 28 Apr 2016 10:25:08 -0700
Message-ID: <29691.4887651385$1461864376@news.gmane.org>
References: <pull-1461856674-976179>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1461856674-976179>
In-Reply-To: <pull-1461856674-976179>
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
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.7/defconfig-signed

for you to fetch changes up to 714749313da9800ecc10bfc2bfab87540a349e97:

  ARM: omap2plus_defconfig: Enable PWM and ir-rx51 as loadable modules (2016-04-27 09:40:09 -0700)

----------------------------------------------------------------
Defconfig changes for omap2plus_defconfig for v4.7 merge window.
Mostly enable drivers used on various boards as loadable modules
where possible. Also one warning fix related to RXKAD changes
heading to v4.7. And run make save_defconfig to shrink down the
size a bit.

----------------------------------------------------------------
Javier Martinez Canillas (1):
      ARM: omap2plus_defconfig: Fix warning due invalid RXKAD symbol value

Lokesh Vutla (1):
      ARM: omap2plus_defconfig: Enable GPIO_TPIC2810

Nishanth Menon (1):
      ARM: omap2plus_defconfig: Enable DP83867 support

Tony Lindgren (3):
      ARM: omap2plus_defconfig: Update with make savedefconfig
      ARM: omap2plus_defconfig: Enable twl6030 USB phy as loadable module
      ARM: omap2plus_defconfig: Enable PWM and ir-rx51 as loadable modules

Yegor Yefremov (1):
      ARM: omap2plus_defconfig: Enable MDIO Bus/PHY emulation support

 arch/arm/configs/omap2plus_defconfig | 66 ++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 36 deletions(-)
