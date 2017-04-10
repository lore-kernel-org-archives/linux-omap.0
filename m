From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/2] omap defconfig changes for v4.12
Date: Mon, 10 Apr 2017 12:46:07 -0700
Message-ID: <4696.17455169118$1505299321@news.gmane.org>
References: <pull-1491846028-72246>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1491846028-72246>
In-Reply-To: <pull-1491846028-72246>
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

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.12/defconfig-signed

for you to fetch changes up to 25ea8207abb80652629670095d4a2e06915c4cd2:

  ARM: omap2plus_defconfig: Enable droid 4 devices (2017-04-10 09:29:40 -0700)

----------------------------------------------------------------
Defconfig updates for omaps for v4.12 merge window. Mostly
to update to use new ti-cpufreq driver, the rest is just
to enable drivers found on various devices:

- Update to use ti-cpufreq driver that we now have

- Enable SATA for ti81xx as a loadable module

- Enable Ethernet PHY for DP83848

- Enable modem related modules for PPP, QMI and USB ACM
  as loadable modules

- Enable droid 4 related drivers as lodable modules except
  for PMIC and regulator so eMMC can be used for root

----------------------------------------------------------------
Bartosz Golaszewski (1):
      ARM: omap2plus_defconfig: enable ahci-dm816 module

Dave Gerlach (1):
      ARM: omap2plus_defconfig: Enable support for ti-cpufreq

Roger Quadros (1):
      ARM: omap2plus_defconfig: Enable TI Ethernet PHY

Tony Lindgren (2):
      ARM: omap2plus_defconfig: Add QMI, ACM and PPP as loadable modules
      ARM: omap2plus_defconfig: Enable droid 4 devices

 arch/arm/configs/omap2plus_defconfig | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
