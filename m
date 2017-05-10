From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 00/10] usb: musb: tusb6010_omap: Convert to DMAengine
Date: Wed, 10 May 2017 11:42:22 +0300
Message-ID: <20170510084231.19302-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: b-liu@ti.com, tony@atomide.com, gregkh@linuxfoundation.org, vinod.koul@intel.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

Changes since v1:
- Fix the port_window support in omap-dma DMAengine driver
- MUSB_G_NO_SKB_RESERVE quirk flag addition to msub core
- packet size corruption fix for tusb6010
- Handle DMA completion for TX also in the DMA callback

The v1 series was tested with g_cdc where only the DMA was only enabled for TX
and because of that I have not noticed that the sDMA code was not correct for RX,
it only worked for TX case.

The ASYNC mode of tusb6010 is really unstable, we get corrupted TX/RX offset
register quite easily, but the SYNC mode is stable.

The series was tested on top of next-20170510 with g_ncm module since with this
we can use the quirk to avoid skb_reserve and get properly aligned buffers for
DMA.
The n810 is using nfsroot.

The device would not boot to prompt most of the time before patch 5 (packet size
reset fix).
With that patch in, the device would boot up fine most of the cases, but will
fail pretty fast with my stress test [1].
After the first 9 patch the legacy DMA mode is going to be stable with g_ncm, it
boots to prompt, and survives the stress test [1].

The last patch is going the DMAengine conversion and I have run the stress test
against it over 3 hours (ping-test.sh wrap count is 139).

[1] Running these in parallel:
ping -f 192.168.0.2
ping -f -s 2048 192.168.0.2
ping-test.sh 192.168.0.2 1

and (nfsroot) time to time:
scp root@192.168.0.1:/usr/portage/distfiles/thunderbird-52.1.0.source.tar.xz /

$ ls -alh /usr/portage/distfiles/thunderbird-52.1.0.source.tar.xz 
218M Apr 30 15:46 /usr/portage/distfiles/thunderbird-52.1.0.source.tar.xz

In essence copy 218M from my host back to the host.

ping-test.sh (modified version from Tony to show the wrap count):
#!/bin/bash

device=$1
size=$2
wraps=0

while [ 1 ]; do
        #echo "Pinging with size $size"
        if ! ping -w0 -c1 -s$size $device > /dev/null 2>&1; then
                break;
        fi
        size=$(expr $size + 1)

        if [ $size -gt 8192 ]; then
	        wraps=$(expr $wraps + 1)
		echo "wrapping ($wraps) at $size"
                size=1
        fi
done
echo "Test ran up to $size"

Regards,
Peter

CC: dmaengine@vger.kernel.org
I only send the cover letter and the DMAengine patch for the dmaengine list, the
rest can be checked - if there is interest - via lkml
---
Peter Ujfalusi (10):
  dmaengine: omap-dma: port_window support correction for both direction
  usb: musb: Add quirk to avoid skb reserve in gadget mode
  usb: musb: tusb6010: Add MUSB_G_NO_SKB_RESERVE to quirks
  usb: musb: tusb6010_omap: Use one musb_ep_select call in
    tusb_omap_dma_program
  usb: musb: tusb6010_omap: Do not reset the other direction's packet
    size
  usb: musb: tusb6010_omap: Create new struct for DMA data/parameters
  usb: musb: tusb6010_omap: Allocate DMA channels upfront
  usb: musb: tusb6010: Handle DMA TX completion in DMA callback as well
  ARM: OMAP2+: DMA: Add slave map entries for 24xx external request
    lines
  usb: musb: tusb6010_omap: Convert to DMAengine API

 arch/arm/mach-omap2/dma.c        |  24 +++
 drivers/dma/omap-dma.c           |  39 ++--
 drivers/usb/musb/musb_core.c     |   3 +
 drivers/usb/musb/musb_core.h     |   1 +
 drivers/usb/musb/tusb6010.c      |  21 +--
 drivers/usb/musb/tusb6010_omap.c | 391 ++++++++++++++++-----------------------
 6 files changed, 211 insertions(+), 268 deletions(-)

-- 
2.12.2
