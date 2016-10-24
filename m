From: John Syne <john3909@gmail.com>
Subject: Re: [PATCH] drivers: mfd: ti_am335x_tscadc: increase ADC ref clock to 24MHz
Date: Mon, 24 Oct 2016 13:58:55 -0700
Message-ID: <038C6B01-8443-4321-9C65-BAC4095237D3@gmail.com>
References: <20161024060226.4170-1-mugunthanvnm@ti.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161024060226.4170-1-mugunthanvnm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mugunthan V N <mugunthanvnm@ti.com>
Cc: Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Jonathan Cameron <jic23@kernel.org>, Vignesh R <vigneshr@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org


> On Oct 23, 2016, at 11:02 PM, Mugunthan V N <mugunthanvnm@ti.com> =
wrote:
>=20
> Increase ADC reference clock from 3MHz to 24MHz so that the
> sampling rates goes up from 100K samples per second to 800K
> samples per second on AM335x and AM437x SoC.
>=20
> Also increase opendelay for touchscreen configuration to
> equalize the increase in ADC reference clock frequency,
> which results in the same amount touch events reported via
> evtest on AM335x GP EVM.
>=20
> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
> ---
>=20
> This patch depends on ADC DMA patch series [1]
>=20
> Without DMA support, when ADC ref clock is set at 24MHz, I am
> seeing fifo overflow as CPU is not able to pull the ADC samples.
> This answers that DMA support is must for ADC to consume the
> samples generated at 24MHz with no open, step delay or
> averaging with patch [2].
>=20
> Measured the performance with the iio_generic_buffer with the
> patch [3] applied
>=20
> [1] - http://www.spinics.net/lists/devicetree/msg145045.html
> [2] - http://pastebin.ubuntu.com/23357935/
> [3] - http://pastebin.ubuntu.com/23357939/
>=20
> ---
> include/linux/mfd/ti_am335x_tscadc.h | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/mfd/ti_am335x_tscadc.h =
b/include/linux/mfd/ti_am335x_tscadc.h
> index b9a53e0..96c4207 100644
> --- a/include/linux/mfd/ti_am335x_tscadc.h
> +++ b/include/linux/mfd/ti_am335x_tscadc.h
> @@ -90,7 +90,7 @@
> /* Delay register */
> #define STEPDELAY_OPEN_MASK	(0x3FFFF << 0)
> #define STEPDELAY_OPEN(val)	((val) << 0)
> -#define STEPCONFIG_OPENDLY	STEPDELAY_OPEN(0x098)
Wouldn=E2=80=99t this be better to add this to the devicetree?

	ti,chan-step-avg =3D <0x16 0x16 0x16 0x16 0x16 0x16 0x16>;
	ti,chan-step-opendelay =3D <0x500 0x500 0x500 0x500 0x500 0x500 =
0x500>;
	ti,chan-step-sampledelay =3D <0x0 0x0 0x0 0x0 0x0 0x0 0x0>;

Regards,
John
> +#define STEPCONFIG_OPENDLY	STEPDELAY_OPEN(0x500)
> #define STEPDELAY_SAMPLE_MASK	(0xFF << 24)
> #define STEPDELAY_SAMPLE(val)	((val) << 24)
> #define STEPCONFIG_SAMPLEDLY	STEPDELAY_SAMPLE(0)
> @@ -137,7 +137,7 @@
> #define SEQ_STATUS BIT(5)
> #define CHARGE_STEP		0x11
>=20
> -#define ADC_CLK			3000000
> +#define ADC_CLK			24000000
> #define TOTAL_STEPS		16
> #define TOTAL_CHANNELS		8
> #define FIFO1_THRESHOLD		19
> --=20
> 2.10.1.502.g6598894
>=20
