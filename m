From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: Enabling DBGEN signal in GP OMAP3
Date: Thu, 26 Feb 2015 03:09:56 +0200
Message-ID: <CANOLnOOBHmHjydhtH3_gL9D+ZPWywxsXHtn9RRaNWCSJb50Cnw@mail.gmail.com>
References: <CANOLnOOpzK9BvaOk+bgREPBEKs+OErf_1DfXmefSDweb4XjNxg@mail.gmail.com>
	<20150216175826.GT2531@atomide.com>
	<CAALWOA_JZgWWKvFnDmzZRTSqFVJPZOEar1L0D7KR5VoU_7FqCg@mail.gmail.com>
	<CANOLnOO6HWtptks+TXbJEim9fhk5mp5q94gg1wva77x4H7c3pg@mail.gmail.com>
	<CAALWOA_DWjDkmnTj1h0EaSKPeJB_Xd+8YAa6Yv=_HgH9W+ijWA@mail.gmail.com>
	<CANOLnOOgTtTeg_OBvJSGy9OOwdA65omwN=_8Webt8M5E6DoJbg@mail.gmail.com>
	<CAALWOA_Hj4bNHX2LX8w_vBBaThpnwQ+=JxScF710vc_itEfV4Q@mail.gmail.com>
	<CAALWOA_Vw=1xC=yUYJBUhp4QqZWvk+EsiLSB=J7+EQmBMTgEkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a1133a5b4072585050ff369fb
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:46932 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752907AbbBZBJ6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Feb 2015 20:09:58 -0500
Received: by lams18 with SMTP id s18so7776309lam.13
        for <linux-omap@vger.kernel.org>; Wed, 25 Feb 2015 17:09:57 -0800 (PST)
In-Reply-To: <CAALWOA_Vw=1xC=yUYJBUhp4QqZWvk+EsiLSB=J7+EQmBMTgEkQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Will Deacon <will.deacon@arm.com>

--001a1133a5b4072585050ff369fb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2015 at 1:52 PM, Matthijs van Duin
<matthijsvanduin@gmail.com> wrote:
> At least on the am335x, the trick actually works!  I have a working
> demo which configures ICEPick registers and even performs transactions
> on the debug interconnect.

Nice!

> I've been lazy and imported a bunch of files from my baremetal
> projects so I could easily mess with the hardware, rudely bypassing
> the kernel.  The whole implementation is hideous in all sorts of ways,
> but it gets the job done: https://github.com/dutchanddutch/jbang
>
> The key part, how to bitbang JTAG, is reasonably isolated from all
> this in src/jbang.cc and glues onto the device-specific part via
> hw-subarctic.h.  You could probably also turn jbang.cc into plain C
> without too much effort and discard the rest... I accept that my code
> style is probably a bit of an acquired taste ;-)
>
> For the omap3, apart from the differences in padconf details, you'll
> want to change icepick_init_regs[] to just { 0x23002100 } I think and
> hopefully you can then write the DAPCTL regs using ap_write().

I've finally got rid of nTRST pulldown (haven't connected TDO though),
created hw-omap3.{h,cc}, but couldn't get it to do anything, until it
came to my mind that you may be running ARM on your BBB slower that
1GHz that I'm using on my DM3730. So lowered the clock to 500MHz and
voila, it worked!

I guess I'll still connect TDO as it's not so much fun without it,
going to try connecting to EMU0 too, hopefully it doesn't mess up the
boot modes.

