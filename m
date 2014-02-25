From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 0/2] mfd: twl6040: Small clean-ups
Date: Tue, 25 Feb 2014 16:20:42 +0200
Message-ID: <530CA6BA.1000405@ti.com>
References: <1393334900-29740-1-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48828 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753702AbaBYOUt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Feb 2014 09:20:49 -0500
In-Reply-To: <1393334900-29740-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

On 02/25/2014 03:28 PM, Florian Vaussard wrote:
> Hi,
>=20
> Here is two cleanups patches for the TWL6040 audio codec. The first
> one checks for an error when reading the revision register (first rea=
d
> in the probe path). The second removes a duplicate I2C writes.
>=20
> Regards,
> Florian

To both:
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

>=20
> Florian Vaussard (2):
>   mfd: twl6040: Check for error when reading revision register
>   mfd: twl6040: Remove duplicate register write
>=20
>  drivers/mfd/twl6040.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
