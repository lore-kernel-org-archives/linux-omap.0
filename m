From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] wl1251 platform data changes for v3.14
Date: Mon, 9 Dec 2013 20:49:00 -0800
Message-ID: <20166.9351351031$1386650977@news.gmane.org>
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
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit 736e812636ea72be444b85fa7e92554967459069:

  ARM: OMAP2+: Remove unused platform init code and headers (2013-12-08 14:15:46 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.14/omap3-board-removal-wl1251

for you to fetch changes up to ce226391aec803a49b39c22d3385057c9db02f30:

  Merge branch 'wl1251-pdata' into omap-for-v3.14/omap3-board-removal (2013-12-09 19:39:51 -0800)

----------------------------------------------------------------

Minimal changes for the wl151 platform data that would otherwise
cause merge conflicts between the wireless tree and linux-omap
tree. This was discussed on the mailing lists here:

http://www.spinics.net/lists/linux-omap/msg99906.html

----------------------------------------------------------------
Luciano Coelho (1):
      wl1251: split wl251 platform data to a separate structure

Sebastian Reichel (1):
      wl1251: move power GPIO handling into the driver

Tony Lindgren (1):
      Merge branch 'wl1251-pdata' into omap-for-v3.14/omap3-board-removal

 drivers/net/wireless/ti/wilink_platform_data.c | 37 +++++++++++++++++++++-----
 drivers/net/wireless/ti/wl1251/sdio.c          | 31 ++++++++++++++-------
 drivers/net/wireless/ti/wl1251/spi.c           | 35 +++++++++++++++---------
 drivers/net/wireless/ti/wl1251/wl1251.h        |  2 +-
 include/linux/wl12xx.h                         | 24 +++++++++++++++--
 5 files changed, 97 insertions(+), 32 deletions(-)
