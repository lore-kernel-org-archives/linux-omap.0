From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/4] non-urgent dts fixes for omaps for v4.14
Date: Tue, 15 Aug 2017 09:52:25 -0700
Message-ID: <9069.23417137495$1505308704@news.gmane.org>
References: <pull-1502815785-702769>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1502815785-702769>
In-Reply-To: <pull-1502815785-702769>
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

The following changes since commit ff570a01b1bd15cf8a87c9ea774fc9c52ea07f15:

  ARM: dts: dra71-evm: mdio: Fix impedance values (2017-07-05 00:54:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.14/fixes-not-urgent-dt-signed

for you to fetch changes up to 83f51f06d132c5430b4ac5065ce3594fc4c99aaa:

  ARM: dts: dra72-evm-revc: workaround incorrect DP83867 RX_CTRL pin strap (2017-08-10 10:32:17 -0700)

----------------------------------------------------------------
Two non-urgent dts fixes for dra7 Ethernet quirk. These are sent
separately from the rest of the dts changes to avoid merge conflicts
as these depend on earlier fixes sent during v4.13-rc cycle.

----------------------------------------------------------------
Sekhar Nori (2):
      ARM: dts: dra71-evm: workaround incorrect DP83867 RX_CTRL pin strap
      ARM: dts: dra72-evm-revc: workaround incorrect DP83867 RX_CTRL pin strap

 arch/arm/boot/dts/dra71-evm.dts      | 2 ++
 arch/arm/boot/dts/dra72-evm-revc.dts | 2 ++
 2 files changed, 4 insertions(+)
