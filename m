From: "Wang Sawsd-A24013" <cqwang@motorola.com>
Subject: RE: [PATCH] OMAP2/3 Avoid GPIO pending irq status been set after irq_disable
Date: Wed, 3 Jun 2009 01:18:15 +0800
Message-ID: <B00E06E2766C2744B022DE9BAF3C59D532D5DE@zmy16exm69.ds.mot.com>
References: <87y6sak6wn.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C9E3A6.27C907F6"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail153.messagelabs.com ([216.82.253.51]:57038 "EHLO
	mail153.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754556AbZFBRS5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jun 2009 13:18:57 -0400
Received: from il27exr03.cig.mot.com (il27exr03.mot.com [10.17.196.72])
	by motgate2.mot.com (8.14.3/8.14.3) with ESMTP id n52HIv2J003964
	for <linux-omap@vger.kernel.org>; Tue, 2 Jun 2009 10:18:57 -0700 (MST)
Received: from il27vts02.mot.com (il27vts02.cig.mot.com [10.17.196.86])
	by il27exr03.cig.mot.com (8.13.1/Vontu) with SMTP id n52HIvDS024101
	for <linux-omap@vger.kernel.org>; Tue, 2 Jun 2009 12:18:57 -0500 (CDT)
Received: from zmy16exm69.ds.mot.com (zmy16exm69.ap.mot.com [10.179.4.36])
	by il27exr03.cig.mot.com (8.13.1/8.13.0) with ESMTP id n52HItqx024071
	for <linux-omap@vger.kernel.org>; Tue, 2 Jun 2009 12:18:56 -0500 (CDT)
Content-class: urn:content-classes:message
In-Reply-To: <87y6sak6wn.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com, Mike Chan <mikechan@google.com>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9E3A6.27C907F6
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


> "Wang Sawsd-A24013" <cqwang@motorola.com> writes:
>=20
> > Resend because of the content format issues in last mail---sorry for
> > inconvenience.
>=20
> This version is line-wrapped and otherwise confusing as well so does
> not apply cleanly.  Could you try using 'git format-patch' to generate
> your patch?  It looks like you may have used 'git diff' and then
> appended them together?
>=20

I did use git-format-patch command, seems the issue is caused=20
our mail server, this time I attached the whole patch in the mail,
and I didn't separate the change into sub-patchs, see explanation below.

> In addition, the many uses of "also" in this description suggest that
> that it could be broken up in to several patches with more clear
> descriptions/justifications..  Some are fixes, some are new
> functionality.

Yes, "also" is abused in my description, too spoken. :-)=20
But the whole change is actually for the same issue which is=20
OMAP GPIO IRQ/WAKEUP issue and I think they are all fixes
but not new functionality.

>=20
> > This patch adds irq_enable and irq_disable for OMAP GPIO IRQ chip,=20
>=20
> Please elaborate on why you chose to implement the enable/disable
> hooks instead of using the mask/unmask hooks.
>=20
1: irq mask/unmask are typically used by the IRQ handling framework
or CHIP IRQ handler to disable and enable IRQ during the IRQ handing
procedure; While still many drivers are using irq_disable and
irq_disable
in their code especially in the case of suspend/resume and IOCTL to turn
on/off the peripherals, without the irq_disable in IRQ CHIP, the
default_disable
Is used but it is just an empty function now. This will cause an issue
that
The IRQ may still happen after irq_disable which may cause unexpected=20
behavior in driver since they are not expecting any IRQ after
irq_disable.

2: I noticed that we have the mask and unmask already, but why I didn't
choose to use them directly for irq_disable and irq_enable is because
we need something special in irq_disable for OMAP.=20

Since irq_disable typically means the driver wants to deactive the
peripherals
for a long period of time and may allow System going into low power
state,=20
but for OMAP GPIO the IRQ status bit may still be set even when IRQEN
bit is cleared, that's why we need also clear the level detect and edge
detect
Configuration register to ensure after irq_disable, no IRQ status bit is
set,
since once the IRQ status bit is set while IRQ is disabled, then this
will
prevent GPIO module acknowledge IDLE request from PRCM, so PER=20
and CORE will fail entering RET state. We are facing this issue now,
that is why I made this patch.


