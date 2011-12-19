From: Olof Johansson <olof@lixom.net>
Subject: Re: [RFC v2 PATCH 1/3] dt: device tree bindings for DDR memories
Date: Mon, 19 Dec 2011 08:52:55 -0800
Message-ID: <CAOesGMjOybCbu1Bgxe0Te=XANVOqOPcaDOL_6c4=pVCxzu9ZnA@mail.gmail.com>
References: <1324303533-17458-1-git-send-email-aneesh@ti.com>
	<1324303533-17458-2-git-send-email-aneesh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:55518 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032Ab1LSQw4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Dec 2011 11:52:56 -0500
Received: by werm1 with SMTP id m1so1398547wer.19
        for <linux-omap@vger.kernel.org>; Mon, 19 Dec 2011 08:52:55 -0800 (PST)
In-Reply-To: <1324303533-17458-2-git-send-email-aneesh@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aneesh V <aneesh@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>

Hi,

Some comments below, but also a more general question: How much of
this generic data makes sense to encode in the device tree? Final
hardware configuration usually has to take into consideration board
layout/signal delays, etc, and that's not part of this binding.


On Mon, Dec 19, 2011 at 6:05 AM, Aneesh V <aneesh@ti.com> wrote:

> diff --git a/Documentation/devicetree/bindings/ddr/ddr.txt b/Document=
ation/devicetree/bindings/ddr/ddr.txt
> new file mode 100644
> index 0000000..f15c4dd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ddr/ddr.txt
> @@ -0,0 +1,114 @@
> +* DDR SDRAM memories compliant to JEDEC specifications JESD209-2(LPD=
DR2)
> + =A0or JESD79-3(DDR3).
> +
> +Required properties:
> +- compatible : Should be one of - "jedec,ddr3", "jedec,lpddr2-nvm",
> + =A0"jedec,lpddr2-s2", "jedec,lpddr2-s4"
> +
> + =A0"ti,jedec-ddr3" should be listed if the memory part is DDR3 type
> +
> + =A0"ti,jedec-lpddr2-s2" should be listed if the memory part is LPDD=
R2-S2 type
> +
> + =A0"ti,jedec-lpddr2-s4" should be listed if the memory part is LPDD=
R2-S4 type
> +
> + =A0"ti,jedec-lpddr2-nvm" should be listed if the memory part is LPD=
DR2-NVM type
> +
> +- density =A0: string representing the density of the device in term=
s of
> + =A0Mb (mega bits). Following are the allowed values: "64Mb", "128Mb=
",
> + =A0"256Mb", "512Mb", "1Gb", "2Gb", "4Gb", "8Gb", "16Gb", or "32Gb"

No, please encode as a two-cell integer instead.

> +- io-width : string representing the io width: "x8", "x16" or "x32".

No, encode as an integer.

> +
> +Optional properties:
> +
> +The following optional properties represent the minimum value of som=
e AC
> +timing parameters of the DDR device in terms of number of clock cycl=
es.
> +These values shall be obtained from the device data-sheet.
> +
> +The suffix nCK indicates that the unit for these parameters is numbe=
r
> +of DDR clock cycles. Note: In LPDDR2 spec and data-sheets tCK is use=
d
> +inter-changeably for nCK. Both are equivalent in this context.

Please use only lower characters in property names unless absolutely
necessary, which this doesn't qualify as, in my opinion.

Also, can't these strings be shortened a bit? All of them have '-min'
in common, and none of them seem to be very devicetree-like in their
naming.

=46inally, the "lpddr2" and "ddr3" properties could just be prefixed
with "lpddr2,<propertyname>" instead.

