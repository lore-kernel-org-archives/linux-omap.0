From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 0/6] mfd: Fine-tuning for three function implementations
Date: Tue, 28 Jun 2016 16:01:41 +0100
Message-ID: <20160628150141.GH24982@dell>
References: <566ABCD9.1060404@users.sourceforge.net>
 <5682D228.7070902@users.sourceforge.net>
 <20160111082922.GB14104@x1>
 <05b7db2a-437a-60ac-d289-71d2150e7f5f@users.sourceforge.net>
 <de3598c4-f85a-6807-303a-55ee0ac707f2@users.sourceforge.net>
 <20160608111442.GB14888@dell>
 <e4eaf0b4-e539-b400-c8a2-70f210cee1fa@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e4eaf0b4-e539-b400-c8a2-70f210cee1fa@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-omap@vger.kernel.org

On Sun, 26 Jun 2016, SF Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 26 Jun 2016 15:25:43 +0200
>=20
> Several update suggestions were taken into account
> from static source code analysis.
>=20
> Markus Elfring (6):
>   twl-core: Return directly after a failed platform_device_alloc()
>     in add_numbered_child()
>   twl-core: Refactoring for add_numbered_child()
>   dm355evm_msp: Return directly after a failed platform_device_alloc(=
)
>     in add_child()
>   dm355evm_msp: Refactoring for add_child()
>   smsc-ece1099: Delete an unnecessary variable initialisation
>     in smsc_i2c_probe()
>   smsc-ece1099: Return directly after a function failure
>     in smsc_i2c_probe()
>=20
>  drivers/mfd/dm355evm_msp.c | 25 ++++++++++++-------------
>  drivers/mfd/smsc-ece1099.c | 11 ++++-------
>  drivers/mfd/twl-core.c     | 28 +++++++++++++---------------
>  3 files changed, 29 insertions(+), 35 deletions(-)

What is this set?  A different but related one to the set you tagged
it on to?  Probably best not to do that.  I now have a huge entangled
thread in my inbox, which is going to become out of control rather
quickly (if it isn't already).

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe kernel-janito=
rs" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
