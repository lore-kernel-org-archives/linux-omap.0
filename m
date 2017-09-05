From: Suman Anna via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: [PATCH v2 0/2] Dual MMU support for TI DRA7xx DSPs
Date: Tue, 5 Sep 2017 17:56:16 -0500
Message-ID: <20170905225618.912-1-s-anna@ti.com>
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

The following is v2 of the patch series that enhances the OMAP IOMMU driver
to support the mirror-programming of the two MMUs present within the DSP
subsystems on TI DRA7xx/AM57xx family of SoCs.

The main changes are to address the review comments on the registration of
the MMU devices with the IOMMU core. I have added logic in omap_iommu_probe
function to not register the second MMU device with the IOMMU core. There is
also only one iommu_group now and the iommu sysfs entries do not show the second
core anymore. Example output log given below.

I have chosen to make the modifications in the probe rather than the .add_device
callback as this is much simpler. It eliminates the need for additional logic for
refcounting (need the iommu_group allocation only for the first client) and moving
the iommu_group allocation out of probe. This also ensures the IOMMU device and
group registration is done during probe itself irrespective of whether there are
client nodes defined or not in the DTS (for the .add_device callbacks to be
effective).

Patches still based on your 4.13 arm/omap branch. DT representation and usage
details are the same as described in v1 [1].

regards
Suman

[1] https://marc.info/?l=linux-omap&m=150418532431811&w=2

Following is the output of sysfs with these MMUs exercised
with additional patches now:

root@am57xx-evm:~# dmesg | grep mmu
[    0.520328] omap-iommu 40d01000.mmu: 40d01000.mmu registered
[    0.520676] omap-iommu 40d02000.mmu: 40d02000.mmu registered
[    0.521148] omap-iommu 58882000.mmu: 58882000.mmu registered
[    0.521638] omap-iommu 55082000.mmu: 55082000.mmu registered
[    0.522226] omap-iommu 41501000.mmu: 41501000.mmu registered
[    0.522575] omap-iommu 41502000.mmu: 41502000.mmu registered
[    0.523040] iommu: Adding device 58820000.ipu to group 1
[    0.523192] iommu: Adding device 55020000.ipu to group 2
[    0.523444] iommu: Adding device 40800000.dsp to group 0
[    0.523841] iommu: Adding device 41000000.dsp to group 3
root@am57xx-evm:~# ls -l /sys/class/iommu/
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 40d01000.mmu -> ../../devices/platform/44000000.ocp/40d01000.mmu/iommu/40d01000.mmu
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 41501000.mmu -> ../../devices/platform/44000000.ocp/41501000.mmu/iommu/41501000.mmu
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 55082000.mmu -> ../../devices/platform/44000000.ocp/55082000.mmu/iommu/55082000.mmu
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 58882000.mmu -> ../../devices/platform/44000000.ocp/58882000.mmu/iommu/58882000.mmu
root@am57xx-evm:~# ls -l /sys/kernel/iommu_groups/
drwxr-xr-x    3 root     root             0 Aug  8 03:59 0
drwxr-xr-x    3 root     root             0 Aug  8 03:59 1
drwxr-xr-x    3 root     root             0 Aug  8 03:59 2
drwxr-xr-x    3 root     root             0 Aug  8 03:59 3
root@am57xx-evm:~# ls -l /sys/kernel/iommu_groups/*/devices
/sys/kernel/iommu_groups/0/devices:
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 40800000.dsp -> ../../../../devices/platform/44000000.ocp/40800000.dsp

/sys/kernel/iommu_groups/1/devices:
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 58820000.ipu -> ../../../../devices/platform/44000000.ocp/58820000.ipu

/sys/kernel/iommu_groups/2/devices:
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 55020000.ipu -> ../../../../devices/platform/44000000.ocp/55020000.ipu

