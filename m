From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v9 3/9] mfd: omap-usb-host: Use proper clock name instead
 of alias
Date: Mon, 10 Mar 2014 14:32:07 +0000
Message-ID: <20140310143207.GD15558@lee--X1>
References: <1393510711-4697-1-git-send-email-rogerq@ti.com>
 <1393510711-4697-4-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1393510711-4697-4-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, bcousson@baylibre.com, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

> Use the proper clock name 'usbhost_120m_fck' instead of the
> alias 'ehci_logic_fck'
>=20
> Get rid of the 'ehci_logic_fck' alias from the OMAP3 hwmod data
> as well.
>=20
> CC: Paul Walmsley <paul@pwsan.com>
> CC: Lee Jones <lee.jones@linaro.org>
> CC: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 6 ------
>  drivers/mfd/omap-usb-host.c                | 5 +++--
>  2 files changed, 3 insertions(+), 8 deletions(-)

So long as the platform guys are okay with the semantic change, the
MFD diff looks okay to me. For the MFD changes:
  Acked-by: Lee Jones <lee.jones@linaro.org>

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
