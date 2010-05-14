From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Fri, 14 May 2010 14:36:42 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1005141428100.3348@utopia.booyaka.com>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<87wrvl5479.fsf@deeprootsystems.com>
	<20100503180741.GB2098@rakim.wolfsonmicro.main>
	<201005032318.35383.rjw@sisk.pl>
	<87sk68r1zh.fsf@deeprootsystems.com>
	<20100504004338.GA22678@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100504004338.GA22678@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Liam Girdwood <lrg@slimlogic.co.uk>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Oleg Nesterov <oleg@redhat.com>, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>, Daniel Walker <dwalker@codeaurora.org>, Theodore Ts'o <tytso@mit.edu>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Geoff Smith <geoffx.smith@intel.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org

Hello,

On Tue, 4 May 2010, Matthew Garrett wrote:

> On Mon, May 03, 2010 at 04:37:22PM -0700, Kevin Hilman wrote:
> 
> > Please forgive the ignorance of ACPI (in embedded, we thankfully live
> > in magical world without ACPI) but doesn't that already happen with
> > CPUidle and C-states?  I think of CPUidle as basically runtime PM for
> > the CPU.  IOW, runtime PM manages the devices, CPUidle manages the CPU
> > (via C-states), resulting in dynaimc PM for the entire system.  What
> > am I missing?
> 
> ACPI doesn't provide any functionality for cutting power to most devices 
> other than shifting into full system suspend.

ACPI may not, but the vast majority of ACPI systems are paired with PCI 
buses, or buses that emulate PCI buses; and PCI devices can implement 
device power control through the PCI Power Management capability. On my 
2-year old ThinkPad, 13 of the 24 devices do, according to lspci.

Many Linux device drivers already use PCI D-states to support a 
rudimentary form of runtime PM:

[paul@twilight current]$ fgrep -r pci_set_power_state drivers/ | cut -d: 
-f1 | sort -u
drivers/ata/ata_piix.c
drivers/ata/libata-core.c
drivers/ata/pata_macio.c
drivers/block/cciss.c
drivers/char/agp/amd64-agp.c
drivers/char/agp/amd-k7-agp.c
drivers/char/agp/ati-agp.c
drivers/char/agp/nvidia-agp.c
drivers/char/agp/sis-agp.c
drivers/char/agp/via-agp.c
drivers/firewire/ohci.c
drivers/gpio/bt8xxgpio.c
drivers/gpu/drm/i915/i915_dma.c
drivers/gpu/drm/i915/i915_drv.c
drivers/gpu/drm/nouveau/nouveau_drv.c
drivers/gpu/drm/radeon/radeon_device.c
drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
drivers/i2c/busses/i2c-i801.c
drivers/ide/delkin_cb.c
drivers/ide/sc1200.c
drivers/ide/setup-pci.c
drivers/ieee1394/ohci1394.c
drivers/media/video/bt8xx/bttv-driver.c
drivers/media/video/cx88/cx88-mpeg.c
drivers/media/video/cx88/cx88-video.c
drivers/media/video/saa7134/saa7134-core.c
drivers/memstick/host/jmb38x_ms.c
drivers/message/fusion/mptbase.c
drivers/misc/cb710/core.c
drivers/misc/tifm_7xx1.c
drivers/mmc/host/sdhci-pci.c
drivers/mmc/host/via-sdmmc.c
drivers/net/3c59x.c
drivers/net/8139cp.c
drivers/net/8139too.c
drivers/net/amd8111e.c
drivers/net/atl1c/atl1c_main.c
drivers/net/atl1e/atl1e_main.c
drivers/net/atlx/atl1.c
drivers/net/atlx/atl2.c
drivers/net/benet/be_main.c
drivers/net/e1000/e1000_main.c
drivers/net/e1000e/netdev.c
drivers/net/e100.c
drivers/net/forcedeth.c
drivers/net/igb/igb_main.c
drivers/net/irda/vlsi_ir.c
drivers/net/ixgbe/ixgbe_main.c
drivers/net/jme.c
drivers/net/ksz884x.c
drivers/net/myri10ge/myri10ge.c
drivers/net/ne2k-pci.c
drivers/net/netxen/netxen_nic_main.c
drivers/net/pci-skeleton.c
drivers/net/pcnet32.c
drivers/net/qlcnic/qlcnic_main.c
drivers/net/qlge/qlge_main.c
drivers/net/r8169.c
drivers/net/sc92031.c
drivers/net/sfc/efx.c
drivers/net/sis900.c
drivers/net/skge.c
drivers/net/sky2.c
drivers/net/smsc9420.c
drivers/net/starfire.c
drivers/net/tc35815.c
drivers/net/tg3.c
drivers/net/tulip/dmfe.c
drivers/net/tulip/tulip_core.c
drivers/net/tulip/uli526x.c
drivers/net/typhoon.c
drivers/net/via-rhine.c
drivers/net/via-velocity.c
drivers/net/vmxnet3/vmxnet3_drv.c
drivers/net/wireless/adm8211.c
drivers/net/wireless/airo.c
drivers/net/wireless/ath/ath9k/pci.c
drivers/net/wireless/hostap/hostap_pci.c
drivers/net/wireless/ipw2x00/ipw2100.c
drivers/net/wireless/ipw2x00/ipw2200.c
drivers/net/wireless/iwlwifi/iwl-core.c
drivers/net/wireless/orinoco/orinoco_pci.h
drivers/net/wireless/p54/p54pci.c
drivers/net/wireless/prism54/islpci_hotplug.c
drivers/net/wireless/rt2x00/rt2x00pci.c
drivers/net/wireless/rtl818x/rtl8180_dev.c
drivers/parport/parport_serial.c
drivers/pci/pci-acpi.c
drivers/pci/pci.c
drivers/pci/pci-driver.c
drivers/pcmcia/yenta_socket.c
drivers/scsi/3w-9xxx.c
drivers/scsi/3w-sas.c
drivers/scsi/aic7xxx/aic79xx_osm_pci.c
drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
drivers/scsi/aic7xxx/aic7xxx_pci.c
drivers/scsi/hpsa.c
drivers/scsi/lpfc/lpfc_init.c
drivers/scsi/megaraid/megaraid_sas.c
drivers/scsi/mpt2sas/mpt2sas_scsih.c
drivers/scsi/nsp32.c
drivers/scsi/pm8001/pm8001_init.c
drivers/scsi/pmcraid.c
drivers/serial/8250_pci.c
drivers/serial/serial_txx9.c
drivers/spi/dw_spi_pci.c
drivers/ssb/pcihost_wrapper.c
drivers/staging/crystalhd/crystalhd_lnx.c
drivers/staging/rt2860/pci_main_dev.c
drivers/staging/rtl8187se/r8180_core.c
drivers/staging/rtl8192e/r8192_pm.c
drivers/staging/sm7xx/smtcfb.c
drivers/staging/vt6655/device_main.c
drivers/usb/gadget/langwell_udc.c
drivers/video/arkfb.c
drivers/video/aty/aty128fb.c
drivers/video/aty/atyfb_base.c
drivers/video/aty/radeon_pm.c
drivers/video/i810/i810_main.c
drivers/video/nvidia/nvidia.c
drivers/video/s3fb.c
drivers/video/savage/savagefb_driver.c
drivers/video/vt8623fb.c
drivers/virtio/virtio_pci.c


- Paul
