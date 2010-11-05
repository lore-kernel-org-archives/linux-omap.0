From: "Sapiens, Rene" <rene.sapiens@ti.com>
Subject: Re: [PATCH v2 06/12] staging: tidspbridge: convert core to list_head
Date: Fri, 5 Nov 2010 16:12:45 -0600
Message-ID: <AANLkTinEa8y1AfeNDKa6gDcDoL-s6BKU_RLyr4BRUDDJ@mail.gmail.com>
References: <1288969996-22103-1-git-send-email-ionut.nicu@mindbit.ro>
	<1288969996-22103-7-git-send-email-ionut.nicu@mindbit.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: base64
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:34193 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754885Ab0KEWMs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Nov 2010 18:12:48 -0400
Received: by mail-ww0-f42.google.com with SMTP id 22so261782wwb.1
        for <linux-omap@vger.kernel.org>; Fri, 05 Nov 2010 15:12:46 -0700 (PDT)
In-Reply-To: <1288969996-22103-7-git-send-email-ionut.nicu@mindbit.ro>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ionut Nicu <ionut.nicu@gmail.com>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Ionut Nicu <ionut.nicu@mindbit.ro>

SGkgSW9udXQsCgpPbiBGcmksIE5vdiA1LCAyMDEwIGF0IDk6MTMgQU0sIElvbnV0IE5pY3UgPGlv
bnV0Lm5pY3VAZ21haWwuY29tPiB3cm90ZToKPiBDb252ZXJ0IHRoZSBjb3JlIG1vZHVsZSBvZiB0
aGUgdGlkc3BicmlkZ2UgZHJpdmVyCj4gdG8gdXNlIHN0cnVjdCBsaXN0X2hlYWQgaW5zdGVhZCBv
ZiBzdHJ1Y3QgbHN0X2xpc3QuCj4KPiBTaWduZWQtb2ZmLWJ5OiBJb251dCBOaWN1IDxpb251dC5u
aWN1QG1pbmRiaXQucm8+Cgo8c25pcD4KCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy90
aWRzcGJyaWRnZS9jb3JlL2lvX3NtLmMgYi9kcml2ZXJzL3N0YWdpbmcvdGlkc3BicmlkZ2UvY29y
ZS9pb19zbS5jCj4gaW5kZXggMTk0YmFkYS4uOTg1MWYzMiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L3N0YWdpbmcvdGlkc3BicmlkZ2UvY29yZS9pb19zbS5jCj4gKysrIGIvZHJpdmVycy9zdGFnaW5n
L3RpZHNwYnJpZGdlL2NvcmUvaW9fc20uYwoKPHNuaXA+Cgo+IEBAIC0xMTA2LDQ3ICsxMTAzLDM4
IEBAIHN0YXRpYyB2b2lkIGlucHV0X21zZyhzdHJ1Y3QgaW9fbWdyICpwaW9fbWdyLCBzdHJ1Y3Qg
bXNnX21nciAqaG1zZ19tZ3IpCj4goCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgICogcXVldWVkLgo+IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCAq
Lwo+IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCgqaG1zZ19tZ3ItPm9u
X2V4aXQpICgodm9pZCAqKQo+IC0goCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgbXNnX3F1ZXVlX29iai0+YXJnLAo+IC0goCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgbXNnLm1zZy5kd19h
cmcxKTsKPiArIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIG1zZ19xdWV1ZV9vYmotPmFyZywKPiArIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIG1zZy5tc2cuZHdfYXJnMSk7Cj4gKyCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIGJyZWFrOwo+ICsgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgfQo+ICsgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgLyoKPiAr
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAqIE5vdCBhbiBleGl0IGFja25vd2xlZGdl
bWVudCwgcXVldWUKPiArIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAqIHRoZSBtZXNz
YWdlLgo+ICsgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCovCj4gKyCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCBpZiAoIWxpc3RfZW1wdHkoJm1zZ19xdWV1ZV9vYmotPm1zZ19m
cmVlX2xpc3QpKSB7CgpZb3UgYXJlIGdvaW5nIGJleW9uZCB0aGUgODAgY2hhcnMuCgpSZWdhcmRz
LApSZW5lCg==
