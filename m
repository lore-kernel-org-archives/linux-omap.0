From: <kalle.jokiniemi@nokia.com>
Subject: RE: [PATCH V4 3/3] OMAP: I2C: Add mpu wake up latency constraint	in
 i2c
Date: Mon, 23 Nov 2009 08:35:30 +0100
Message-ID: <E839BB5467CE1640B3CC2F90F647A52C274A01E2D2@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1256125881-12441-1-git-send-email-kalle.jokiniemi@digia.com>
	<1256125881-12441-2-git-send-email-kalle.jokiniemi@digia.com>
	<1256125881-12441-3-git-send-email-kalle.jokiniemi@digia.com>
	<1256125881-12441-4-git-send-email-kalle.jokiniemi@digia.com>
	<CD8CC2B65FEE304DA95744A5472698F2029E427B04@dlee06.ent.ti.com>
	<1256806523.31764.57.camel@ubuntu>
	<E839BB5467CE1640B3CC2F90F647A52C274A01DB80@NOK-EUMSG-02.mgdnok.nokia.com>
 <87eint6u0a.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_E839BB5467CE1640B3CC2F90F647A52C274A01E2D2NOKEUMSG02mgd_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:31366 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754198AbZKWHfp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Nov 2009 02:35:45 -0500
In-Reply-To: <87eint6u0a.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com, tony@atomide.com, m-sonasath@ti.com
Cc: linux-omap@vger.kernel.org, jouni.hogander@nokia.com

--_002_E839BB5467CE1640B3CC2F90F647A52C274A01E2D2NOKEUMSG02mgd_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: ext Kevin Hilman [mailto:khilman@deeprootsystems.com]=20
> Sent: 20. marraskuuta 2009 18:28
> To: Jokiniemi Kalle (Nokia-D/Tampere); Tony Lindgren
> Cc: linux-omap@vger.kernel.org; m-sonasath@ti.com; Hogander=20
> Jouni (Nokia-D/Tampere)
> Subject: Re: [PATCH V4 3/3] OMAP: I2C: Add mpu wake up=20
> latency constraint in i2c
>=20
> <kalle.jokiniemi@nokia.com> writes:
>=20
> > Could you please take this patch in? Currently i2c is not=20
> working very=20
> > well with cpuidle and off mode, and the patch is needed.
> >
> > I would go with V4 of the patch.
>=20
> Kalle,
>=20
> Last I saw with this thread, it didn't look like there was resolution.

OK. Let's resolve it then :)

Moiz, could you please comment on my last reply in the old thread:

--------- (sent on 29th of October) ----------------

> >>Well, I don't completely agree with the necessity of preparing for=20
> >>different rx/tx thresholds. For this to make sense, the i2c-omap=20
> >>driver should first separate in it's code the use of rx and tx=20
> >>thresholds. If someone is planning to do that, he/she should anyway=20
> >>update the usage of fifo_size throughout the code,=20
> including the wake=20
> >>up latency setting.
> >>
> >>Anyways, attached a patch that separates the mpu wake up=20
> latencies for=20
> >>rx and tx. In case that is needed. Though I'm not for it, since it=20
> >>adds unneeded complexity.
> >>
--------- (sent on 29th of October) ----------------

Attached also the alternative patch I was referring to.


> If things are resolved, this shouldn't go upstream via PM=20
> branch, since it doesn't seem to have any dependencies on the=20
> PM branch.

Ah, the pm interfaces are in mainline now.


>=20
> It should go upstream either via the I2C list, or via Tony.
>=20
> If it goes via i2c list, I can add it to PM branch while=20
> waiting for it to merge.

Tony, would you take this? If not, what is the address for i2c mailing list=
, and who maintains i2c?

- Kalle

