From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/3] soc changes for omaps for v4.20
Date: Wed, 26 Sep 2018 10:40:43 -0700
Message-ID: <pull-1537983432-167273@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
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

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.20/soc-signed

for you to fetch changes up to 6e77137927639fad66e17c06b50fd319d6b59833:

  ARM: OMAP2+: Convert to using %pOFn instead of device_node.name (2018-09-07 10:50:03 -0700)

----------------------------------------------------------------
SoC changes for omap variants

These changes improve support for clkctrl clocks to deal with
split memory ranges for clkctrl providers. And to use %pOFn
instead of device_node.name.

----------------------------------------------------------------
Rob Herring (1):
      ARM: OMAP2+: Convert to using %pOFn instead of device_node.name

Tero Kristo (1):
      ARM: OMAP2+: hwmod_core: improve the support for clkctrl clocks

Tony Lindgren (1):
      Merge commit '1dbcb97c656eed1a244c960b8b3a469c3d20ce7b' into omap-for-v4.20/soc

 arch/arm/mach-omap2/omap_hwmod.c | 125 +++++++++++++++++++++++++++------------
 1 file changed, 88 insertions(+), 37 deletions(-)
