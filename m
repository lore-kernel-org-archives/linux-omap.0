From: Bjarne Steinsbo <bsteinsbo@gmail.com>
Subject: [PATCH 0/4] Omap-related warnings compiling current mainline 3.1-rc tree
Date: Thu, 4 Aug 2011 20:01:53 +0200
Message-ID: <CAFULf_yR-Z8p4CWaM6i1A9GedvRGG2omBG2TVtmma09n1jyHWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf307f37daa188dd04a9b1c614
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:65101 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856Ab1HDSBy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Aug 2011 14:01:54 -0400
Received: by vws1 with SMTP id 1so1319292vws.19
        for <linux-omap@vger.kernel.org>; Thu, 04 Aug 2011 11:01:53 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

--20cf307f37daa188dd04a9b1c614
Content-Type: text/plain; charset=ISO-8859-1

Compiling the current mainline tree (commit
288d5abec8314ae50fe6692f324b0444acae8486) produces some omap-related
warnings.  Most of them are harmless, and they are simple enough to
fix that even I can do it.  I hope..

The compiler warnings from running `make omap2plus_defconfig uImage
CONFIG_DEBUG_SECTION_MISMATCH=1':
...
  CC      arch/arm/mach-omap2/clock44xx_data.o
arch/arm/mach-omap2/clock44xx_data.c: In function 'omap4xxx_clk_init':
arch/arm/mach-omap2/clock44xx_data.c:3371: warning: 'cpu_clkflg' may
be used uninitialized in this function
...
  CC      arch/arm/mach-omap2/usb-musb.o
arch/arm/mach-omap2/usb-musb.c:71: warning: 'usb_musb_mux_init'
defined but not used
arch/arm/mach-omap2/usb-musb.c: In function 'usb_musb_init':
arch/arm/mach-omap2/usb-musb.c:141: warning: 'dev' may be used
uninitialized in this function
...
  CC      arch/arm/mach-omap2/display.o
arch/arm/mach-omap2/display.c: In function 'omap_display_init':
arch/arm/mach-omap2/display.c:101: warning: assignment from
incompatible pointer type
...
  LD      arch/arm/mach-omap2/built-in.o
WARNING: arch/arm/mach-omap2/built-in.o(.data+0x354d0): Section
mismatch in reference from the variable keypad_data to the (unknown
reference) .init.data:(unknown)
The variable keypad_data references
the (unknown reference) __initdata (unknown)

By applying the patches is this series, most of these warnings are gone.

The warning from omap_display has not been fixed.  I could do
something similar to what hsmmc.c is using, but I think this is
unnessarily complex.  I think the real fix for this warning is to make
the type of the returned value from
omap_pm_get_dev_context_loss_count() be the same as the prototype in
struct omap_dss_board_info.  I can't see why one should be u32, and
the other int.  However, I don't know which to fix..

The resulting kernel has been booted on a pandaboard.

Please note that commit a0bfa1373859e9d11dc92561a8667588803e42d8
introduces a typo in arch/arm/kernel/process.c, and this needs to be
fixed in order to even compile the kernel.  Please see attached patch.
 This patch is sufficient to make it compile, but probably not a
complete fix for the problems introduced by the changes to cpu_idle.
There is still a boot messages from lockdep pointing to cpu_idle.

Bjarne Steinsbo

--20cf307f37daa188dd04a9b1c614
Content-Type: application/octet-stream; name="0001-cpuidle-fix-typos.patch"
Content-Disposition: attachment; filename="0001-cpuidle-fix-typos.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gqxzqw8p0

RnJvbSA5MDdkZjExMzEyOGUzYWNmYjAyZjc1YjNiYWY2OTUwNjI4Zjc0YzA2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBCamFybmUgU3RlaW5zYm8gPGJzdGVpbnNib0BnbWFpbC5jb20+
CkRhdGU6IFRodSwgNCBBdWcgMjAxMSAxODozMjowNCArMDIwMApTdWJqZWN0OiBbUEFUQ0hdIGNw
dWlkbGU6IGZpeCB0eXBvcwoKRml4IHR5cG9zIGludHJvZHVjZWQgYnkgY29tbWl0IGEwYmZhMTM3
Mzg1OWU5ZDExZGM5MjU2MWE4NjY3NTg4ODAzZTQyZDguCkZ1bmN0aW9uIGlzIGNhbGxlZCBgY3B1
aWRsZV9pZGxlX2NhbGwnLCBub3QgYGNwdWlkbGVfY2FsbF9pZGxlJy4KLS0tCiBhcmNoL2FybS9r
ZXJuZWwvcHJvY2Vzcy5jIHwgICAgMiArLQogYXJjaC9zaC9rZXJuZWwvaWRsZS5jICAgICB8ICAg
IDIgKy0KIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2tlcm5lbC9wcm9jZXNzLmMgYi9hcmNoL2FybS9rZXJuZWwv
cHJvY2Vzcy5jCmluZGV4IGQ3ZWUwZDQuLjFhMzQ3ZjQgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL2tl
cm5lbC9wcm9jZXNzLmMKKysrIGIvYXJjaC9hcm0va2VybmVsL3Byb2Nlc3MuYwpAQCAtMTk3LDcg
KzE5Nyw3IEBAIHZvaWQgY3B1X2lkbGUodm9pZCkKIAkJCQljcHVfcmVsYXgoKTsKIAkJCX0gZWxz
ZSB7CiAJCQkJc3RvcF9jcml0aWNhbF90aW1pbmdzKCk7Ci0JCQkJaWYgKGNwdWlkbGVfY2FsbF9p
ZGxlKCkpCisJCQkJaWYgKGNwdWlkbGVfaWRsZV9jYWxsKCkpCiAJCQkJCXBtX2lkbGUoKTsKIAkJ
CQlzdGFydF9jcml0aWNhbF90aW1pbmdzKCk7CiAJCQkJLyoKZGlmZiAtLWdpdCBhL2FyY2gvc2gv
a2VybmVsL2lkbGUuYyBiL2FyY2gvc2gva2VybmVsL2lkbGUuYwppbmRleCAzYzQ1ZGUxLi4zMjEx
NGUwIDEwMDY0NAotLS0gYS9hcmNoL3NoL2tlcm5lbC9pZGxlLmMKKysrIGIvYXJjaC9zaC9rZXJu
ZWwvaWRsZS5jCkBAIC0xMDEsNyArMTAxLDcgQEAgdm9pZCBjcHVfaWRsZSh2b2lkKQogCQkJbG9j
YWxfaXJxX2Rpc2FibGUoKTsKIAkJCS8qIERvbid0IHRyYWNlIGlycXMgb2ZmIGZvciBpZGxlICov
CiAJCQlzdG9wX2NyaXRpY2FsX3RpbWluZ3MoKTsKLQkJCWlmIChjcHVpZGxlX2NhbGxfaWRsZSgp
KQorCQkJaWYgKGNwdWlkbGVfaWRsZV9jYWxsKCkpCiAJCQkJcG1faWRsZSgpOwogCQkJLyoKIAkJ
CSAqIFNhbml0eSBjaGVjayB0byBlbnN1cmUgdGhhdCBwbV9pZGxlKCkgcmV0dXJucwotLSAKMS43
LjEKCg==
--20cf307f37daa188dd04a9b1c614--
