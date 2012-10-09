From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 5/5] omap asoc regression fixes for v3.7-rc1
Date: Tue, 9 Oct 2012 11:46:27 -0700
Message-ID: <E1TLepo-0002qk-TQ@merlin.infradead.org>
References: <pull-1349808387-617119>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1349808387-617119>
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

The following changes since commit 5e090ed7af10729a396a25df43d69a236e789736:

  Merge tag 'soc-late' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc (2012-10-07 20:55:16 +0900)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.7-rc1/fixes-asoc-regression-signed

for you to fetch changes up to 8bbacc55ba72368d7fdbad06b63d66bd763a428a:

  ARM/dts: omap5-evm: pinmux configuration for audio (2012-10-08 16:06:28 -0700)

----------------------------------------------------------------
This branch contains regression fixes for omap4/5 ASoC
audio that were caused by the fact that u-boot stopped
muxing non essential pins.

As omap audio and dmaengine development happens on
these platforms, let's make sure they are usable.

Of course this should have been fixed earlier and
not during the -rc cycle.

----------------------------------------------------------------
Peter Ujfalusi (9):
      ARM: OMAP: board-4430-sdp: Pin mux configuration for audio needs
      ARM: OMAP: board-omap4panda: Pin mux configuration for audio needs
      ARM/dts: omap4-panda: Disable unused audio IPs
      ARM/dts: omap4-sdp: Disable unused McBSP3
      ARM/dts: omap5-evm: Disable unused McBSP3
      ARM/dts: omap4-sdp: pinmux configuration for audio
      ARM/dts: omap4-panda: pinmux configuration for audio
      ARM/dts: Add pinctrl driver entries for omap5
      ARM/dts: omap5-evm: pinmux configuration for audio

 arch/arm/boot/dts/omap4-panda.dts      |   47 ++++++++++++++++++++++++++
 arch/arm/boot/dts/omap4-sdp.dts        |   57 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap5-evm.dts        |   58 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap5.dtsi           |   17 ++++++++++
 arch/arm/mach-omap2/board-4430sdp.c    |   26 ++++++++++++++
 arch/arm/mach-omap2/board-omap4panda.c |   15 +++++++++
 6 files changed, 220 insertions(+)
