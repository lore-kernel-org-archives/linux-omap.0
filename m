From: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Subject: [PATCH V3 0/2] ARM: dts: Add DT bindings for OMAP SDMA
Date: Tue, 26 Feb 2013 12:27:22 -0600
Message-ID: <1361903244-19837-1-git-send-email-jon-hunter@ti.com>
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
To: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: device-tree <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Adds device-tree bindings from SDMA on OMAP2+ devices. DMA client
bindings are also added for devices that have SPI and MMC bindings
populated. Client binding data is based upon existing HWMOD data for
OMAP and has been checked against OMAP documentation.

Please note that the underlying (legacy) OMAP SDMA driver has not been
ported over to DT and this still needs to be done. However, this allows
DMA clients to look-up the DMA resource information via device-tree.

Testing includes ...
1. Boot tested on OMAP3430 SDP board and OMAP4430 SDP board with
   without device-tree present.
2. Testing of MMC1 with SD card on OMAP3430 SDP board and OMAP4430
   SDP board with and without device-tree present.

Testing branch available here [1].

Series is based upon v3.8 on top of the following ...
- Vinod's topic/dmaengine_dt branch [3]
- Matt Porter's series "DMA Engine support for AM33XX" [4]
- Matt Porter's series "omap_hsmmc DT DMA Client support" [5]
- Sourav Poddar's series "add omap mcspi device tree data" [6]

V3 changes:
- Updated name of of_dma_filter_info and statically initialised
  filter_fn member of this structure per Arnd's feedback.

V2 changes:
- Updated to Tony's omap-for-v3.9/multiplatform-v2 branch to pull in
  DMA changes for v3.9
- Added comma to omap_dma_driver structure as pointed out by Arnd.
- Updated OMAP SDMA DT binding compatible strings to indicate which
  devices are bit compatible with each other with respect to the SDMA
  controller. Grant had mentioned in the past that he wants the
  compatible string to be based upon a particular device and not
  something generic like "ti,omap-sdma".

[1] https://github.com/jonhunter/linux/commits/dev-dt-dma
[2] git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git omap-for-v3.9/multiplatform-v2
[3] http://git.infradead.org/users/vkoul/slave-dma.git/shortlog/refs/heads/topic/dmaengine_dt
[4] http://permalink.gmane.org/gmane.linux.kernel.spi.devel/12508
[5] http://permalink.gmane.org/gmane.linux.ports.arm.omap/93165
[6] http://permalink.gmane.org/gmane.linux.kernel/1435002

Jon Hunter (2):
  ARM: dts: OMAP2+: Add SDMA controller bindings and nodes
  dmaengine: OMAP: Register SDMA controller with Device Tree DMA driver

 .../devicetree/bindings/dma/omap-sdma.txt          |   51 ++++++++++++++++++++
 arch/arm/boot/dts/omap2.dtsi                       |   12 +++++
 arch/arm/boot/dts/omap3.dtsi                       |   40 +++++++++++++++
 arch/arm/boot/dts/omap4.dtsi                       |   41 ++++++++++++++++
 arch/arm/boot/dts/omap5.dtsi                       |   41 ++++++++++++++++
 arch/arm/mach-omap2/dma.c                          |    4 ++
 drivers/dma/omap-dma.c                             |   38 ++++++++++++++-
 7 files changed, 225 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/omap-sdma.txt

-- 
1.7.10.4
