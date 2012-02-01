From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: GPIO debounce problems on 3.2
Date: Thu, 2 Feb 2012 00:33:42 +0200
Message-ID: <CANOLnOM_mFapSbE7Q6Qf+RQU7R3fj_BXOkHN92ZQghFv-X-6vg@mail.gmail.com>
References: <CANOLnOOKSC72MsteqE_+F4Q3MUZCJBfDebe7kKHoLsDAxr5y0g@mail.gmail.com>
	<87obtlrniz.fsf@ti.com>
	<CANOLnOM-kaHv=Dm2-6xowK4Z_BJuRopj-25M1HeyJsiYgXp7tA@mail.gmail.com>
	<87obtkpyna.fsf@ti.com>
	<alpine.DEB.2.00.1201301628440.17726@utopia.booyaka.com>
	<CANOLnOM5VYOQOngF-T=5-CM-J2JzXVEnSaYbDjTQ8P=z9XSSAw@mail.gmail.com>
	<alpine.DEB.2.00.1201301835430.10061@utopia.booyaka.com>
	<CANOLnONK_hhzpCuu4xANrMns6eEesnW-5KR6kOSo3AbBwG3twA@mail.gmail.com>
	<CANOLnOMzkNSr5hFbASCWaT6PkBSYQhqMxXmjBfU0tm0GTv=yYA@mail.gmail.com>
	<alpine.DEB.2.00.1201312254150.10061@utopia.booyaka.com>
	<alpine.DEB.2.00.1201312305190.10061@utopia.booyaka.com>
	<CANOLnOMmcztNH+fUzrQxjK5nVVEaAtLi=7ww+dPm0AXEv09qUA@mail.gmail.com>
	<87wr86fu52.fsf@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=f46d043743bf049e8304b7eeac8e
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:38764 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755437Ab2BAWdo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Feb 2012 17:33:44 -0500
Received: by lagu2 with SMTP id u2so942729lag.19
        for <linux-omap@vger.kernel.org>; Wed, 01 Feb 2012 14:33:42 -0800 (PST)
In-Reply-To: <87wr86fu52.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

--f46d043743bf049e8304b7eeac8e
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 1, 2012 at 5:30 PM, Kevin Hilman <khilman@ti.com> wrote:
> Grazvydas Ignotas <notasas@gmail.com> writes:
>
>> On Wed, Feb 1, 2012 at 8:06 AM, Paul Walmsley <paul@pwsan.com> wrote:
>>>
>>> Along these lines, you might try patching omap2_gpio_prepare_for_idle()=
 to
>>> turn off the DEBOUNCENABLE bits?
>>
>> Yes that helps. I guess I'll carry this in pandora tree, at least
>> we'll have debounce while more demanding programs/games are running.
>
> Care to share the patch? =C2=A0It might be worth merging until we have a =
full
> solution.

Attached.

>> Don't know how it's all working for Kevin though..
>
> Now I'm not so sure either...
>
> At first I thought it was because I was getting IO ring wakeups, but
> using vanilla 3.2, MPU, CORE & PER are staying on due to the (broken)
> UART constraint, so I'm getting module-level wakeups, but haven't dug
> into why.

Maybe the CPU is sometimes busy and debounce clock is enabled long
enough for it to work.


--=20
Gra=C5=BEvydas

--f46d043743bf049e8304b7eeac8e
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-gpio-omap-disable-debounce-on-idle.patch"
Content-Disposition: attachment;
	filename="0001-gpio-omap-disable-debounce-on-idle.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gy4xg5kw0

