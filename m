From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: [PATCH] serial: Add driver for OMAP UARTs
Date: Tue, 10 Apr 2007 00:36:00 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47A1A4FB@dlee13.ent.ti.com>
References: <20070409204433.GA23320@mail.solidboot.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <20070409204433.GA23320@mail.solidboot.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: =?iso-8859-1?B?SnVoYSBZcmr2bOQ=?= <juha.yrjola@solidboot.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Juha,

The serial driver presented is really good, as you said we can enhance =
the same for DMA, High speed UART, Power Management etc.

One concern I had here was, as we know OMAP supports multiple (3) UART =
ports and they can be used for IrDA (UART3), Bluetooth (UART2/1), Serial =
applications etc. All these drivers should configure/use similar =
register sets. So if we could,=20

- make the arch/arm/mach-omap2/serial.c more kind of a generic UART API =
library that can be used by all UART drivers.
	- the UART library should handle overall clock /power management =
policy.
	- Centralized interrupt handler.
	- DMA / Polling / Interrupt based read/writes.

- The serial driver implemented by you, IrDA and other UART dependent =
drivers should use the APIs exported by UART library.

- Basically UART dependent drivers should get registered with =
centralized UART library for interrupt, clock, power and data transfer.=20

This will avoid redundant code (for DMA, interrupt, PM, clk) in multiple =
drivers. If we like/agree on this design, I can probably post a patch =
(RFC) for the same.=20

Please do let me know your comments / suggestions.

Regards,
Khasim

>-----Original Message-----
>From: linux-omap-open-source-bounces+x0khasim=3Dti.com@linux.omap.com
>[mailto:linux-omap-open-source-bounces+x0khasim=3Dti.com@linux.omap.com]=
 On
>Behalf Of Juha Yrj=F6l=E4
>Sent: Monday, April 09, 2007 3:45 PM
>To: linux-omap-open-source@linux.omap.com
>Subject: [PATCH] serial: Add driver for OMAP UARTs
>
>>From 1b812d197f1451fc03335a999472a25e8c1830c6 Mon Sep 17 00:00:00 2001
>From: Juha Yrjola <juha.yrjola@solidboot.com>
>Date: Mon, 9 Apr 2007 23:43:34 +0300
>Subject: [PATCH] serial: Add driver for OMAP UARTs
>
>An OMAP-specific UART driver is needed when support for advanced
>functionality (such as DMA transfers and power management) is added.
>Currently it helps to work around UART initialization bugs at least
>in the OMAP2420 silicon.
>
>Only OMAP24xx CPUs are supported at the moment, although adding
>support for OMAP1 should not be a big deal.
>
>Signed-off-by: Juha Yrjola <juha.yrjola@solidboot.com>
>---
> arch/arm/configs/n800_defconfig              |    8 +-
> arch/arm/configs/omap_2430sdp_defconfig      |   12 +-
> arch/arm/configs/omap_apollon_2420_defconfig |   12 +-
> arch/arm/configs/omap_generic_2420_defconfig |    7 +-
> arch/arm/configs/omap_h4_2420_defconfig      |   12 +-
> arch/arm/mach-omap2/serial.c                 |  190 ++----
> drivers/serial/Kconfig                       |   23 +
> drivers/serial/Makefile                      |    1 +
> drivers/serial/omap.c                        |  893
>++++++++++++++++++++++++++
> include/linux/serial_core.h                  |    2 +
> 10 files changed, 994 insertions(+), 166 deletions(-)
> create mode 100644 drivers/serial/omap.c
