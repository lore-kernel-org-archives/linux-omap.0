From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3 0/3] MFD: twl6040: Conversion to i2c driver
Date: Fri, 17 Feb 2012 13:47:25 +0200
Message-ID: <4F3E3E4D.6080505@ti.com>
References: <1328868018-24668-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1328868018-24668-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dmitry Torokhov <dtor@mail.ru>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

On 02/10/2012 12:00 PM, Peter Ujfalusi wrote:
> Hello,
>=20
> Changes since v2:
> - soc/codec/Kconfig: make twl6040 depend on I2C
> - Regulator related patches has been removed (to be sent as separate =
series)
>=20
> ------
> Intro mail from the original series:
>=20
> This series will convert the twl6040 MFD driver to an i2c driver.
> Compared to older twl4030/5030/TPS the twl6040 is a standalone audio =
IC. It is
> better if the twl6040-core (and all of it's child devices) does not d=
epend on
> the twl-core since it has nothing to with it.
>=20
> With this conversion the dependency on twl can be dropped from the tw=
l6040
> driver stack (core, vibra, audio).
>=20
> Between the first and second patch the audio will not probe on OMAP4,=
 but I felt
> it is better this way at least for the first RFC series to not have t=
oo big
> change within one patch. The two patch can be squashed together later=
 if no
> objections.
>=20
> Regards,
> Peter
> ---
> Peter Ujfalusi (3):
>   MFD: twl-core: Detach twl6040 from the pmic mfd driver
>   MFD: twl6040: Convert to i2c driver, and separate it from twl core
>   ASoC: twl6040: Remove dependency on twl4030 from Kconfig
>=20
>  arch/arm/mach-omap2/board-4430sdp.c    |   12 ++--
>  arch/arm/mach-omap2/board-generic.c    |    2 +-
>  arch/arm/mach-omap2/board-omap4panda.c |   13 ++--
>  arch/arm/mach-omap2/twl-common.c       |   37 +++++++++--
>  arch/arm/mach-omap2/twl-common.h       |   10 +--
>  drivers/input/misc/Kconfig             |    1 -
>  drivers/input/misc/twl6040-vibra.c     |    4 +-
>  drivers/mfd/Kconfig                    |    2 +-
>  drivers/mfd/twl-core.c                 |   58 +++++++++-------
>  drivers/mfd/twl6040-core.c             |  114 +++++++++++++++++++---=
----------
>  include/linux/i2c/twl.h                |   12 ----
>  include/linux/mfd/twl6040.h            |   27 ++++++++
>  sound/soc/codecs/Kconfig               |    2 +-
>  sound/soc/codecs/twl6040.c             |    3 +-
>  14 files changed, 182 insertions(+), 115 deletions(-)

It has been a week since I have sent this series. It would be great if
this be on time for 3.4 merge window.

Thank you,
P=E9ter
