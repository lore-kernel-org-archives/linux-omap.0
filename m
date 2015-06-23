From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 0/5] drivers/rtc/rtc-ds1307.c: Basic cleanups and support
 for wakeupirq
Date: Tue, 23 Jun 2015 11:15:09 -0500
Message-ID: <1435076114-12416-1-git-send-email-nm@ti.com>
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
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Alessandro Zummo <a.zummo@towertech.it>
Cc: Nishanth Menon <nm@ti.com>, grygorii.strashko@ti.com, rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

Here is the revamp of the patch posted eariler to support wakeupirq.
This series does a few cleanups as well prior to introducing the
generic apis required to support the wakeirq mechanism used on certain
TI SoCs. Cleanups done here are just minimal set of the cleanups we
discussed in [2].

Series is based on next-20150623

Test log: http://pastebin.ubuntu.com/11763002/

NOTE1: I have only tested in mcp79410 device, and not on other
ds1307-rtc driver compatbile devices as I dont have any other.
additional testing might be nice to have.
NOTE2: there are additional fixes that linux-next seems to need but
those are in omap-rtc, cpufreq etc, but those are not related by the
ds-1307.

V1: https://patchwork.kernel.org/patch/4759171/

NOTE: Patch 5/5 of the series is meant to indicate the usage, and will
be reposted along with other wakeup sources to be enabled once the
driver changes are accepted.

Felipe Balbi (1):
  drivers/rtc/rtc-ds1307.c: Convert to threaded IRQ

Nishanth Menon (4):
  drivers/rtc/rtc-ds1307.c: Switch to managed irq allocation
  drivers/rtc/rtc-ds1307.c: Sort the headers
  drivers/rtc/rtc-ds1307.c: Support optional wakeup interrupt source
  (TMP) ARM: dts: am57xx-beagle-x15: Add wakeup irq for mcp79410

 arch/arm/boot/dts/am57xx-beagle-x15.dts |    3 +-
 drivers/rtc/rtc-ds1307.c                |  110 +++++++++++++++++--------------
 2 files changed, 63 insertions(+), 50 deletions(-)

-- 
1.7.9.5

[2] https://patchwork.kernel.org/patch/6245101/
