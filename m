From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RFC v1] MFD: Change TWL6025 references to TWL6032
Date: Wed, 19 Jun 2013 09:35:15 +0100
Message-ID: <20130619083515.GC22998@laptop>
References: <1370602390-12306-1-git-send-email-oleksandr.kozaruk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1370602390-12306-1-git-send-email-oleksandr.kozaruk@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, sameo@linux.intel.com, lgirdwood@gmail.com, broonie@kernel.org, balbi@ti.com, peter.ujfalusi@ti.com, t-kristo@ti.com, tony@atomide.com, Graeme Gregory <gg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

On Fri, 07 Jun 2013, Oleksandr Kozaruk wrote:

> From: Graeme Gregory <gg@slimlogic.co.uk>
>=20
> The TWL6025 was never released beyond sample form and was replaced by
> the PhoenixLite range of chips - TWL6032. Change the references to
> reference the TWL6032 class and name the registers to twl6032 in line=
 with
> an actual released chip name to avoid confusion.
>=20
> Currently there is no users of TWL6025 in the code.=20
>=20
> Signed-off-by: Graeme Gregory <gg@slimlogic.co.uk>
> Signed-off-by: Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>
> ---
>=20
> There are non-mainline branches that use twl6032 by its name (for exa=
mple
> git://git.omapzoom.org/kernel/omap.git). There is intention to add su=
pport
> of twl6032 device in mainline, but we'd like to know if we can use tw=
l6032
> instead of twl6025 in our new patches, that we are going to provide.
>=20
>  drivers/mfd/twl-core.c            |   46 +++++++++++-----------
>  drivers/regulator/twl-regulator.c |   76 ++++++++++++++++++---------=
----------
>  drivers/usb/phy/phy-twl6030-usb.c |    2 +-
>  include/linux/i2c/twl.h           |   30 +++++++--------
>  4 files changed, 77 insertions(+), 77 deletions(-)

If the TWL6025 truly didn't enter production then I'm okay with this
as long as Mark and the other maintainers are.

=46or the MFD parts:

Acked-by: Lee Jones <lee.jones@linaro.org>

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