> +
> +- tRRD-min-nCK
> +- tWTR-min-nCK
> +- tXP-min-nCK
> +- tRTP-min-nCK
> +- tCKE-min-nCK
> +- tRPab-min-nCK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* LPDDR2 only */
> +- tRCD-min-nCK =A0 =A0 =A0 =A0 /* LPDDR2 only */
> +- tWR-min-nCK =A0 =A0 =A0 =A0 =A0/* LPDDR2 only */
> +- tRASmin-min-nCK =A0 =A0 =A0/* LPDDR2 only */
> +- tCKESR-min-nCK =A0 =A0 =A0 /* LPDDR2 only */
> +- tFAW-min-nCK =A0 =A0 =A0 =A0 /* LPDDR2 only */
> +- tZQCS-min-nCK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* DDR3 only */
> +- tZQoper-min-nCK =A0 =A0 =A0/* DDR3 only */
> +- tZQinit-min-nCK =A0 =A0 =A0/* DDR3 only */
> +- tXS-min-nCK =A0 =A0 =A0 =A0 =A0/* DDR3 only */
> +
> +Child nodes:
> +- The ddr node may have one or more child nodes of type "ddr-timings=
".
> + =A0"ddr-timings" provides AC timing parameters of the device for
> + =A0a given speed-bin. The user may provide the timings for as many
> + =A0speed-bins as is required. Please see Documentation/devicetree/
> + =A0bindings/ddr/ddr-timings.txt for more information on "ddr-timing=
s"
> +
> +Example:
> +
> +elpida_ECB240ABACN : ddr {
> + =A0 =A0 =A0 compatible =A0 =A0 =A0=3D "Elpida,ECB240ABACN","jedec,l=
pddr2-s4";
> + =A0 =A0 =A0 density =A0 =A0 =A0 =A0 =3D "2Gb";
> + =A0 =A0 =A0 io-width =A0 =A0 =A0 =A0=3D "x32";
> +
> + =A0 =A0 =A0 tRPab-min-nCK =A0 =3D <3>;
> + =A0 =A0 =A0 tRCD-min-nCK =A0 =A0=3D <3>;
> + =A0 =A0 =A0 tWR-min-nCK =A0 =A0 =3D <3>;
> + =A0 =A0 =A0 tRASmin-min-nCK =3D <3>;
> + =A0 =A0 =A0 tRRD-min-nCK =A0 =A0=3D <2>;
> + =A0 =A0 =A0 tWTR-min-nCK =A0 =A0=3D <2>;
> + =A0 =A0 =A0 tXP-min-nCK =A0 =A0 =3D <2>;
> + =A0 =A0 =A0 tRTP-min-nCK =A0 =A0=3D <2>;
> + =A0 =A0 =A0 tCKE-min-nCK =A0 =A0=3D <3>;
> + =A0 =A0 =A0 tCKESR-min-nCK =A0=3D <3>;
> + =A0 =A0 =A0 tFAW-min-nCK =A0 =A0=3D <8>;
> +
> + =A0 =A0 =A0 timings_elpida_ECB240ABACN_400mhz: ddr-timings {

You will need a unit address here.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 min-freq =A0 =A0 =A0 =A0=3D <10000000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 max-freq =A0 =A0 =A0 =A0=3D <400000000>=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tRP-ps =A0 =A0 =A0 =A0 =A0=3D <21000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tRCD-ps =A0 =A0 =A0 =A0 =3D <18000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tWR-ps =A0 =A0 =A0 =A0 =A0=3D <15000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tRAS-min-ps =A0 =A0 =3D <42000:;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tRRD-ps =A0 =A0 =A0 =A0 =3D <10000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tWTR-ps =A0 =A0 =A0 =A0 =3D <7500>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tXP-ps =A0 =A0 =A0 =A0 =A0=3D <7500>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tRTP-ps =A0 =A0 =A0 =A0 =3D <7500>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tCKESR-ps =A0 =A0 =A0 =3D <15000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tDQSCK-max-ps =A0 =3D <5500>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tFAW-ps =A0 =A0 =A0 =A0 =3D <50000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tZQCS-ps =A0 =A0 =A0 =A0=3D <90000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tZQoper-ps =A0 =A0 =A0=3D <360000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tZQinit-ps =A0 =A0 =A0=3D <1000000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tRAS-max-ns =A0 =A0 =3D <70000>;
> + =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 timings_elpida_ECB240ABACN_200mhz: ddr-timings {

Same here, since you have more than one table. See previous
discussions about emc tables on tegra (I'll repost that series this
week).

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 min-freq =A0 =A0 =A0 =A0=3D <10000000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 max-freq =A0 =A0 =A0 =A0=3D <200000000>=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tRP-ps =A0 =A0 =A0 =A0 =A0=3D <21000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tRCD-ps =A0 =A0 =A0 =A0 =3D <18000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tWR-ps =A0 =A0 =A0 =A0 =A0=3D <15000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tRAS-min-ps =A0 =A0 =3D <42000:;

Typo

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tRRD-ps =A0 =A0 =A0 =A0 =3D <10000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tWTR-ps =A0 =A0 =A0 =A0 =3D <10000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tXP-ps =A0 =A0 =A0 =A0 =A0=3D <7500>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tRTP-ps =A0 =A0 =A0 =A0 =3D <7500>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tCKESR-ps =A0 =A0 =A0 =3D <15000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tDQSCK-max-ps =A0 =3D <5500>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tFAW-ps =A0 =A0 =A0 =A0 =3D <50000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tZQCS-ps =A0 =A0 =A0 =A0=3D <90000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tZQoper-ps =A0 =A0 =A0=3D <360000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tZQinit-ps =A0 =A0 =A0=3D <1000000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tRAS-max-ns =A0 =A0 =3D <70000>;
> + =A0 =A0 =A0 };
> +
> +}
> diff --git a/Documentation/devicetree/bindings/ddr/ddr_timings.txt b/=
Documentation/devicetree/bindings/ddr/ddr_timings.txt
> new file mode 100644
> index 0000000..38fcdec
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ddr/ddr_timings.txt
> @@ -0,0 +1,62 @@
> +* AC timing parameters of DDR memories for a given speed-bin
> + =A0At the moment properties for only LPDDR2 and DDR3 have been adde=
d
> +
> +Required properties:
> +- min-freq : minimum DDR clock frequency for the speed-bin
> +- max-freq : maximum DDR clock frequency for the speed-bin

There should be a compatible field here too, especially if the binding
ever has to be revised.

> +
> +Optional properties:
> +
> +The following properties represent AC timing parameters from the mem=
ory
> +data-sheet of the device for a given speed-bin. All these properties=
 are
> +of type <u32> and "-ps", "-ns", "-nCK" etc in the name indicates the
> +unit of the corresponding parameter:
> + =A0ps - pico seconds
> + =A0ns - nano seconds
> + =A0nCK - number of DDR clock cycles. Please note that in LPDDR2 spe=
c and
> + =A0data-sheets tCK is used inter-changeably for nCK. Both are equiv=
alent
> + =A0in this context.

Seems noisy to include the units on every single property instead of
just in the bindings.

> +
> +- tRCD-ps
> +- tWR-ps
> +- tRAS-min-ps
> +- tRRD-ps
> +- tWTR-ps
> +- tXP-ps
> +- tRTP-ps
> +- tDQSCK-max-ps
> +- tFAW-ps
> +- tZQCS-ps
> +- tZQinit-ps
> +- tRP-ps =A0 =A0 =A0 /* DDR3 only */
> +- tRC-ps =A0 =A0 =A0 /* DDR3 only */
> +- tXSDLL-nCK =A0 /* DDR3 only */
> +- tCKE-ps =A0 =A0 =A0/* DDR3 only */
> +- tZQoper-ps =A0 /* DDR3 only */
> +- tRPab-ps =A0 =A0 /* LPDDR2 only */
> +- tZQCL-ps =A0 =A0 /* LPDDR2 only */
> +- tCKESR-ps =A0 =A0/* LPDDR2 only */
> +- tRAS-max-ns =A0/* LPDDR2 only */

Same above about type-specific properties.

> +
> +Example:
> +
> +timings_elpida_ECB240ABACN_400mhz: ddr-timings {
> + =A0 =A0 =A0 min-freq =A0 =A0 =A0 =A0=3D <10000000>;
> + =A0 =A0 =A0 max-freq =A0 =A0 =A0 =A0=3D <400000000>;
> + =A0 =A0 =A0 tRPab-ps =A0 =A0 =A0 =A0=3D <21000>;
> + =A0 =A0 =A0 tRCD-ps =A0 =A0 =A0 =A0 =3D <18000>;
> + =A0 =A0 =A0 tWR-ps =A0 =A0 =A0 =A0 =A0=3D <15000>;
> + =A0 =A0 =A0 tRAS-min-ps =A0 =A0 =3D <42000:;
> + =A0 =A0 =A0 tRRD-ps =A0 =A0 =A0 =A0 =3D <10000>;
> + =A0 =A0 =A0 tWTR-ps =A0 =A0 =A0 =A0 =3D <7500>;
> + =A0 =A0 =A0 tXP-ps =A0 =A0 =A0 =A0 =A0=3D <7500>;
> + =A0 =A0 =A0 tRTP-ps =A0 =A0 =A0 =A0 =3D <7500>;
> + =A0 =A0 =A0 tCKESR-ps =A0 =A0 =A0 =3D <15000>;
> + =A0 =A0 =A0 tDQSCK-max-ps =A0 =3D <5500>;
> + =A0 =A0 =A0 tFAW-ps =A0 =A0 =A0 =A0 =3D <50000>;
> + =A0 =A0 =A0 tZQCS-ps =A0 =A0 =A0 =A0=3D <90000>;
> + =A0 =A0 =A0 tZQCL-ps =A0 =A0 =A0 =A0=3D <360000>;
> + =A0 =A0 =A0 tZQinit-ps =A0 =A0 =A0=3D <1000000>;
> + =A0 =A0 =A0 tRAS-max-ns =A0 =A0 =3D <70000>;
> +};
> +
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
