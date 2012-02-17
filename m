From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 0/7] TWL6040: Regulator support
Date: Fri, 17 Feb 2012 13:48:34 +0200
Message-ID: <4F3E3E92.30304@ti.com>
References: <1328868316-24749-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1328868316-24749-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

On 02/10/2012 12:05 PM, Peter Ujfalusi wrote:
> Hello,
>=20
> This series depends on the V3 of MFD: twl6040: Conversion to i2c driv=
er set.
>=20
> In order to have proper regulator support for twl6040 on SDP4430, and
> PandaBoards I needed to add support for the V1V8, and V2V1 SMPS suppl=
ies from
> twl6030.
> The configuration on both boards (and the TRM recommendations) are th=
e same, so
> it make sens to have the V1V8, V2V1 supply configured in the twl-comm=
on to avoid
> duplicated code in board files.
>=20
> The last patch in this series was part of the V2 of MFD: twl6040: Con=
version to
> i2c driver set. I have added Mark's Reviewd-by tag, and also addresse=
d his
> comment regarding to the supplies member of the twl6040 struct (no ne=
ed to
> allocate it separately).
>=20
> Regards,
> Peter
> ---
> Peter Ujfalusi (7):
>   OMAP: 4430SDP: Correct fixed regulator device ID
>   regulator: twl-regulator: Add fixed LDO for V1V8, V2V1 supply
>   MFD: twl-core: regulator configuration for twl6030 V1V8, V2V1 SMPS
>   OMAP4: twl-common: Add twl6030 V1V8, V2V1 SMPS common configuration
>   OMAP: 4430SDP: Use common configuration for V1V8, V2V1 supplies
>   OMAP: omap4panda: Use common configuration for V1V8, V2V1 supplies
>   MFD: TWL6040: Add regulator support for VIO, V2V1 supplies
>=20
>  arch/arm/mach-omap2/board-4430sdp.c    |   11 ++++++--
>  arch/arm/mach-omap2/board-omap4panda.c |    4 ++-
>  arch/arm/mach-omap2/twl-common.c       |   43 ++++++++++++++++++++++=
++++++++++
>  arch/arm/mach-omap2/twl-common.h       |    2 +
>  drivers/mfd/twl-core.c                 |   10 +++++++
>  drivers/mfd/twl6040-core.c             |   33 +++++++++++++++++++++-=
--
>  drivers/regulator/twl-regulator.c      |    2 +
>  include/linux/i2c/twl.h                |    2 +
>  include/linux/mfd/twl6040.h            |    2 +
>  9 files changed, 101 insertions(+), 8 deletions(-)

It has been a week since I have sent this series. It would be great if
this be on time for 3.4 merge window (with the depending series which
converts the twl6040 mfd part into i2c driver).

Thank you,
P=E9ter
