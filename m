From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 0/2] mfd: twl6040: Small clean-ups
Date: Tue, 25 Feb 2014 14:27:05 +0000
Message-ID: <20140225142705.GC9195@lee--X1>
References: <1393334900-29740-1-git-send-email-florian.vaussard@epfl.ch>
 <530CA6BA.1000405@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <530CA6BA.1000405@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Florian Vaussard <florian.vaussard@epfl.ch>, Samuel Ortiz <sameo@linux.intel.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

> > Here is two cleanups patches for the TWL6040 audio codec. The first
> > one checks for an error when reading the revision register (first r=
ead
> > in the probe path). The second removes a duplicate I2C writes.
> >=20
> > Regards,
> > Florian
>=20
> To both:
> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Applied both with Peter's Ack.

> > Florian Vaussard (2):
> >   mfd: twl6040: Check for error when reading revision register
> >   mfd: twl6040: Remove duplicate register write
> >=20
> >  drivers/mfd/twl6040.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >=20
>=20
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
