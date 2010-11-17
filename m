From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] OMAP: Serial: Define register access modes in LCR
Date: Wed, 17 Nov 2010 08:17:29 -0800
Message-ID: <20101117161729.GF10992@kroah.com>
References: <1289982712-7309-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1289982712-7309-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 17, 2010 at 10:31:52AM +0200, Emeltchenko Andrei wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
>=20
> Access to some registers depends on register access mode
> Three different modes are available for OMAP (at least)
> =E2=80=A2 Operational mode     LCR_REG[7] =3D 0x0
> =E2=80=A2 Configuration mode A LCR_REG[7] =3D 0x1 and LCR_REG[7:0]! =3D=
 0xBF
> =E2=80=A2 Configuration mode B LCR_REG[7] =3D 0x1 and LCR_REG[7:0]  =3D=
 0xBF
>=20
> Define access modes and remove redefinitions and magic numbers
> in serial drivers (and later in bluetooth driver).
>=20
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> ---
>  arch/arm/mach-omap2/serial.c                  |   12 ++++----
>  arch/arm/plat-omap/include/plat/omap-serial.h |    9 ------
>  drivers/serial/8250.c                         |   26 +++++++++------=
---
>  drivers/serial/omap-serial.c                  |   34 ++++++++++++---=
---------
>  include/linux/serial_reg.h                    |    7 +++++

What tree should this go through?  THe omap or serial one?

thanks,

greg k-h
