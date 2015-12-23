From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/3] reworked soc changes for ti81xx devices and minimal
 dra62x j5ec-evm support
Date: Tue, 22 Dec 2015 17:44:46 -0800
Message-ID: <40567.6560396843$1450835165@news.gmane.org>
References: <pull-1450834180-928842>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1450834180-928842>
In-Reply-To: <pull-1450834180-928842>
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

The following changes since commit f2e6a0a913b53f5af87c7e9a783ceae5bb4ae2c4:

  ARM: OMAP2+: Remove device creation for omap-pcm-audio (2015-12-17 10:34:41 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.5/81xx-soc-signed

for you to fetch changes up to f53850b5dc625ca37ae84b47f4f92b1d55df2aa0:

  ARM: OMAP2+: Add support for dm814x and dra62x usb (2015-12-22 16:23:08 -0800)

----------------------------------------------------------------
Add minimal SoC support for dra62x also known as j5eco. As it's closely
related to dm814x, we can treat it as a dm814x variant for now and do
rest of the configuration with DTS just files. And let's add hwmod
support for MMC and USB on dm814x and dra62x.

----------------------------------------------------------------
Tony Lindgren (4):
      ARM: OMAP2+: Fix SoC detection for dra62x j5-eco
      ARM: OMAP2+: Update 81xx clock and power domains for default, active and sgx
      ARM: OMAP2+: Add mmc hwmod entries for dm814x
      ARM: OMAP2+: Add support for dm814x and dra62x usb

 arch/arm/mach-omap2/clockdomains81xx_data.c |  29 +++---
 arch/arm/mach-omap2/cm81xx.h                |   6 +-
 arch/arm/mach-omap2/id.c                    |   4 +-
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c  | 131 ++++++++++++++++++++++++----
 arch/arm/mach-omap2/powerdomains3xxx_data.c |  10 ++-
 5 files changed, 139 insertions(+), 41 deletions(-)
