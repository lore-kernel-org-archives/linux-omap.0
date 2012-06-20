From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 07/10] ARM: OMAP3: update cpuidle latency and threshold figures
Date: Wed, 20 Jun 2012 13:39:37 +0200
Message-ID: <CAORVsuU7N3N=iSGQKo0oBYysWrg3M15Uak0u2kQg6N7Jwk0Jjg@mail.gmail.com>
References: <1339686361-11526-1-git-send-email-j-pihet@ti.com>
	<1339686361-11526-8-git-send-email-j-pihet@ti.com>
	<4FE1AD8B.305@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: base64
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58263 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753913Ab2FTLjj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jun 2012 07:39:39 -0400
Received: by bkcji2 with SMTP id ji2so6052854bkc.19
        for <linux-omap@vger.kernel.org>; Wed, 20 Jun 2012 04:39:37 -0700 (PDT)
In-Reply-To: <4FE1AD8B.305@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, khilman@ti.com, Jean Pihet <j-pihet@ti.com>

T24gV2VkLCBKdW4gMjAsIDIwMTIgYXQgMTowMSBQTSwgUmFqZW5kcmEgTmF5YWsgPHJuYXlha0B0
aS5jb20+IHdyb3RlOgo+IE9uIFRodXJzZGF5IDE0IEp1bmUgMjAxMiAwODozNSBQTSwgSmVhbiBQ
aWhldCB3cm90ZToKPj4KPj4goCCgIKAgoCCgIKAgoCCgewo+PiCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoC5lbnRlciCgIKAgoCCgIKAgoD0gb21hcDNfZW50ZXJfaWRsZV9ibSwKPj4gLSCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgLmV4aXRfbGF0ZW5jeSCgIKAgPSAzMDAwICsgODUwMCwKPj4gLSCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgLnRhcmdldF9yZXNpZGVuY3kgPSAxNTAwMCwKPj4gKyCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgLmV4aXRfbGF0ZW5jeSCgIKAgPSA0MDgwICsgODAxLAo+PiArIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCAudGFyZ2V0X3Jlc2lkZW5jeSA9IDIxNTAwMCwKPj4goCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAuZmxhZ3MgoCCgIKAgoCCgIKA9IENQVUlETEVfRkxBR19USU1FX1ZBTElE
LAo+PiCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoC5uYW1lIKAgoCCgIKAgoCCgID0gIkM2IiwKPj4g
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAuZGVzYyCgIKAgoCCgIKAgoCA9ICJNUFUgT0ZGICsgQ09S
RSBSRVQiLAo+PiCgIKAgoCCgIKAgoCCgIKB9LAo+PiCgIKAgoCCgIKAgoCCgIKB7Cj4+IKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgLmVudGVyIKAgoCCgIKAgoCCgPSBvbWFwM19lbnRlcl9pZGxlX2Jt
LAo+PiAtIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCAuZXhpdF9sYXRlbmN5IKAgoCA9IDEwMDAwICsg
MzAwMDAsCj4+IC0goCCgIKAgoCCgIKAgoCCgIKAgoCCgIC50YXJnZXRfcmVzaWRlbmN5ID0gMzAw
MDAsCj4+ICsgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIC5leGl0X2xhdGVuY3kgoCCgID0gNDMwMCAr
IDEzMDAwLAo+PiArIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCAudGFyZ2V0X3Jlc2lkZW5jeSA9IDIx
NTAwMCwKPgo+Cj4gSXMgdGhlIHRhcmdldF9yZXNpZGVuY3kgc2FtZSBmb3IgYm90aCB0aGVzZSBz
dGF0ZXM/ClllcyBpdCBpcy4gVGhlIGRldGFpbHMgYXJlIGZvdW5kIGluIHRoZSBvbWFwcGVkaWEg
d2lraSBwYWdlLgoKVGhhbmtzLApKZWFuCgo+Cj4KPj4goCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAu
ZmxhZ3MgoCCgIKAgoCCgIKA9IENQVUlETEVfRkxBR19USU1FX1ZBTElELAo+PiCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoC5uYW1lIKAgoCCgIKAgoCCgID0gIkM3IiwKPj4goCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAuZGVzYyCgIKAgoCCgIKAgoCA9ICJNUFUgT0ZGICsgQ09SRSBPRkYiLAo+Cj4K
