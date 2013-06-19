From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 1/1] arm: add bandgap DT entry for OMAP5
Date: Wed, 19 Jun 2013 05:36:00 -0500
Message-ID: <51C18990.8000109@ti.com>
References: <1371609398-26454-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1371609398-26454-1-git-send-email-eduardo.valentin@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, J Keerthy <j-keerthy@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, benoit.cousson@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Eduardo,

On 06/18/2013 09:36 PM, Eduardo Valentin wrote:
> Add bandgap device DT entry for OMAP5 dtsi.
>
> Cc: "Beno=C3=AEt Cousson" <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-omap@vger.kernel.org
> Cc: devicetree-discuss@lists.ozlabs.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> Signed-off-by: J Keerthy <j-keerthy@ti.com>
> ---
>   arch/arm/boot/dts/omap5.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
> ---
>
> Benoit,
>
> Sorry for this very late request, but can you please consider
> these patches for 3.11 still?
>
> I completely forgot to send these on my "Enable TI SoC thermal driver" se=
ries.
>
> All best,
>
> Eduardo
>
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index 2ad63c4..5ede6e1 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -615,5 +615,13 @@
>   			interrupts =3D <0 80 0x4>;
>   			ti,hwmods =3D "wd_timer2";
>   		};

missing blank line

> +		bandgap {

You must use the first address in that case. Otherwise DT will affect a ran=
dom number and provide a non-standard device name. That does not really mat=
ter in theory, but it will looks ugly in the /sys/devices list.

> +			reg =3D <0x4a0021e0 0xc
> +				0x4a00232c 0xc
> +				0x4a002380 0x2c
> +				0x4a0023C0 0x3c>;
> +				interrupts =3D <0 126 4>; /* talert */

Not well aligned and should use the macros.

> +			compatible =3D "ti,omap5430-bandgap";
> +		};
>   	};
>   };
>

I did the update for you :-)

Here is the version I've just applied.

Benoit


>From f0160bb93467e22f2f8bc77591dcd7e35cdee999 Mon Sep 17 00:00:00 2001
From: Eduardo Valentin <eduardo.valentin@ti.com>
Date: Tue, 18 Jun 2013 22:36:38 -0400
Subject: [PATCH] ARM: dts: Add bandgap DT entry for OMAP5

Add bandgap device DT entry for OMAP5 dtsi.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
Signed-off-by: J Keerthy <j-keerthy@ti.com>
Signed-off-by: Benoit Cousson <benoit.cousson@linaro.org>
---
 arch/arm/boot/dts/omap5.dtsi |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index accab62..47693c9 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -696,5 +696,14 @@
 				interrupts =3D <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
+
+		bandgap@4a0021e0 {
+			reg =3D <0x4a0021e0 0xc
+			       0x4a00232c 0xc
+			       0x4a002380 0x2c
+			       0x4a0023C0 0x3c>;
+			interrupts =3D <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
+			compatible =3D "ti,omap5430-bandgap";
+		};
 	};
 };
-- =

1.7.9.5
