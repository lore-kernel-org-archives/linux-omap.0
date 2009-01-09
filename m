From: "Grazvydas Ignotas" <notasas@gmail.com>
Subject: Re: Fix for dispc's error "omapfb omapfb: irq error status 4020"
Date: Fri, 9 Jan 2009 23:57:54 +0200
Message-ID: <6ed0b2680901091357s435ea0cbke06f6bfccc15ee1@mail.gmail.com>
References: <E1KyYMw-0003Ob-5e@amazonia.comcast.net>
	 <1226585192.32348.3.camel@tubuntu>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_22629_3793246.1231538274193"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:39538 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757291AbZAIV54 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jan 2009 16:57:56 -0500
Received: by fg-out-1718.google.com with SMTP id 19so3532488fgg.17
        for <linux-omap@vger.kernel.org>; Fri, 09 Jan 2009 13:57:54 -0800 (PST)
In-Reply-To: <1226585192.32348.3.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: rick@efn.org, linux-omap@vger.kernel.org

------=_Part_22629_3793246.1231538274193
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thu, Nov 13, 2008 at 4:06 PM, Tomi Valkeinen
<tomi.valkeinen@nokia.com> wrote:
> Hi,
>
> On Fri, 2008-11-07 at 12:55 -0800, ext Rick Bronson wrote:
>> Folks,
>>
>>   Please take a look at this change to drivers/video/omap/dispc.c.  It
>> addresses a problem seen on some boots of OMAP's.  On about 1 in 30
>> boots one gets an endless stream of interrupts from the
>> DISPC_IRQ_SYNC_LOST bit in the DISPC_IRQSTATUS register.  The
>> following messages are printed.
>>
>>  omapfb omapfb: irq error status 4020
>
> Can you try the patch below if it fixes this problem for you? On my new
> display subsystem adding a sleep between enabling clocks and doing the
> soft reset removed the problem.
>
> I tried a bit with different sleep times. With 1ms sleep I still got
> sync losts. With 10ms I didn't, but I went safe and put 40ms.

Unfortunately sleeping there doesn't help for pandora. I've tried
10ms, 40ms, 400ms (this seems to be used by DSS2 now).

However because we are also setting up the display in u-boot for
pandora, I can hook up irq handler early and wait for frame done irq
before resetting DSS (patch attached). With this I've done ~50 reboots
now and hadn't got any sync lost interrupts yet.

In case display is not enabled in bootloader waiting for interrupt
just times out there, so no harm made. This probably could substitute
that sleep, so maybe this solution could be considered for DSS2.

