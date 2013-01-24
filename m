From: "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v4 0/8] MFD: ti_am335x_tscadc: DT support and TSC features
 addition
Date: Thu, 24 Jan 2013 09:15:04 +0530
Message-ID: <1358999112-31192-1-git-send-email-rachna@ti.com>
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
To: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, gururaja.hebbar-l0cyMroinI0@public.gmane.org, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>

This patch set is a cumulative set of [1] and [2] sent earlier.

Note that there are no code changes in either of the patch set,
only rebased on top of Linus's v3.8-rc3 tag to make sure that
all the patches apply without any conflicts.

This patch set has been tested on AM335x EVM.

[1] http://www.spinics.net/lists/linux-input/msg23060.html
[2] http://www.spinics.net/lists/linux-input/msg23090.html

Changes in v4:
	Subnodes and their properties documentation added.
	Non-standard properties prefixed with vendor name.

Changes in v3:
	No code change.

Changes in v2:
	Patch "input: ti_am335x_tsc: Add variance filter"
	from v1 has been dropped.
	Add MFD device DT node in AM335x EVM.

Patil, Rachna (8):
  input: ti_am335x_tsc: Step enable bits made configurable
  input: ti_am335x_tsc: Order of TSC wires, made configurable
  input: touchscreen: ti_tsc: remove unwanted fifo flush
  MFD: ti_am335x_tscadc: add device tree binding information
  MFD: ti_am335x_tscadc: Add DT support
  input: ti_am335x_tsc: Add DT support
  IIO: ti_am335x_adc: Add DT support
  arm/dts: AM335x-evm: Add TSC/ADC MFD device support

 .../devicetree/bindings/mfd/ti_am335x_tscadc.txt   |   52 ++++
 arch/arm/boot/dts/am335x-evm.dts                   |   13 +
 arch/arm/boot/dts/am33xx.dtsi                      |    8 +
 drivers/iio/adc/ti_am335x_adc.c                    |   26 +-
 drivers/input/touchscreen/ti_am335x_tsc.c          |  266 +++++++++++++++++---
 drivers/mfd/ti_am335x_tscadc.c                     |   28 ++-
 include/linux/input/ti_am335x_tsc.h                |   12 +
 include/linux/mfd/ti_am335x_tscadc.h               |   11 +-
 8 files changed, 364 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti_am335x_tscadc.txt

-- 
1.7.9.5
