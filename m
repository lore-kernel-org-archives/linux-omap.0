From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [Resending - PATCH 1/3] Triton BCI driver board/device setup for
 OMAP3430
Date: Tue, 22 Jul 2008 07:33:47 -0500
Message-ID: <1473aac0380c8c62329714e83f6ca795@felipebalbi.com>
References: <38309.192.168.10.89.1216727733.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=_7931f54ef0f2347fc04af427305e5d27"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:36355 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724AbYGVMdy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jul 2008 08:33:54 -0400
In-Reply-To: <38309.192.168.10.89.1216727733.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap@vger.kernel.org, Mikko.K.Ylinen@nokia.com

--=_7931f54ef0f2347fc04af427305e5d27
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi,


On Tue, 22 Jul 2008 17:25:33 +0530 (IST), "Madhusudhan Chikkature"
<madhu.cr@ti.com> wrote:
>  extern void sdp3430_usb_init(void);

Tony, weird that we still have these prototypes in these headers.
Could be some merging conflict ?

Anyways, please apply the attached patch. We're using
usb_musb_init() and usb_ehci_init() now.



-- 
Best Regards,

Felipe Balbi
http://blog.felipebalbi.com
me@felipebalbi.com
--=_7931f54ef0f2347fc04af427305e5d27
Content-Transfer-Encoding: base64
Content-Type: text/x-diff; name="0001-arch-omap-remove-unused-prototypes.diff"; charset="UTF-8"
Content-Disposition: attachment; filename="0001-arch-omap-remove-unused-prototypes.diff"

RnJvbSBjZjk2YmQwMzcyMjc5NzlhNDQ4ZTAzNzc5ZWM0NGQwYzMxYzFmYTI5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBGZWxpcGUgQmFsYmkgPGZlbGlwZS5iYWxiaUBub2tpYS5jb20+
CkRhdGU6IFR1ZSwgMjIgSnVsIDIwMDggMTU6MDc6MDggKzAzMDAKU3ViamVjdDogW1BBVENIXSBh
cmNoOiBvbWFwOiByZW1vdmUgdW51c2VkIHByb3RvdHlwZXMKCldlIGRvbid0IGhhdmUgdGhvc2Ug
ZnVuY3Rpb25zIGFueW1vcmUuIFByb2JhYmx5IHNvbWUKbWVyZ2UgY29uZmxpY3QgcHV0IHRoZSBw
cm90b3R5cGVzIGJhY2suCgpSZW1vdmluZyB0aGVtLgoKU2lnbmVkLW9mZi1ieTogRmVsaXBlIEJh
bGJpIDxmZWxpcGUuYmFsYmlAbm9raWEuY29tPgotLS0KIGluY2x1ZGUvYXNtLWFybS9hcmNoLW9t
YXAvYm9hcmQtMjQzMHNkcC5oIHwgICAgMSAtCiBpbmNsdWRlL2FzbS1hcm0vYXJjaC1vbWFwL2Jv
YXJkLTM0MzBzZHAuaCB8ICAgIDEgLQogMiBmaWxlcyBjaGFuZ2VkLCAwIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9hc20tYXJtL2FyY2gtb21hcC9i
b2FyZC0yNDMwc2RwLmggYi9pbmNsdWRlL2FzbS1hcm0vYXJjaC1vbWFwL2JvYXJkLTI0MzBzZHAu
aAppbmRleCBmZGU2OTE1Li44M2QwZWVjIDEwMDY0NAotLS0gYS9pbmNsdWRlL2FzbS1hcm0vYXJj
aC1vbWFwL2JvYXJkLTI0MzBzZHAuaAorKysgYi9pbmNsdWRlL2FzbS1hcm0vYXJjaC1vbWFwL2Jv
YXJkLTI0MzBzZHAuaApAQCAtMzYsNiArMzYsNSBAQAogCiAvKiBGdW5jdGlvbiBwcm90b3R5cGVz
ICovCiBleHRlcm4gdm9pZCBzZHAyNDMwX2ZsYXNoX2luaXQodm9pZCk7Ci1leHRlcm4gdm9pZCBz
ZHAyNDMwX3VzYl9pbml0KHZvaWQpOwogCiAjZW5kaWYgLyogX19BU01fQVJDSF9PTUFQXzI0MzBT
RFBfSCAqLwpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9hc20tYXJtL2FyY2gtb21hcC9ib2FyZC0zNDMw
c2RwLmggYi9pbmNsdWRlL2FzbS1hcm0vYXJjaC1vbWFwL2JvYXJkLTM0MzBzZHAuaAppbmRleCBk
NTgzMDA4Li44NWY3NjllIDEwMDY0NAotLS0gYS9pbmNsdWRlL2FzbS1hcm0vYXJjaC1vbWFwL2Jv
YXJkLTM0MzBzZHAuaAorKysgYi9pbmNsdWRlL2FzbS1hcm0vYXJjaC1vbWFwL2JvYXJkLTM0MzBz
ZHAuaApAQCAtMjksNyArMjksNiBAQAogI2lmbmRlZiBfX0FTTV9BUkNIX09NQVBfMzQzMFNEUF9I
CiAjZGVmaW5lIF9fQVNNX0FSQ0hfT01BUF8zNDMwU0RQX0gKIAotZXh0ZXJuIHZvaWQgc2RwMzQz
MF91c2JfaW5pdCh2b2lkKTsKIGV4dGVybiB2b2lkIHNkcDM0MzBfZmxhc2hfaW5pdCh2b2lkKTsK
IAogI2RlZmluZSBERUJVR19CQVNFCQkJMHgwODAwMDAwMCAgLyogZGVidWcgYm9hcmQgKi8KLS0g
CjEuNS42LjEuMTU2LmdlOTAzYgoK
--=_7931f54ef0f2347fc04af427305e5d27--


