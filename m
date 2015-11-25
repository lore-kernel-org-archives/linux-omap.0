From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] arm: boot: beaglex15: pass correct interrupt
Date: Wed, 25 Nov 2015 11:01:37 -0800
Message-ID: <20151125190137.GQ2517@atomide.com>
References: <1447350781-20649-1-git-send-email-balbi@ti.com>
 <1447350781-20649-3-git-send-email-balbi@ti.com>
 <564EB215.5080209@samsung.com>
 <564F4D90.4050305@gmail.com>
 <CAGTfZH3o_G91qDS6_9tYJHDDAbOWj90rBfCKvi0f-uL0L2PcTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGTfZH3o_G91qDS6_9tYJHDDAbOWj90rBfCKvi0f-uL0L2PcTA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: cw00.choi@samsung.com
Cc: Felipe Balbi <balbi@ti.com>, Rob Herring <robh+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Chanwoo Choi <cwchoi00@gmail.com> [151120 08:56]:
> Hi,
>=20
> On Sat, Nov 21, 2015 at 1:42 AM, Chanwoo Choi <cwchoi00@gmail.com> wr=
ote:
> > Hi,
> >
> > On 2015. 11. 20. =EC=98=A4=ED=9B=84 2:39, Chanwoo Choi wrote:
> >> Hi,
> >>
> >> On 2015=EB=85=84 11=EC=9B=94 13=EC=9D=BC 02:53, Felipe Balbi wrote=
:
> >>> According to latest schematics [1], GPIO_1/VBUSDET
> >>> on TPS659038 is tied to AM57x GPIO4_21. We can use
> >>> that as a VBUS interrupt, instead of relying on
> >>> PMIC's VBUS interrupts which don't seem to be firing
> >>> on x15 at all.
> >>>
> >>> A follow up patch will add support for using this
> >>> GPIO-based interrupt mechanism for notifying about
> >>> VBUS.
> >>>
> >>> [1] https://github.com/beagleboard/beagleboard-x15/blob/master/Be=
agleBoard-X15_RevA2.pdf
> >>>
> >>> Signed-off-by: Felipe Balbi <balbi@ti.com>
> >>> ---
> >>>  arch/arm/boot/dts/am57xx-beagle-x15.dts | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/b=
oot/dts/am57xx-beagle-x15.dts
> >>> index 6f3a1a7ec5f9..5e47162f7883 100644
> >>> --- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
> >>> +++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> >>> @@ -560,6 +560,7 @@
> >>>              extcon_usb2: tps659038_usb {
> >>>                      compatible =3D "ti,palmas-usb-vid";
> >>>                      ti,enable-vbus-detection;
> >>> +                    interrupts-extended =3D <&gpio4 21 IRQ_TYPE_=
EDGE_RISING>;
> >
> >                         vbus-gpio =3D <&gpio4 21>;
>=20
> I'm sorry. I'm sending the missing email without writing completion.
>=20
> I agree the Felipe's opinion. Just I think that we can use the
> following property
> instead of 'interrupt-extended'. Because I think 'vbus-gpio' is more
> readability than before. The following property mean the attribute of
> GPIO pin as VBUS.
> - vbus-gpio =3D <&gpio4 21>;

Hmm OK not applying the first two patches yet then as it seems changes
are needed. Felipe can you please repost the missing ones after you guy=
s
have figured out which dts changes are needed?

Regards,

Tony
