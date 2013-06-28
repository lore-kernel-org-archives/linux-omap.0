From: Hebbar Gururaja <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/4] rtc: omap: handle rtc wakeup support in driver
Date: Fri, 28 Jun 2013 15:05:05 +0530
Message-ID: <1372412109-986-1-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

rtc-omap driver modules is used both by OMAP1/2, Davinci SoC platforms.

However, rtc wake support on OMAP1 is broken. Hence the
device_init_wakeup() was removed from rtc-omap driver and moved to
platform board files that supported it (DA850/OMAP-L138). [1]

However, recently [2] it was suggested that driver should always do a
device_init_wakeup(dev, true). Platforms that don't want/need
wakeup support can disable it from userspace via:

    echo disabled > /sys/devices/.../power/wakeup

Also, with the new DT boot-up, board file doesn't exist and hence there
is no way to have device wakeup support rtc.

The fix for above issues, is to hard code device_init_wakeup() inside
driver and let platforms that don't need this, handle it through the
sysfs power entry.


Also, update Davinci & AM335x files to above changes.

[1]
https://patchwork.kernel.org/patch/136731/

[2]
http://www.mail-archive.com/davinci-linux-open-source@linux.
davincidsp.com/msg26077.html

Hebbar Gururaja (4):
  rtc: omap: restore back (hard-code) wakeup support
  davinci: da8xx/omap-l1: Remove hard coding of rtc device wakeup
  rtc: omap: add rtc wakeup support to alarm events
  ARM: dts: AM33XX: update rtc node compatibility

 Documentation/devicetree/bindings/rtc/rtc-omap.txt |    6 +-
 arch/arm/boot/dts/am33xx.dtsi                      |    2 +-
 arch/arm/mach-davinci/devices-da8xx.c              |    9 +--
 drivers/rtc/rtc-omap.c                             |   58 +++++++++++++++++---
 4 files changed, 58 insertions(+), 17 deletions(-)

-- 
1.7.9.5
