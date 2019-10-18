From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/2] Better voltage controller configuration for droid4
Date: Fri, 18 Oct 2019 15:21:05 -0700
Message-ID: <20191018222107.32917-1-tony@atomide.com>
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
Cc: Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>, linux-arm-kernel@lists.infradead.org, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

Here are two more patches to change droid4 to use low-speed configuration
like the Motorola Mapphone Android Linux kernel does.

This gains us a power saving of 7mW bringing the whole device power
consumption in retention idle mode to about 32mW between wakeups with
screen blanked, modem off, usb and phy modules unloaded and wlan
connected. That's about the same number as I measured Android do in
flight mode suspended.

With the pending modem patches with modem online, I'm now seeing average
power consumption of about 60 - 70mW for the whole device as measured
once a minute from /sys/class/power_supply/battery/power_avg.

The patches are against v5.4-rc1 on top of the related patches:

[PATCH 0/8] Improve PM for omap4 devices

Regards,

Tony


Tony Lindgren (2):
  ARM: OMAP2+: Configure voltage controller for retention
  ARM: OMAP2+: Configure voltage controller for cpcap to low-speed

 arch/arm/mach-omap2/pmic-cpcap.c | 18 ++++++++++++-----
 arch/arm/mach-omap2/vc.c         | 34 ++++++++++++++++++++++++++++----
 arch/arm/mach-omap2/vc.h         |  2 +-
 3 files changed, 44 insertions(+), 10 deletions(-)

-- 
2.23.0
