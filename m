From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] few omap regression fixes for v3.7-rc5
Date: Wed, 21 Nov 2012 13:46:22 -0800
Message-ID: <20121121214622.GH18567@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
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

The following changes since commit 3d70f8c617a436c7146ecb81df2265b4626dfe89:

  Linux 3.7-rc4 (2012-11-04 11:07:39 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.7-rc5/fixes-signed

for you to fetch changes up to 1ef43369c681bf30a980a4ba42df20514b15fdda:

  ARM: OMAP4: TWL: mux sys_drm_msecure as output for PMIC (2012-11-12 14:11:47 -0800)

----------------------------------------------------------------
Few more regression fixes related to u-boot only muxing
essential pins.

----------------------------------------------------------------
Anders Hedlund (1):
      ARM: OMAP3: igep0020: Set WIFI/BT GPIO pins in correct mux mode

Javier Martinez Canillas (1):
      ARM: OMAP: Add maintainer entry for IGEP machines

Kevin Hilman (1):
      ARM: OMAP4: TWL: mux sys_drm_msecure as output for PMIC

 MAINTAINERS                          | 8 ++++++++
 arch/arm/mach-omap2/board-igep0020.c | 5 +++++
 arch/arm/mach-omap2/twl-common.c     | 1 +
 3 files changed, 14 insertions(+)