>=20
> Kevin
>=20
>=20
> >>-----Original Message-----
> >>From: linux-omap-owner@vger.kernel.org=20
> >>[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of ext Kalle=20
> >>Jokiniemi
> >>Sent: 29. lokakuuta 2009 10:55
> >>To: Sonasath, Moiz
> >>Cc: khilman@deeprootsystems.com; linux-omap@vger.kernel.org
> >>Subject: RE: [PATCH V4 3/3] OMAP: I2C: Add mpu wake up latency=20
> >>constraint in i2c
> >>
> >>OK, let's try this once more, since my mail did not seem to go to=20
> >>linux-omap.
> >>
> >>Sorry for the spam.
> >>
> >>See my comments below:
> >>
> >>On Fri, 2009-10-23 at 18:53 +0300, Sonasath, Moiz wrote:
> >>> Hello Jokiniemi!
> >>>=20
> >>> > -----Original Message-----
> >>> > From: Kalle Jokiniemi [mailto:kalle.jokiniemi@digia.com]
> >>> > Sent: Wednesday, October 21, 2009 6:51 AM
> >>> > To: khilman@deeprootsystems.com
> >>> > Cc: linux-omap@vger.kernel.org; Kalle Jokiniemi; Sonasath, Moiz;
> >>> Jarkko
> >>> > Nikula; Paul Walmsley; Menon, Nishanth
> >>> > Subject: [PATCH V4 3/3] OMAP: I2C: Add mpu wake up latency
> >>> constraint in
> >>> > i2c
> >>> >=20
> >>> > While waiting for completion of the i2c transfer, the MPU
> >>could hit
> >>> > OFF mode and cause several msecs of delay that made i2c=20
> transfers=20
> >>> > fail more often. The extra delays and subsequent=20
> re-trys cause i2c=20
> >>> > clocks to be active more often. This has also an negative
> >>effect on
> >>> > power consumption.
> >>> >=20
> >>> > Created a mechanism for passing and using the=20
> constraint setting=20
> >>> > function in driver code. The used mpu wake up latency=20
> constraints=20
> >>> > are now set individually per bus, and they are=20
> calculated based on=20
> >>> > clock rate and fifo size.
> >>> >=20
> >>> > Thanks to Jarkko Nikula, Moiz Sonasath, Paul Walmsley, and
> >>Nishanth
> >>> > Menon for tuning out the details of this patch.
> >>> >=20
> >>> > Cc: Moiz Sonasath <m-sonasath@ti.com>
> >>> > Cc: Jarkko Nikula <jhnikula@gmail.com>
> >>> > Cc: Paul Walmsley <paul@pwsan.com>
> >>> > Cc: Nishanth Menon <nm@ti.com>
> >>> > Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
> >>> > ---
> >>> >=20
> >>>=20
> >>>=20
> >>> >  	dev->speed =3D speed;
> >>> >  	dev->idle =3D 1;
> >>> > @@ -911,6 +923,11 @@ omap_i2c_probe(struct=20
> platform_device *pdev)
> >>> >  		 */
> >>> >  		dev->fifo_size =3D (dev->fifo_size / 2);
> >>> >  		dev->b_hw =3D 1; /* Enable hardware fixes */
> >>> > +
> >>> > +		/* calculate wakeup latency constraint=20
> for MPU */
> >>> > +		if (dev->set_mpu_wkup_lat !=3D NULL)
> >>> > +			dev->latency =3D (1000000 *=20
> dev->fifo_size) /
> >>> > +				       (1000 * speed / 8);
> >>> >  	}
> >>>=20
> >>> IMHO, here instead of using 'dev->fifo_size' for calculating the=20
> >>> 'dev->latency', we need to use:
> >>>=20
> >>> 1. For RX case, to avoid Reciver overrun:
> >>> 	if (msg->flags & I2C_M_RD)
> >>> 		Use [(FIFO Depth)bytes - (FIFO THRSH)bytes] in
> >>calculating
> >>> 		dev->latency
> >>>=20
> >>> Because conceptually, RDR/RRDY interrupts are generated when
> >>RTRSH is
> >>> reached, so we want the MPU to be wake up within the time it
> >>takes to
> >>> fill the FIFO from RTRSH to FIFO Depth (FIFO full).
> >>>=20
> >>> 2. For TX case, to avoid Transmitter Underflow:
> >>> 	if (!(msg->flags & I2C_M_RD))
> >>> 		Use (FIFO THRSH)bytes in calculating dev->latency
> >>>=20
> >>> Because conceptually, XDR/XRDY interrupts are generated when
> >>XTRSH is
> >>> reached, so we want the MPU to be wake up within the time it
> >>takes to
> >>> drain the FIFO from XTRSH to Zero (FIFO empty).
> >>>=20
> >>> Using, dev->fifo_size instead, works in the present code=20
> because we=20
> >>> have a RTRSH/XTRSH =3D dev->fifo_size/2 =3D 4 bytes And=20
> therefore, (FIFO=20
> >>> Depth)bytes - (FIFO THRSH)bytes =3D 8 - 4 =3D 4 bytes
> >>>=20
> >>> But, to make it more generic in future and to make it=20
> independent of=20
> >>> any changes in the RTRSH/XTRSH values or FIFO depths in=20
> future, we=20
> >>> should use a generic code here.
> >>
> >>Well, I don't completely agree with the necessity of preparing for=20
> >>different rx/tx thresholds. For this to make sense, the i2c-omap=20
> >>driver should first separate in it's code the use of rx and tx=20
> >>thresholds. If someone is planning to do that, he/she should anyway=20
> >>update the usage of fifo_size throughout the code,=20
> including the wake=20
> >>up latency setting.
> >>
> >>Anyways, attached a patch that separates the mpu wake up=20
> latencies for=20
> >>rx and tx. In case that is needed. Though I'm not for it, since it=20
> >>adds unneeded complexity.
> >>
> >>- Kalle
> >>
> >>>=20
> >>> >=20
> >>> >  	/* reset ASAP, clearing any IRQs */ diff --git=20
> >>> > a/include/linux/i2c-omap.h b/include/linux/i2c-omap.h new
> >>file mode
> >>> > 100644 index 0000000..1362fba
> >>> > --- /dev/null
> >>> > +++ b/include/linux/i2c-omap.h
> >>> > @@ -0,0 +1,9 @@
> >>> > +#ifndef __I2C_OMAP_H__
> >>> > +#define __I2C_OMAP_H__
> >>> > +
> >>> > +struct omap_i2c_bus_platform_data {
> >>> > +	u32		clkrate;
> >>> > +	void		(*set_mpu_wkup_lat)(struct device *dev,=20
> >>int set);
> >>> > +};
> >>> > +
> >>> > +#endif
> >>> > --
> >>> > 1.5.4.3
> >>>=20
> >>> Regards
> >>> Moiz Sonasath
> >>>=20
> >>
> =

