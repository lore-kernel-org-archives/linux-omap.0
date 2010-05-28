From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v2] serial: Add OMAP high-speed UART driver
Date: Fri, 28 May 2010 16:54:13 +0530
Message-ID: <AANLkTikvFAs7Ck_1bQtlKmj6cj-Lkh1ySOFZo5pR3QPU@mail.gmail.com>
References: <58269.192.168.10.88.1274708590.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <58269.192.168.10.88.1274708590.squirrel@dbdmail.itg.ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Mon, May 24, 2010 at 7:13 PM, Govindraj.R <govindraj.raja@ti.com> wr=
ote:
> This patch adds driver support for OMAP3/4 high speed UART.
>
> The driver is made separate from 8250 driver as we cannot
> over load 8250 driver with omap platform specific configuration for
> features like DMA, it makes easier to implement features like DMA and
> hardware flow control and software flow control configuration with
> this driver as required for the omap-platform.This patch involves onl=
y
> the core driver and its dependent.
>
> Cc: Tony Lindgren <tony@atomide.com>
> Tested-by: Kevin Hilman <khilman@deeprootsystems.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> ---
> Platform data support for this driver is currently
> present in Kevin's PM tree remotes/origin/pm-wip/uart branch
> This branch contains uart-hwmod platform conversion which
> utilizes the omap-hwmod framework. Tested using OMAP
> 3430/3630/4430SDP boards.
>
> =A0arch/arm/plat-omap/include/plat/omap-serial.h | =A0129 +++
> =A0drivers/serial/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 27 +
> =A0drivers/serial/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A01 +
> =A0drivers/serial/omap-serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
1318 +++++++++++++++++++++++++
> =A0include/linux/serial_core.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 =A03 +
> =A05 files changed, 1478 insertions(+), 0 deletions(-)
> =A0create mode 100644 arch/arm/plat-omap/include/plat/omap-serial.h
> =A0create mode 100644 drivers/serial/omap-serial.c

Update:

Populating following changes for v3:
Will be posting in couple of days.

1.)  Replace platform_get_resource with platform_get_resource_byname
     Reference :
     http://marc.info/?l=3Dlinux-omap&m=3D127479257522952&w=3D2

2.)  Update kconfig to add OMAP2 support also
      [Thanks to Kevin for testing it on n810(omap2)]
      Reference :
     http://marc.info/?l=3Dlinux-serial&m=3D127491414713957&w=3D2

Please let me know if there are any further comments.
Thanks for the reviews and testing.

---
Regards,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
