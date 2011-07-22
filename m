From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] OMAP: omap_device: replace pr_* prints with dev_*
Date: Fri, 22 Jul 2011 16:15:27 +0300
Message-ID: <CANOLnOOAJMyHUjrf_cM2LVSAs6Zm2bK3RWK73ibNcVg=7vQP4w@mail.gmail.com>
References: <1311269976-4035-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43499 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754203Ab1GVNP2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Jul 2011 09:15:28 -0400
Received: by iyb12 with SMTP id 12so1963925iyb.19
        for <linux-omap@vger.kernel.org>; Fri, 22 Jul 2011 06:15:27 -0700 (PDT)
In-Reply-To: <1311269976-4035-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>, Felipe Balbi <balbi@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org

T24gVGh1LCBKdWwgMjEsIDIwMTEgYXQgODozOSBQTSwgS2V2aW4gSGlsbWFuIDxraGlsbWFuQHRp
LmNvbT4gd3JvdGU6Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoYWN0X2xhdCA+IG9kcGwt
PmFjdGl2YXRlX2xhdCkgewo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgb2Rw
bC0+YWN0aXZhdGVfbGF0X3dvcnN0ID0gYWN0X2xhdDsKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGlmIChvZHBsLT5mbGFncyAmIE9NQVBfREVWSUNFX0xBVEVOQ1lfQVVUT19B
REpVU1QpIHsKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oG9kcGwtPmFjdGl2YXRlX2xhdCA9IGFjdF9sYXQ7Cj4gLSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBwcl93YXJuaW5nKCJvbWFwX2RldmljZTogJXMuJWQ6IG5l
dyB3b3JzdCBjYXNlICIKPiAtIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgImFjdGl2YXRlIGxhdGVuY3kgJWQ6ICVsbHVcbiIsCj4g
LSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoG9kLT5wZGV2Lm5hbWUsIG9kLT5wZGV2LmlkLAo+IC0gwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBvZC0+cG1fbGF0X2xl
dmVsLCBhY3RfbGF0KTsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIGRldl93YXJuKCZvZC0+cGRldi5kZXYsCj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCJuZXcgd29yc3QgY2FzZSBhY3Rp
dmF0ZSBsYXRlbmN5ICIKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIiVkOiAlbGx1XG4iLAo+ICsgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBvZC0+cG1fbGF0X2xldmVs
LCBhY3RfbGF0KTsKCkkgd29uZGVyIHdoeSB0aGVzZSBoYXZlIHRvIGJlIHdhcm5pbmdzLCBJIGdl
dCBxdWl0ZSBhIGxvdCBvZiB0aGVtIGFuZApmaW5kIHRoZW0gcmF0aGVyIGFubm95aW5nLiBPciBp
cyBteSBoYXJkd2FyZSBicm9rZW4gb3Igc29tZXRoaW5nPwoKSSBrbm93IG90aGVyIHBlb3BsZSBh
cmUgZGlzYWJsaW5nIHRoaXMgaW4gdGhlaXIgdHJlZXMgdG9vOgpodHRwOi8vd3d3LnNha29tYW4u
Y29tL2NnaS1iaW4vZ2l0d2ViLmNnaT9wPWxpbnV4LW9tYXAtMi42LmdpdDthPWNvbW1pdGRpZmY7
aD0xNDVjZjlhN2Q0YmE3YzI2MGRmNzA3MWEyOGVmNDBjNmE0ODFiNmRmCgoKCgotLSAKR3Jhxb52
eWRhcwo=
