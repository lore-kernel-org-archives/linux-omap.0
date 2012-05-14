From: Felipe Balbi <balbi@ti.com>
Subject: Re: Panda: USB crash with today's linux-next
Date: Mon, 14 May 2012 20:58:40 +0300
Message-ID: <20120514175838.GA31200@arwen.pp.htv.fi>
References: <1336996151.2333.3.camel@deskari>
 <20120514121527.GF22242@arwen.pp.htv.fi>
 <1336998251.2333.17.camel@deskari>
 <20120514122920.GK22242@arwen.pp.htv.fi>
 <20120514124757.GL22242@arwen.pp.htv.fi>
 <4FB13B91.7020007@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:42982 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757199Ab2ENSAb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 May 2012 14:00:31 -0400
Received: by lban1 with SMTP id n1so3377509lba.10
        for <linux-omap@vger.kernel.org>; Mon, 14 May 2012 11:00:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4FB13B91.7020007@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: balbi@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>, "Venkatraman S." <svenkatr@ti.com>


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 14, 2012 at 07:06:25PM +0200, Cousson, Benoit wrote:
> On 5/14/2012 2:47 PM, Felipe Balbi wrote:
> >Hi,
> >
> >On Mon, May 14, 2012 at 03:29:21PM +0300, Felipe Balbi wrote:
> >>On Mon, May 14, 2012 at 03:24:11PM +0300, Tomi Valkeinen wrote:
> >>>On Mon, 2012-05-14 at 15:15 +0300, Felipe Balbi wrote:
> >>>
> >>>>looks like MUSB is probing before transceiver driver... could it be ?
> >>>>Can you check transceiver has actually probed ? I guess panda's using
> >>>>twl6030-usb.c
> >>>
> >>>Ah. Perhaps it's then about this?
> >>>
> >>>[    0.352905] Skipping twl internal clock init and using bootloader v=
alue (unknown osc rate)
> >>>[    0.354034] twl 1-0048: PIH (irq 39) chaining IRQs 352..372
> >>>[    0.356079] VUSB: 3300 mV normal standby
> >>>[    0.358123] genirq: Threaded irq requested with handler=3DNULL and =
!ONESHOT for irq 356
> >>>[    0.358215] twl6030_usb twl6030_usb: can't get IRQ 356, err -22
> >>>[    0.358398] twl6030_usb: probe of twl6030_usb failed with error -22
> >>
> >>sounds about right. Now, why can't it get the IRQ... Benoit, is this
> >>related to your sparse irq/irq_domain changes ?
> >
> >Looks like twl6030-irq still missed conversion to threaded IRQ. It still
> >has that ugly ass kthread to handle the IRQs. Oh well, yet another
> >broken OMAP driver...
>=20
> Well, yeah, I did not clean all that mess.
>=20
> That being said, we did have some issue recently as well, but due to
> the increase of IRQ number and the fact the NR_IRQS is still used
> since SPARSE_IRQ migration is not completed.
>=20
> At least we saw similar issue with OMAP5.
>=20
> Maybe increasing NR_IRQS will fix that, but in this case, it looks
> like the IRQ might already been used by someone else.
> This is probably because something is still using the hard coded IRQ
> BASE number from the irqs.h define.
>=20
> I was planning to get rid of them to highlight the broken driver /
> board that might still used them. But this is on my TODO list :-(

another thing you might want to add to your TODO list is implementing
irq_chip properly on twl6030-irq:

$ git grep -e EXPORT_SYMBOL drivers/mfd/twl6030-irq.c
drivers/mfd/twl6030-irq.c:EXPORT_SYMBOL(twl6030_interrupt_unmask);
drivers/mfd/twl6030-irq.c:EXPORT_SYMBOL(twl6030_interrupt_mask);
drivers/mfd/twl6030-irq.c:EXPORT_SYMBOL(twl6030_mmc_card_detect_config);
drivers/mfd/twl6030-irq.c:EXPORT_SYMBOL(twl6030_mmc_card_detect);

$ git grep -e "twl6030_interrupt_\(mask\|unmask\)" drivers/
drivers/mfd/twl6030-irq.c:int twl6030_interrupt_unmask(u8 bit_mask, u8 offs=
et)
drivers/mfd/twl6030-irq.c:EXPORT_SYMBOL(twl6030_interrupt_unmask);
drivers/mfd/twl6030-irq.c:int twl6030_interrupt_mask(u8 bit_mask, u8 offset)
drivers/mfd/twl6030-irq.c:EXPORT_SYMBOL(twl6030_interrupt_mask);
drivers/mfd/twl6030-irq.c:	twl6030_interrupt_unmask(TWL6030_MMCDETECT_INT_M=
ASK,
drivers/mfd/twl6030-irq.c:	twl6030_interrupt_unmask(TWL6030_MMCDETECT_INT_M=
ASK,
drivers/rtc/rtc-twl.c:		twl6030_interrupt_unmask(TWL6030_RTC_INT_MASK,
drivers/rtc/rtc-twl.c:		twl6030_interrupt_unmask(TWL6030_RTC_INT_MASK,
drivers/rtc/rtc-twl.c:		twl6030_interrupt_mask(TWL6030_RTC_INT_MASK,
drivers/rtc/rtc-twl.c:		twl6030_interrupt_mask(TWL6030_RTC_INT_MASK,
drivers/usb/otg/twl6030-usb.c:	twl6030_interrupt_unmask(0x05, REG_INT_MSK_L=
INE_C);
drivers/usb/otg/twl6030-usb.c:	twl6030_interrupt_unmask(0x05, REG_INT_MSK_S=
TS_C);
drivers/usb/otg/twl6030-usb.c:	twl6030_interrupt_unmask(TWL6030_CHARGER_CTR=
L_INT_MASK,
drivers/usb/otg/twl6030-usb.c:	twl6030_interrupt_unmask(TWL6030_CHARGER_CTR=
L_INT_MASK,
drivers/usb/otg/twl6030-usb.c:	twl6030_interrupt_mask(TWL6030_USBOTG_INT_MA=
SK,
drivers/usb/otg/twl6030-usb.c:	twl6030_interrupt_mask(TWL6030_USBOTG_INT_MA=
SK,

That whole MMC card detection is also pretty screwed up. Balaji/Venkat,
can you guys look into that ? Probably making something generic using a
threaded IRQ handler ?

I mean, all the MMC core should need is an IRQ number (through GPIOs or
not doesn't/shouldn't matter) and it should be able to use a threaded
IRQ handler to kick the card detection/initialization.

--=20
balbi

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPsUfOAAoJEIaOsuA1yqRE/gIP/07g9voN+Tn9Wr2owEsbW4YL
q4Hk7vwF5IouyAnRSYIlBd8MjvzWHaY5GWWFxDCePIUaPup6ZrJaBuCI2uzJjKti
UKIJdBKZRfvKCLYHQVxqGlRi0buQvoh6akUQahKqwi57RIrmh2KcN64rJPvshh23
tojvNK8hXbRCCSORkqOjp2BH8GieMaIYb9b9ZfG4Di+Z1sV9teXNBs/rvCoAwz65
JH87iDv21JqeszNubqHIxvuNb7UWG1WCD+LZp75P41QXIh32qmnSPm5BFGzbzg9P
Vl1+yOH6WYSqBn6b9qVp66wngnfCR9N+C4nfwQhaRiFUej5K3OJh8CvruaYo8nv/
GkoRUK2sOCo0cnoBkt09sfp1hrJV0XVzA2n0H4AheWqQcShe0OcKB3ZbbVX3mz1P
OUMVlEaOkmjD1A3APRkYdDStRzaAoTNGwX+B7D8JEHhRncVZJ4Zx+1pmBl8VOAQQ
9YvFX972xfjUDQLO5+CakyrCj7gqGBRf2YebSC88jIGF8K/XK3xGdaq+TfzSi+oQ
zUli2UgrBDt4Su/46tqBp+K+2pw03aDpJNmwxTGe9H3SWtko18nV+1OiAkFt1Mfz
Jq1/YczjU2tY2AIVQcuQ0LvoHsVfeHy455lf/6e2juPM/tTh0wSfG8F+iwlDIT6q
VqLc6xmaVQzz4DNbloov
=PzsU
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
