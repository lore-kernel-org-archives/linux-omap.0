From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/7] mfd: max77686: Use devm_mfd_add_devices and
 devm_regmap_add_irq_chip
Date: Thu, 28 Apr 2016 10:01:02 +0100
Message-ID: <20160428090102.GM4892@dell>
References: <1461241558-26983-1-git-send-email-ldewangan@nvidia.com>
 <1461241558-26983-4-git-send-email-ldewangan@nvidia.com>
 <571DF7FD.8020209@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <571DF7FD.8020209@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, milo.kim@ti.com, cw00.choi@samsung.com, sbkim73@samsung.com, tony@atomide.com, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, 25 Apr 2016, Krzysztof Kozlowski wrote:

> On 04/21/2016 02:25 PM, Laxman Dewangan wrote:
> > Use devm_mfd_add_devices() for adding MFD child devices and
> > devm_regmap_add_irq_chip() for IRQ chip registration.
> >=20
> > This reduces the error code path and .remove callback for removing
> > MFD child devices and deleting IRQ chip data.
> >=20
> > Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> > CC: Chanwoo Choi <cw00.choi@samsung.com>
> > CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > ---
> >  drivers/mfd/max77686.c | 31 ++++++++-----------------------
> >  1 file changed, 8 insertions(+), 23 deletions(-)
>=20
> Switching existing code to devm-like interface doesn't bring huge
> benefits but looks okay and I'm fine with it:

This is pretty much my view, but it get's Laxman's patch count up. ;)

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
