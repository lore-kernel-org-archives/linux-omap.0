From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RESEND 3/3] mfd: twl6040: Clear the interrupt ID register
 before requesting IRQ
Date: Mon, 28 Apr 2014 11:43:13 +0100
Message-ID: <20140428104313.GL21279@lee--X1>
References: <1396359901-32656-1-git-send-email-peter.ujfalusi@ti.com>
 <1396359901-32656-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1396359901-32656-4-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, sameo@linux.intel.com, nm@ti.com
List-Id: linux-omap@vger.kernel.org

> If for some reason the boot loader enabled the audpwron GPIO we will =
have
> pending IRQs to be handled. This seams to break twl6040 for some reas=
on
> leading to non working i2c communication (i2c timeouts). Clearing the=
 INTID
> register after we requested the audpwron GPIO (and set it to low) wil=
l
> ensure that the chip will operate normally in this case as well.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/mfd/twl6040.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
