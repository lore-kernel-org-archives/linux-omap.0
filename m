From: Mika Korhonen <mika.j.korhonen@gmail.com>
Subject: [PATCH] twl4030-gpio: Avoid call to a discarded function
Date: Wed, 29 Apr 2009 15:31:44 +0300
Message-ID: <7948530904290531o8174cecse24247a701415a90@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e6d646ed21edaf0468b0c3b6
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:41413 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752749AbZD2Mbr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Apr 2009 08:31:47 -0400
Received: by fk-out-0910.google.com with SMTP id 18so547397fkq.5
        for <linux-omap@vger.kernel.org>; Wed, 29 Apr 2009 05:31:44 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

--0016e6d646ed21edaf0468b0c3b6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

The patch is attached.
Probably there are better ways of doing this like extracting the
cleanup part from __devexited function to another spot. The patch is a
quick one to make it build in non-module, non-hotplug configuration
and to demonstrate the problem.

Mika K

--0016e6d646ed21edaf0468b0c3b6
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-twl4030-gpio-Avoid-call-to-a-discarded-function.patch"
Content-Disposition: attachment;
	filename="0001-twl4030-gpio-Avoid-call-to-a-discarded-function.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fu404r580

RnJvbSBhOGE4NGE2ODVhNWVmMTA4Y2U0ZjRmY2NlMzc1NzJlOTlkMWMwZWIyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNaWthIEtvcmhvbmVuIDxtaWthLmoua29yaG9uZW5AZ21haWwu
Y29tPgpEYXRlOiBXZWQsIDI5IEFwciAyMDA5IDE1OjI1OjA2ICswMzAwClN1YmplY3Q6IFtQQVRD
SF0gdHdsNDAzMC1ncGlvOiBBdm9pZCBjYWxsIHRvIGEgZGlzY2FyZGVkIGZ1bmN0aW9uCgpncGlv
X3R3bDQwMzBfcmVtb3ZlKCkgaXMgbWFya2VkIHRvIGJlIGRpc2NhcmRlZCBpbiBjZXJ0YWluIGNv
bmZpZ3VyYXRpb25zLApzbyBpdCBjYW5ub3QgYmUgY2FsbGVkIHdpdGhvdXQgY2hlY2tpbmcuCgpT
aWduZWQtb2ZmLWJ5OiBNaWthIEtvcmhvbmVuIDxtaWthLmoua29yaG9uZW5AZ21haWwuY29tPgot
LS0KIGRyaXZlcnMvZ3Bpby90d2w0MDMwLWdwaW8uYyB8ICAgIDUgKysrKy0KIDEgZmlsZXMgY2hh
bmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3Bpby90d2w0MDMwLWdwaW8uYyBiL2RyaXZlcnMvZ3Bpby90d2w0MDMwLWdwaW8uYwppbmRl
eCBhZmFkMTQ3Li40ZWE5Y2FkIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwaW8vdHdsNDAzMC1ncGlv
LmMKKysrIGIvZHJpdmVycy9ncGlvL3R3bDQwMzAtZ3Bpby5jCkBAIC00NDMsMTEgKzQ0MywxNCBA
QCBub19pcnFzOgogCiAJcmV0ID0gZ3Bpb2NoaXBfYWRkKCZ0d2xfZ3Bpb2NoaXApOwogCWlmIChy
ZXQgPCAwKSB7CisJCWludCAoKnJlbW92ZV9mbikoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqKSA9
IF9fZGV2ZXhpdF9wKGdwaW9fdHdsNDAzMF9yZW1vdmUpOwogCQlkZXZfZXJyKCZwZGV2LT5kZXYs
CiAJCQkJImNvdWxkIG5vdCByZWdpc3RlciBncGlvY2hpcCwgJWRcbiIsCiAJCQkJcmV0KTsKIAkJ
dHdsX2dwaW9jaGlwLm5ncGlvID0gMDsKLQkJZ3Bpb190d2w0MDMwX3JlbW92ZShwZGV2KTsKKwkJ
aWYgKHJlbW92ZV9mbikgeworCQkJcmVtb3ZlX2ZuKHBkZXYpOworCQl9CiAJfSBlbHNlIGlmIChw
ZGF0YS0+c2V0dXApIHsKIAkJaW50IHN0YXR1czsKIAotLSAKMS41LjYuNQoK
--0016e6d646ed21edaf0468b0c3b6--