--_002_E839BB5467CE1640B3CC2F90F647A52C274A01E2D2NOKEUMSG02mgd_
Content-Type: application/octet-stream;
	name="0001-OMAP-I2C-Add-mpu-wake-up-latency-constraint-in-i2c.patch"
Content-Description: 0001-OMAP-I2C-Add-mpu-wake-up-latency-constraint-in-i2c.patch
Content-Disposition: attachment;
	filename="0001-OMAP-I2C-Add-mpu-wake-up-latency-constraint-in-i2c.patch";
	size=8549; creation-date="Mon, 23 Nov 2009 08:32:26 GMT";
	modification-date="Mon, 23 Nov 2009 08:32:26 GMT"
Content-Transfer-Encoding: base64

RnJvbSBlMjA3YjdjZGRmOWU4NzRhZGIxNTBmNTA2NTU3YWYyMDA2MzRhNjUwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogS2FsbGUgSm9raW5pZW1pIDxrYWxsZS5qb2tpbmllbWlAZGln
aWEuY29tPg0KRGF0ZTogVHVlLCAyNyBPY3QgMjAwOSAxMzo1OToxOSArMDIwMA0KU3ViamVjdDog
W1BBVENIXSBPTUFQOiBJMkM6IEFkZCBtcHUgd2FrZSB1cCBsYXRlbmN5IGNvbnN0cmFpbnQgaW4g
aTJjDQoNCldoaWxlIHdhaXRpbmcgZm9yIGNvbXBsZXRpb24gb2YgdGhlIGkyYyB0cmFuc2Zlciwg
dGhlDQpNUFUgY291bGQgaGl0IE9GRiBtb2RlIGFuZCBjYXVzZSBzZXZlcmFsIG1zZWNzIG9mDQpk
ZWxheSB0aGF0IG1hZGUgaTJjIHRyYW5zZmVycyBmYWlsIG1vcmUgb2Z0ZW4uIFRoZQ0KZXh0cmEg
ZGVsYXlzIGFuZCBzdWJzZXF1ZW50IHJlLXRyeXMgY2F1c2UgaTJjIGNsb2Nrcw0KdG8gYmUgYWN0
aXZlIG1vcmUgb2Z0ZW4uIFRoaXMgaGFzIGFsc28gYW4gbmVnYXRpdmUNCmVmZmVjdCBvbiBwb3dl
ciBjb25zdW1wdGlvbi4NCg0KQ3JlYXRlZCBhIG1lY2hhbmlzbSBmb3IgcGFzc2luZyBhbmQgdXNp
bmcgdGhlDQpjb25zdHJhaW50IHNldHRpbmcgZnVuY3Rpb24gaW4gZHJpdmVyIGNvZGUuIFRoZSB1
c2VkDQptcHUgd2FrZSB1cCBsYXRlbmN5IGNvbnN0cmFpbnRzIGFyZSBub3cgc2V0IGluZGl2aWR1
YWxseQ0KcGVyIGJ1cywgYW5kIHRoZXkgYXJlIGNhbGN1bGF0ZWQgYmFzZWQgb24gY2xvY2sgcmF0
ZQ0KYW5kIGZpZm8gc2l6ZSBmb3IgcnggYW5kIHR4IHRyYW5zZmVycy4NCg0KVGhhbmtzIHRvIEph
cmtrbyBOaWt1bGEsIE1vaXogU29uYXNhdGgsIFBhdWwgV2FsbXNsZXksDQphbmQgTmlzaGFudGgg
TWVub24gZm9yIHR1bmluZyBvdXQgdGhlIGRldGFpbHMgb2YNCnRoaXMgcGF0Y2guDQoNCkNjOiBN
b2l6IFNvbmFzYXRoIDxtLXNvbmFzYXRoQHRpLmNvbT4NCkNjOiBKYXJra28gTmlrdWxhIDxqaG5p
a3VsYUBnbWFpbC5jb20+DQpDYzogUGF1bCBXYWxtc2xleSA8cGF1bEBwd3Nhbi5jb20+DQpDYzog
TmlzaGFudGggTWVub24gPG5tQHRpLmNvbT4NClNpZ25lZC1vZmYtYnk6IEthbGxlIEpva2luaWVt
aSA8a2FsbGUuam9raW5pZW1pQGRpZ2lhLmNvbT4NCi0tLQ0KIGFyY2gvYXJtL3BsYXQtb21hcC9p
MmMuYyAgICAgIHwgICA1NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0t
DQogZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1vbWFwLmMgfCAgIDM4ICsrKysrKysrKysrKysrKysr
KysrKysrKy0tLS0NCiBpbmNsdWRlL2xpbnV4L2kyYy1vbWFwLmggICAgICB8ICAgIDkgKysrKysr
Kw0KIDMgZmlsZXMgY2hhbmdlZCwgODMgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pDQog
Y3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvbGludXgvaTJjLW9tYXAuaA0KDQpkaWZmIC0tZ2l0
IGEvYXJjaC9hcm0vcGxhdC1vbWFwL2kyYy5jIGIvYXJjaC9hcm0vcGxhdC1vbWFwL2kyYy5jDQpp
bmRleCA4Yjg0ODM5Li4zYzEyMmNkIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm0vcGxhdC1vbWFwL2ky
Yy5jDQorKysgYi9hcmNoL2FybS9wbGF0LW9tYXAvaTJjLmMNCkBAIC0yNiw4ICsyNiwxMCBAQA0K
ICNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4NCiAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2
aWNlLmg+DQogI2luY2x1ZGUgPGxpbnV4L2kyYy5oPg0KKyNpbmNsdWRlIDxsaW51eC9pMmMtb21h
cC5oPg0KICNpbmNsdWRlIDxtYWNoL2lycXMuaD4NCiAjaW5jbHVkZSA8bWFjaC9tdXguaD4NCisj
aW5jbHVkZSA8bWFjaC9vbWFwLXBtLmg+DQogDQogI2RlZmluZSBPTUFQX0kyQ19TSVpFCQkweDNm
DQogI2RlZmluZSBPTUFQMV9JMkNfQkFTRQkJMHhmZmZiMzgwMA0KQEAgLTY5LDE0ICs3MSwxNCBA
QCBzdGF0aWMgc3RydWN0IHJlc291cmNlIGkyY19yZXNvdXJjZXNbXVsyXSA9IHsNCiAJCX0sCQkJ
CQlcDQogCX0NCiANCi1zdGF0aWMgdTMyIGkyY19yYXRlW0FSUkFZX1NJWkUoaTJjX3Jlc291cmNl
cyldOw0KK3N0YXRpYyBzdHJ1Y3Qgb21hcF9pMmNfYnVzX3BsYXRmb3JtX2RhdGEgaTJjX3BkYXRh
W0FSUkFZX1NJWkUoaTJjX3Jlc291cmNlcyldOw0KIHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlIG9tYXBfaTJjX2RldmljZXNbXSA9IHsNCi0JSTJDX0RFVl9CVUlMREVSKDEsIGkyY19yZXNv
dXJjZXNbMF0sICZpMmNfcmF0ZVswXSksDQorCUkyQ19ERVZfQlVJTERFUigxLCBpMmNfcmVzb3Vy
Y2VzWzBdLCAmaTJjX3BkYXRhWzBdKSwNCiAjaWYJZGVmaW5lZChDT05GSUdfQVJDSF9PTUFQMjRY
WCkgfHwgZGVmaW5lZChDT05GSUdfQVJDSF9PTUFQMzRYWCkNCi0JSTJDX0RFVl9CVUlMREVSKDIs
IGkyY19yZXNvdXJjZXNbMV0sICZpMmNfcmF0ZVsxXSksDQorCUkyQ19ERVZfQlVJTERFUigyLCBp
MmNfcmVzb3VyY2VzWzFdLCAmaTJjX3BkYXRhWzFdKSwNCiAjZW5kaWYNCiAjaWYJZGVmaW5lZChD
T05GSUdfQVJDSF9PTUFQMzRYWCkNCi0JSTJDX0RFVl9CVUlMREVSKDMsIGkyY19yZXNvdXJjZXNb
Ml0sICZpMmNfcmF0ZVsyXSksDQorCUkyQ19ERVZfQlVJTERFUigzLCBpMmNfcmVzb3VyY2VzWzJd
LCAmaTJjX3BkYXRhWzJdKSwNCiAjZW5kaWYNCiB9Ow0KIA0KQEAgLTEwMCw2ICsxMDIsMzEgQEAg
c3RhdGljIGNvbnN0IGludCBvbWFwMzR4eF9waW5zW11bMl0gPSB7fTsNCiANCiAjZGVmaW5lIE9N
QVBfSTJDX0NNRExJTkVfU0VUVVAJKEJJVCgzMSkpDQogDQorI2lmZGVmIENPTkZJR19BUkNIX09N
QVAzNFhYDQorLyoNCisgKiBvbWFwX2kyY19zZXRfd2ZjX21wdV93a3VwX2xhdCAtIHNldHMgbXB1
IHdha2UgdXAgY29uc3RyYWludA0KKyAqIEBkZXY6CWkyYyBidXMgZGV2aWNlIHBvaW50ZXINCisg
KiBAdmFsOglsYXRlbmN5IGNvbnN0cmFpbnQgdG8gc2V0LCAtMSB0byBkaXNhYmxlIGNvbnN0cmFp
bnQNCisgKg0KKyAqIFdoZW4gd2FpdGluZyBmb3IgY29tcGxldGlvbiBvZiBhIGkyYyB0cmFuc2Zl
ciwgd2UgbmVlZCB0byBzZXQgYSB3YWtlIHVwDQorICogbGF0ZW5jeSBjb25zdHJhaW50IGZvciB0
aGUgTVBVLiBUaGlzIGlzIHRvIGVuc3VyZSBxdWljayBlbm91Z2ggd2FrZXVwIGZyb20NCisgKiBp
ZGxlLCB3aGVuIHRyYW5zZmVyIGNvbXBsZXRlcy4NCisgKi8NCitzdGF0aWMgdm9pZCBvbWFwX2ky
Y19zZXRfd2ZjX21wdV93a3VwX2xhdChzdHJ1Y3QgZGV2aWNlICpkZXYsIGludCB2YWwpDQorew0K
KwlvbWFwX3BtX3NldF9tYXhfbXB1X3dha2V1cF9sYXQoZGV2LCB2YWwpOw0KK30NCisjZW5kaWYN
CisNCitzdGF0aWMgdm9pZCBfX2luaXQgb21hcF9zZXRfaTJjX2NvbnN0cmFpbnRfZnVuYygNCisJ
CQkJc3RydWN0IG9tYXBfaTJjX2J1c19wbGF0Zm9ybV9kYXRhICpwZCkNCit7DQorCWlmIChjcHVf
aXNfb21hcDM0eHgoKSkNCisJCXBkLT5zZXRfbXB1X3drdXBfbGF0ID0gb21hcF9pMmNfc2V0X3dm
Y19tcHVfd2t1cF9sYXQ7DQorCWVsc2UNCisJCXBkLT5zZXRfbXB1X3drdXBfbGF0ID0gTlVMTDsN
Cit9DQorDQogc3RhdGljIHZvaWQgX19pbml0IG9tYXBfaTJjX211eF9waW5zKGludCBidXMpDQog
ew0KIAlpbnQgc2NsLCBzZGE7DQpAQCAtMTgwLDggKzIwNyw4IEBAIHN0YXRpYyBpbnQgX19pbml0
IG9tYXBfaTJjX2J1c19zZXR1cChjaGFyICpzdHIpDQogCWdldF9vcHRpb25zKHN0ciwgMywgaW50
cyk7DQogCWlmIChpbnRzWzBdIDwgMiB8fCBpbnRzWzFdIDwgMSB8fCBpbnRzWzFdID4gcG9ydHMp
DQogCQlyZXR1cm4gMDsNCi0JaTJjX3JhdGVbaW50c1sxXSAtIDFdID0gaW50c1syXTsNCi0JaTJj
X3JhdGVbaW50c1sxXSAtIDFdIHw9IE9NQVBfSTJDX0NNRExJTkVfU0VUVVA7DQorCWkyY19wZGF0
YVtpbnRzWzFdIC0gMV0uY2xrcmF0ZSA9IGludHNbMl07DQorCWkyY19wZGF0YVtpbnRzWzFdIC0g
MV0uY2xrcmF0ZSB8PSBPTUFQX0kyQ19DTURMSU5FX1NFVFVQOw0KIA0KIAlyZXR1cm4gMTsNCiB9
DQpAQCAtMTk1LDkgKzIyMiwxMCBAQCBzdGF0aWMgaW50IF9faW5pdCBvbWFwX3JlZ2lzdGVyX2ky
Y19idXNfY21kbGluZSh2b2lkKQ0KIHsNCiAJaW50IGksIGVyciA9IDA7DQogDQotCWZvciAoaSA9
IDA7IGkgPCBBUlJBWV9TSVpFKGkyY19yYXRlKTsgaSsrKQ0KLQkJaWYgKGkyY19yYXRlW2ldICYg
T01BUF9JMkNfQ01ETElORV9TRVRVUCkgew0KLQkJCWkyY19yYXRlW2ldICY9IH5PTUFQX0kyQ19D
TURMSU5FX1NFVFVQOw0KKwlmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShpMmNfcGRhdGEpOyBp
KyspDQorCQlpZiAoaTJjX3BkYXRhW2ldLmNsa3JhdGUgJiBPTUFQX0kyQ19DTURMSU5FX1NFVFVQ
KSB7DQorCQkJaTJjX3BkYXRhW2ldLmNsa3JhdGUgJj0gfk9NQVBfSTJDX0NNRExJTkVfU0VUVVA7
DQorCQkJb21hcF9zZXRfaTJjX2NvbnN0cmFpbnRfZnVuYygmaTJjX3BkYXRhW2ldKTsNCiAJCQll
cnIgPSBvbWFwX2kyY19hZGRfYnVzKGkgKyAxKTsNCiAJCQlpZiAoZXJyKQ0KIAkJCQlnb3RvIG91
dDsNCkBAIC0yMzEsOSArMjU5LDExIEBAIGludCBfX2luaXQgb21hcF9yZWdpc3Rlcl9pMmNfYnVz
KGludCBidXNfaWQsIHUzMiBjbGtyYXRlLA0KIAkJCXJldHVybiBlcnI7DQogCX0NCiANCi0JaWYg
KCFpMmNfcmF0ZVtidXNfaWQgLSAxXSkNCi0JCWkyY19yYXRlW2J1c19pZCAtIDFdID0gY2xrcmF0
ZTsNCi0JaTJjX3JhdGVbYnVzX2lkIC0gMV0gJj0gfk9NQVBfSTJDX0NNRExJTkVfU0VUVVA7DQor
CWlmICghaTJjX3BkYXRhW2J1c19pZCAtIDFdLmNsa3JhdGUpDQorCQlpMmNfcGRhdGFbYnVzX2lk
IC0gMV0uY2xrcmF0ZSA9IGNsa3JhdGU7DQorDQorCW9tYXBfc2V0X2kyY19jb25zdHJhaW50X2Z1
bmMoJmkyY19wZGF0YVtidXNfaWQgLSAxXSk7DQorCWkyY19wZGF0YVtidXNfaWQgLSAxXS5jbGty
YXRlICY9IH5PTUFQX0kyQ19DTURMSU5FX1NFVFVQOw0KIA0KIAlyZXR1cm4gb21hcF9pMmNfYWRk
X2J1cyhidXNfaWQpOw0KIH0NCmRpZmYgLS1naXQgYS9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLW9t
YXAuYyBiL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtb21hcC5jDQppbmRleCA3NWJmM2FkLi5lMTdj
MDc5IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1vbWFwLmMNCisrKyBiL2Ry
aXZlcnMvaTJjL2J1c3Nlcy9pMmMtb21hcC5jDQpAQCAtMzcsNiArMzcsNyBAQA0KICNpbmNsdWRl
IDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCiAjaW5jbHVkZSA8bGludXgvY2xrLmg+DQogI2lu
Y2x1ZGUgPGxpbnV4L2lvLmg+DQorI2luY2x1ZGUgPGxpbnV4L2kyYy1vbWFwLmg+DQogDQogLyog
STJDIGNvbnRyb2xsZXIgcmV2aXNpb25zICovDQogI2RlZmluZSBPTUFQX0kyQ19SRVZfMgkJCTB4
MjANCkBAIC0xNjUsNiArMTY2LDEwIEBAIHN0cnVjdCBvbWFwX2kyY19kZXYgew0KIAlzdHJ1Y3Qg
Y2xrCQkqZmNsazsJCS8qIEZ1bmN0aW9uYWwgY2xvY2sgKi8NCiAJc3RydWN0IGNvbXBsZXRpb24J
Y21kX2NvbXBsZXRlOw0KIAlzdHJ1Y3QgcmVzb3VyY2UJCSppb2FyZWE7DQorCXUzMgkJCXR4X2xh
dGVuY3k7CS8qIHR4IG1heCBtcHUgd2t1cCBsYXRlbmN5ICovDQorCXUzMgkJCXJ4X2xhdGVuY3k7
CS8qIHJ4IG1heCBtcHUgd2t1cCBsYXRlbmN5ICovDQorCXZvaWQJCQkoKnNldF9tcHVfd2t1cF9s
YXQpKHN0cnVjdCBkZXZpY2UgKmRldiwNCisJCQkJCQkgICAgaW50IGxhdGVuY3kpOw0KIAl1MzIJ
CQlzcGVlZDsJCS8qIFNwZWVkIG9mIGJ1cyBpbiBLaHogKi8NCiAJdTE2CQkJY21kX2VycjsNCiAJ
dTgJCQkqYnVmOw0KQEAgLTUyNiw4ICs1MzEsMTYgQEAgc3RhdGljIGludCBvbWFwX2kyY194ZmVy
X21zZyhzdHJ1Y3QgaTJjX2FkYXB0ZXIgKmFkYXAsDQogCSAqIFJFVklTSVQ6IFdlIHNob3VsZCBh
Ym9ydCB0aGUgdHJhbnNmZXIgb24gc2lnbmFscywgYnV0IHRoZSBidXMgZ29lcw0KIAkgKiBpbnRv
IGFyYml0cmF0aW9uIGFuZCB3ZSdyZSBjdXJyZW50bHkgdW5hYmxlIHRvIHJlY292ZXIgZnJvbSBp
dC4NCiAJICovDQorCWlmIChkZXYtPnNldF9tcHVfd2t1cF9sYXQgIT0gTlVMTCkgew0KKwkJaWYg
KG1zZy0+ZmxhZ3MgJiBJMkNfTV9SRCkNCisJCQlkZXYtPnNldF9tcHVfd2t1cF9sYXQoZGV2LT5k
ZXYsIGRldi0+cnhfbGF0ZW5jeSk7DQorCQllbHNlDQorCQkJZGV2LT5zZXRfbXB1X3drdXBfbGF0
KGRldi0+ZGV2LCBkZXYtPnR4X2xhdGVuY3kpOw0KKwl9DQogCXIgPSB3YWl0X2Zvcl9jb21wbGV0
aW9uX3RpbWVvdXQoJmRldi0+Y21kX2NvbXBsZXRlLA0KIAkJCQkJT01BUF9JMkNfVElNRU9VVCk7
DQorCWlmIChkZXYtPnNldF9tcHVfd2t1cF9sYXQgIT0gTlVMTCkNCisJCWRldi0+c2V0X21wdV93
a3VwX2xhdChkZXYtPmRldiwgLTEpOw0KIAlkZXYtPmJ1Zl9sZW4gPSAwOw0KIAlpZiAociA8IDAp
DQogCQlyZXR1cm4gcjsNCkBAIC04NDQsOSArODU3LDExIEBAIG9tYXBfaTJjX3Byb2JlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCXN0cnVjdCBvbWFwX2kyY19kZXYJKmRldjsNCiAJ
c3RydWN0IGkyY19hZGFwdGVyCSphZGFwOw0KIAlzdHJ1Y3QgcmVzb3VyY2UJCSptZW0sICppcnEs
ICppb2FyZWE7DQorCXN0cnVjdCBvbWFwX2kyY19idXNfcGxhdGZvcm1fZGF0YSAqcGRhdGEgPSBw
ZGV2LT5kZXYucGxhdGZvcm1fZGF0YTsNCiAJaXJxX2hhbmRsZXJfdCBpc3I7DQogCWludCByOw0K
IAl1MzIgc3BlZWQgPSAwOw0KKwl1MTYgZmlmb19mdWxsX3NpemU7DQogDQogCS8qIE5PVEU6IGRy
aXZlciB1c2VzIHRoZSBzdGF0aWMgcmVnaXN0ZXIgbWFwcGluZyAqLw0KIAltZW0gPSBwbGF0Zm9y
bV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOw0KQEAgLTg3MywxMCArODg4
LDEzIEBAIG9tYXBfaTJjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCQln
b3RvIGVycl9yZWxlYXNlX3JlZ2lvbjsNCiAJfQ0KIA0KLQlpZiAocGRldi0+ZGV2LnBsYXRmb3Jt
X2RhdGEgIT0gTlVMTCkNCi0JCXNwZWVkID0gKih1MzIgKilwZGV2LT5kZXYucGxhdGZvcm1fZGF0
YTsNCi0JZWxzZQ0KLQkJc3BlZWQgPSAxMDA7CS8qIERlZnVhbHQgc3BlZWQgKi8NCisJaWYgKHBk
YXRhICE9IE5VTEwpIHsNCisJCXNwZWVkID0gcGRhdGEtPmNsa3JhdGU7DQorCQlkZXYtPnNldF9t
cHVfd2t1cF9sYXQgPSBwZGF0YS0+c2V0X21wdV93a3VwX2xhdDsNCisJfSBlbHNlIHsNCisJCXNw
ZWVkID0gMTAwOwkvKiBEZWZhdWx0IHNwZWVkICovDQorCQlkZXYtPnNldF9tcHVfd2t1cF9sYXQg
PSBOVUxMOw0KKwl9DQogDQogCWRldi0+c3BlZWQgPSBzcGVlZDsNCiAJZGV2LT5pZGxlID0gMTsN
CkBAIC05MDIsMTcgKzkyMCwyNSBAQCBvbWFwX2kyY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KIA0KIAkJLyogU2V0IHVwIHRoZSBmaWZvIHNpemUgLSBHZXQgdG90YWwgc2l6
ZSAqLw0KIAkJcyA9IChvbWFwX2kyY19yZWFkX3JlZyhkZXYsIE9NQVBfSTJDX0JVRlNUQVRfUkVH
KSA+PiAxNCkgJiAweDM7DQotCQlkZXYtPmZpZm9fc2l6ZSA9IDB4OCA8PCBzOw0KKwkJZmlmb19m
dWxsX3NpemUgPSAweDggPDwgczsNCiANCiAJCS8qDQogCQkgKiBTZXQgdXAgbm90aWZpY2F0aW9u
IHRocmVzaG9sZCBhcyBoYWxmIHRoZSB0b3RhbCBhdmFpbGFibGUNCiAJCSAqIHNpemUuIFRoaXMg
aXMgdG8gZW5zdXJlIHRoYXQgd2UgY2FuIGhhbmRsZSB0aGUgc3RhdHVzIG9uIGludA0KIAkJICog
Y2FsbCBiYWNrIGxhdGVuY2llcy4NCiAJCSAqLw0KLQkJZGV2LT5maWZvX3NpemUgPSAoZGV2LT5m
aWZvX3NpemUgLyAyKTsNCisJCWRldi0+Zmlmb19zaXplID0gKGZpZm9fZnVsbF9zaXplIC8gMik7
DQogCQlkZXYtPmJfaHcgPSAxOyAvKiBFbmFibGUgaGFyZHdhcmUgZml4ZXMgKi8NCiAJfQ0KIA0K
KwkvKiBjYWxjdWxhdGUgcnggYW5kIHR4IHdha2V1cCBsYXRlbmN5IGNvbnN0cmFpbnRzIGZvciBN
UFUgKi8NCisJaWYgKGRldi0+c2V0X21wdV93a3VwX2xhdCAhPSBOVUxMKSB7DQorCQlkZXYtPnR4
X2xhdGVuY3kgPSAoZGV2LT5maWZvX3NpemUgKiAxMDAwMDAwKSAvDQorCQkJCSAgKDEwMDAgKiBk
ZXYtPnNwZWVkIC8gOCk7DQorCQlkZXYtPnJ4X2xhdGVuY3kgPSAoKGZpZm9fZnVsbF9zaXplIC0g
ZGV2LT5maWZvX3NpemUpICoNCisJCQkJICAxMDAwMDAwKSAvICgxMDAwICogZGV2LT5zcGVlZCAv
IDgpOw0KKwl9DQorDQogCS8qIHJlc2V0IEFTQVAsIGNsZWFyaW5nIGFueSBJUlFzICovDQogCW9t
YXBfaTJjX2luaXQoZGV2KTsNCiANCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2kyYy1vbWFw
LmggYi9pbmNsdWRlL2xpbnV4L2kyYy1vbWFwLmgNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRl
eCAwMDAwMDAwLi4xMzYyZmJhDQotLS0gL2Rldi9udWxsDQorKysgYi9pbmNsdWRlL2xpbnV4L2ky
Yy1vbWFwLmgNCkBAIC0wLDAgKzEsOSBAQA0KKyNpZm5kZWYgX19JMkNfT01BUF9IX18NCisjZGVm
aW5lIF9fSTJDX09NQVBfSF9fDQorDQorc3RydWN0IG9tYXBfaTJjX2J1c19wbGF0Zm9ybV9kYXRh
IHsNCisJdTMyCQljbGtyYXRlOw0KKwl2b2lkCQkoKnNldF9tcHVfd2t1cF9sYXQpKHN0cnVjdCBk
ZXZpY2UgKmRldiwgaW50IHNldCk7DQorfTsNCisNCisjZW5kaWYNCi0tIA0KMS41LjQuMw0KDQo=

--_002_E839BB5467CE1640B3CC2F90F647A52C274A01E2D2NOKEUMSG02mgd_--