/sys/kernel/iommu_groups/3/devices:
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 41000000.dsp -> ../../../../devices/platform/44000000.ocp/41000000.dsp
root@am57xx-evm:~# ls -l /sys/kernel/iommu_groups/*/devices/*/                                                                                                                                  
/sys/kernel/iommu_groups/0/devices/40800000.dsp/:
lrwxrwxrwx    1 root     root             0 Aug  8 04:04 driver -> ../../../../bus/platform/drivers/omap-rproc
-rw-r--r--    1 root     root          4096 Aug  8 03:59 driver_override
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 iommu -> ../40d01000.mmu/iommu/40d01000.mmu
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 iommu_group -> ../../../../kernel/iommu_groups/0
-r--r--r--    1 root     root          4096 Aug  8 03:59 modalias
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 of_node -> ../../../../firmware/devicetree/base/ocp/dsp@40800000
drwxr-xr-x    2 root     root             0 Aug  8 03:59 power
drwxr-xr-x    3 root     root             0 Aug  8 04:04 remoteproc
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 subsystem -> ../../../../bus/platform
-rw-r--r--    1 root     root          4096 Aug  8 03:59 uevent

/sys/kernel/iommu_groups/1/devices/58820000.ipu/:
lrwxrwxrwx    1 root     root             0 Aug  8 04:04 driver -> ../../../../bus/platform/drivers/omap-rproc
-rw-r--r--    1 root     root          4096 Aug  8 03:59 driver_override
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 iommu -> ../58882000.mmu/iommu/58882000.mmu
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 iommu_group -> ../../../../kernel/iommu_groups/1
-r--r--r--    1 root     root          4096 Aug  8 03:59 modalias
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 of_node -> ../../../../firmware/devicetree/base/ocp/ipu@58820000
drwxr-xr-x    2 root     root             0 Aug  8 03:59 power
drwxr-xr-x    3 root     root             0 Aug  8 04:04 remoteproc
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 subsystem -> ../../../../bus/platform
-rw-r--r--    1 root     root          4096 Aug  8 03:59 uevent

/sys/kernel/iommu_groups/2/devices/55020000.ipu/:
lrwxrwxrwx    1 root     root             0 Aug  8 04:04 driver -> ../../../../bus/platform/drivers/omap-rproc
-rw-r--r--    1 root     root          4096 Aug  8 03:59 driver_override
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 iommu -> ../55082000.mmu/iommu/55082000.mmu
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 iommu_group -> ../../../../kernel/iommu_groups/2
-r--r--r--    1 root     root          4096 Aug  8 03:59 modalias
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 of_node -> ../../../../firmware/devicetree/base/ocp/ipu@55020000
drwxr-xr-x    2 root     root             0 Aug  8 03:59 power
drwxr-xr-x    3 root     root             0 Aug  8 04:04 remoteproc
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 subsystem -> ../../../../bus/platform
-rw-r--r--    1 root     root          4096 Aug  8 03:59 uevent

/sys/kernel/iommu_groups/3/devices/41000000.dsp/:
lrwxrwxrwx    1 root     root             0 Aug  8 04:04 driver -> ../../../../bus/platform/drivers/omap-rproc
-rw-r--r--    1 root     root          4096 Aug  8 03:59 driver_override
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 iommu -> ../41501000.mmu/iommu/41501000.mmu
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 iommu_group -> ../../../../kernel/iommu_groups/3
-r--r--r--    1 root     root          4096 Aug  8 03:59 modalias
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 of_node -> ../../../../firmware/devicetree/base/ocp/dsp@41000000
drwxr-xr-x    2 root     root             0 Aug  8 03:59 power
drwxr-xr-x    3 root     root             0 Aug  8 04:04 remoteproc
lrwxrwxrwx    1 root     root             0 Aug  8 03:59 subsystem -> ../../../../bus/platform
-rw-r--r--    1 root     root          4096 Aug  8 03:59 uevent

Suman Anna (2):
  iommu/omap: Change the attach detection logic
  iommu/omap: Add support to program multiple iommus

 drivers/iommu/omap-iommu.c | 375 ++++++++++++++++++++++++++++++++++-----------
 drivers/iommu/omap-iommu.h |  30 ++--
 2 files changed, 296 insertions(+), 109 deletions(-)

-- 
2.13.1
