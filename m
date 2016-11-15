From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 5/5] omap defconfig changes for v4.10
Date: Tue, 15 Nov 2016 13:22:23 -0800
Message-ID: <32558.9610067711$1505294607@news.gmane.org>
References: <pull-1479236877-351747>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1479236877-351747>
In-Reply-To: <pull-1479236877-351747>
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

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.10/defconfig-signed

for you to fetch changes up to 9c106e4efab2ec96daebb7bdd0bb61602fd52e7a:

  ARM: omap2plus_defconfig: Run make savedefconfig to save some space (2016-11-15 11:01:24 -0800)

----------------------------------------------------------------
Defconfig changes for omaps for v4.10 merge window:

- Enable tsc2004 touchscreen as a loadable module

- Enable REGULATOR_GPIO, dra71-evm needs this for MMC voltage

- Enable LP873x PMICs for dra71x-evm

- Run make savedefconfig to save some space and make it
  easier to generate minimal patches against it

----------------------------------------------------------------
Adam Ford (1):
      ARM: omap2plus_defconfig: Enable TOUCHSCREEN_TSC2004

Lokesh Vutla (2):
      ARM: omap2plus_defconfig: Enable REGULATOR_GPIO
      ARM: omap2plus_defconfig: Enable LP873X support

Tony Lindgren (1):
      ARM: omap2plus_defconfig: Run make savedefconfig to save some space

 arch/arm/configs/omap2plus_defconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)
