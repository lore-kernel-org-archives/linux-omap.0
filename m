From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: Enabling HSUSB1 port on OMAP3430 labrador
Date: Thu, 26 Nov 2009 21:37:19 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0309DAC238@dbde02.ent.ti.com>
References: <4B0BEED4.1060005@holografika.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0309DAC237@dbde02.ent.ti.com>
 <4B0E5E81.6030706@holografika.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_5A47E75E594F054BAF48C5E4FC4B92AB0309DAC238dbde02enttico_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53840 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756271AbZKZQHc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Nov 2009 11:07:32 -0500
In-Reply-To: <4B0E5E81.6030706@holografika.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kovacs Peter Tamas <p.kovacs@holografika.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--_002_5A47E75E594F054BAF48C5E4FC4B92AB0309DAC238dbde02enttico_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Kovacs Peter Tamas wrote:
>=20
> Dear Anand,
>=20
> thank you very much for your exhaustive answer and help. Unfortunately=20
> it seems there is no clock signal coming out of the HSUSB1_CLK line.
>=20
> >> We are trying to make the HSUSB1 port on the OMAP3430 work as an USB h=
ost.
> >> To do that, an ISP1507A ULPI HighSpeed USB transceiver is connected to=
=20
> >> the HSUSB1pins (HSUSB1_STP, CLK, D-0..D7, DIR, NXT).
> >>
> >> I have all these USB related kernel config options enabled:
> >> USB_EHCI_HCD
> >> USB_OHCI_HCD
> >> USB_MUSB_HDRC
> >> TWL4030_USB
> >>
> >> My guess was that either EHCI or the Inventra should be the one enabli=
ng=20
> >> that USB port on the OMAP, but no luck.
> >> The external USB port on the MDK works fine with this configuration.
> >>
> >> The pin multiplexing configuration in the board file omap3430-labrador=
.c=20
> >> in u-boot also seems to be correct (although the config of USB1_STP=20
> >> seems to be strange, but changing that didn't work either).
> >>    =20
> >
> > HSUSB1 is not supposed to be used with the labrador (do you have a link
> > to the board schematics with the mods?). HSUSB1 is the EHCI port.
> >  =20
> What do you mean not supposed to be used? HSUSB0 goes to the TWL4030 and=
=20
> then out of the casing. HSUSB2 goes to the ISP1702, but the pins are not=
=20
> wired out on the Logic MDK baseboard so we cannot use that. Thus only=20
> one possibility remains if we need an extra USB port inside the casing,=20
> which is HSUSB1.


I meant there was nothing connected to it on the default board.
The pads are possibly brought out to the expansion connector, but
I haven't checked the schematic - so I'm not sure. I don't think
anyone's tried hooking up a transceiver to that port.


> > Not sure why the pad conf is done in u-boot for this board, but maybe
> > it was a copy-paste thing. That being said, if you've got the part
> > installed correctly, it ought to work.
> >  =20
> Yes, I can also see these pin multiplexing configs in arch/arm/mach-omap2=
/usb-ehci.c.
> I have defined CONFIG_OMAP_EHCI_PHY_MODE there to make sure they are PHY=
=20
> (couldn't find it in menuconfig, but this macro seems to be used in this =
single file).
> Still, the clock goes high when powering the board on, and it remains=20
> there forever.
>=20
> I recall seeing a TI-specific kernel source in another git repository,=20
> which had menuconfig options for setting PHY/TLL, maybe the USB code is=20
> different too?
>=20
> >> Note, the ISP1507A is connected to the following pins of the BGA:
> >> HSUSB1_STP (AF10)
> >> HSUSB1_CLK (AE10)
> >> HSUSB1_DIR (AF9)
> >> HSUSB1_NXP (AG9)
> >> HSUSB1_D0 (AF11)
> >> HSUSB1_D1 (AG12)
> >> HSUSB1_D2 (AH12)
> >> HSUSB1_D3 (AH14)
> >> HSUSB1_D4 (AE11)
> >> HSUSB1_D5 (AH9)
> >> HSUSB1_D6 (AF13)
> >> HSUSB1_D7 (AE13)
> >>    =20
> >
> > These are the pads for EHCI. So I suppose that's what you're trying to =
use.
> >  =20
> We suspect there might be a confusion here.
> According to the Logic 3430 SOM board schematic, HSUSB1_CLK is AE10 (and=
=20
> also ETK_CLK, MMC3_CMD, GPIO_13).
> According to the OMAP3430 Multimedia Processor Data Manual version N=20
> (OMAP3430_ES1.0_POP_DM_V_N.pdf), the AE10 pin can be ETK_CLK, HW_DBG1,=20

Not sure about this - if it says ES1.0, that's a really old silicon
version. The HSUSB block was not present in that chip and there are
very very few of these chips floating around.

ES2.0 and greater all have this block and all boards in the wild (including
the labrador) should have an ES2 or greater chip.

> GPIO_13 and SYS_NDMAREQ1, so it mentions HW_DBG1 as Mode3 instead of USB.
> Then, in mach_omap2/usb-ehci.c, I can see =20
> omap_cfg_reg(Y8_3430_USB1HS_PHY_CLK); Does this mean that Y8 is=20
> configured as USB? According to the Logic schematic pin Y8 is UART1_RX=20
> or GPIO_151, but not USB at all.

No, this is incorrect. Go with the setting in mach-omap2/mux.c.
All packages have the same pads for HSUSB1 lines, so there should be
no issue with this.

>=20
> So far we have used the pins as seen in the Logic schematic for creating=
=20
> an extension board with a number of SPI and GPIO signals, and everything=
=20
> worked perfectly. Why are the pins described differently?
>=20
> > Note that EHCI on the OMAP3 supports only the input clocking mode. This
> > might mean you need to check if you've configured the PHY correctly for
> > this mode. (No XTAL required, OMAP provides the clock to the PHY).
> > NXP seems to have removed all mention of this mode from their
> > data sheets, so you might want to check with them.
> >  =20
> Thanks, this is our fault. The clock pin of the ISP1507 is output only,=20
> so it seems not to be compatible with the OMAP3430.
> The clock pin of the ISP1504 can be configured for I/O, however this=20
> component is quite difficult to get, but it seems it's necessary.

You might want to take a look at the NXP ISP1703. I believe it's
available now and does officially support the input-clocking mode.
(Disclaimer: I haven't personally used with my OMAP3 SDP , but I was
informed that it works)

Beagleboard and others use the SMSC 332x, but we have issues with
suspend-resume with this PHY. If you're designing fresh, you might
want to try the NXP PHY.


> > Also, do you see a 60MHz clock when you probe the HSUSB1_CLK line?
> >  =20
> Unfortunately not. There is a constant high in the CLK line during the=20
> whole poweron and boot process, no matter if I configure the USB to PHY=20
> or TLL. We've also tried another Logic OMAP MDK unit and the effect is=20
> the same.
>=20
> Could you please suggest what can be the cause of no clock signal (and=20
> other ULPI signals) appearing at all?

Depends. DPLL5 not locked maybe? Current linux-omap code should have this
sorted out (other boards work great).

On current linux-omap, all you should need to do is add an
entry in the board file (attached patch should do it, compile
tested only), and enable EHCI in the menuconfig. Now when you
load the ehci module, you should be able to see the 60MHz clock
on HSUSB1_CLK.

Note that the clock won't be enabled until the ehci driver enables the
usb 120 MHz f-clock (which is divided to give out the ULPI clock).

- Anand

--_002_5A47E75E594F054BAF48C5E4FC4B92AB0309DAC238dbde02enttico_
Content-Type: application/octet-stream; name="ldp-enable-ehci.patch"
Content-Description: ldp-enable-ehci.patch
Content-Disposition: attachment; filename="ldp-enable-ehci.patch"; size=1078;
	creation-date="Thu, 26 Nov 2009 21:30:42 GMT";
	modification-date="Thu, 26 Nov 2009 21:30:42 GMT"
Content-Transfer-Encoding: base64

RW5hYmxlIEVIQ0kgb24gT01BUDMgTERQCgpGb3ItdGVzdC1vbmx5LiBObyBzaWduLW9mZiB5ZXQu
Ci0tLQogYXJjaC9hcm0vbWFjaC1vbWFwMi9ib2FyZC1sZHAuYyB8ICAgMTIgKysrKysrKysrKysr
CiAxIGZpbGVzIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9ib2FyZC1sZHAuYyBiL2FyY2gvYXJtL21hY2gt
b21hcDIvYm9hcmQtbGRwLmMKaW5kZXggYzA2MjIzOC4uMTA0OGY0YSAxMDA2NDQKLS0tIGEvYXJj
aC9hcm0vbWFjaC1vbWFwMi9ib2FyZC1sZHAuYworKysgYi9hcmNoL2FybS9tYWNoLW9tYXAyL2Jv
YXJkLWxkcC5jCkBAIC0zNzQsNiArMzc0LDE3IEBAIHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpsZHBfZGV2aWNlc1tdIF9faW5pdGRhdGEgPSB7CiAJJmxkcF9ncGlvX2tleXNfZGV2aWNl
LAogfTsKIAorc3RhdGljIHN0cnVjdCBlaGNpX2hjZF9vbWFwX3BsYXRmb3JtX2RhdGEgZWhjaV9w
ZGF0YSBfX2luaXRjb25zdCA9IHsKKwkucG9ydF9tb2RlWzBdID0gRUhDSV9IQ0RfT01BUF9NT0RF
X1BIWSwKKwkucG9ydF9tb2RlWzFdID0gRUhDSV9IQ0RfT01BUF9NT0RFX1VOS05PV04sCisJLnBv
cnRfbW9kZVsyXSA9IEVIQ0lfSENEX09NQVBfTU9ERV9VTktOT1dOLAorCisJLnBoeV9yZXNldCA9
IGZhbHNlLAorCS5yZXNldF9ncGlvX3BvcnRbMF0gPSAtRUlOVkFMLAorCS5yZXNldF9ncGlvX3Bv
cnRbMV0gPSAtRUlOVkFMLAorCS5yZXNldF9ncGlvX3BvcnRbMl0gPSAtRUlOVkFMLAorfTsKKwog
c3RhdGljIHZvaWQgX19pbml0IG9tYXBfbGRwX2luaXQodm9pZCkKIHsKIAlvbWFwX2kyY19pbml0
KCk7CkBAIC0zODUsNiArMzk2LDcgQEAgc3RhdGljIHZvaWQgX19pbml0IG9tYXBfbGRwX2luaXQo
dm9pZCkKIAlhZHM3ODQ2X2Rldl9pbml0KCk7CiAJb21hcF9zZXJpYWxfaW5pdCgpOwogCXVzYl9t
dXNiX2luaXQoKTsKKwl1c2JfZWhjaV9pbml0KCZlaGNpX3BkYXRhKTsKIAogCXR3bDQwMzBfbW1j
X2luaXQobW1jKTsKIAkvKiBsaW5rIHJlZ3VsYXRvcnMgdG8gTU1DIGFkYXB0ZXJzICovCg==

--_002_5A47E75E594F054BAF48C5E4FC4B92AB0309DAC238dbde02enttico_--
