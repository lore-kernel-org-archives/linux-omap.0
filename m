From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/3]  defconfig changes for v4.3
Date: Wed, 22 Jul 2015 02:41:18 -0700
Message-ID: <47644.8693465956$1437558186@news.gmane.org>
References: <pull-1437549432-994499>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1437549432-994499>
In-Reply-To: <pull-1437549432-994499>
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

The following changes since commit bc0195aad0daa2ad5b0d76cce22b167bc3435590:

  Linux 4.2-rc2 (2015-07-12 15:10:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap omap-for-v4.3/defconfig

for you to fetch changes up to da104dc845afbebcad6d87bd5810c266a426f4dc:

  ARM: omap2plus_defconfig: enable support for M25P80 SPI NOR (2015-07-16 00:54:53 -0700)

----------------------------------------------------------------
Sekhar Nori (4):
      ARM: omap2plus_defconfig: enable support for TI ADC
      ARM: omap2plus_defconfig: enable support for TI touchscreen
      ARM: omap2plus_defconfig: enable support for TI CPTS
      ARM: omap2plus_defconfig: enable support for M25P80 SPI NOR

 arch/arm/configs/omap2plus_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)