> > and also only enable WAKEUPEN When GPIO edge detection is enabled,
>=20
> Can you send this fixa separate patch.  It is a bug fix that is
> separate from the new stuff you're adding here.
>=20
This issue is also related with the OMAP GPIO IRQ wakeup configuration
So it is not a separate issue. But I can send it as separate patch if
the community
Think the rest of this patch is not applicable.

> > also clear the gpio event triggering configurations to avoid Pending
> > interrupt status which is generated regardless of the IRQEN and
> > WKUPEN bit, the pending IRQ status may prevent GPIO module
> > acknowledge IDLE request and prevent PER and thus CORE RETENTION.
>=20
> Have you tested the PM branch code?
>=20
Yes, I have verified the patch on the kernel which is based on google
omap
GIT which is based on linux-omap PM branch, and it does resolve the
issue.
The issue I am facing is the Touch controller on my HW will continously
report
Input interrupts fastly, so without the patch, the IRQ staus will be
pending there
Even after the touch driver calls irq_disable and prevents PER and CORE
going into RETENTION In suspend mode.

> I'm not sure I quite follow your description here, but IIUC, we are
> already doing this in the [prepare|resume]_idle() hooks.
>=20
The code in GPIO prepare/resume for idle functions are made to address
another different issue for OMAP2, since on OMAP2 there are some silicon
bugs
that causes some GPIO to be non-wakeupable, so the workaround was made
to
not enable edge detection for those GPIOs and manually trigger IRQs
using level
detect based on input GPIO levels after idle. But for OMAP3, there is no
non-wakeup
gpio, all the GPIOs are wakeup gpios.

This patch is needed for both OMAP2 and OMAP3 since the GPIO module has
The similar silicon architecture, that is IRQ status will be set
regardless of IRQEN bit.

> Kevin
> > To unsubscribe from this list: send the line "unsubscribe=20
> linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

------_=_NextPart_001_01C9E3A6.27C907F6
Content-Type: application/octet-stream;
	name="0001-Fix-OMAP2-3-GPIO-pending-irq-status-blocking-RETENTI.patch"
Content-Transfer-Encoding: base64
Content-Description: 0001-Fix-OMAP2-3-GPIO-pending-irq-status-blocking-RETENTI.patch
Content-Disposition: attachment;
	filename="0001-Fix-OMAP2-3-GPIO-pending-irq-status-blocking-RETENTI.patch"

