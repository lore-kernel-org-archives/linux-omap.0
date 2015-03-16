From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 0/2] ARM: devicetree: Remove unused ti,codec property
Date: Mon, 16 Mar 2015 09:16:32 +0200
Message-ID: <55068350.9080500@ti.com>
References: <1426279237-15940-1-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426279237-15940-1-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Belisko <marek@goldelico.com>, bcousson@baylibre.com, tony@atomide.com
Cc: eballetbo@gmail.com, javier@dowhile0.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jarkko.nikula@bitmer.com, hns@goldelico.com, arnd@arndb.de
List-Id: linux-omap@vger.kernel.org

On 03/13/2015 10:40 PM, Marek Belisko wrote:
> ti,codec in not parsed in omap-twl4030 sound driver. It's not necessa=
ry
> to specify this property in DT because ti,twl4030-audio which ti,code=
c
> was pointing to by phandle is mfd driver and device for ASoC ic creat=
ed w/o
> any DT property (codec name is hardcoded in ASoC driver).
>=20
> Please see reply [1] from Peter Ujfalusi.

All:
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

>=20
> Changes from v1:
> - keep ti,codec property in Documentation as optional that the
> existing dtbs do not become noncompliant after the change
>=20
> [1]: http://comments.gmane.org/gmane.linux.ports.arm.omap/124273
>=20
> Marek Belisko (2):
>   ARM: dts: omap3: Remove all references to ti,codec property
>   Documentation: omap-twl4030: Move ti,codec property to optional
>=20
>  Documentation/devicetree/bindings/sound/omap-twl4030.txt | 3 +--
>  arch/arm/boot/dts/omap3-beagle-xm.dts                    | 1 -
>  arch/arm/boot/dts/omap3-beagle.dts                       | 1 -
>  arch/arm/boot/dts/omap3-cm-t3x30.dtsi                    | 1 -
>  arch/arm/boot/dts/omap3-devkit8000.dts                   | 1 -
>  arch/arm/boot/dts/omap3-gta04.dtsi                       | 1 -
>  arch/arm/boot/dts/omap3-igep.dtsi                        | 1 -
>  arch/arm/boot/dts/omap3-lilly-a83x.dtsi                  | 1 -
>  arch/arm/boot/dts/omap3-overo-base.dtsi                  | 1 -
>  arch/arm/boot/dts/omap3-tao3530.dtsi                     | 1 -
>  10 files changed, 1 insertion(+), 11 deletions(-)
>=20


--=20
P=E9ter
