From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/3] omap defconfig updates for v4.9 merge window
Date: Thu,  1 Sep 2016 08:45:21 -0700
Message-ID: <28889.6608203233$1505291655@news.gmane.org>
References: <pull-1472744519-445833>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1472744519-445833>
In-Reply-To: <pull-1472744519-445833>
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

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.9/defconfig-signed

for you to fetch changes up to f56e6fe09c7848f0a299e661153977372a11abad:

  ARM: omap2plus_defconfig: switch to the IIO BMP085 driver (2016-08-26 08:45:38 -0700)

----------------------------------------------------------------
A patch from Linus Walleij <linus.walleij@linaro.org> to switch to use
generic IIO BMP280 driver instead of the BMP085.

----------------------------------------------------------------
Linus Walleij (1):
      ARM: omap2plus_defconfig: switch to the IIO BMP085 driver

 arch/arm/configs/omap2plus_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
