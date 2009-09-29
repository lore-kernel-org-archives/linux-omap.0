From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: linux-omap git tree updated to v2.6.32-rc1, important changes,
 	please read
Date: Tue, 29 Sep 2009 14:26:21 -0500
Message-ID: <A24693684029E5489D1D202277BE89444B781B7C@dlee02.ent.ti.com>
References: <20090928190404.GE18957@atomide.com>
	 <94a0d4530909291024kcac6b20m727b2908b2a76b88@mail.gmail.com>
	 <20090929182639.GA16865@atomide.com>,<71a0d6ff0909291220ve586b41s7c75ff580f34cb95@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_A24693684029E5489D1D202277BE89444B781B7Cdlee02entticom_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33553 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753899AbZI2Taa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Sep 2009 15:30:30 -0400
In-Reply-To: <71a0d6ff0909291220ve586b41s7c75ff580f34cb95@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alexander Shishkin <virtuoso@slind.org>, Tony Lindgren <tony@atomide.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--_002_A24693684029E5489D1D202277BE89444B781B7Cdlee02entticom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

From: linux-omap-owner@vger.kernel.org [linux-omap-owner@vger.kernel.org] O=
n Behalf Of Alexander Shishkin [virtuoso@slind.org]
Sent: Tuesday, September 29, 2009 2:20 PM
> 2009/9/29 Tony Lindgren <tony@atomide.com>:
> > * Felipe Contreras <felipe.contreras@gmail.com> [090929 10:24]:
> >> On Mon, Sep 28, 2009 at 10:04 PM, Tony Lindgren <tony@atomide.com> wro=
te:
> >> > Hi all,
> >> >
> >> > I've updated our linux-omap tree to v2.6.32-rc1. I've also
> >> > added a branch omap-2.6.31 for the old code.
> >> >
> >> > This time I also nuked the remaining omap legacy code we
> >> > still had lurking around :) The commits at the end of this
> >> > mail describe what I did first as commits, then I merged
> >> > everything to be the same as the mainline v2.6.32-rc1.
> >> >
> >> > So currently the linux-omap master branch is:
> >> >
> >> > v2.6.32-rc1 + omap-fixes + ehci + cbus
> >> >
> >> > The new model is that I'll be resetting the linux-omap master
> >> > branch to mainline at each -rc, then merge in our various
> >> > upstream queues back in again.
> >>
> >> Excellent! I was wondering why this wasn't being done. I certainly
> >> hope linus' 2.6.32 will work on omap right away.
> >
> > Yeah, let's hope Tomi gets in the DSS2 code too.
> >
> >> Anyway, I haven't been able to make 2.6.31 boot on beagleboard, and
> >> other people report similar issues:
> >> http://www.spinics.net/lists/linux-omap/msg17968.html
> >>
> >> Have you got 2.6.32-rc1 (+fixes) to boot?
> >
> > Hmm, looks like it's musb again. This is what I get on my
> > overo after applying the DEBUG_LL hack from omap-debug branch:
> >
> > <3>musb_hdrc musb_hdrc: musb_init_controller failed with status -19
> > <1>Unable to handle kernel NULL pointer dereference at virtual address =
00000000
> > <1>pgd =3D c0004000
> > <1>[00000000] *pgd=3D00000000
> > Internal error: Oops: 5 [#1]
> > <d>Modules linked in:
> > CPU: 0    Not tainted  (2.6.32-rc2-05967-gd350540-dirty #892)
> > PC is at musb_free+0x68/0xb8
> > LR is at musb_free+0x34/0xb8

<snip>

> >
> > After disabling musb, it boots further but can't mount root on the MMC:
> >
> > ...
> > <4>regulator_init_complete: incomplete constraints, leaving VUSB1V8 on
> > regulator_init_complete: incomplete constraints, leaving VUSB1V8 on
> > <4>regulator_init_complete: incomplete constraints, leaving VUSB1V5 on
> > regulator_init_complete: incomplete constraints, leaving VUSB1V5 on
> > <4>regulator_init_complete: incomplete constraints, leaving VMMC1 on
> > regulator_init_complete: incomplete constraints, leaving VMMC1 on
> > <6>twl4030_rtc twl4030_rtc: setting system clock to 2000-01-01 00:00:00=
 UTC (94)
> > twl4030_rtc twl4030_rtc: setting system clock to 2000-01-01 00:00:00 UT=
C (94668)
> > <6>Waiting for root device /dev/mmcblk0p2...
> > Waiting for root device /dev/mmcblk0p2...
> >
> > What are you getting with DEBUG_LL enabled and the associated patch app=
lied
> > from omap-debug branch?
> MUSB enabled gives me the same backtrace. When I disable it, I get
> (this is beagle B6):
>=20
> <1>Unable to handle kernel NULL pointer dereference at virtual address 00=
000000
> <1>pgd =3D c0004000
> <1>[00000000] *pgd=3D00000000

<snip>

Hi,

Can you please try attached patch?

Regards,
Sergio=

--_002_A24693684029E5489D1D202277BE89444B781B7Cdlee02entticom_
Content-Type: text/x-patch;
	name="0001-omapfb-Condition-mutex-acquisition.patch"
Content-Description: 0001-omapfb-Condition-mutex-acquisition.patch
Content-Disposition: attachment;
	filename="0001-omapfb-Condition-mutex-acquisition.patch"; size=2493;
	creation-date="Tue, 29 Sep 2009 14:30:23 GMT";
	modification-date="Tue, 29 Sep 2009 14:30:23 GMT"
Content-Transfer-Encoding: base64

RnJvbSBiYmEyZDg5ZWE0NWVjMDM1OWRlYzZmZTIxYzE3NTZhZDM0MDZlMzQ3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTZXJnaW8gQWd1aXJyZSA8c2FhZ3VpcnJlQHRpLmNvbT4KRGF0
ZTogVHVlLCAyOSBTZXAgMjAwOSAwNzo0NDoxOSAtMDUwMApTdWJqZWN0OiBbUEFUQ0hdIG9tYXBm
YjogQ29uZGl0aW9uIG11dGV4IGFjcXVpc2l0aW9uCgpBY3F1aXJpbmcgbXV0ZXggYmVmb3JlIGZy
YW1lYnVmZmVyIHJlZ2lzdHJhdGlvbiBkb2Vzbid0IG1ha2Ugc2Vuc2UsCkFzIHRoZXJlJ3Mgbm8g
ZGFuZ2VyIG9mIGV4dGVybmFsIGFjY2VzcyB0byB0aGUgbWVtb3J5IHJlbGF0ZWQgZmllbGRzLgoK
Tk9URTogUExFQVNFIFJFVklFVyEgSSdNIE5PVCBBTiBFWFBFUlQgT04gVEhJUy4KClNpZ25lZC1v
ZmYtYnk6IFNlcmdpbyBBZ3VpcnJlIDxzYWFndWlycmVAdGkuY29tPgotLS0KIGRyaXZlcnMvdmlk
ZW8vb21hcC9vbWFwZmJfbWFpbi5jIHwgICAyMiArKysrKysrKysrKysrKy0tLS0tLS0tCiAxIGZp
bGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy92aWRlby9vbWFwL29tYXBmYl9tYWluLmMgYi9kcml2ZXJzL3ZpZGVvL29tYXAv
b21hcGZiX21haW4uYwppbmRleCAxMjVlNjA1Li4wZDBjOGM4IDEwMDY0NAotLS0gYS9kcml2ZXJz
L3ZpZGVvL29tYXAvb21hcGZiX21haW4uYworKysgYi9kcml2ZXJzL3ZpZGVvL29tYXAvb21hcGZi
X21haW4uYwpAQCAtMzkzLDcgKzM5Myw3IEBAIHN0YXRpYyB2b2lkIG9tYXBmYl9zeW5jKHN0cnVj
dCBmYl9pbmZvICpmYmkpCiAgKiBTZXQgZmJfaW5mby5maXggZmllbGRzIGFuZCBhbHNvIHVwZGF0
ZXMgZmJkZXYuCiAgKiBXaGVuIGNhbGxpbmcgdGhpcyBmYl9pbmZvLnZhciBtdXN0IGJlIHNldCB1
cCBhbHJlYWR5LgogICovCi1zdGF0aWMgdm9pZCBzZXRfZmJfZml4KHN0cnVjdCBmYl9pbmZvICpm
YmkpCitzdGF0aWMgdm9pZCBzZXRfZmJfZml4KHN0cnVjdCBmYl9pbmZvICpmYmksIGludCBmcm9t
X2luaXQpCiB7CiAJc3RydWN0IGZiX2ZpeF9zY3JlZW5pbmZvICpmaXggPSAmZmJpLT5maXg7CiAJ
c3RydWN0IGZiX3Zhcl9zY3JlZW5pbmZvICp2YXIgPSAmZmJpLT52YXI7CkBAIC00MDMsMTAgKzQw
MywxNiBAQCBzdGF0aWMgdm9pZCBzZXRfZmJfZml4KHN0cnVjdCBmYl9pbmZvICpmYmkpCiAKIAly
ZyA9ICZwbGFuZS0+ZmJkZXYtPm1lbV9kZXNjLnJlZ2lvbltwbGFuZS0+aWR4XTsKIAlmYmktPnNj
cmVlbl9iYXNlCT0gcmctPnZhZGRyOwotCW11dGV4X2xvY2soJmZiaS0+bW1fbG9jayk7Ci0JZml4
LT5zbWVtX3N0YXJ0CQk9IHJnLT5wYWRkcjsKLQlmaXgtPnNtZW1fbGVuCQk9IHJnLT5zaXplOwot
CW11dGV4X3VubG9jaygmZmJpLT5tbV9sb2NrKTsKKworCWlmICghZnJvbV9pbml0KSB7CisJCW11
dGV4X2xvY2soJmZiaS0+bW1fbG9jayk7CisJCWZpeC0+c21lbV9zdGFydAkJPSByZy0+cGFkZHI7
CisJCWZpeC0+c21lbV9sZW4JCT0gcmctPnNpemU7CisJCW11dGV4X3VubG9jaygmZmJpLT5tbV9s
b2NrKTsKKwl9IGVsc2UgeworCQlmaXgtPnNtZW1fc3RhcnQJCT0gcmctPnBhZGRyOworCQlmaXgt
PnNtZW1fbGVuCQk9IHJnLT5zaXplOworCX0KIAogCWZpeC0+dHlwZSA9IEZCX1RZUEVfUEFDS0VE
X1BJWEVMUzsKIAlicHAgPSB2YXItPmJpdHNfcGVyX3BpeGVsOwpAQCAtNzA0LDcgKzcxMCw3IEBA
IHN0YXRpYyBpbnQgb21hcGZiX3NldF9wYXIoc3RydWN0IGZiX2luZm8gKmZiaSkKIAlpbnQgciA9
IDA7CiAKIAlvbWFwZmJfcnF1ZXVlX2xvY2soZmJkZXYpOwotCXNldF9mYl9maXgoZmJpKTsKKwlz
ZXRfZmJfZml4KGZiaSwgMCk7CiAJciA9IGN0cmxfY2hhbmdlX21vZGUoZmJpKTsKIAlvbWFwZmJf
cnF1ZXVlX3VubG9jayhmYmRldik7CiAKQEAgLTkwNCw3ICs5MTAsNyBAQCBzdGF0aWMgaW50IG9t
YXBmYl9zZXR1cF9tZW0oc3RydWN0IGZiX2luZm8gKmZiaSwgc3RydWN0IG9tYXBmYl9tZW1faW5m
byAqbWkpCiAJCWlmIChvbGRfc2l6ZSAhPSBzaXplKSB7CiAJCQlpZiAoc2l6ZSkgewogCQkJCW1l
bWNweSgmZmJpLT52YXIsIG5ld192YXIsIHNpemVvZihmYmktPnZhcikpOwotCQkJCXNldF9mYl9m
aXgoZmJpKTsKKwkJCQlzZXRfZmJfZml4KGZiaSwgMCk7CiAJCQl9IGVsc2UgewogCQkJCS8qCiAJ
CQkJICogU2V0IHRoZXNlIGV4cGxpY2l0bHkgdG8gaW5kaWNhdGUgdGhhdCB0aGUKQEAgLTE1MDQs
NyArMTUxMCw3IEBAIHN0YXRpYyBpbnQgZmJpbmZvX2luaXQoc3RydWN0IG9tYXBmYl9kZXZpY2Ug
KmZiZGV2LCBzdHJ1Y3QgZmJfaW5mbyAqaW5mbykKIAl2YXItPmJpdHNfcGVyX3BpeGVsID0gZmJk
ZXYtPnBhbmVsLT5icHA7CiAKIAlzZXRfZmJfdmFyKGluZm8sIHZhcik7Ci0Jc2V0X2ZiX2ZpeChp
bmZvKTsKKwlzZXRfZmJfZml4KGluZm8sIDEpOwogCiAJciA9IGZiX2FsbG9jX2NtYXAoJmluZm8t
PmNtYXAsIDE2LCAwKTsKIAlpZiAociAhPSAwKQotLSAKMS42LjAuNAoK

--_002_A24693684029E5489D1D202277BE89444B781B7Cdlee02entticom_--
