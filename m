From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v1 1/3] ARM: dts: am335x-bone: add support for beaglebone
 NAND cape
Date: Tue, 1 Jul 2014 06:28:34 -0700
Message-ID: <20140701132834.GR28884@atomide.com>
References: <1403612666-31197-1-git-send-email-pekon@ti.com>
 <1403612666-31197-2-git-send-email-pekon@ti.com>
 <20140626194824.GA18814@fox>
 <20980858CB6D3A4BAE95CA194937D5E73EAF8248@DBDE04.ent.ti.com>
 <20140701084709.GO28884@atomide.com>
 <20980858CB6D3A4BAE95CA194937D5E73EAF88FF@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:27772 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754356AbaGAN2f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jul 2014 09:28:35 -0400
Content-Disposition: inline
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EAF88FF@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: Guido =?utf-8?B?TWFydMOtbmV6?= <guido@vanguardiasur.com.ar>, linux-omap <linux-omap@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>, Jason Kridner <jkridner@gmail.com>, Robert Nelson <robertcnelson@gmail.com>

* Gupta, Pekon <pekon@ti.com> [140701 02:09]:
> >From: Tony Lindgren [mailto:tony@atomide.com]
> >>* Gupta, Pekon <pekon@ti.com> [140627 14:08]:
> >> >From: Guido Mart=C3=ADnez [mailto:guido@vanguardiasur.com.ar]
> >> >>On Tue, Jun 24, 2014 at 05:54:24PM +0530, Pekon Gupta wrote:
> >>
> >> [...]
> >>
> >> >> +&gpmc {
> >> >> +	ranges =3D <0 0 0 0x01000000>;	/* address range =3D 16MB (min=
imum GPMC partition) */
> >> >> +	nand@0,0 {
> >> >> +		status =3D "disabled";
> >> >> +		reg =3D <0 0 4>;		/* device IO registers */
> >> >> +		pinctrl-names =3D "default";
> >> >> +		pinctrl-0 =3D <&bbcape_nand_flash_pins>;
> >> >This doesn't seem to work as pinctrl properties are not parsed fo=
r
> >> >childs of the gpmc node. Did this work for you?
> >> >Putting this in the gpmc node makes it work, but how will we cont=
rol
> >> >pins for the nand and nor independently? I believe there is curre=
ntly no
> >> >support for muxing individual gpmc devices. If we want to add bot=
h
> >> >devices to the DT and enable them as needed we'd need to add supp=
ort for
> >> >this, right?
> >> >
> >> Yes, And that should be the case, because different devices would =
be
> >> connected to different chip-selects, so there should be support of
> >> providing individual pin-mux for different GPMC devices.
> >>
> >> Currently both NAND and NOR cape share GPMC_CS0, so both NAND and =
NOR
> >> capes will not work simultaneously. But I'm planning to modify NOR=
 cape
> >> hardware at my end to use GPMC_CS1 instead of GPMC_CS0.
> >> - NAND on GPMC_CS0
> >> - NOR on GPMC_CS1
> >
> >Hmm but we should have these working with both using CS0 without
> >any need to modify the hardware though?
> >
> Yes, but one at a time. That mean either of 'NAND cape' or 'NOR cape'=
=2E
> If you need both working simultaneously as 2 separate devices attache=
d
> to GPMC, then you need 2 separate chip-selects, which is what I'm try=
ing
> to test with [1].

Right only one enabled at a time, not both enabled at the same time :)
=20
> >In that case we should make sure we always set large enough GPMC
> >partition
> Yes, this is taken care with introduction of NOR cape in
> [PATCH v1 2/3] ARM: dts: am335x-bone: add support for beaglebone NOR =
cape
>  &gpmc {
> -	ranges =3D <0 0 0 0x01000000>;	/* address range =3D 16MB (minimum G=
PMC partition) */
> +	ranges =3D <0 0 0x08000000 0x01000000>;	/* address offset=3D128MB, =
range=3D128Mb=3D16MB */
> This GPMC partition suffices for both NAND and NOR requirements.

OK
=20
> > and that the pins are muxed for the connected GPMC
> >devices only.
> >
> Pin mux is something I need to re-work, because currently
> I've tested either NAND or NOR individually, not together.
>=20
> Also as mentioned above by Guido, pin-ctrl property is not parsed ind=
ividually
> for GPMC children, Instead pin-ctrl is set once for GPMC as a whole.

Yes, drivers/base/pinctrl.c should already take care of that though?
=20
> Do you have any suggestions on how pin-ctrl should be set if we have
> multiple devices connected to GPMC like;
> All these devices will share:
> - control lines (gpmc_wait, gpmc_ben_cle, gpmc_advn_ale, gpmc_we, gpm=
c_oe_ren)
> - *some* data lines (gpmc_ad[])
> - *some* address lines (gpmc_a[])
> - but chip-selects will be different:
> 	gpmc_cs0: NAND
> 	gpmc_cs1: NOR
> 	gpmc_cs2: SMSC91xx
> 	gpmc_cs3: Camera

Well the pinctrl settings should be done a the child driver level
when it probes so drivers/base/pinctrl.c does what it's supposed
to do.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
