From: "Candelaria Villareal, Jorge" <x0107209@ti.com>
Subject: [PATCHv2 0/6] McPDM driver patch series
Date: Fri, 22 Jan 2010 17:14:48 -0600
Message-ID: <2256F256009DAA4CBE661E9F41EAC84B8C43A8AB@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: linux-omap@vger.kernel.org

McPDM module is the interface between the OMAP and TWL6030 audio codec.

The interface supports the following:
* Up to 5 downlink channels and 3 uplink channels
* 88.2 and 96 KHz
* 32 bit sample size

Currently, driver is set to support up to 4 downlink channels. If 2
channels are selected, output will go to the headset, and if 4 channels
are selected, output will go to the headset and speakers. Functionality
to select the output at runtime will be added afterwards.

Command and status mode is not supported in current patches.

Changes from v1:
- Device registration now takes place plat-omap/devices.c
- struct resources is used to store mem and irq resources.
- DMA allows packet_size to be configured.
- PACKET is now used as sync_mode for McPDM

--

Jorge Eduardo Candelaria (4):
      OMAP4: IRQ: Add McPDM IRQ definition.
      ARM: OMAP4: Add McPDM base address
      OMAP4: MCPDM: Register McPDM platform device
      ASoC: OMAP4: Add support for McPDM

Misael Lopez Cruz (2):
      ASoC: OMAP: data_type and sync_mode configurable in audio dma
      ASoC: OMAP4: Add McPDM platform driver

 arch/arm/plat-omap/devices.c               |   34 ++
 arch/arm/plat-omap/include/plat/irqs.h     |    1 +
 arch/arm/plat-omap/include/plat/omap44xx.h |    2 +
 sound/soc/omap/Kconfig                     |    3 +
 sound/soc/omap/Makefile                    |    2 +
 sound/soc/omap/mcpdm.c                     |  524 ++++++++++++++++++++++++++++
 sound/soc/omap/mcpdm.h                     |  153 ++++++++
 sound/soc/omap/omap-mcbsp.c                |    2 +
 sound/soc/omap/omap-mcpdm.c                |  248 +++++++++++++
 sound/soc/omap/omap-mcpdm.h                |   29 ++
 sound/soc/omap/omap-pcm.c                  |   15 +-
 sound/soc/omap/omap-pcm.h                  |    4 +-
 12 files changed, 1009 insertions(+), 8 deletions(-)
 create mode 100644 sound/soc/omap/mcpdm.c
 create mode 100644 sound/soc/omap/mcpdm.h
 create mode 100644 sound/soc/omap/omap-mcpdm.c