RnJvbSBmMzg0YjJiNDg5NzBkYjM2YTc1MWY0NTRkMWVmMTA5MTA3NzViNWQyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBHcmF6dnlkYXMgSWdub3RhcyA8bm90YXNhc0BnbWFpbC5jb20+
CkRhdGU6IFdlZCwgMSBGZWIgMjAxMiAxNToxMDo1MiArMDIwMApTdWJqZWN0OiBbUEFUQ0hdIGdw
aW8vb21hcDogZGlzYWJsZSBkZWJvdW5jZSBvbiBpZGxlCgpBZnRlciBvbWFwMl9ncGlvX3ByZXBh
cmVfZm9yX2lkbGUgY2FsbCBpdCdzIG5vdCBndWFyYW50ZWVkIHRoYXQgZ2l2ZW4KR1BJTyBtb2R1
bGUgd2lsbCBoaXQgaWRsZSwgc28gaXQgbWlnaHQgZW5kIHVwIGluIGFjdGl2ZSBzdGF0ZSBidXQg
d2l0aApkZWJvdW5jZSBjbG9jayBkaXNhYmxlZCwgd2hpY2ggd2lsbCBicmVhayBpbnB1dCBmdW5j
dGlvbmFsaXR5LgoKRGlzYWJsZSBkZWJvdW5jZSBmZWF0dXJlIG9uIGlkbGUgdG8gYXZvaWQgdGhp
cyBwcm9ibGVtLgoKU2lnbmVkLW9mZi1ieTogR3JhenZ5ZGFzIElnbm90YXMgPG5vdGFzYXNAZ21h
aWwuY29tPgotLS0KIGRyaXZlcnMvZ3Bpby9ncGlvLW9tYXAuYyB8ICAgMTYgKysrKysrKysrKysr
KysrKwogMSBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3Bpby9ncGlvLW9tYXAuYyBiL2RyaXZlcnMvZ3Bpby9ncGlv
LW9tYXAuYwppbmRleCAwYjA1NjI5Li40ZjhlOGJhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwaW8v
Z3Bpby1vbWFwLmMKKysrIGIvZHJpdmVycy9ncGlvL2dwaW8tb21hcC5jCkBAIC0xMzQ3LDkgKzEz
NDcsMTkgQEAgdm9pZCBvbWFwMl9ncGlvX3ByZXBhcmVfZm9yX2lkbGUoaW50IG9mZl9tb2RlKQog
CiAJZm9yIChpID0gbWluOyBpIDwgZ3Bpb19iYW5rX2NvdW50OyBpKyspIHsKIAkJc3RydWN0IGdw
aW9fYmFuayAqYmFuayA9ICZncGlvX2JhbmtbaV07CisJCXZvaWQgX19pb21lbSAqcmVnOwogCQl1
MzIgbDEgPSAwLCBsMiA9IDA7CiAJCWludCBqOwogCisJCS8qCisJCSAqIERpc2FibGUgZGVib3Vu
Y2Ugc2luY2UgY2xvY2sgZGlzYWJsZSBiZWxvdyB3aWxsIGNhdXNlCisJCSAqIHByb2JsZW1zIGlm
IEdQSU8gbW9kdWxlIGRvZXNuJ3QgZ28gaWRsZSBmb3Igc29tZSByZWFzb24uCisJCSAqLworCQlp
ZiAoYmFuay0+ZGJja19lbmFibGVfbWFzayAhPSAwKSB7CisJCQlyZWcgPSBiYW5rLT5iYXNlICsg
YmFuay0+cmVncy0+ZGVib3VuY2VfZW47CisJCQlfX3Jhd193cml0ZWwoMCwgcmVnKTsKKwkJfQor
CiAJCWZvciAoaiA9IDA7IGogPCBod2VpZ2h0X2xvbmcoYmFuay0+ZGJja19lbmFibGVfbWFzayk7
IGorKykKIAkJCWNsa19kaXNhYmxlKGJhbmstPmRiY2spOwogCkBAIC0xNDE1LDEyICsxNDI1LDE4
IEBAIHZvaWQgb21hcDJfZ3Bpb19yZXN1bWVfYWZ0ZXJfaWRsZSh2b2lkKQogCQltaW4gPSAxOwog
CWZvciAoaSA9IG1pbjsgaSA8IGdwaW9fYmFua19jb3VudDsgaSsrKSB7CiAJCXN0cnVjdCBncGlv
X2JhbmsgKmJhbmsgPSAmZ3Bpb19iYW5rW2ldOworCQl2b2lkIF9faW9tZW0gKnJlZzsKIAkJdTMy
IGwgPSAwLCBnZW4sIGdlbjAsIGdlbjE7CiAJCWludCBqOwogCiAJCWZvciAoaiA9IDA7IGogPCBo
d2VpZ2h0X2xvbmcoYmFuay0+ZGJja19lbmFibGVfbWFzayk7IGorKykKIAkJCWNsa19lbmFibGUo
YmFuay0+ZGJjayk7CiAKKwkJaWYgKGJhbmstPmRiY2tfZW5hYmxlX21hc2sgIT0gMCkgeworCQkJ
cmVnID0gYmFuay0+YmFzZSArIGJhbmstPnJlZ3MtPmRlYm91bmNlX2VuOworCQkJX19yYXdfd3Jp
dGVsKGJhbmstPmRiY2tfZW5hYmxlX21hc2ssIHJlZyk7CisJCX0KKwogCQlpZiAoIXdvcmthcm91
bmRfZW5hYmxlZCkKIAkJCWNvbnRpbnVlOwogCi0tIAoxLjcuMC40Cgo=
--f46d043743bf049e8304b7eeac8e--
