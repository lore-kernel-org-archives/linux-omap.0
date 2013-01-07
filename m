From: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 00/10] video: da8xx-fb: DT support
Date: Mon, 7 Jan 2013 10:40:02 +0530
Message-ID: <cover.1357304090.git.afzal@ti.com>
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
To: Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Vaibhav Hiremath <hvaibhav-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

This series adds DT support to da8xx-fb driver (device found on
DaVinci and AM335x SoC's). It does certain cleanup's in the process.

This makes use of Steffen Trumtrar's v16 of display timing DT support.

Testing has been done on AM335x SoC based boards like AM335x EVM and
AM335x EVM-SK. It has also been verified that display on DA850 EVM
(non-DT boot) works as earlier.

Another series that adds DT nodes for AM335x SoC/board would follow
this.

This series is based on v3.8-rc2,
 and is dependent on,
1. Series v16 "of: add display helper" by,
	Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
2. Patch "da8xx: Allow use by am33xx based devices" by,
	Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
3. Series v2 "video: da8xx-fb: runtime timing configuration" by,
	me (Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>)

To test this series on AM335x based boards,
1. Series "ARM: dts: AM33XX: lcdc support" by,
	me (Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>),
as well as,
2. Series "HWMOD fixes for AM33xx PWM submodules and device tree nodes" by,
	Philip, Avinash <avinashphilip-l0cyMroinI0@public.gmane.org>
would be needed.

A tree with all above dependencies (and below mentioned hack) is available
 @git://gitorious.org/x0148406-public/linux-kernel.git da8xx-fb-dt

In the case of AM335x, in addition to this series, display PLL has to
be locked to required frequency. Unless bootloader configures it
properly, a hack would required in the Kernel. This is also present in
the above mentioned branch of the tree. A solution in the Kernel
is being worked upon and would be posted at the earliest.


Regards
Afzal

Afzal Mohammed (9):
  video: da8xx-fb: enable sync lost intr for v2 ip
  video: da8xx-fb: use devres
  video: da8xx-fb: ensure non-null cfg in pdata
  video: da8xx-fb: reorganize panel detection
  video: da8xx-fb: minimal dt support
  video: da8xx-fb: invoke platform callback safely
  video: da8xx-fb: obtain fb_videomode info from dt
  video: da8xx-fb: ensure pdata only for non-dt
  video: da8xx-fb: setup struct lcd_ctrl_config for dt

Manjunathappa, Prakash (1):
  video: da8xx-fb: fix 24bpp raster configuration

 .../devicetree/bindings/video/fb-da8xx.txt         |   36 +++++
 drivers/video/da8xx-fb.c                           |  145 +++++++++++++-------
 2 files changed, 132 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/video/fb-da8xx.txt

-- 
1.7.9.5
