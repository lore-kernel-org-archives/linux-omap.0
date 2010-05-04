From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] OMAP: DSS2: GFX FIFO UNDERFLOW issue fixed
Date: Tue, 4 May 2010 18:53:10 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E3516FE@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
	 <1269263380-12995-1-git-send-email-hvaibhav@ti.com>
	 <1271410679.2690.290.camel@tubuntu.research.nokia.com>
	 <19F8576C6E063C45BE387C64729E7394044E1371C6@dbde02.ent.ti.com>
	 <19F8576C6E063C45BE387C64729E7394044E1EB360@dbde02.ent.ti.com>
 <1271848174.2433.49.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_19F8576C6E063C45BE387C64729E7394044E3516FEdbde02enttico_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38664 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753742Ab0EDNW4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 May 2010 09:22:56 -0400
In-Reply-To: <1271848174.2433.49.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--_002_19F8576C6E063C45BE387C64729E7394044E3516FEdbde02enttico_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: Wednesday, April 21, 2010 4:40 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org
> Subject: RE: [PATCH] OMAP: DSS2: GFX FIFO UNDERFLOW issue fixed
>=20
> On Wed, 2010-04-21 at 12:45 +0200, ext Hiremath, Vaibhav wrote:
> > > -----Original Message-----
> > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > > owner@vger.kernel.org] On Behalf Of Hiremath, Vaibhav
> > > Sent: Friday, April 16, 2010 4:28 PM
> > > To: Tomi Valkeinen
> > > Cc: linux-omap@vger.kernel.org
> > > Subject: RE: [PATCH] OMAP: DSS2: GFX FIFO UNDERFLOW issue fixed
> > >
> > >
> > > > -----Original Message-----
> > > > From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> > > > Sent: Friday, April 16, 2010 3:08 PM
> > > > To: Hiremath, Vaibhav
> > > > Cc: linux-omap@vger.kernel.org
> > > > Subject: Re: [PATCH] OMAP: DSS2: GFX FIFO UNDERFLOW issue fixed
> > > >
> > > > On Mon, 2010-03-22 at 14:09 +0100, ext hvaibhav@ti.com wrote:
> > > > > From: Vaibhav Hiremath <hvaibhav@ti.com>
> > > > >
> > > > > In case of 720P with 90/270 degree rotation, the system reports
> > > > > GFX_FIFO_UNDERFLOW error which usually happens if DSS DMA is not
> able to
> > > > fill
> > > > > the FIFO as per requirement.
> > > > >
> > > > > In TRM (section 11.2.6.1.3), where is has been clearly mentioned
> that,
> > > > >
> > > > > "To improve the performance on 90 degree rotation, split the data
> access
> > > > on
> > > > > write side and not read side."
> > > > >
> > > > > That means, read should always happen on 0 degree and write shoul=
d
> go to
> > > > > respective rotation view.
> > > > >
> > > >
> > > > With this patch my db test app (from
> > > > git://gitorious.org/linux-omap-dss2/omapfb-tests.git) shows a lot o=
f
> > > > tearing when rotation !=3D 0. I tested this on 3430SDP using the LC=
D.
> > [Hiremath, Vaibhav] Tomi,
> >
> > Yes, just now I tried your db application and I am also seeing tearing
> effect. All other apps (including the one which I used for testing) works
> fine for other rotation angles.
> >
> > Let me debug further before commenting anything on this, I just thought=
 of
> updating you on this.
>=20
> "db" app uses double buffering for updating the display, with maximum
> update rate. There's also "pan" app, that does a bit similar thing using
> fb offsets.
[Hiremath, Vaibhav] Tomi,

I found the bug which is causing tearing effect, I tested it here with both=
, mine and your applications and for me it is working fine.

Can you please check at your end?
(Sorry for the attachment)

Thanks,
Vaibhav

>=20
> What kind of test apps you have?
>=20
>  Tomi
>=20


--_002_19F8576C6E063C45BE387C64729E7394044E3516FEdbde02enttico_
Content-Type: application/octet-stream;
	name="0001-OMAP-DSS2-GFX-FIFO-UNDERFLOW-issue-fixed.patch"
Content-Description: 0001-OMAP-DSS2-GFX-FIFO-UNDERFLOW-issue-fixed.patch
Content-Disposition: attachment;
	filename="0001-OMAP-DSS2-GFX-FIFO-UNDERFLOW-issue-fixed.patch"; size=6503;
	creation-date="Tue, 04 May 2010 18:52:27 GMT";
	modification-date="Tue, 04 May 2010 18:52:27 GMT"
Content-Transfer-Encoding: base64

RnJvbSAxOTk3NTU1YWI1YmYyYzhjOGY4OGI3NTA0N2JmNjY2MDA0YTZjODZhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBWYWliaGF2IEhpcmVtYXRoIDxodmFpYmhhdkB0aS5jb20+CkRh
dGU6IE1vbiwgMjIgTWFyIDIwMTAgMTM6MzU6MTggKzA1MzAKU3ViamVjdDogW1BBVENIXSBPTUFQ
OiBEU1MyOiBHRlggRklGTyBVTkRFUkZMT1cgaXNzdWUgZml4ZWQKCkluIGNhc2Ugb2YgNzIwUCB3
aXRoIDkwLzI3MCBkZWdyZWUgcm90YXRpb24sIHRoZSBzeXN0ZW0gcmVwb3J0cwpHRlhfRklGT19V
TkRFUkZMT1cgZXJyb3Igd2hpY2ggdXN1YWxseSBoYXBwZW5zIGlmIERTUyBETUEgaXMgbm90IGFi
bGUgdG8gZmlsbAp0aGUgRklGTyBhcyBwZXIgcmVxdWlyZW1lbnQuCgpJbiBUUk0gKHNlY3Rpb24g
MTEuMi42LjEuMyksIHdoZXJlIGlzIGhhcyBiZWVuIGNsZWFybHkgbWVudGlvbmVkIHRoYXQsCgoi
VG8gaW1wcm92ZSB0aGUgcGVyZm9ybWFuY2Ugb24gOTAgZGVncmVlIHJvdGF0aW9uLCBzcGxpdCB0
aGUgZGF0YSBhY2Nlc3Mgb24Kd3JpdGUgc2lkZSBhbmQgbm90IHJlYWQgc2lkZS4iCgpUaGF0IG1l
YW5zLCByZWFkIHNob3VsZCBhbHdheXMgaGFwcGVuIG9uIDAgZGVncmVlIGFuZCB3cml0ZSBzaG91
bGQgZ28gdG8KcmVzcGVjdGl2ZSByb3RhdGlvbiB2aWV3LgoKU2lnbmVkLW9mZi1ieTogVmFpYmhh
diBIaXJlbWF0aCA8aHZhaWJoYXZAdGkuY29tPgotLS0KIGRyaXZlcnMvdmlkZW8vb21hcDIvb21h
cGZiL29tYXBmYi1tYWluLmMgfCAgIDgzICsrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLQog
MSBmaWxlcyBjaGFuZ2VkLCA1NSBpbnNlcnRpb25zKCspLCAyOCBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL3ZpZGVvL29tYXAyL29tYXBmYi9vbWFwZmItbWFpbi5jIGIvZHJpdmVy
cy92aWRlby9vbWFwMi9vbWFwZmIvb21hcGZiLW1haW4uYwppbmRleCA0YjQ1MDZkLi45YmZkZDFl
IDEwMDY0NAotLS0gYS9kcml2ZXJzL3ZpZGVvL29tYXAyL29tYXBmYi9vbWFwZmItbWFpbi5jCisr
KyBiL2RyaXZlcnMvdmlkZW8vb21hcDIvb21hcGZiL29tYXBmYi1tYWluLmMKQEAgLTE4NSw2ICsx
ODUsMTEgQEAgc3RhdGljIHVuc2lnbmVkIG9tYXBmYl9nZXRfdnJmYl9vZmZzZXQoY29uc3Qgc3Ry
dWN0IG9tYXBmYl9pbmZvICpvZmJpLCBpbnQgcm90KQogc3RhdGljIHUzMiBvbWFwZmJfZ2V0X3Jl
Z2lvbl9yb3RfcGFkZHIoY29uc3Qgc3RydWN0IG9tYXBmYl9pbmZvICpvZmJpLCBpbnQgcm90KQog
ewogCWlmIChvZmJpLT5yb3RhdGlvbl90eXBlID09IE9NQVBfRFNTX1JPVF9WUkZCKSB7CisJCWlm
IChyb3QgPT0gRkJfUk9UQVRFX0NXKQorCQkJcm90ID0gRkJfUk9UQVRFX0NDVzsKKwkJZWxzZSBp
ZiAocm90ID09IEZCX1JPVEFURV9DQ1cpCisJCQlyb3QgPSBGQl9ST1RBVEVfQ1c7CisKIAkJcmV0
dXJuIG9mYmktPnJlZ2lvbi52cmZiLnBhZGRyW3JvdF0KIAkJCSsgb21hcGZiX2dldF92cmZiX29m
ZnNldChvZmJpLCByb3QpOwogCX0gZWxzZSB7CkBAIC0xOTIsMjAgKzE5NywzMiBAQCBzdGF0aWMg
dTMyIG9tYXBmYl9nZXRfcmVnaW9uX3JvdF9wYWRkcihjb25zdCBzdHJ1Y3Qgb21hcGZiX2luZm8g
Km9mYmksIGludCByb3QpCiAJfQogfQogCi1zdGF0aWMgdTMyIG9tYXBmYl9nZXRfcmVnaW9uX3Bh
ZGRyKGNvbnN0IHN0cnVjdCBvbWFwZmJfaW5mbyAqb2ZiaSkKK3N0YXRpYyB1MzIgb21hcGZiX2dl
dF9yZWdpb25fcGFkZHIoc3RydWN0IG9tYXBmYl9pbmZvICpvZmJpLCBpbnQgcm90KQogewotCWlm
IChvZmJpLT5yb3RhdGlvbl90eXBlID09IE9NQVBfRFNTX1JPVF9WUkZCKQotCQlyZXR1cm4gb2Zi
aS0+cmVnaW9uLnZyZmIucGFkZHJbMF07Ci0JZWxzZQorCWlmIChvZmJpLT5yb3RhdGlvbl90eXBl
ID09IE9NQVBfRFNTX1JPVF9WUkZCKSB7CisJCWlmIChyb3QgPT0gRkJfUk9UQVRFX0NXKQorCQkJ
cm90ID0gRkJfUk9UQVRFX0NDVzsKKwkJZWxzZSBpZiAocm90ID09IEZCX1JPVEFURV9DQ1cpCisJ
CQlyb3QgPSBGQl9ST1RBVEVfQ1c7CisKKwkJcmV0dXJuIG9mYmktPnJlZ2lvbi52cmZiLnBhZGRy
W3JvdF07CisJfSBlbHNlIHsKIAkJcmV0dXJuIG9mYmktPnJlZ2lvbi5wYWRkcjsKKwl9CiB9CiAK
LXN0YXRpYyB2b2lkIF9faW9tZW0gKm9tYXBmYl9nZXRfcmVnaW9uX3ZhZGRyKGNvbnN0IHN0cnVj
dCBvbWFwZmJfaW5mbyAqb2ZiaSkKK3N0YXRpYyB2b2lkIF9faW9tZW0gKm9tYXBmYl9nZXRfcmVn
aW9uX3ZhZGRyKHN0cnVjdCBvbWFwZmJfaW5mbyAqb2ZiaSwgaW50IHJvdCkKIHsKLQlpZiAob2Zi
aS0+cm90YXRpb25fdHlwZSA9PSBPTUFQX0RTU19ST1RfVlJGQikKLQkJcmV0dXJuIG9mYmktPnJl
Z2lvbi52cmZiLnZhZGRyWzBdOwotCWVsc2UKKwlpZiAob2ZiaS0+cm90YXRpb25fdHlwZSA9PSBP
TUFQX0RTU19ST1RfVlJGQikgeworCQlpZiAocm90ID09IEZCX1JPVEFURV9DVykKKwkJCXJvdCA9
IEZCX1JPVEFURV9DQ1c7CisJCWVsc2UgaWYgKHJvdCA9PSBGQl9ST1RBVEVfQ0NXKQorCQkJcm90
ID0gRkJfUk9UQVRFX0NXOworCisJCXJldHVybiBvZmJpLT5yZWdpb24udnJmYi52YWRkcltyb3Rd
OworCX0gZWxzZSB7CiAJCXJldHVybiBvZmJpLT5yZWdpb24udmFkZHI7CisJfQogfQogCiBzdGF0
aWMgc3RydWN0IG9tYXBmYl9jb2xvcm1vZGUgb21hcGZiX2NvbG9ybW9kZXNbXSA9IHsKQEAgLTUw
NCw3ICs1MjEsNyBAQCBzdGF0aWMgaW50IHNldHVwX3ZyZmJfcm90YXRpb24oc3RydWN0IGZiX2lu
Zm8gKmZiaSkKIAl1bnNpZ25lZCBieXRlc3BwOwogCWJvb2wgeXV2X21vZGU7CiAJZW51bSBvbWFw
X2NvbG9yX21vZGUgbW9kZTsKLQlpbnQgcjsKKwlpbnQgciwgcm90YXRpb24gPSB2YXItPnJvdGF0
ZTsKIAlib29sIHJlY29uZjsKIAogCWlmICghcmctPnNpemUgfHwgb2ZiaS0+cm90YXRpb25fdHlw
ZSAhPSBPTUFQX0RTU19ST1RfVlJGQikKQEAgLTUxMiw2ICs1MjksMTEgQEAgc3RhdGljIGludCBz
ZXR1cF92cmZiX3JvdGF0aW9uKHN0cnVjdCBmYl9pbmZvICpmYmkpCiAKIAlEQkcoInNldHVwX3Zy
ZmJfcm90YXRpb25cbiIpOwogCisJaWYgKHJvdGF0aW9uID09IEZCX1JPVEFURV9DVykKKwkJcm90
YXRpb24gPSBGQl9ST1RBVEVfQ0NXOworCWVsc2UgaWYgKHJvdGF0aW9uID09IEZCX1JPVEFURV9D
Q1cpCisJCXJvdGF0aW9uID0gRkJfUk9UQVRFX0NXOworCiAJciA9IGZiX21vZGVfdG9fZHNzX21v
ZGUodmFyLCAmbW9kZSk7CiAJaWYgKHIpCiAJCXJldHVybiByOwpAQCAtNTM1LDMyICs1NTcsMzUg
QEAgc3RhdGljIGludCBzZXR1cF92cmZiX3JvdGF0aW9uKHN0cnVjdCBmYl9pbmZvICpmYmkpCiAJ
CQl2cmZiLT55cmVzICE9IHZhci0+eXJlc192aXJ0dWFsKQogCQlyZWNvbmYgPSB0cnVlOwogCi0J
aWYgKHZyZmItPnZhZGRyWzBdICYmIHJlY29uZikgeworCWlmICh2cmZiLT52YWRkcltyb3RhdGlv
bl0gJiYgcmVjb25mKSB7CiAJCWZiaS0+c2NyZWVuX2Jhc2UgPSBOVUxMOwogCQlmaXgtPnNtZW1f
c3RhcnQgPSAwOwogCQlmaXgtPnNtZW1fbGVuID0gMDsKLQkJaW91bm1hcCh2cmZiLT52YWRkclsw
XSk7Ci0JCXZyZmItPnZhZGRyWzBdID0gTlVMTDsKKwkJaW91bm1hcCh2cmZiLT52YWRkcltyb3Rh
dGlvbl0pOworCQl2cmZiLT52YWRkcltyb3RhdGlvbl0gPSBOVUxMOwogCQlEQkcoInNldHVwX3Zy
ZmJfcm90YXRpb246IHJlc2V0IGZiXG4iKTsKIAl9CiAKLQlpZiAodnJmYi0+dmFkZHJbMF0pCisJ
aWYgKHZyZmItPnZhZGRyW3JvdGF0aW9uXSkKIAkJcmV0dXJuIDA7CiAKLQlvbWFwX3ZyZmJfc2V0
dXAoJnJnLT52cmZiLCByZy0+cGFkZHIsCi0JCQl2YXItPnhyZXNfdmlydHVhbCwKLQkJCXZhci0+
eXJlc192aXJ0dWFsLAotCQkJYnl0ZXNwcCwgeXV2X21vZGUpOworCWlmIChyb3RhdGlvbiA9PSBG
Ql9ST1RBVEVfQ1cgfHwgcm90YXRpb24gPT0gRkJfUk9UQVRFX0NDVykKKwkJb21hcF92cmZiX3Nl
dHVwKCZyZy0+dnJmYiwgcmctPnBhZGRyLAorCQkJCXZhci0+eXJlc192aXJ0dWFsLCB2YXItPnhy
ZXNfdmlydHVhbCwKKwkJCQlieXRlc3BwLCB5dXZfbW9kZSk7CisJZWxzZQorCQlvbWFwX3ZyZmJf
c2V0dXAoJnJnLT52cmZiLCByZy0+cGFkZHIsCisJCQkJdmFyLT54cmVzX3ZpcnR1YWwsIHZhci0+
eXJlc192aXJ0dWFsLAorCQkJCWJ5dGVzcHAsIHl1dl9tb2RlKTsKIAotCS8qIE5vdyBvbmUgY2Fu
IGlvcmVtYXAgdGhlIDAgYW5nbGUgdmlldyAqLwotCXIgPSBvbWFwX3ZyZmJfbWFwX2FuZ2xlKHZy
ZmIsIHZhci0+eXJlc192aXJ0dWFsLCAwKTsKKwkvKiBOb3cgb25lIGNhbiBpb3JlbWFwIHRoZSBy
b3RhdGlvbiBhbmdsZSB2aWV3ICovCisJciA9IG9tYXBfdnJmYl9tYXBfYW5nbGUodnJmYiwgdmFy
LT55cmVzX3ZpcnR1YWwsIHJvdGF0aW9uKTsKIAlpZiAocikKIAkJcmV0dXJuIHI7Ci0KIAkvKiB1
c2VkIGJ5IG9wZW4vd3JpdGUgaW4gZmJtZW0uYyAqLwotCWZiaS0+c2NyZWVuX2Jhc2UgPSBvZmJp
LT5yZWdpb24udnJmYi52YWRkclswXTsKKwlmYmktPnNjcmVlbl9iYXNlID0gb2ZiaS0+cmVnaW9u
LnZyZmIudmFkZHJbcm90YXRpb25dOwogCi0JZml4LT5zbWVtX3N0YXJ0ID0gb2ZiaS0+cmVnaW9u
LnZyZmIucGFkZHJbMF07CisJZml4LT5zbWVtX3N0YXJ0ID0gb2ZiaS0+cmVnaW9uLnZyZmIucGFk
ZHJbcm90YXRpb25dOwogCiAJc3dpdGNoICh2YXItPm5vbnN0ZCkgewogCWNhc2UgT01BUEZCX0NP
TE9SX1lVVjQyMjoKQEAgLTYwNCw3ICs2MjksOCBAQCB2b2lkIHNldF9mYl9maXgoc3RydWN0IGZi
X2luZm8gKmZiaSkKIAlEQkcoInNldF9mYl9maXhcbiIpOwogCiAJLyogdXNlZCBieSBvcGVuL3dy
aXRlIGluIGZibWVtLmMgKi8KLQlmYmktPnNjcmVlbl9iYXNlID0gKGNoYXIgX19pb21lbSAqKW9t
YXBmYl9nZXRfcmVnaW9uX3ZhZGRyKG9mYmkpOworCWZiaS0+c2NyZWVuX2Jhc2UgPSAoY2hhciBf
X2lvbWVtICopb21hcGZiX2dldF9yZWdpb25fdmFkZHIob2ZiaSwKKwkJCXZhci0+cm90YXRlKTsK
IAogCS8qIHVzZWQgYnkgbW1hcCBpbiBmYm1lbS5jICovCiAJaWYgKG9mYmktPnJvdGF0aW9uX3R5
cGUgPT0gT01BUF9EU1NfUk9UX1ZSRkIpIHsKQEAgLTYyNyw3ICs2NTMsNyBAQCB2b2lkIHNldF9m
Yl9maXgoc3RydWN0IGZiX2luZm8gKmZiaSkKIAkJZml4LT5zbWVtX2xlbiA9IHJnLT5zaXplOwog
CX0KIAotCWZpeC0+c21lbV9zdGFydCA9IG9tYXBmYl9nZXRfcmVnaW9uX3BhZGRyKG9mYmkpOwor
CWZpeC0+c21lbV9zdGFydCA9IG9tYXBmYl9nZXRfcmVnaW9uX3BhZGRyKG9mYmksIHZhci0+cm90
YXRlKTsKIAogCWZpeC0+dHlwZSA9IEZCX1RZUEVfUEFDS0VEX1BJWEVMUzsKIApAQCAtODYzLDEx
ICs4ODksMTEgQEAgc3RhdGljIGludCBvbWFwZmJfc2V0dXBfb3ZlcmxheShzdHJ1Y3QgZmJfaW5m
byAqZmJpLCBzdHJ1Y3Qgb21hcF9vdmVybGF5ICpvdmwsCiAKIAogCWlmIChvZmJpLT5yb3RhdGlv
bl90eXBlID09IE9NQVBfRFNTX1JPVF9WUkZCKSB7Ci0JCWRhdGFfc3RhcnRfcCA9IG9tYXBmYl9n
ZXRfcmVnaW9uX3JvdF9wYWRkcihvZmJpLCByb3RhdGlvbik7CisJCWRhdGFfc3RhcnRfcCA9IG9t
YXBmYl9nZXRfcmVnaW9uX3JvdF9wYWRkcihvZmJpLCAwKTsKIAkJZGF0YV9zdGFydF92ID0gTlVM
TDsKIAl9IGVsc2UgewotCQlkYXRhX3N0YXJ0X3AgPSBvbWFwZmJfZ2V0X3JlZ2lvbl9wYWRkcihv
ZmJpKTsKLQkJZGF0YV9zdGFydF92ID0gb21hcGZiX2dldF9yZWdpb25fdmFkZHIob2ZiaSk7CisJ
CWRhdGFfc3RhcnRfcCA9IG9tYXBmYl9nZXRfcmVnaW9uX3BhZGRyKG9mYmksIDApOworCQlkYXRh
X3N0YXJ0X3YgPSBvbWFwZmJfZ2V0X3JlZ2lvbl92YWRkcihvZmJpLCAwKTsKIAl9CiAKIAlpZiAo
b2ZiaS0+cm90YXRpb25fdHlwZSA9PSBPTUFQX0RTU19ST1RfVlJGQikKQEAgLTEwNzksNiArMTEw
NSw3IEBAIHN0YXRpYyBzdHJ1Y3Qgdm1fb3BlcmF0aW9uc19zdHJ1Y3QgbW1hcF91c2VyX29wcyA9
IHsKIHN0YXRpYyBpbnQgb21hcGZiX21tYXAoc3RydWN0IGZiX2luZm8gKmZiaSwgc3RydWN0IHZt
X2FyZWFfc3RydWN0ICp2bWEpCiB7CiAJc3RydWN0IG9tYXBmYl9pbmZvICpvZmJpID0gRkIyT0ZC
KGZiaSk7CisJc3RydWN0IGZiX3Zhcl9zY3JlZW5pbmZvICp2YXIgPSAmZmJpLT52YXI7CiAJc3Ry
dWN0IGZiX2ZpeF9zY3JlZW5pbmZvICpmaXggPSAmZmJpLT5maXg7CiAJdW5zaWduZWQgbG9uZyBv
ZmY7CiAJdW5zaWduZWQgbG9uZyBzdGFydDsKQEAgLTEwOTAsNyArMTExNyw3IEBAIHN0YXRpYyBp
bnQgb21hcGZiX21tYXAoc3RydWN0IGZiX2luZm8gKmZiaSwgc3RydWN0IHZtX2FyZWFfc3RydWN0
ICp2bWEpCiAJCXJldHVybiAtRUlOVkFMOwogCW9mZiA9IHZtYS0+dm1fcGdvZmYgPDwgUEFHRV9T
SElGVDsKIAotCXN0YXJ0ID0gb21hcGZiX2dldF9yZWdpb25fcGFkZHIob2ZiaSk7CisJc3RhcnQg
PSBvbWFwZmJfZ2V0X3JlZ2lvbl9wYWRkcihvZmJpLCB2YXItPnJvdGF0ZSk7CiAJbGVuID0gZml4
LT5zbWVtX2xlbjsKIAlpZiAob2ZmID49IGxlbikKIAkJcmV0dXJuIC1FSU5WQUw7Ci0tIAoxLjYu
Mi40Cgo=

--_002_19F8576C6E063C45BE387C64729E7394044E3516FEdbde02enttico_--
