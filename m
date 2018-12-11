From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] few device fixes for omaps for v4.20-rc cycle
Date: Tue, 11 Dec 2018 07:58:47 -0800
Message-ID: <pull-1544543892-150996@atomide.com>
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

The following changes since commit 91e43395820baad80248987608216c35da9df65b:

  Merge branch 'fixes-dts' into omap-for-v4.20/fixes (2018-11-08 09:32:24 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.20/fixes-rc6

for you to fetch changes up to 84fb6c7feb1494ebb7d1ec8b95cfb7ada0264465:

  ARM: dts: Fix OMAP4430 SDP Ethernet startup (2018-12-07 09:10:49 -0800)

----------------------------------------------------------------
Few device fixes for omaps

Here's a collection of minor fixes for annoying usability issues
people have noticed using various devices.

There are two regression fixes:

- A regression fix for omap5 usb3 dual role mode

- A regression fix to ams-delta audio being muted permanently

And two one-liners:

- Fix polarity for am335x-pdu001 SD card detection

- Fix non-working omap4-sdp Ethernet startup for rebind

It would be nice to get these merged during the -rc cycle if
possible. Naturally these can all wait for the merge window too
if we start running out of time.

----------------------------------------------------------------
Felix Brack (1):
      ARM: dts: am335x-pdu001: Fix polarity of card detection input

Janusz Krzysztofik (1):
      ARM: OMAP1: ams-delta: Fix audio permanently muted

Roger Quadros (1):
      ARM: dts: omap5: Fix dual-role mode on Super-Speed port

Russell King - ARM Linux (1):
      ARM: dts: Fix OMAP4430 SDP Ethernet startup

Tony Lindgren (1):
      Merge branch 'audio-fix' into omap-for-v4.20/fixes

 arch/arm/boot/dts/am335x-pdu001.dts       | 2 +-
 arch/arm/boot/dts/omap4-sdp.dts           | 1 +
 arch/arm/boot/dts/omap5-board-common.dtsi | 1 +
 arch/arm/mach-omap1/board-ams-delta.c     | 6 ++++--
 4 files changed, 7 insertions(+), 3 deletions(-)
