From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/2] mfd: twl6040: Check for error when reading revision
 register
Date: Tue, 25 Feb 2014 14:22:23 +0000
Message-ID: <20140225142223.GA9195@lee--X1>
References: <1393334900-29740-1-git-send-email-florian.vaussard@epfl.ch>
 <1393334900-29740-2-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1393334900-29740-2-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

> We may have an error when reading the revision register, so check for
> the returned value.
>=20
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
> ---
>  drivers/mfd/twl6040.c | 5 +++++
>  1 file changed, 5 insertions(+)

Applied, thanks.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
