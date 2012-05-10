From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 9/10] omap devicetree updates for v3.5 merge window
Date: Thu, 10 May 2012 11:39:19 -0700
Message-ID: <E1SSYIl-0006IZ-6i@merlin.infradead.org>
References: <pull-1336675159-747052>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1336675159-747052>
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

The following changes since commit b3431f5ba402a98a89b78a9408b4972d8870df4d:

  arm/dts: OMAP3: Add mmc controller nodes and board data (2012-03-14 21:54:57 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-dt-for-v3.5

for you to fetch changes up to 40364b9f5a4d167d97bb6a76cd239ca8cfff056a:

  arm/dts: omap4-panda: Add LEDs support (2012-05-09 17:18:03 -0700)

----------------------------------------------------------------
Minor DT updates based on the dt-missed-3.4 branch

----------------------------------------------------------------
Benoit Cousson (3):
      arm/dts: twl4030: Add twl4030-gpio node
      arm/dts: omap4-sdp: Add LEDs support
      arm/dts: omap4-panda: Add LEDs support

Peter Ujfalusi (2):
      OMAP4: devices: Do not create dmic device if the dtb has been provided
      OMAP4: devices: Do not create mcpdm device if the dtb has been provided

 arch/arm/boot/dts/omap4-panda.dts |   15 +++++++++++++
 arch/arm/boot/dts/omap4-sdp.dts   |   43 +++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/twl4030.dtsi    |    8 +++++++
 arch/arm/mach-omap2/devices.c     |    7 +++---
 4 files changed, 70 insertions(+), 3 deletions(-)
