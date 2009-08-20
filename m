From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: OMAPFB: LL pointer dereference because of uninitialized mutex
Date: Thu, 20 Aug 2009 16:20:22 -0500
Message-ID: <A24693684029E5489D1D202277BE89444BA0DC30@dlee02.ent.ti.com>
References: <f67028d40908180632l26e62512n8e342629faeda36d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_A24693684029E5489D1D202277BE89444BA0DC30dlee02entticom_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53330 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752204AbZHTVQL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Aug 2009 17:16:11 -0400
In-Reply-To: <f67028d40908180632l26e62512n8e342629faeda36d@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "frederik@kriewitz.eu" <frederik@kriewitz.eu>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--_002_A24693684029E5489D1D202277BE89444BA0DC30dlee02entticom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Frederik Kriewitz
> Sent: Tuesday, August 18, 2009 8:32 AM
> To: linux-omap@vger.kernel.org
> Subject: OMAPFB: LL pointer dereference because of uninitialized mutex
>=20
> Hello,

Hi,

>=20
> I'm trying to add support for a omap3 board.
>=20
> But I get a NULL pointer dereference during initialization of the lcd
> panel driver because framebufferInfo->mm_lock wasn't initialized.
>=20
> Code of the lcd driver: http://pastebin.com/m44ccc56d (nothing special)
>=20
> Stack trace:
> __mutex_lock_slowpath()
> mutex_lock()
> set_fb_fix()
> omapfb_do_probe()
> devkit8000_panel_probe() << my probe function
> platform_drv_probe()
> ...
>=20
> It get's initialized in register_framebuffer() but in my case the
> probe function gets called before register_framebuffer().
>=20
> Once I added the missing inits to framebuffer_alloc()
> (drivers/video/fbsysfs.c) it works fine:
> mutex_init(&info->lock);
> mutex_init(&info->mm_lock);
>=20
> How I'm intended to fix this?

Can you try attached patch, and let me know if worked for you?

Regards,
Sergio
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--_002_A24693684029E5489D1D202277BE89444BA0DC30dlee02entticom_
Content-Type: application/octet-stream;
	name="0001-omapfb-Reorder-Register_framebuffer-call.patch"
Content-Description: 0001-omapfb-Reorder-Register_framebuffer-call.patch
Content-Disposition: attachment;
	filename="0001-omapfb-Reorder-Register_framebuffer-call.patch"; size=1681;
	creation-date="Thu, 20 Aug 2009 15:08:11 GMT";
	modification-date="Thu, 20 Aug 2009 15:08:11 GMT"
Content-Transfer-Encoding: base64

RnJvbSBiZjY4MTM0YzBkMTNjOWRmNjE4ZDllZjRkM2U5ZDA2NTU4NWYzZDE1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTZXJnaW8gQWd1aXJyZSA8c2FhZ3VpcnJlQHRpLmNvbT4KRGF0
ZTogVGh1LCAyMCBBdWcgMjAwOSAxNDo1ODoyMiAtMDUwMApTdWJqZWN0OiBbUEFUQ0hdIG9tYXBm
YjogUmVvcmRlciBSZWdpc3Rlcl9mcmFtZWJ1ZmZlciBjYWxsCgpUaGlzIGZpeGVzIHRoZSBpc3N1
ZSBpbiB3aGljaCBtbV9sb2NrIG11dGV4IHdhcyBhdHRlbXB0ZWQgdG8gYmUKdXNlZCB3aXRob3V0
IGluaXRpYWxpemluZyBwcmV2aW91c2x5LgoKU2lnbmVkLW9mZi1ieTogU2VyZ2lvIEFndWlycmUg
PHNhYWd1aXJyZUB0aS5jb20+Ci0tLQogZHJpdmVycy92aWRlby9vbWFwL29tYXBmYl9tYWluLmMg
fCAgIDIwICsrKysrKysrKysrLS0tLS0tLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlv
bnMoKyksIDkgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy92aWRlby9vbWFwL29t
YXBmYl9tYWluLmMgYi9kcml2ZXJzL3ZpZGVvL29tYXAvb21hcGZiX21haW4uYwppbmRleCAxMjVl
NjA1Li42MGY5NDgyIDEwMDY0NAotLS0gYS9kcml2ZXJzL3ZpZGVvL29tYXAvb21hcGZiX21haW4u
YworKysgYi9kcml2ZXJzL3ZpZGVvL29tYXAvb21hcGZiX21haW4uYwpAQCAtMTUwMywxMiArMTUw
MywyMSBAQCBzdGF0aWMgaW50IGZiaW5mb19pbml0KHN0cnVjdCBvbWFwZmJfZGV2aWNlICpmYmRl
diwgc3RydWN0IGZiX2luZm8gKmluZm8pCiAJdmFyLT5yb3RhdGUJICA9IGRlZl9yb3RhdGU7CiAJ
dmFyLT5iaXRzX3Blcl9waXhlbCA9IGZiZGV2LT5wYW5lbC0+YnBwOwogCisJciA9IHJlZ2lzdGVy
X2ZyYW1lYnVmZmVyKGluZm8pOworCWlmIChyICE9IDApIHsKKwkJZGV2X2VycihmYmRldi0+ZGV2
LAorCQkJInJlZ2lzdGVyaW5nIGZyYW1lYnVmZmVyIGZhaWxlZFxuIik7CisJCXJldHVybiByOwor
CX0KKwogCXNldF9mYl92YXIoaW5mbywgdmFyKTsKIAlzZXRfZmJfZml4KGluZm8pOwogCiAJciA9
IGZiX2FsbG9jX2NtYXAoJmluZm8tPmNtYXAsIDE2LCAwKTsKLQlpZiAociAhPSAwKQorCWlmIChy
ICE9IDApIHsKIAkJZGV2X2VycihmYmRldi0+ZGV2LCAidW5hYmxlIHRvIGFsbG9jYXRlIGNvbG9y
IG1hcCBtZW1vcnlcbiIpOworCQl1bnJlZ2lzdGVyX2ZyYW1lYnVmZmVyKGluZm8pOworCX0KIAog
CXJldHVybiByOwogfQpAQCAtMTc3MywxNSArMTc4Miw4IEBAIHN0YXRpYyBpbnQgb21hcGZiX2Rv
X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsCiAJaW5pdF9zdGF0ZSsrOwogCiAJ
dnJhbSA9IDA7Ci0JZm9yIChpID0gMDsgaSA8IGZiZGV2LT5tZW1fZGVzYy5yZWdpb25fY250OyBp
KyspIHsKLQkJciA9IHJlZ2lzdGVyX2ZyYW1lYnVmZmVyKGZiZGV2LT5mYl9pbmZvW2ldKTsKLQkJ
aWYgKHIgIT0gMCkgewotCQkJZGV2X2VycihmYmRldi0+ZGV2LAotCQkJCSJyZWdpc3RlcmluZyBm
cmFtZWJ1ZmZlciAlZCBmYWlsZWRcbiIsIGkpOwotCQkJZ290byBjbGVhbnVwOwotCQl9CisJZm9y
IChpID0gMDsgaSA8IGZiZGV2LT5tZW1fZGVzYy5yZWdpb25fY250OyBpKyspCiAJCXZyYW0gKz0g
ZmJkZXYtPm1lbV9kZXNjLnJlZ2lvbltpXS5zaXplOwotCX0KIAogCWZiZGV2LT5zdGF0ZSA9IE9N
QVBGQl9BQ1RJVkU7CiAKLS0gCjEuNi4zLjIKCg==

--_002_A24693684029E5489D1D202277BE89444BA0DC30dlee02entticom_--
