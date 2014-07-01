From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v1 1/3] ARM: dts: am335x-bone: add support for beaglebone
 NAND cape
Date: Tue, 1 Jul 2014 01:47:10 -0700
Message-ID: <20140701084709.GO28884@atomide.com>
References: <1403612666-31197-1-git-send-email-pekon@ti.com>
 <1403612666-31197-2-git-send-email-pekon@ti.com>
 <20140626194824.GA18814@fox>
 <20980858CB6D3A4BAE95CA194937D5E73EAF8248@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:60275 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753510AbaGAIrL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jul 2014 04:47:11 -0400
Content-Disposition: inline
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EAF8248@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: Guido =?utf-8?B?TWFydMOtbmV6?= <guido@vanguardiasur.com.ar>, linux-omap <linux-omap@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>, Jason Kridner <jkridner@gmail.com>, Robert Nelson <robertcnelson@gmail.com>

* Gupta, Pekon <pekon@ti.com> [140627 14:08]:
> >From: Guido Mart=C3=ADnez [mailto:guido@vanguardiasur.com.ar]
> >>On Tue, Jun 24, 2014 at 05:54:24PM +0530, Pekon Gupta wrote:
>=20
> [...]
>=20
> >> +&gpmc {
> >> +	ranges =3D <0 0 0 0x01000000>;	/* address range =3D 16MB (minimu=
m GPMC partition) */
> >> +	nand@0,0 {
> >> +		status =3D "disabled";
> >> +		reg =3D <0 0 4>;		/* device IO registers */
> >> +		pinctrl-names =3D "default";
> >> +		pinctrl-0 =3D <&bbcape_nand_flash_pins>;
> >This doesn't seem to work as pinctrl properties are not parsed for
> >childs of the gpmc node. Did this work for you?
> >Putting this in the gpmc node makes it work, but how will we control
> >pins for the nand and nor independently? I believe there is currentl=
y no
> >support for muxing individual gpmc devices. If we want to add both
> >devices to the DT and enable them as needed we'd need to add support=
 for
> >this, right?
> >
> Yes, And that should be the case, because different devices would be
> connected to different chip-selects, so there should be support of
> providing individual pin-mux for different GPMC devices.
>=20
> Currently both NAND and NOR cape share GPMC_CS0, so both NAND and NOR
> capes will not work simultaneously. But I'm planning to modify NOR ca=
pe
> hardware at my end to use GPMC_CS1 instead of GPMC_CS0.
> - NAND on GPMC_CS0
> - NOR on GPMC_CS1

Hmm but we should have these working with both using CS0 without
any need to modify the hardware though?

In that case we should make sure we always set large enough GPMC
partition and that the pins are muxed for the connected GPMC
devices only.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
