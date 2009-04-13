From: Tim Yamin <plasm@roo.me.uk>
Subject: Re: YUV rotation support for DSS2 - 2.6.29 [WAS Re: Hello Tomi
	Valkeinen, I have some questions about dss2 driver.]
Date: Mon, 13 Apr 2009 14:00:20 -0700
Message-ID: <792f5f410904131400v3199fa09w14c24f01f468d1c2@mail.gmail.com>
References: <792f5f410904071200h1dae9024v1f2d9cbd4f1bbebc@mail.gmail.com>
	 <5A47E75E594F054BAF48C5E4FC4B92AB02FB1A1896@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636285354b0dac10467760078
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f117.google.com ([209.85.221.117]:35981 "EHLO
	mail-qy0-f117.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152AbZDMVGf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Apr 2009 17:06:35 -0400
Received: by qyk15 with SMTP id 15so104761qyk.33
        for <linux-omap@vger.kernel.org>; Mon, 13 Apr 2009 14:06:34 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02FB1A1896@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shah, Hardik" <hardik.shah@ti.com>
Cc: "gregoire@gentil.com" <gregoire@gentil.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "beagleboard@googlegroups.com" <beagleboard@googlegroups.com>

--001636285354b0dac10467760078
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Hardik,

Thanks for fixing up the patch. I can confirm that YUV rotation is
fine and patches are ready to be merged -- although the attached fix
is needed as well for the userspace layer to know the correct row
strides when writing YUV to the framebuffer.

I'm still having VID1_FIFO_UNDERFLOW errors when I try to play rotated
video on plane 1 and plane 0 is rotated as well. Do you have any ideas
how to debug this further?

Thanks,

Tim

> Hi Tomi,
> If YUV rotation with frame buffer passes can you please review the patch and merge it to your latest.
>
> Regards,
> Hardik

--001636285354b0dac10467760078
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-DSS2-OMAPFB-Set-line_length-correctly-for-YUV-with.patch"
Content-Disposition: attachment;
	filename="0001-DSS2-OMAPFB-Set-line_length-correctly-for-YUV-with.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fthnaz4t2

RnJvbSA0YmEzZjhiMWQyZmVlZjAwYWM2YzhkZTgyNzI2MmQyNTVjZWJiMTg1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUaW0gWWFtaW4gPHBsYXNtQHJvby5tZS51az4KRGF0ZTogTW9u
LCAxMyBBcHIgMjAwOSAxMzo1Nzo0MiAtMDcwMApTdWJqZWN0OiBbUEFUQ0hdIERTUzI6IE9NQVBG
QjogU2V0IGxpbmVfbGVuZ3RoIGNvcnJlY3RseSBmb3IgWVVWIHdpdGggVlJGQi4KClNpZ25lZC1v
ZmYtYnk6IFRpbSBZYW1pbiA8cGxhc21Acm9vLm1lLnVrPgotLS0KIGRyaXZlcnMvdmlkZW8vb21h
cDIvb21hcGZiL29tYXBmYi1tYWluLmMgfCAgIDMwICsrKysrKysrKysrKysrKysrKysrKysrKyst
LS0tLQogMSBmaWxlcyBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlkZW8vb21hcDIvb21hcGZiL29tYXBmYi1tYWluLmMgYi9k
cml2ZXJzL3ZpZGVvL29tYXAyL29tYXBmYi9vbWFwZmItbWFpbi5jCmluZGV4IDkwNDMyNjUuLjY3
NWE3YzkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdmlkZW8vb21hcDIvb21hcGZiL29tYXBmYi1tYWlu
LmMKKysrIGIvZHJpdmVycy92aWRlby9vbWFwMi9vbWFwZmIvb21hcGZiLW1haW4uYwpAQCAtMzc3
LDEwICszNzcsMTkgQEAgdm9pZCBzZXRfZmJfZml4KHN0cnVjdCBmYl9pbmZvICpmYmkpCiAJZmJp
LT5zY3JlZW5fYmFzZSA9IChjaGFyIF9faW9tZW0gKilvbWFwZmJfZ2V0X3JlZ2lvbl92YWRkcihv
ZmJpKTsKIAogCS8qIHVzZWQgYnkgbW1hcCBpbiBmYm1lbS5jICovCi0JaWYgKG9mYmktPnJvdGF0
aW9uX3R5cGUgPT0gT01BUF9EU1NfUk9UX1ZSRkIpCi0JCWZpeC0+bGluZV9sZW5ndGggPQotCQkJ
KE9NQVBfVlJGQl9MSU5FX0xFTiAqIHZhci0+Yml0c19wZXJfcGl4ZWwpID4+IDM7Ci0JZWxzZQor
CWlmIChvZmJpLT5yb3RhdGlvbl90eXBlID09IE9NQVBfRFNTX1JPVF9WUkZCKSB7CisJCXN3aXRj
aCAodmFyLT5ub25zdGQpIHsKKwkJY2FzZSBPTUFQRkJfQ09MT1JfWVVWNDIyOgorCQljYXNlIE9N
QVBGQl9DT0xPUl9ZVVk0MjI6CisJCQlmaXgtPmxpbmVfbGVuZ3RoID0KKwkJCQkoT01BUF9WUkZC
X0xJTkVfTEVOICogdmFyLT5iaXRzX3Blcl9waXhlbCkgPj4gMjsKKwkJCWJyZWFrOworCQlkZWZh
dWx0OgorCQkJZml4LT5saW5lX2xlbmd0aCA9CisJCQkJKE9NQVBfVlJGQl9MSU5FX0xFTiAqIHZh
ci0+Yml0c19wZXJfcGl4ZWwpID4+IDM7CisJCQlicmVhazsKKwkJfQorCX0gZWxzZQogCQlmaXgt
PmxpbmVfbGVuZ3RoID0KIAkJCSh2YXItPnhyZXNfdmlydHVhbCAqIHZhci0+Yml0c19wZXJfcGl4
ZWwpID4+IDM7CiAJZml4LT5zbWVtX3N0YXJ0ID0gb21hcGZiX2dldF9yZWdpb25fcGFkZHIob2Zi
aSk7CkBAIC02ODksNyArNjk4LDE4IEBAIHN0YXRpYyBpbnQgb21hcGZiX3NldHVwX292ZXJsYXko
c3RydWN0IGZiX2luZm8gKmZiaSwgc3RydWN0IG9tYXBfb3ZlcmxheSAqb3ZsLAogCQlnb3RvIGVy
cjsKIAl9CiAKLQlzY3JlZW5fd2lkdGggPSBmaXgtPmxpbmVfbGVuZ3RoIC8gKHZhci0+Yml0c19w
ZXJfcGl4ZWwgPj4gMyk7CisJc3dpdGNoICh2YXItPm5vbnN0ZCkgeworCWNhc2UgT01BUEZCX0NP
TE9SX1lVVjQyMjoKKwljYXNlIE9NQVBGQl9DT0xPUl9ZVVk0MjI6CisJCWlmIChvZmJpLT5yb3Rh
dGlvbl90eXBlID09IE9NQVBfRFNTX1JPVF9WUkZCKSB7CisJCQlzY3JlZW5fd2lkdGggPSBmaXgt
PmxpbmVfbGVuZ3RoCisJCQkJLyAodmFyLT5iaXRzX3Blcl9waXhlbCA+PiAyKTsKKwkJCWJyZWFr
OworCQl9CisJZGVmYXVsdDoKKwkJc2NyZWVuX3dpZHRoID0gZml4LT5saW5lX2xlbmd0aCAvICh2
YXItPmJpdHNfcGVyX3BpeGVsID4+IDMpOworCQlicmVhazsKKwl9CiAKIAlvdmwtPmdldF9vdmVy
bGF5X2luZm8ob3ZsLCAmaW5mbyk7CiAKLS0gCjEuNS42LjMKCg==
--001636285354b0dac10467760078--
