From: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Subject: [RFC 0/4] ARM: OMAP3+: Add device-tree support for timers
Date: Fri, 13 Jul 2012 17:19:30 -0500
Message-ID: <1342217976-29802-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Tarun Kanti DebBarma <tarun.kanti-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: device-tree <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This series adds device-tree support for the timers on OMAP3/4 devices. Once
everyone is happy with the implementation I can add support for OMAP2/5 devices
too.

Testing:
- I have tested the all the timers (not used by the kernel as sys-timers) on
  both OMAP3430 Beagle and OMAP4460 Panda with/without device-tree with this
  series.
- The testing includes
	- Configuring, starting a timer and checking the counter value is
	  incrementing.
	- Testing timer overflow interrupt when timer expires.
	- Using different clock sources to operate the timer with.
	- Using DT to provide resource information for IRQ and memory by
	  removing Benoit's intention "HACK" in commit a4f6cdb0 (ARM: OMAP:
	  omap_device: Add omap_device_[alloc|delete] for DT integration)

Jon Hunter (4):
  arm/dts: OMAP: Add timer nodes
  ARM: OMAP3: Dynamically disable secure timer nodes for secure devices
  ARM: OMAP4: Add timer clock aliases for device-tree
  ARM: OMAP: Add DT support for timer driver

 .../devicetree/bindings/arm/omap/timer.txt         |   34 +++++++
 arch/arm/boot/dts/omap3.dtsi                       |  104 ++++++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi                       |   93 +++++++++++++++++
 arch/arm/mach-omap2/board-generic.c                |    1 +
 arch/arm/mach-omap2/clock44xx_data.c               |   12 +++
 arch/arm/mach-omap2/common.h                       |    1 +
 arch/arm/mach-omap2/timer.c                        |   40 ++++++++
 arch/arm/plat-omap/dmtimer.c                       |   32 ++++--
 8 files changed, 311 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/timer.txt

-- 
1.7.9.5
