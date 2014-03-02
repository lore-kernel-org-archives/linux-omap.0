From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH v5 1/2] arm: dts: omap4+: Add DMM bindings
Date: Sun, 02 Mar 2014 20:53:23 +0100
Message-ID: <53138C33.4010200@baylibre.com>
References: <1379063679-4869-1-git-send-email-archit@ti.com> <1387274542-29645-1-git-send-email-archit@ti.com> <1387274542-29645-2-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:34482 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701AbaCBTx2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 Mar 2014 14:53:28 -0500
Received: by mail-we0-f178.google.com with SMTP id q59so2288899wes.9
        for <linux-omap@vger.kernel.org>; Sun, 02 Mar 2014 11:53:26 -0800 (PST)
In-Reply-To: <1387274542-29645-2-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, tony@atomide.com, mark.rutland@arm.com
Cc: robdclark@gmail.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Andy Gross <andygro@gmail.com>

Hi Archit,

On 17/12/2013 11:02, Archit Taneja wrote:
> Add Dynamic Memory Manager (DMM) bindings for OMAP4 and OMAP5 and DRA=
7x devices.
> DMM only requires address and irq information.
>
> Add documentation for the DMM bindings.
>
> Originally worked on by Andy Gross <andygro@gmail.com>
>
> Cc: Andy Gross <andygro@gmail.com>
> Signed-off-by: Archit Taneja <archit@ti.com>

I've just applied your patch.

Thanks,
Benoit

> ---
>   Documentation/devicetree/bindings/arm/omap/dmm.txt | 22 +++++++++++=
+++++++++++
>   arch/arm/boot/dts/dra7.dtsi                        |  7 +++++++
>   arch/arm/boot/dts/omap4.dtsi                       |  7 +++++++
>   arch/arm/boot/dts/omap5.dtsi                       |  7 +++++++
>   4 files changed, 43 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/arm/omap/dmm.t=
xt
>
> diff --git a/Documentation/devicetree/bindings/arm/omap/dmm.txt b/Doc=
umentation/devicetree/bindings/arm/omap/dmm.txt
> new file mode 100644
> index 0000000..8bd6d0a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/omap/dmm.txt
> @@ -0,0 +1,22 @@
> +OMAP Dynamic Memory Manager (DMM) bindings
> +
> +The dynamic memory manager (DMM) is a module located immediately in =
front of the
> +SDRAM controllers (called EMIFs on OMAP). DMM manages various aspect=
s of memory
> +accesses such as priority generation amongst initiators, configurati=
on of SDRAM
> +interleaving, optimizing transfer of 2D block objects, and provide M=
MU-like page
> +translation for initiators which need contiguous dma bus addresses.
> +
> +Required properties:
> +- compatible:	Should contain "ti,omap4-dmm" for OMAP4 family
> +		Should contain "ti,omap5-dmm" for OMAP5 and DRA7x family
> +- reg:		Contains DMM register address range (base address and length=
)
> +- interrupts:	Should contain an interrupt-specifier for DMM_IRQ.
> +- ti,hwmods:	Name of the hwmod associated to DMM, which is typically=
 "dmm"
> +
> +Example:
> +
> +dmm@4e000000 {
> +	compatible =3D "ti,omap4-dmm";
> +	reg =3D <0x4e000000 0x800>;
> +	ti,hwmods =3D "dmm";
> +};
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dts=
i
> index d0df4c4..c9bb006 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -425,6 +425,13 @@
>   			ti,hwmods =3D "wd_timer2";
>   		};
>
> +		dmm@4e000000 {
> +			compatible =3D "ti,omap5-dmm";
> +			reg =3D <0x4e000000 0x800>;
> +			interrupts =3D <0 113 0x4>;
> +			ti,hwmods =3D "dmm";
> +		};
> +
>   		i2c1: i2c@48070000 {
>   			compatible =3D "ti,omap4-i2c";
>   			reg =3D <0x48070000 0x100>;
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.d=
tsi
> index a1e0585..3c67b2f 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -502,6 +502,13 @@
>   			ti,hwmods =3D "kbd";
>   		};
>
> +		dmm@4e000000 {
> +			compatible =3D "ti,omap4-dmm";
> +			reg =3D <0x4e000000 0x800>;
> +			interrupts =3D <0 113 0x4>;
> +			ti,hwmods =3D "dmm";
> +		};
> +
>   		emif1: emif@4c000000 {
>   			compatible =3D "ti,emif-4d";
>   			reg =3D <0x4c000000 0x100>;
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.d=
tsi
> index fc3fad5..878f635 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -621,6 +621,13 @@
>   			ti,hwmods =3D "wd_timer2";
>   		};
>
> +		dmm@4e000000 {
> +			compatible =3D "ti,omap5-dmm";
> +			reg =3D <0x4e000000 0x800>;
> +			interrupts =3D <0 113 0x4>;
> +			ti,hwmods =3D "dmm";
> +		};
> +
>   		emif1: emif@4c000000 {
>   			compatible	=3D "ti,emif-4d5";
>   			ti,hwmods	=3D "emif1";
>


--=20
Beno=EEt Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
