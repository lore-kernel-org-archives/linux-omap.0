From: Kyuwon Kim <q1.kim@samsung.com>
Subject: [PATCH] Fix the size of twl4030 script
Date: Fri, 10 Apr 2009 04:09:34 +0000 (GMT)
Message-ID: <7217161.82751239336573809.JavaMail.weblogic@epml19>
Reply-To: q1.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:59481 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbZDJETs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Apr 2009 00:19:48 -0400
Received: from ep_ms7_bk (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0KHV0010FA7YS6@mailout3.samsung.com> for
 linux-omap@vger.kernel.org; Fri, 10 Apr 2009 13:09:34 +0900 (KST)
Received: from ep_spt04 (ms7.samsung.com [203.254.225.101])
 by ms7.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0KHV006AWA7YK4@ms7.samsung.com> for linux-omap@vger.kernel.org;
 Fri, 10 Apr 2009 13:09:34 +0900 (KST)
Content-return: prohibited
MIME-version: 1.0
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?utf-8?Q?=EB=B0=95=EA=B2=BD=EB=AF=BC?= <kyungmin.park@samsung.com>, =?utf-8?Q?=EB=8C=80=EC=9D=B8=EA=B8=B0?= <inki.dae@samsung.com>, OMAP <linux-omap@vger.kernel.org>

VGhlIGFycmF5IHNpemUgb2Ygd3JzdF9zZXEgaXMgQVJSQVlfU0laRSh3cnN0X3NlcSkNCg0KU2ln
bmVkLW9mZi1ieTogS2ltIEt5dXdvbiA8cTEua2ltQHNhbXN1bmcuY29tPg0KLS0tDQogYXJjaC9h
cm0vbWFjaC1vbWFwMi9ib2FyZC0zNDMwc2RwLmMgfCAgICAyICstDQogYXJjaC9hcm0vbWFjaC1v
bWFwMi9ib2FyZC1sZHAuYyAgICAgfCAgICAyICstDQogMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW9t
YXAyL2JvYXJkLTM0MzBzZHAuYyBiL2FyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQtMzQzMHNkcC5j
DQppbmRleCAwM2FjYWM3Li4zODU1MGUyIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm0vbWFjaC1vbWFw
Mi9ib2FyZC0zNDMwc2RwLmMNCisrKyBiL2FyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQtMzQzMHNk
cC5jDQpAQCAtNDczLDcgKzQ3Myw3IEBAIHN0YXRpYyBzdHJ1Y3QgdHdsNDAzMF9pbnMgd3JzdF9z
ZXFbXSBfX2luaXRkYXRhID0gew0KIH07DQogc3RhdGljIHN0cnVjdCB0d2w0MDMwX3NjcmlwdCB3
cnN0X3NjcmlwdCBfX2luaXRkYXRhID0gew0KIAkuc2NyaXB0ID0gd3JzdF9zZXEsDQotCS5zaXpl
ICAgPSBBUlJBWV9TSVpFKHdha2V1cF9zZXEpLA0KKwkuc2l6ZSAgID0gQVJSQVlfU0laRSh3cnN0
X3NlcSksDQogCS5mbGFncyAgPSBUUklUT05fV1JTVF9TQ1JJUFQsDQogfTsNCiANCmRpZmYgLS1n
aXQgYS9hcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLWxkcC5jIGIvYXJjaC9hcm0vbWFjaC1vbWFw
Mi9ib2FyZC1sZHAuYw0KaW5kZXggODA0ZmQ4ZS4uZGE4MTRkNyAxMDA2NDQNCi0tLSBhL2FyY2gv
YXJtL21hY2gtb21hcDIvYm9hcmQtbGRwLmMNCisrKyBiL2FyY2gvYXJtL21hY2gtb21hcDIvYm9h
cmQtbGRwLmMNCkBAIC00NTAsNyArNDUwLDcgQEAgc3RhdGljIHN0cnVjdCB0d2w0MDMwX2lucyB3
cnN0X3NlcVtdIF9faW5pdGRhdGEgPSB7DQogDQogc3RhdGljIHN0cnVjdCB0d2w0MDMwX3Njcmlw
dCB3cnN0X3NjcmlwdCBfX2luaXRkYXRhID0gew0KIAkuc2NyaXB0ID0gd3JzdF9zZXEsDQotCS5z
aXplICAgPSBBUlJBWV9TSVpFKHdha2V1cF9zZXEpLA0KKwkuc2l6ZSAgID0gQVJSQVlfU0laRSh3
cnN0X3NlcSksDQogCS5mbGFncyAgPSBUUklUT05fV1JTVF9TQ1JJUFQsDQogfTsNCiANCi0tIA0K
MS41LjIuNQ0KDQotLQ0KSGFwcHkgRW5naW5lZXIuIEtpbSBLeXV3b24g


