From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 0/1] Possibly fix USB OTG on GTA04 and N900
Date: Mon, 7 Oct 2013 16:28:12 +0300
Message-ID: <1381152493-28055-1-git-send-email-rogerq@ti.com>
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
To: bcousson@baylibre.com, pavel@ucw.cz, aaro.koskinen@iki.fi, marek@goldelico.com
Cc: devicetree@vger.kernel.org, tony@atomide.com, bigeasy@linutronix.de, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, kishon@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

USB OTG on these boards might be broken on Greg's usb-next branch [1]
after the Generic PHY framework and associated patches were merged.

This is a probable fix but I'm not able to test these boards. Please
give it a try and your Ack if it works. Thanks.

[1] - git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git

cheers,
-roger

Roger Quadros (1):
  ARM: dts: omap3:  Adapt USB OTG to generic PHY framework

 arch/arm/boot/dts/omap3-gta04.dts |    2 ++
 arch/arm/boot/dts/omap3-n900.dts  |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

-- 
1.7.4.1
