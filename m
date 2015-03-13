From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 0/2] ARM: devicetree: Remove unused ti,codec property
Date: Fri, 13 Mar 2015 09:09:01 +0200
Message-ID: <55028D0D.3050403@ti.com>
References: <1426194899-14037-1-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426194899-14037-1-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Belisko <marek@goldelico.com>, bcousson@baylibre.com, tony@atomide.com
Cc: eballetbo@gmail.com, javier@dowhile0.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jarkko.nikula@bitmer.com, hns@goldelico.com
List-Id: linux-omap@vger.kernel.org

On 03/12/2015 11:14 PM, Marek Belisko wrote:
> ti,codec in not parsed in omap-twl4030 sound driver. It's not necessa=
ry
> to specify this property in DT because ti,twl4030-audio which ti,code=
c
> was pointing to by phandle is mfd driver and device for ASoC ic creat=
ed w/o
> any DT property (codec name is hardcoded in ASoC driver).

All:
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>


>=20
> Please see reply [1] from Peter Ujfalusi.
>=20
> [1]: http://comments.gmane.org/gmane.linux.ports.arm.omap/124273
>=20
> Marek Belisko (2):
>   ARM: dts: omap3: Remove all references to ti,codec property
>   Documentation: omap-twl4030: Remove ti,codec property
>=20
>  Documentation/devicetree/bindings/sound/omap-twl4030.txt | 2 --
>  arch/arm/boot/dts/omap3-beagle-xm.dts                    | 1 -
>  arch/arm/boot/dts/omap3-beagle.dts                       | 1 -
>  arch/arm/boot/dts/omap3-cm-t3x30.dtsi                    | 1 -
>  arch/arm/boot/dts/omap3-devkit8000.dts                   | 1 -
>  arch/arm/boot/dts/omap3-gta04.dtsi                       | 1 -
>  arch/arm/boot/dts/omap3-igep.dtsi                        | 1 -
>  arch/arm/boot/dts/omap3-lilly-a83x.dtsi                  | 1 -
>  arch/arm/boot/dts/omap3-overo-base.dtsi                  | 1 -
>  arch/arm/boot/dts/omap3-tao3530.dtsi                     | 1 -
>  10 files changed, 11 deletions(-)
>=20


--=20
P=E9ter