Before I could get it all to work a coworker lent me an Altera USB
Blaster, which I've connected to a pandora prototype board I still
have from a long time ago and wasn't that afraid to kill with bad
soldering job. And hey, it worked too with your code modified to use
USB Blaster in it's bitbang mode over libftdi. This setup also works
with openocd, but somewhat unreliably (only occasionally gets through
init, often gets register values it doesn't like).

My main goal is to have hardware watchpoints on the cased production
unit without extra hardware, and it looks like I can finally have
that, thanks!

> I hope this example is of any help.

It sure is! The only thing I do not understand is why are you using
that process_vm_readv() call, mmap() already makes unprivileged user
mode writable mappings.

Anyway I'm attaching my code too, feel free to incorporate it too
and/or ultra-modernize to your c++ dialect.

Gra=C5=BEvydas

--001a1133a5b4072585050ff369fb
Content-Type: text/x-c++src; charset=US-ASCII; name="hw-omap3.cc"
Content-Disposition: attachment; filename="hw-omap3.cc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i6lg0dmd0

I2luY2x1ZGUgImRlZnMuaCIKI2luY2x1ZGUgIm1hcC1waHlzLmgiCiNpbmNsdWRlICJody1vbWFw
My5oIgoKc3RhdGljIHUxNiAqcGFkY29uZl9yZWdzOwoKLy8tLS0tLS0tLS0tLS0tLSBKVEFHIHBp
biBpL28gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLy8K
Ci8vIEpUQUcgaW5wdXRzIGNvbnRyb2xsZWQgYnkgdG9nZ2xpbmcgcmVjZWl2ZXItZW5hYmxlIChw
aW5zIG11c3QgYmUgcHVsbGVkIGhpZ2gKLy8gZXh0ZXJuYWxseSBvciBsZWZ0IGZsb2F0aW5nIHRv
IGFsbG93IGludGVybmFsIHB1bGwtdXAgdG8gd29yaykuCi8vCmxldCBzdGF0aWMgc2ltX2lucHV0
KCB1aW50IG9mZnNldCwgYm9vbCBsZXZlbCApCnsKCXBhZGNvbmZfcmVnc1tvZmZzZXQgPj4gMV0g
PSAweDAwMTggfCAobGV2ZWwgPyAweDAxMDAgOiAweDAwMDApOwp9CgovLyBKVEFHIGlucHV0cyBj
b250cm9sbGVkIHZpYSBwYWRjb25mCmxldCB0cnN0KCBib29sIGxldmVsICkgLT4gdm9pZCB7ICBz
aW1faW5wdXQoIDB4MGExYywgbGV2ZWwgKTsgIH0KbGV0IHRjayggIGJvb2wgbGV2ZWwgKSAtPiB2
b2lkIHsgIHNpbV9pbnB1dCggMHgwYTFlLCBsZXZlbCApOyAgfQpsZXQgdG1zKCAgYm9vbCBsZXZl
bCApIC0+IHZvaWQgeyAgc2ltX2lucHV0KCAweDBhMjAsIGxldmVsICk7ICB9CmxldCB0ZGkoICBi
b29sIGxldmVsICkgLT4gdm9pZCB7ICBzaW1faW5wdXQoIDB4MGEyMiwgbGV2ZWwgKTsgIH0KCi8v
IEpUQUcgb3V0cHV0IChURE8pIG1vbml0b3JlZCB2aWEgZ3BpbwpsZXQgdGRvKCkgLT4gYm9vbCB7
CglyZXR1cm4gMDsKfQoKLy8gVERPIHVuYXZhaWxhYmxlCmxldCBzdGF0aWMgdGRvX2luaXQoKQp7
Cn0KCi8vIFJUQ0sgdW5hdmFpbGFibGUKbGV0IHJ0Y2soKSAtPiBib29sIHsgIHJldHVybiBmYWxz
ZTsgIH0KCmxldCBod19pbml0KCkgLT4gdm9pZAp7CglwYWRjb25mX3JlZ3MgPSAodTE2ICopbWFw
X3BoeXMoIDB4NDgwMCcyMDAwLCAweDEwMDAgKTsKCglpZiggaGFzX3RkbyApCgkJdGRvX2luaXQo
KTsKfQo=
--001a1133a5b4072585050ff369fb
Content-Type: text/x-chdr; charset=US-ASCII; name="hw-omap3.h"
Content-Disposition: attachment; filename="hw-omap3.h"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i6lg0dmv1

I3ByYWdtYSBvbmNlCiNpbmNsdWRlICJkZWZzLmgiCgoKbGV0IGh3X2luaXQoKSAtPiB2b2lkOwoK
Ci8vLS0tLS0tLS0tLS0tLS0gSlRBRyBwaW4gaS9vIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS8vCgovLyBjb250cm9sIEpUQUcgaW5wdXRzCmxldCB0cnN0
KCBib29sIG91dCApIC0+IHZvaWQ7CmxldCB0Y2soICBib29sIG91dCApIC0+IHZvaWQ7CmxldCB0
bXMoICBib29sIG91dCApIC0+IHZvaWQ7CmxldCB0ZGkoICBib29sIG91dCApIC0+IHZvaWQ7Cgov
LyBtb25pdG9yIEpUQUcgb3V0cHV0CmxldCB0ZG8oKSAtPiBib29sOwpsZXQgcnRjaygpIC0+IGJv
b2w7CgpsZXQgY29uc3RleHByIGhhc190ZG8gPSBmYWxzZTsKbGV0IGNvbnN0ZXhwciBoYXNfcnRj
ayA9IGZhbHNlOwoKCi8vLS0tLS0tLS0tLS0tLS0gRGVidWcgaHcgY29uZmlnIC0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS8vCgpjb25zdGV4cHIgdTMyIGlkY29k
ZV9tYXNrICA9IDB4MCdmZmZmJ2ZmZjsKY29uc3RleHByIHUzMiBpZGNvZGVfbWF0Y2ggPSAweDAn
YjdhZScwMmY7CgovLyBpbml0aWFsaXphdGlvbiBvZiBpY2VwaWNrIHJlZ2lzdGVycwpjb25zdGV4
cHIgdTMyIGljZXBpY2tfaW5pdF9yZWdzW10gPSB7CgkweDIzJzAwMjEwMCwgIC8vIGFzc2VydCBj
b3J0ZXgtYTggREJHRU4KfTsKCi8vIGFkZHJlc3Mgb2YgY29ydGV4LWE4IGRlYnVnIHJlZ3Mgb24g
ZGVidWcgQVBCCmNvbnN0ZXhwciB1MzIgYThfZGVidWcgPSAweDU0MDExJzAwMDsK
--001a1133a5b4072585050ff369fb
Content-Type: text/x-c++src; charset=US-ASCII; name="hw-usbblaster.cc"
Content-Disposition: attachment; filename="hw-usbblaster.cc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i6lg0dn02

I2luY2x1ZGUgImRlZnMuaCIKI2luY2x1ZGUgImh3LW9tYXAzLmgiCiNpbmNsdWRlICJkaWUuaCIK
CiNpbmNsdWRlIDxmdGRpLmg+CgovKiBzZWUgdXNiLWJsYXN0ZXItcHJvdG9jb2wudHh0ICovCiNk
ZWZpbmUgQkxBU1RFUl9UQ0sJKDEgPDwgMCkKI2RlZmluZSBCTEFTVEVSX1RNUwkoMSA8PCAxKQoj
ZGVmaW5lIEJMQVNURVJfTkNFCSgxIDw8IDIpCiNkZWZpbmUgQkxBU1RFUl9UREkJKDEgPDwgNCkK
I2RlZmluZSBCTEFTVEVSX0xFRAkoMSA8PCA1KQojZGVmaW5lIEJMQVNURVJfUkVBRAkoMSA8PCA2
KQoKc3RhdGljIHN0cnVjdCBmdGRpX2NvbnRleHQgZnRkaWM7CnN0YXRpYyB1OCBibGFzdGVyX2J5
dGU7CgovLy0tLS0tLS0tLS0tLS0tIEpUQUcgcGluIGkvbyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0vLwoKbGV0IHN0YXRpYyBzaW1faW5wdXQoIHU4IG1h
c2ssIGJvb2wgbGV2ZWwgKQp7CglpbnQgcmV0OwoKCWlmIChsZXZlbCkKCQlibGFzdGVyX2J5dGUg
fD0gbWFzazsKCWVsc2UKCQlibGFzdGVyX2J5dGUgJj0gfm1hc2s7CgoJcmV0ID0gZnRkaV93cml0
ZV9kYXRhKCZmdGRpYywgJmJsYXN0ZXJfYnl0ZSwgMSk7CglpZiAocmV0ICE9IDEpCgkJZGllKCJm
dGRpX3dyaXRlX2RhdGEgJWRcbiIsIHJldCk7Cn0KCi8vIEpUQUcgaW5wdXRzCmxldCB0cnN0KCBi
b29sIGxldmVsICkgLT4gdm9pZCB7ICBzaW1faW5wdXQoIEJMQVNURVJfTkNFLCBsZXZlbCApOyAg
fQpsZXQgdGNrKCAgYm9vbCBsZXZlbCApIC0+IHZvaWQgeyAgc2ltX2lucHV0KCBCTEFTVEVSX1RD
SywgbGV2ZWwgKTsgIH0KbGV0IHRtcyggIGJvb2wgbGV2ZWwgKSAtPiB2b2lkIHsgIHNpbV9pbnB1
dCggQkxBU1RFUl9UTVMsIGxldmVsICk7ICB9CmxldCB0ZGkoICBib29sIGxldmVsICkgLT4gdm9p
ZCB7ICBzaW1faW5wdXQoIEJMQVNURVJfVERJLCBsZXZlbCApOyAgfQoKLy8gSlRBRyBvdXRwdXQg
KFRETykKbGV0IHRkbygpIC0+IGJvb2wgewoJc3RhdGljIHU4IGJ5dGU7CglpbnQgcmV0OwoKCWRv
IHsKCQlyZXQgPSBmdGRpX3JlYWRfZGF0YSgmZnRkaWMsICZieXRlLCAxKTsKCX0KCXdoaWxlIChy
ZXQgPT0gMSk7CgoJaWYgKHJldCAhPSAwICYmIHJldCAhPSAxKQoJCWRpZSgiZnRkaV9yZWFkX2Rh
dGEgJWRcbiIsIHJldCk7CgoJcmV0dXJuIGJ5dGUgJiAxOwp9CgovLyBSVENLIHVuYXZhaWxhYmxl
CmxldCBydGNrKCkgLT4gYm9vbCB7ICByZXR1cm4gZmFsc2U7ICB9CgpsZXQgaHdfaW5pdCgpIC0+
IHZvaWQKewoJaWYgKGZ0ZGlfaW5pdCgmZnRkaWMpIDwgMCkKCQlkaWUoImZ0ZGlfaW5pdFxuIik7
CgoJaWYgKGZ0ZGlfdXNiX29wZW4oJmZ0ZGljLCAweDA5ZmIsIDB4NjAwMSkgPCAwKQoJCWRpZSgi
ZnRkaV91c2Jfb3BlblxuIik7CgoJaWYgKGZ0ZGlfdXNiX3Jlc2V0KCZmdGRpYykgPCAwKQoJCWRp
ZSgiZnRkaV91c2JfcmVzZXRcbiIpOwoKCWlmIChmdGRpX3NldF9sYXRlbmN5X3RpbWVyKCZmdGRp
YywgMikgPCAwKQoJCWRpZSgiZnRkaV9zZXRfbGF0ZW5jeV90aW1lclxuIik7CgoJZnRkaV9kaXNh
YmxlX2JpdGJhbmcoJmZ0ZGljKTsKCglibGFzdGVyX2J5dGUgPSBCTEFTVEVSX0xFRCB8IEJMQVNU
RVJfUkVBRDsKfQo=
--001a1133a5b4072585050ff369fb--
