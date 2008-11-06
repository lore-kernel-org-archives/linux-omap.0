From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: 2.6.28-rc3 musb speed up (or not).
Date: Wed, 5 Nov 2008 22:05:43 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE89671620369A1FC43@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_13B9B4C6EF24D648824FF11BE89671620369A1FC43dlee02enttico_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34668 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751870AbYKFEGR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Nov 2008 23:06:17 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>

--_002_13B9B4C6EF24D648824FF11BE89671620369A1FC43dlee02enttico_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

Attached is an updated timer suppression patch for NO-HZ.  Thomas had fed b=
ack that some changes were necessary.

The good is with patch testusb goes from 45.4sec to 10.9sec to move a fixed=
 amount of data.

The bad is I found it necessary to remove a different in-kernel hack for ti=
ck_nohz_kick_tick().  Kernel comments for this new function say it's a hack=
 to work around badly behaved long running soft-irqs.  Any thing waiting in=
 irq context spinning on jiffies seems pretty bad.

Code was added 17 Oct 08:
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcomm=
itdiff;h=3Dfb02fbc14d17837b4b7b02dbb36142c16a7bf208

Does anyone have any thoughts on fixing the kick part?

Really all interrupts during idle will benefit from the combined patch.  US=
B is just the worst case as its moving so little data per interrupt in its =
current mode.

I'll send a couple pictures in a separate mail.

alias o=3D'./testusb -a -t 1 -c 6250 -s 16384'

L-O: 2.6.28-rc3-oma1-05153-g13c444a
------------------------------------
[root@localhost tst]# o

 ENTERED MAIN()...
unknown speed   /proc/bus/usb/001/019

 NAME OF DEVICE TO TEST --> [/proc/bus/usb/001/019]

->test 1 1

/proc/bus/usb/001/019 test 1,   45.458298 secs
[root@localhost tst]#
[root@localhost tst]#

L-O (+ rkw/tglx-patch) 2.6.28-rc3-oma1-05153-g13c444a
[root@localhost tst]# o

[root@localhost tst]# o

 ENTERED MAIN()...
unknown speed   /proc/bus/usb/001/004

 NAME OF DEVICE TO TEST --> [/proc/bus/usb/001/004]

->test 1 1
/proc/bus/usb/001/004 test 1,   10.945926 secs

Regards,
Richard W.

--_002_13B9B4C6EF24D648824FF11BE89671620369A1FC43dlee02enttico_
Content-Type: application/octet-stream; name="suppress_tick_no_kick.diff"
Content-Description: suppress_tick_no_kick.diff
Content-Disposition: attachment; filename="suppress_tick_no_kick.diff";
	size=2466; creation-date="Wed, 05 Nov 2008 22:29:18 GMT";
	modification-date="Wed, 05 Nov 2008 22:29:18 GMT"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2tlcm5lbC90aW1lL3RpY2stc2NoZWQuYyBiL2tlcm5lbC90aW1lL3RpY2st
