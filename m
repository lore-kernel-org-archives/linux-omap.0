From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 0/7] MFD: twl6040: Conversion to i2c driver
Date: Thu, 09 Feb 2012 09:47:22 +0200
Message-ID: <4F337A0A.1010101@ti.com>
References: <1328619678-26080-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1328619678-26080-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dmitry Torokhov <dtor@mail.ru>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

On 02/07/2012 03:01 PM, Peter Ujfalusi wrote:
> Still in the to-do list:
> Implement proper regulator support on SDP4430, and PandaBoard for the=
 needed
> supplies by the twl6040.
> The supply source is the same on both boards:
> TWL6040 VDD2V1 <- TWL6030 V2V1 SMPS
> TWL6040 VDDVIO <- TWL6030 V1V8 SMPS
>=20
> There seams to be no control implemented in the regulator driver for =
these SMPS
> regulators, so this need to be done first.
>=20
> The reason that I'm sending this series (even when I know that the pr=
oper
> regulator support is missing for SDP4430/PandaBoard) is to get feedba=
ck for the
> rest of the series, so I can include the fixes in the v3 series.

I will separate the i2c driver conversion, and the regulator support to
avoid bloating this series.
Could you review the first three patch from this series (the i2c driver
conversion part)?
I can as well resend only that as version v3, but I would like to apply
the fixes for the issues you might find before I send it.

Thank you,
P=E9ter