------=_Part_22629_3793246.1231538274193
Content-Type: text/x-diff; name=dispc.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fprdoue20
Content-Disposition: attachment; filename=dispc.patch

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlkZW8vb21hcC9kaXNwYy5jIGIvZHJpdmVycy92aWRlby9v
bWFwL2Rpc3BjLmMKaW5kZXggYzE0MGMyMS4uZTczZDA0YSAxMDA2NDQKLS0tIGEvZHJpdmVycy92
aWRlby9vbWFwL2Rpc3BjLmMKKysrIGIvZHJpdmVycy92aWRlby9vbWFwL2Rpc3BjLmMKQEAgLTEz
OTgsMTAgKzEzOTgsMzEgQEAgc3RhdGljIGludCBvbWFwX2Rpc3BjX2luaXQoc3RydWN0IG9tYXBm
Yl9kZXZpY2UgKmZiZGV2LCBpbnQgZXh0X21vZGUsCiAJfQogI2VuZGlmCiAKKwlsID0gZGlzcGNf
cmVhZF9yZWcoRElTUENfSVJRU1RBVFVTKTsKKwlkaXNwY193cml0ZV9yZWcoRElTUENfSVJRU1RB
VFVTLCBsKTsKKworCXJlY2FsY19pcnFfbWFzaygpOworCisJaWYgKChyID0gcmVxdWVzdF9pcnEo
SU5UXzI0WFhfRFNTX0lSUSwgb21hcF9kaXNwY19pcnFfaGFuZGxlciwKKwkJCSAgIDAsIE1PRFVM
RV9OQU1FLCBmYmRldikpIDwgMCkgeworCQlkZXZfZXJyKGRpc3BjLmZiZGV2LT5kZXYsICJjYW4n
dCBnZXQgRFNTIElSUVxuIik7CisJCWdvdG8gZmFpbDE7CisJfQorCiAJaWYgKCFza2lwX2luaXQp
IHsKIAkJLyogUmVzZXQgbW9uaXRvcmluZyB3b3JrcyBvbmx5IHcvIHRoZSA1NE0gY2xrICovCiAJ
CWVuYWJsZV9kaWdpdF9jbG9ja3MoMSk7CiAKKwkJLyogV2UgaGF2ZSB0byB3YWl0IGhlcmUgdG8g
YXZvaWQgb2NjYXNpb25hbCBTWU5DIExPU1QgZXJyb3JzICovCisJCU1PRF9SRUdfRkxEKERJU1BD
X0lSUUVOQUJMRSwgMSwgMSk7CisJCW9tYXBfZGlzcGNfZW5hYmxlX2xjZF9vdXQoMCk7CS8qIGlm
IGJvb3Rsb2FkZXIgZW5hYmxlZCBpdCAqLworCQlpZiAoIXdhaXRfZm9yX2NvbXBsZXRpb25fdGlt
ZW91dCgmZGlzcGMuZnJhbWVfZG9uZSwKKwkJCQltc2Vjc190b19qaWZmaWVzKDQwMCkpKSB7CisJ
CQlkZXZfZXJyKGRpc3BjLmZiZGV2LT5kZXYsCisJCQkJInRpbWVvdXQgd2FpdGluZyBmb3IgRlJB
TUUgRE9ORVxuIik7CisJCX0KKwkJTU9EX1JFR19GTEQoRElTUENfSVJRRU5BQkxFLCAxLCAwKTsK
KwogCQkvKiBTb2Z0IHJlc2V0ICovCiAJCU1PRF9SRUdfRkxEKERJU1BDX1NZU0NPTkZJRywgMSA8
PCAxLCAxIDw8IDEpOwogCkBAIC0xNDEwLDcgKzE0MzEsNyBAQCBzdGF0aWMgaW50IG9tYXBfZGlz
cGNfaW5pdChzdHJ1Y3Qgb21hcGZiX2RldmljZSAqZmJkZXYsIGludCBleHRfbW9kZSwKIAkJCQlk
ZXZfZXJyKGRpc3BjLmZiZGV2LT5kZXYsICJzb2Z0IHJlc2V0IGZhaWxlZFxuIik7CiAJCQkJciA9
IC1FTk9ERVY7CiAJCQkJZW5hYmxlX2RpZ2l0X2Nsb2NrcygwKTsKLQkJCQlnb3RvIGZhaWwxOwor
CQkJCWdvdG8gZmFpbDI7CiAJCQl9CiAJCX0KIApAQCAtMTQyOSwxNiArMTQ1MCw2IEBAIHN0YXRp
YyBpbnQgb21hcF9kaXNwY19pbml0KHN0cnVjdCBvbWFwZmJfZGV2aWNlICpmYmRldiwgaW50IGV4
dF9tb2RlLAogCWwgfD0gMSA8PCA5OwogCWRpc3BjX3dyaXRlX3JlZyhESVNQQ19DT05GSUcsIGwp
OwogCi0JbCA9IGRpc3BjX3JlYWRfcmVnKERJU1BDX0lSUVNUQVRVUyk7Ci0JZGlzcGNfd3JpdGVf
cmVnKERJU1BDX0lSUVNUQVRVUywgbCk7Ci0KLQlyZWNhbGNfaXJxX21hc2soKTsKLQotCWlmICgo
ciA9IHJlcXVlc3RfaXJxKElOVF8yNFhYX0RTU19JUlEsIG9tYXBfZGlzcGNfaXJxX2hhbmRsZXIs
Ci0JCQkgICAwLCBNT0RVTEVfTkFNRSwgZmJkZXYpKSA8IDApIHsKLQkJZGV2X2VycihkaXNwYy5m
YmRldi0+ZGV2LCAiY2FuJ3QgZ2V0IERTUyBJUlFcbiIpOwotCQlnb3RvIGZhaWwxOwotCX0KIAog
CS8qIEwzIGZpcmV3YWxsIHNldHRpbmc6IGVuYWJsZSBhY2Nlc3MgdG8gT0NNIFJBTSAqLwogCV9f
cmF3X3dyaXRlbCgweDQwMjAwMGIwLCBJT19BRERSRVNTKDB4NjgwMDUwYTApKTsK
------=_Part_22629_3793246.1231538274193--