RnJvbSA2ZDc2ZmU3ZDliN2MwMmQ3ZjQ3MmU2ZWRhZmZmNTJlZTU0OWI3NDE5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDaHVucWl1IFdhbmcgPGNxd2FuZ0Btb3Rvcm9sYS5jb20+CkRh
dGU6IFNhdCwgMzAgTWF5IDIwMDkgMDc6Mzg6NDAgKzA4MDAKU3ViamVjdDogW1BBVENIXSBGaXgg
T01BUDIvMyBHUElPIHBlbmRpbmcgaXJxIHN0YXR1cyBibG9ja2luZyBSRVRFTlRJT04gaXNzdWUK
CgpTaWduZWQtb2ZmLWJ5OiBDaHVucWl1IFdhbmcgPGNxd2FuZ0Btb3Rvcm9sYS5jb20+Ci0tLQog
YXJjaC9hcm0vcGxhdC1vbWFwL2dwaW8uYyB8ICAgNDQgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLS0KIDEgZmlsZXMgY2hhbmdlZCwgNDIgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9wbGF0LW9tYXAvZ3Bpby5jIGIv
YXJjaC9hcm0vcGxhdC1vbWFwL2dwaW8uYwppbmRleCBiZDA0YjQwLi4xOWUwNDYxIDEwMDY0NAot
LS0gYS9hcmNoL2FybS9wbGF0LW9tYXAvZ3Bpby5jCisrKyBiL2FyY2gvYXJtL3BsYXQtb21hcC9n
cGlvLmMKQEAgLTU4MSw3ICs1ODEsNyBAQCB2b2lkIG9tYXBfc2V0X2dwaW9fZGVib3VuY2VfdGlt
ZShpbnQgZ3BpbywgaW50IGVuY190aW1lKQogRVhQT1JUX1NZTUJPTChvbWFwX3NldF9ncGlvX2Rl
Ym91bmNlX3RpbWUpOwogCiAjaWYgZGVmaW5lZChDT05GSUdfQVJDSF9PTUFQMjRYWCkgfHwgZGVm
aW5lZChDT05GSUdfQVJDSF9PTUFQMzRYWCkKLXN0YXRpYyBpbmxpbmUgdm9pZCBzZXRfMjR4eF9n
cGlvX3RyaWdnZXJpbmcoc3RydWN0IGdwaW9fYmFuayAqYmFuaywgaW50IGdwaW8sCitzdGF0aWMg
dm9pZCBzZXRfMjR4eF9ncGlvX3RyaWdnZXJpbmcoc3RydWN0IGdwaW9fYmFuayAqYmFuaywgaW50
IGdwaW8sCiAJCQkJCQlpbnQgdHJpZ2dlcikKIHsKIAl2b2lkIF9faW9tZW0gKmJhc2UgPSBiYW5r
LT5iYXNlOwpAQCAtNTk3LDcgKzU5NywxMiBAQCBzdGF0aWMgaW5saW5lIHZvaWQgc2V0XzI0eHhf
Z3Bpb190cmlnZ2VyaW5nKHN0cnVjdCBncGlvX2JhbmsgKmJhbmssIGludCBncGlvLAogCQl0cmln
Z2VyICYgSVJRX1RZUEVfRURHRV9GQUxMSU5HKTsKIAogCWlmIChsaWtlbHkoIShiYW5rLT5ub25f
d2FrZXVwX2dwaW9zICYgZ3Bpb19iaXQpKSkgewotCQlpZiAodHJpZ2dlciAhPSAwKQorCQkvKgor
CQkgKiBHUElPIHdha2V1cCByZXF1ZXN0IGNhbiBvbmx5IGJlIGdlbmVyYXRlZCBvbiBlZGdlCisJ
CSAqIHRyYW5zaXRpb25zLCBzZWUgT01BUDM0eHhfRVMzLjFfVFJNX1ZfUSBHMjUuNS4zLjEKKwkJ
ICogd2FrZS11cCByZXF1ZXN0IG5vdGUgZm9yIGRldGFpbAorCQkgKi8KKwkJaWYgKCh0cmlnZ2Vy
ICYgSVJRX1RZUEVfRURHRV9CT1RIKSAhPSAwKQogCQkJX19yYXdfd3JpdGVsKDEgPDwgZ3Bpbywg
YmFuay0+YmFzZQogCQkJCQkrIE9NQVAyNFhYX0dQSU9fU0VUV0tVRU5BKTsKIAkJZWxzZQpAQCAt
MTEzMyw2ICsxMTM4LDM5IEBAIHN0YXRpYyB2b2lkIGdwaW9fYWNrX2lycSh1bnNpZ25lZCBpbnQg
aXJxKQogCV9jbGVhcl9ncGlvX2lycXN0YXR1cyhiYW5rLCBncGlvKTsKIH0KIAorc3RhdGljIHZv
aWQgZ3Bpb19lbmFibGVfaXJxKHVuc2lnbmVkIGludCBpcnEpCit7CisJdW5zaWduZWQgaW50IGdw
aW8gPSBpcnEgLSBJSF9HUElPX0JBU0U7CisJc3RydWN0IGdwaW9fYmFuayAqYmFuayA9IGdldF9p
cnFfY2hpcF9kYXRhKGlycSk7CisJaW50IHRyaWdnZXIgPSBpcnFfZGVzY1tpcnFdLnN0YXR1cyAm
IElSUV9UWVBFX1NFTlNFX01BU0s7CisKKyNpZiBkZWZpbmVkKENPTkZJR19BUkNIX09NQVAyNFhY
KSB8fCBkZWZpbmVkKENPTkZJR19BUkNIX09NQVAzNFhYKQorCXNldF8yNHh4X2dwaW9fdHJpZ2dl
cmluZyhiYW5rLCBnZXRfZ3Bpb19pbmRleChncGlvKSwgdHJpZ2dlcik7CisjZW5kaWYKKwlfc2V0
X2dwaW9faXJxZW5hYmxlKGJhbmssIGdwaW8sIDEpOworfQorCitzdGF0aWMgdm9pZCBncGlvX2Rp
c2FibGVfaXJxKHVuc2lnbmVkIGludCBpcnEpCit7CisJdW5zaWduZWQgaW50IGdwaW8gPSBpcnEg
LSBJSF9HUElPX0JBU0U7CisJc3RydWN0IGdwaW9fYmFuayAqYmFuayA9IGdldF9pcnFfY2hpcF9k
YXRhKGlycSk7CisKKwlfc2V0X2dwaW9faXJxZW5hYmxlKGJhbmssIGdwaW8sIDApOworI2lmIGRl
ZmluZWQoQ09ORklHX0FSQ0hfT01BUDI0WFgpIHx8IGRlZmluZWQoQ09ORklHX0FSQ0hfT01BUDM0
WFgpCisJLyoKKwkgKiBDbGVhciB0aGUgZXZlbnQgZGV0ZWN0IHNldHRpbmcgYW5kIElSUSBzdGF0
dXMgdG8gcHJldmVudAorCSAqIElSUSBzdGF1cyBiZWVuIHNldCBvciBwZW5kaW5nIHRoZXJlIFdo
aWxlIElSUSBpcyBkaXNhYmxlZCwKKwkgKiBvdGhlcndpc2UgR1BJTyBtb2R1bGUgd2lsbCBub3Qg
YWNrbm93bGVkZ2UgdGhlIElETEUgcmVxdWVzdAorCSAqIGZyb20gUEVSIHBvd2VyIGRvbWFpbiwg
dGhpcyBtYXkgcHJldmVudCBTeXN0ZW0gd2lkZSByZXRlbnRpb24KKwkgKiBTZWUgT01BUDM0eHhf
RVMzLjFfVFJNX1ZfUSBHMjUuNS4zLjEgR1BJTyBpbnRlcnJ1cHQgYW5kIHdha2V1cAorCSAqIGVu
YWJsZSBub3RlIGZvciBkZXRhaWwKKwkgKi8KKwlzZXRfMjR4eF9ncGlvX3RyaWdnZXJpbmcoYmFu
aywgZ2V0X2dwaW9faW5kZXgoZ3BpbyksIElSUV9UWVBFX05PTkUpOworCV9jbGVhcl9ncGlvX2ly
cXN0YXR1cyhiYW5rLCBncGlvKTsKKyNlbmRpZgorCit9CisKIHN0YXRpYyB2b2lkIGdwaW9fbWFz
a19pcnEodW5zaWduZWQgaW50IGlycSkKIHsKIAl1bnNpZ25lZCBpbnQgZ3BpbyA9IGlycSAtIElI
X0dQSU9fQkFTRTsKQEAgLTExNjAsNiArMTE5OCw4IEBAIHN0YXRpYyB2b2lkIGdwaW9fdW5tYXNr
X2lycSh1bnNpZ25lZCBpbnQgaXJxKQogc3RhdGljIHN0cnVjdCBpcnFfY2hpcCBncGlvX2lycV9j
aGlwID0gewogCS5uYW1lCQk9ICJHUElPIiwKIAkuc2h1dGRvd24JPSBncGlvX2lycV9zaHV0ZG93
biwKKwkuZW5hYmxlCQk9IGdwaW9fZW5hYmxlX2lycSwKKwkuZGlzYWJsZQk9IGdwaW9fZGlzYWJs
ZV9pcnEsCiAJLmFjawkJPSBncGlvX2Fja19pcnEsCiAJLm1hc2sJCT0gZ3Bpb19tYXNrX2lycSwK
IAkudW5tYXNrCQk9IGdwaW9fdW5tYXNrX2lycSwKLS0gCjEuNS40LjMKCg==

------_=_NextPart_001_01C9E3A6.27C907F6--
