From: Suman Anna via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: [PATCH 0/2] Dual MMU support for TI DRA7xx DSPs
Date: Thu, 31 Aug 2017 08:14:00 -0500
Message-ID: <20170831131402.29502-1-s-anna@ti.com>
Reply-To: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Joerg,

The following two patches enhance the OMAP IOMMU driver to support
mirror-programming of two MMUs present within the DSP subsystems 
specifically on TI DRA7xx/AM57xx family of SOCs. The TI OMAP DSP
subsystems traditionally always has a DSP core and an internal EDMA
block behind a single MMU within the subsystem, but DRA7xx DSP SoCs
now separate these out and the blocks are behind an individual MMU
and a dedicated port to connect to the interconnect. The DT usage
for these will be of the form,
	
	dsp1: dsp@40800000 {
		...
		iommus = <&mmu0_dsp1>, <&mmu1_dsp1>;
		...
	};

The series is based on your current 4.13 based arm/omap branch. The
patches add the support in the driver, but the MMU devices themselves
are still not created. There are two separate series (Add hwmod data
for IPU & DSP processors/MMUs [1] and Enable DRA7 processor MMU DT
nodes [2]) that add these patches, and will go through Tony and the
linux-omap tree. The consumer nodes/client drivers are still in-progress
and will depend on this series being merged first. Series is tested
along-side these two additional series and adding the other consumer
patches, no change in behavior with just these patches.

regards
Suman

[1] https://marc.info/?l=linux-omap&m=150335933714097&w=2
[2] https://marc.info/?l=linux-omap&m=150335958414166&w=2

Following is an output of sysfs with these MMUs exercised
with additional patches:

root@dra7xx-evm:~# ls -l /sys/kernel/iommu_groups/
drwxr-xr-x    3 root     root             0 Aug  8 03:59 0
drwxr-xr-x    3 root     root             0 Aug  8 03:59 1
drwxr-xr-x    3 root     root             0 Aug  8 03:59 2
drwxr-xr-x    3 root     root             0 Aug  8 03:59 3
drwxr-xr-x    3 root     root             0 Aug  8 03:59 4
drwxr-xr-x    3 root     root             0 Aug  8 03:59 5
root@dra7xx-evm:~# ls -l /sys/kernel/iommu_groups/*/devices
/sys/kernel/iommu_groups/0/devices:
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 40800000.dsp -> ../../../../devices/platform/44000000.ocp/40800000.dsp

/sys/kernel/iommu_groups/1/devices:

/sys/kernel/iommu_groups/2/devices:
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 58820000.ipu -> ../../../../devices/platform/44000000.ocp/58820000.ipu

/sys/kernel/iommu_groups/3/devices:
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 55020000.ipu -> ../../../../devices/platform/44000000.ocp/55020000.ipu

/sys/kernel/iommu_groups/4/devices:
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 41000000.dsp -> ../../../../devices/platform/44000000.ocp/41000000.dsp

/sys/kernel/iommu_groups/5/devices:
root@dra7xx-evm:~# ls -l /sys/kernel/iommu_groups/*/devices/*/
/sys/kernel/iommu_groups/0/devices/40800000.dsp/:
lrwxrwxrwx    1 root     root             0 Aug  8 15:59 driver -> ../../../../bus/platform/drivers/omap-rproc
-rw-r--r--    1 root     root          4096 Aug  8 03:59 driver_override
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 iommu -> ../40d01000.mmu/iommu/40d01000.mmu
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 iommu_group -> ../../../../kernel/iommu_groups/0
-r--r--r--    1 root     root          4096 Aug  8 03:59 modalias
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 of_node -> ../../../../firmware/devicetree/base/ocp/dsp@40800000
drwxr-xr-x    2 root     root             0 Aug  8 03:59 power
drwxr-xr-x    3 root     root             0 Aug  8 04:03 remoteproc
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 subsystem -> ../../../../bus/platform
-rw-r--r--    1 root     root          4096 Aug  8 03:59 uevent

/sys/kernel/iommu_groups/2/devices/58820000.ipu/:
lrwxrwxrwx    1 root     root             0 Aug  8 15:59 driver -> ../../../../bus/platform/drivers/omap-rproc
-rw-r--r--    1 root     root          4096 Aug  8 03:59 driver_override
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 iommu -> ../58882000.mmu/iommu/58882000.mmu
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 iommu_group -> ../../../../kernel/iommu_groups/2
-r--r--r--    1 root     root          4096 Aug  8 03:59 modalias
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 of_node -> ../../../../firmware/devicetree/base/ocp/ipu@58820000
drwxr-xr-x    2 root     root             0 Aug  8 03:59 power
drwxr-xr-x    3 root     root             0 Aug  8 04:03 remoteproc
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 subsystem -> ../../../../bus/platform
-rw-r--r--    1 root     root          4096 Aug  8 03:59 uevent

/sys/kernel/iommu_groups/3/devices/55020000.ipu/:
lrwxrwxrwx    1 root     root             0 Aug  8 15:59 driver -> ../../../../bus/platform/drivers/omap-rproc
-rw-r--r--    1 root     root          4096 Aug  8 03:59 driver_override
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 iommu -> ../55082000.mmu/iommu/55082000.mmu
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 iommu_group -> ../../../../kernel/iommu_groups/3
-r--r--r--    1 root     root          4096 Aug  8 03:59 modalias
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 of_node -> ../../../../firmware/devicetree/base/ocp/ipu@55020000
drwxr-xr-x    2 root     root             0 Aug  8 03:59 power
drwxr-xr-x    3 root     root             0 Aug  8 04:03 remoteproc
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 subsystem -> ../../../../bus/platform
-rw-r--r--    1 root     root          4096 Aug  8 03:59 uevent

/sys/kernel/iommu_groups/4/devices/41000000.dsp/:
lrwxrwxrwx    1 root     root             0 Aug  8 15:59 driver -> ../../../../bus/platform/drivers/omap-rproc
-rw-r--r--    1 root     root          4096 Aug  8 03:59 driver_override
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 iommu -> ../41501000.mmu/iommu/41501000.mmu
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 iommu_group -> ../../../../kernel/iommu_groups/4
-r--r--r--    1 root     root          4096 Aug  8 03:59 modalias
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 of_node -> ../../../../firmware/devicetree/base/ocp/dsp@41000000
drwxr-xr-x    2 root     root             0 Aug  8 03:59 power
drwxr-xr-x    3 root     root             0 Aug  8 04:03 remoteproc
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 subsystem -> ../../../../bus/platform
-rw-r--r--    1 root     root          4096 Aug  8 03:59 uevent

Suman Anna (2):
  iommu/omap: Change the attach detection logic
  iommu/omap: Add support to program multiple iommus

 drivers/iommu/omap-iommu.c | 324 ++++++++++++++++++++++++++++++++++-----------
 drivers/iommu/omap-iommu.h |  30 ++---
 2 files changed, 259 insertions(+), 95 deletions(-)

-- 
2.13.1
