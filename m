From: Luciano Coelho <coelho@ti.com>
Subject: [PATCH 0/4] ARM: dts: add WiLink support to panda and omap4-sdp
Date: Tue, 30 Jul 2013 20:27:24 +0300
Message-ID: <1375205248-25708-1-git-send-email-coelho@ti.com>
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
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: devicetree@vger.kernel.org, coelho@ti.com, linux-wireless@vger.kernel.org, balbi@ti.com, luca@coelho.fi, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

These patches add the necessary DT configuration to use the WLAN part
of WiLink on OMAP4 Pandaboard and on OMAP4-SDP (including Blaze).

I've tested these changes on Panda and it works fine.  But I couldn't
test the OMAP4 SDP changes properly on 3.11-rc3 because I'm having
problems with clocks and SDIO stuff.  So it's pretty much just
compiled tested.  I've tried this (without the new clock definition
stuff) on Blaze with 3.10 and it was working, though.

Please take a look and let me know what you think.

Luca.


Luciano Coelho (4):
  ARM: dts: omap4-panda: add MMC5 (WiLink WLAN) configuration
  arm: dts: omap4-panda-common: add WiLink6 device tree nodes
  ARM: dts: omap4-sdp: add MMC5 (WiLink WLAN) configuration
  arm: dts: omap4-sdp: add WiLink7 device tree node

 arch/arm/boot/dts/omap4-panda-common.dtsi | 45 +++++++++++++++++++++++++++-
 arch/arm/boot/dts/omap4-sdp.dts           | 49 +++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+), 1 deletion(-)

-- 
1.8.3.2
