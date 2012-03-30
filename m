From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: Suspend broken on 3.3?
Date: Fri, 30 Mar 2012 15:45:19 +0530
Message-ID: <CAMrsUdJrJZXjYOs87xmT_J0w7S=VZyfR0tBmhhuYOFmFsOB3SA@mail.gmail.com>
References: <87vcloipow.fsf@ti.com> <WC20120329083556.20174D@terrafix.co.uk>
 <alpine.DEB.2.00.1203290356190.2788@utopia.booyaka.com> <WC20120329112755.541787@terrafix.co.uk>
 <WC20120329114024.43178C@terrafix.co.uk> <CAMrsUdKR4nwbBEOx9JPeS=GLDPyioHuijK2596=q2OwJ+ARbxA@mail.gmail.com>
 <WC20120330075339.4017FC@terrafix.co.uk> <CAMrsUdKTx84_oHyS9JTCBTqtV-7907snCGFDrOXnPuNVSnvz7w@mail.gmail.com>
 <WC20120330092609.901834@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=e89a8fb1ef3e51c1d104bc731f62
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:38837 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760655Ab2C3KPl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Mar 2012 06:15:41 -0400
Received: by obbwd20 with SMTP id wd20so1013479obb.18
        for <linux-omap@vger.kernel.org>; Fri, 30 Mar 2012 03:15:39 -0700 (PDT)
In-Reply-To: <WC20120330092609.901834@terrafix.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, neilb@suse.de

--e89a8fb1ef3e51c1d104bc731f62
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 30, 2012 at 2:56 PM, Joe Woodward <jw@terrafix.co.uk> wrote:
> ...[snip]...
>>
>> Could you please try attached patch and let me know if this solves the
>> rx issue as well,
>> without using dma mode.
>>
>
> Right,
>
> I think we've getting closer, but still not quite there...
>
> Firstly, the patch adds an include to "iomap.h" - but this doesn't exist =
in stock 3.3. Simply removing this include seemed to allow the compile to c=
omplete
> successfully.

Sorry I forgot to specify this is needed for latest mainline.

>
> With this patch applied (and not in DMA mode) I now get the following:
> =A0- If I leave wake-from-suspend enabled for the serial port then it wor=
ks correctly (i.e. no lost/extra 0x00 characters).
> =A0- If I disable wake-from-suspend for the serial port and go through a =
suspend cycle (i.e. suspend and then wake), then the serial port starts to =
misbehave as
> before.
> =A0- If I then re-enable wake-from-suspend and go through a suspend cycle=
 it starts to work correctly again.
>
> So the problem is still that if wake-from-suspend is disabled for a seria=
l port, and a suspend cycle is performed then when woken the serial port wi=
ll not function
> correctly if operating in interrupt-mode.

I tried it on my 3430sdp but strangely I don't see a 0x00 char read
after disabling uart wakeups
and waking up by keypad press.

Probably as a quick try we can try doing uart_insert_char only if data
was read from rx fifo
(Attached patch)

--
Thanks,
Govindraj.R

--e89a8fb1ef3e51c1d104bc731f62
Content-Type: application/octet-stream; name="rx_fifo_check.patch"
Content-Disposition: attachment; filename="rx_fifo_check.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h0f2soe90

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC9vbWFwLXNlcmlhbC5jIGIvZHJpdmVycy90
dHkvc2VyaWFsL29tYXAtc2VyaWFsLmMKaW5kZXggMDU2MjBmYi4uMTNhMTVjNiAxMDA2NDQKLS0t
IGEvZHJpdmVycy90dHkvc2VyaWFsL29tYXAtc2VyaWFsLmMKKysrIGIvZHJpdmVycy90dHkvc2Vy
aWFsL29tYXAtc2VyaWFsLmMKQEAgLTIwNiwxMCArMjA2LDE0IEBAIHN0YXRpYyBpbmxpbmUgdm9p
ZCByZWNlaXZlX2NoYXJzKHN0cnVjdCB1YXJ0X29tYXBfcG9ydCAqdXAsCiAJdW5zaWduZWQgaW50
IGZsYWcsIGxzciA9ICpzdGF0dXM7CiAJdW5zaWduZWQgY2hhciBjaCA9IDA7CiAJaW50IG1heF9j
b3VudCA9IDI1NjsKKwl1OCByZWNkX2NoID0gZmFsc2U7CiAKIAlkbyB7Ci0JCWlmIChsaWtlbHko
bHNyICYgVUFSVF9MU1JfRFIpKQorCQlpZiAobGlrZWx5KGxzciAmIFVBUlRfTFNSX0RSKSkgewog
CQkJY2ggPSBzZXJpYWxfaW4odXAsIFVBUlRfUlgpOworCQkJcmVjZF9jaCA9IHRydWU7CisJCX0K
KwogCQlmbGFnID0gVFRZX05PUk1BTDsKIAkJdXAtPnBvcnQuaWNvdW50LnJ4Kys7CiAKQEAgLTI1
OCw3ICsyNjIsOSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgcmVjZWl2ZV9jaGFycyhzdHJ1Y3QgdWFy
dF9vbWFwX3BvcnQgKnVwLAogCiAJCWlmICh1YXJ0X2hhbmRsZV9zeXNycV9jaGFyKCZ1cC0+cG9y
dCwgY2gpKQogCQkJZ290byBpZ25vcmVfY2hhcjsKLQkJdWFydF9pbnNlcnRfY2hhcigmdXAtPnBv
cnQsIGxzciwgVUFSVF9MU1JfT0UsIGNoLCBmbGFnKTsKKworCQlpZiAocmVjZF9jaCkKKwkJCXVh
cnRfaW5zZXJ0X2NoYXIoJnVwLT5wb3J0LCBsc3IsIFVBUlRfTFNSX09FLCBjaCwgZmxhZyk7CiBp
Z25vcmVfY2hhcjoKIAkJbHNyID0gc2VyaWFsX2luKHVwLCBVQVJUX0xTUik7CiAJfSB3aGlsZSAo
KGxzciAmIChVQVJUX0xTUl9EUiB8IFVBUlRfTFNSX0JJKSkgJiYgKG1heF9jb3VudC0tID4gMCkp
Owo=
--e89a8fb1ef3e51c1d104bc731f62--
