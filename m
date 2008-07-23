From: George Jahad <george.jahad@windriver.com>
Subject: [PATCH] Volume Down key on the Zoom MDK
Date: Wed, 23 Jul 2008 14:30:32 -0700
Message-ID: <18567.41720.48693.458775@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2ZhO+6n/zo"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from elasmtp-curtail.atl.sa.earthlink.net ([209.86.89.64]:43527 "EHLO
	elasmtp-curtail.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752759AbYGWVcq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Jul 2008 17:32:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: "George J." <George.Jahad@windriver.com>


--2ZhO+6n/zo
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit

 
  Here is a patch to fix the omap-twl4030keypad.c keypad driver to support the volume down key on the Zoom MDK/Labrador.
  
  
  George Jahad
  Wind River Systems
 
 
--2ZhO+6n/zo
Content-Type: application/octet-stream; name="volumeDown.patch"
Content-Disposition: attachment;
	filename="volumeDown.patch"
Content-Transfer-Encoding: base64

LS0tIGEvZHJpdmVycy9pbnB1dC9rZXlib2FyZC9vbWFwLXR3bDQwMzBrZXlwYWQuYwkyMDA4LTA1
LTI2IDEwOjE0OjIzLjAwMDAwMDAwMCAtMDcwMAorKysgYi9kcml2ZXJzL2lucHV0L2tleWJvYXJk
L29tYXAtdHdsNDAzMGtleXBhZC5jCTIwMDgtMDctMTcgMjA6MjM6MTIuMDAwMDAwMDAwIC0wNzAw
CkBAIC00Myw3ICs0MywxMiBAQAogI2RlZmluZSBPTUFQX1RXTDQwMzBLUF9MT0dfTEVWRUwJMAog
CiAjZGVmaW5lIEtFWShjb2wsIHJvdywgdmFsKQkoKChjb2wpIDw8IDI4KSB8ICgocm93KSA8PCAy
NCkgfCAodmFsKSkKKworI2lmZGVmIENPTkZJR19NQUNIX09NQVBfMzQzMExBQlJBRE9SCisjZGVm
aW5lIE5VTV9ST1dTCQk2CisjZWxzZQogI2RlZmluZSBOVU1fUk9XUwkJNQorI2VuZGlmCiAjZGVm
aW5lIE5VTV9DT0xTCQk2CiAKICNkZWZpbmUgUk9XX01BU0sJCSgoMTw8TlVNX1JPV1MpLTEpCkBA
IC02MSw2ICs2NiwxNCBAQAogCXsiUzgiLCAiUzkiLCAiUzEwIiwgIlMxMSIsICJTMTIiLCAiUzI1
In0sCiAJeyJTMTMiLCAiUzE0IiwgIlMxNSIsICJTMTYiLCAiUzE3IiwgIlMyNiJ9LAogCXsiUzE4
IiwgIlMxOSIsICJTMjAiLCAiUzIxIiwgIlMyMiIsICJTMjcifSwKKyNpZmRlZiBDT05GSUdfTUFD
SF9PTUFQXzM0MzBMQUJSQURPUgorCS8qIExhYnJhZG9yIHVzZXMgS0JSNS9LQkM1IGZvciB0aGUg
dm9sdW1lIGRvd24gc3dpdGNoLCBzbyBJIGhhZCB0byBhZGQKKwkgICB0aGlzIGVudGlyZSByb3cg
anVzdCBmb3IgdGhhdCBzd2l0Y2guICBOb3Qgc3VyZSBpZiBhbnkgb2YgdGhlIG90aGVyCisJICAg
a2V5cyBvbiB0aGlzIG5ldyByb3cgYXJlIGFjdHVhbGx5IHVzZWQsIGFuZCBJIGp1c3QgZ2F2ZSB0
aGVtCisJICAgZHVtbXkgbmFtZXMgZm9yIG5vdy4KKwkqLworCXsiU0EiLCAiU0IiLCAiU0MiLCAi
U0QiLCAiU0UiLCAiUzIyLWQifSwKKyNlbmRpZgogfTsKIAogI2lmZGVmIENPTkZJR19NQUNIX09N
QVBfMzQzMExBQlJBRE9SCg==
--2ZhO+6n/zo--
