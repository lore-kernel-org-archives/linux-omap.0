From: Marek Skuczynski <mareksk7@gmail.com>
Subject: Re: Bug: access to already released memory
Date: Sun, 31 Jan 2010 11:00:54 +0100
Message-ID: <a328840c1001310200n6314cf2emf69656b807fcb191@mail.gmail.com>
References: <a328840c1001301356r14505614pbb4563754c6890ac@mail.gmail.com>
	 <20100131035540.GA13428@linux-sh.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0ce038e0cddf3b047e72f163
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:35578 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278Ab0AaKA4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 31 Jan 2010 05:00:56 -0500
Received: by bwz27 with SMTP id 27so2369463bwz.21
        for <linux-omap@vger.kernel.org>; Sun, 31 Jan 2010 02:00:55 -0800 (PST)
In-Reply-To: <20100131035540.GA13428@linux-sh.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Mundt <lethal@linux-sh.org>

--000e0ce038e0cddf3b047e72f163
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,
   I have found an access to already released memory in
clk_debugfs_register_one() function,
   attaching a patch. The included patch was prepared for Linux 2.6 reposit=
ory.

Regards,
  Marek

On Sun, Jan 31, 2010 at 4:55 AM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Sat, Jan 30, 2010 at 10:56:30PM +0100, Marek Skuczynski wrote:
>> =A0 =A0I have found two places where access to already released memory h=
appens,
>> =A0 =A0attaching patches.
>>
> I'll apply them for 2.6.33, thanks.
>
>> Subject: [PATCH 2/2] sh: Fix access to released memory in clk_debugfs_re=
gister_one()
>>
>> Signed-off-by: Marek Skuczynski <mareksk7@gmail.com>
>> ---
>> =A0arch/sh/kernel/cpu/clock.c | =A0 =A04 ++--
>> =A01 files changed, 2 insertions(+), 2 deletions(-)
>>
> Note that this code was copied from omap, so you may want to send them a
> patch for arch/arm/plat-omap/clock.c, too.
>

--000e0ce038e0cddf3b047e72f163
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-arm-omap-Fix-access-to-already-released-memory-in-cl.patch"
Content-Disposition: attachment;
	filename="0001-arm-omap-Fix-access-to-already-released-memory-in-cl.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g53nu17c0

RnJvbSBhMWQyYTljZjk1MmExMTkwNDk5ODliZWE2YjQ1M2IzYjA5Yzk4YjRiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXJlayBTa3Vjenluc2tpIDxtYXJla3NrN0BnbWFpbC5jb20+
CkRhdGU6IFN1biwgMzEgSmFuIDIwMTAgMTA6MzU6MTUgKzAxMDAKU3ViamVjdDogW1BBVENIXSBh
cm0vb21hcDogRml4IGFjY2VzcyB0byBhbHJlYWR5IHJlbGVhc2VkIG1lbW9yeSBpbiBjbGtfZGVi
dWdmc19yZWdpc3Rlcl9vbmUoKQoKU2lnbmVkLW9mZi1ieTogTWFyZWsgU2t1Y3p5bnNraSA8bWFy
ZWtzazdAZ21haWwuY29tPgotLS0KIGFyY2gvYXJtL3BsYXQtb21hcC9jbG9jay5jIHwgICAgNCAr
Ky0tCiAxIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9hcmNoL2FybS9wbGF0LW9tYXAvY2xvY2suYyBiL2FyY2gvYXJtL3BsYXQtb21h
cC9jbG9jay5jCmluZGV4IGQ5ZjhjODQuLjRiZWNiZGQgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL3Bs
YXQtb21hcC9jbG9jay5jCisrKyBiL2FyY2gvYXJtL3BsYXQtb21hcC9jbG9jay5jCkBAIC0zOTEs
NyArMzkxLDcgQEAgc3RhdGljIHN0cnVjdCBkZW50cnkgKmNsa19kZWJ1Z2ZzX3Jvb3Q7CiBzdGF0
aWMgaW50IGNsa19kZWJ1Z2ZzX3JlZ2lzdGVyX29uZShzdHJ1Y3QgY2xrICpjKQogewogCWludCBl
cnI7Ci0Jc3RydWN0IGRlbnRyeSAqZCwgKmNoaWxkOworCXN0cnVjdCBkZW50cnkgKmQsICpjaGls
ZCwgKmNoaWxkX3RtcDsKIAlzdHJ1Y3QgY2xrICpwYSA9IGMtPnBhcmVudDsKIAljaGFyIHNbMjU1
XTsKIAljaGFyICpwID0gczsKQEAgLTQyMyw3ICs0MjMsNyBAQCBzdGF0aWMgaW50IGNsa19kZWJ1
Z2ZzX3JlZ2lzdGVyX29uZShzdHJ1Y3QgY2xrICpjKQogCiBlcnJfb3V0OgogCWQgPSBjLT5kZW50
OwotCWxpc3RfZm9yX2VhY2hfZW50cnkoY2hpbGQsICZkLT5kX3N1YmRpcnMsIGRfdS5kX2NoaWxk
KQorCWxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShjaGlsZCwgY2hpbGRfdG1wLCAmZC0+ZF9zdWJk
aXJzLCBkX3UuZF9jaGlsZCkKIAkJZGVidWdmc19yZW1vdmUoY2hpbGQpOwogCWRlYnVnZnNfcmVt
b3ZlKGMtPmRlbnQpOwogCXJldHVybiBlcnI7Ci0tIAoxLjYuNC4yCgo=
--000e0ce038e0cddf3b047e72f163--
