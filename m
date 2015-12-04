From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/6] Add usb support for dm814x and dra62x
Date: Fri,  4 Dec 2015 15:31:03 -0800
Message-ID: <1449271869-7614-1-git-send-email-tony@atomide.com>
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
To: linux-omap@vger.kernel.org
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>, Neil Armstrong <narmstrong@baylibre.com>, Philipp Rosenberger <ilu@linutronix.de>, Delio Brignoli <dbrignoli@audioscience.com>, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

These patches add usb support for dm814x and dra62x. These patches depend
on what's listed at the mmc patches at:

http://marc.info/?l=linux-omap&m=144919234321418&w=2

Regards,

Tony


Tony Lindgren (6):
  ARM: OMAP2+: Update 81xx clock and power domains for default, active
    and sgx
  ARM: OMAP2+: Add support for dm814x and dra62x usb
  ARM: dts: Add usb support for dm814x and dra62x
  ARM: dts: Add usb support for dm814x-evm
  ARM: dts: Add usb support for hp t410
  ARM: dts: Add usb support for j5-eco evm

 arch/arm/boot/dts/dm8148-evm.dts            |  24 ++++++
 arch/arm/boot/dts/dm8148-t410.dts           |  35 ++++++++
 arch/arm/boot/dts/dm814x.dtsi               | 125 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/dra62x-j5eco-evm.dts      |  21 +++++
 arch/arm/mach-omap2/clockdomains81xx_data.c |  29 +++----
 arch/arm/mach-omap2/cm81xx.h                |   6 +-
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c  |  38 +++++++--
 arch/arm/mach-omap2/powerdomains3xxx_data.c |  10 ++-
 8 files changed, 258 insertions(+), 30 deletions(-)

-- 
2.6.2