c2NoZWQuYwppbmRleCA1YmJiMTA0Li5iMTgwMWRkIDEwMDY0NAotLS0gYS9rZXJuZWwvdGltZS90
aWNrLXNjaGVkLmMKKysrIGIva2VybmVsL3RpbWUvdGljay1zY2hlZC5jCkBAIC0yODIsOCArMjgy
LDI2IEBAIHZvaWQgdGlja19ub2h6X3N0b3Bfc2NoZWRfdGljayhpbnQgaW5pZGxlKQogCS8qIFNj
aGVkdWxlIHRoZSB0aWNrLCBpZiB3ZSBhcmUgYXQgbGVhc3Qgb25lIGppZmZpZSBvZmYgKi8KIAlp
ZiAoKGxvbmcpZGVsdGFfamlmZmllcyA+PSAxKSB7CiAKKwkJLyoKKwkJKiBjYWxjdWxhdGUgdGhl
IGV4cGlyeSB0aW1lIGZvciB0aGUgbmV4dCB0aW1lciB3aGVlbAorCQkqIHRpbWVyLiBkZWx0YV9q
aWZmaWVzID49IE5FWFRfVElNRVJfTUFYX0RFTFRBIHNpZ25hbHMKKwkJKiB0aGF0IHRoZXJlIGlz
IG5vIHRpbWVyIHBlbmRpbmcgb3IgYXQgbGVhc3QgZXh0cmVtbHkKKwkJKiBmYXIgaW50byB0aGUg
ZnV0dXJlICgxMiBkYXlzIGZvciBIWj0xMDAwKS4gSW4gdGhpcworCQkqIGNhc2Ugd2Ugc2V0IHRo
ZSBleHBpcnkgdG8gdGhlIGVuZCBvZiB0aGUgdW5pdmVyc2UuCisJCSovCisJCWlmIChkZWx0YV9q
aWZmaWVzIDwgTkVYVF9USU1FUl9NQVhfREVMVEEpCisJCQlleHBpcmVzID0ga3RpbWVfYWRkX25z
KGxhc3RfdXBkYXRlLCB0aWNrX3BlcmlvZC50djY0ICoKKwkJCQkJICAgICAgIGRlbHRhX2ppZmZp
ZXMpOworCQllbHNlCisJCQlleHBpcmVzLnR2NjQgPSBLVElNRV9NQVg7CisKIAkJaWYgKGRlbHRh
X2ppZmZpZXMgPiAxKQogCQkJY3B1X3NldChjcHUsIG5vaHpfY3B1X21hc2spOworCisJCS8qIFNr
aXAgcmVwcm9ncmFtIG9mIGV2ZW50IGlmIGl0IGhhcyBub3QgY2hhbmdlZCAqLworCQlpZiAodHMt
PnRpY2tfc3RvcHBlZCAmJiBrdGltZV9lcXVhbChleHBpcmVzLCBkZXYtPm5leHRfZXZlbnQpKQor
CQkJZ290byBvdXQ7CisKIAkJLyoKIAkJICogbm9oel9zdG9wX3NjaGVkX3RpY2sgY2FuIGJlIGNh
bGxlZCBzZXZlcmFsIHRpbWVzIGJlZm9yZQogCQkgKiB0aGUgbm9oel9yZXN0YXJ0X3NjaGVkX3Rp
Y2sgaXMgY2FsbGVkLiBUaGlzIGhhcHBlbnMgd2hlbgpAQCAtMzE5LDI3ICszMzcsMTcgQEAgdm9p
ZCB0aWNrX25vaHpfc3RvcF9zY2hlZF90aWNrKGludCBpbmlkbGUpCiAKIAkJdHMtPmlkbGVfc2xl
ZXBzKys7CiAKKwkJdHMtPmlkbGVfZXhwaXJlcyA9IGV4cGlyZXM7CisKIAkJLyoKLQkJICogZGVs
dGFfamlmZmllcyA+PSBORVhUX1RJTUVSX01BWF9ERUxUQSBzaWduYWxzIHRoYXQKLQkJICogdGhl
cmUgaXMgbm8gdGltZXIgcGVuZGluZyBvciBhdCBsZWFzdCBleHRyZW1seSBmYXIKLQkJICogaW50
byB0aGUgZnV0dXJlICgxMiBkYXlzIGZvciBIWj0xMDAwKS4gSW4gdGhpcyBjYXNlCi0JCSAqIHdl
IHNpbXBseSBzdG9wIHRoZSB0aWNrIHRpbWVyOgorCQkgKiBObyBhY3RpdmUgdGltZXJzID8KIAkJ
ICovCi0JCWlmICh1bmxpa2VseShkZWx0YV9qaWZmaWVzID49IE5FWFRfVElNRVJfTUFYX0RFTFRB
KSkgewotCQkJdHMtPmlkbGVfZXhwaXJlcy50djY0ID0gS1RJTUVfTUFYOworCQlpZiAodW5saWtl
bHkoZXhwaXJlcy50djY0ID09IEtUSU1FX01BWCkpIHsKIAkJCWlmICh0cy0+bm9oel9tb2RlID09
IE5PSFpfTU9ERV9ISUdIUkVTKQogCQkJCWhydGltZXJfY2FuY2VsKCZ0cy0+c2NoZWRfdGltZXIp
OwogCQkJZ290byBvdXQ7CiAJCX0KIAotCQkvKgotCQkgKiBjYWxjdWxhdGUgdGhlIGV4cGlyeSB0
aW1lIGZvciB0aGUgbmV4dCB0aW1lciB3aGVlbAotCQkgKiB0aW1lcgotCQkgKi8KLQkJZXhwaXJl
cyA9IGt0aW1lX2FkZF9ucyhsYXN0X3VwZGF0ZSwgdGlja19wZXJpb2QudHY2NCAqCi0JCQkJICAg
ICAgIGRlbHRhX2ppZmZpZXMpOwotCQl0cy0+aWRsZV9leHBpcmVzID0gZXhwaXJlczsKLQogCQlp
ZiAodHMtPm5vaHpfbW9kZSA9PSBOT0haX01PREVfSElHSFJFUykgewogCQkJaHJ0aW1lcl9zdGFy
dCgmdHMtPnNjaGVkX3RpbWVyLCBleHBpcmVzLAogCQkJCSAgICAgIEhSVElNRVJfTU9ERV9BQlMp
OwpAQCAtNTY4LDYgKzU3NiwxMCBAQCBzdGF0aWMgdm9pZCB0aWNrX25vaHpfc3dpdGNoX3RvX25v
aHoodm9pZCkKICAqLwogc3RhdGljIHZvaWQgdGlja19ub2h6X2tpY2tfdGljayhpbnQgY3B1KQog
eworI2lmIDAKKworLy8gaXMgaXQgcG9zc2libGUgdG8gb25seSB0dXJuIHRoaXMgb24gaWYgYW55
IHNvZnRpcnFzIGFyZSBzY2hlZHVsZWQgb3IgcGVuZGluZz8KKwogCXN0cnVjdCB0aWNrX3NjaGVk
ICp0cyA9ICZwZXJfY3B1KHRpY2tfY3B1X3NjaGVkLCBjcHUpOwogCWt0aW1lX3QgZGVsdGEsIG5v
dzsKIApAQCAtNTg0LDYgKzU5Niw3IEBAIHN0YXRpYyB2b2lkIHRpY2tfbm9oel9raWNrX3RpY2so
aW50IGNwdSkKIAkJcmV0dXJuOwogCiAJdGlja19ub2h6X3Jlc3RhcnQodHMsIG5vdyk7CisjZW5k
aWYKIH0KIAogI2Vsc2UK

--_002_13B9B4C6EF24D648824FF11BE89671620369A1FC43dlee02enttico_--
