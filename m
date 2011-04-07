From: Hema Kalliguddi <hemahk@ti.com>
Subject: RE: What is missing from musb - linux-omap merge?
Date: Thu, 7 Apr 2011 14:38:06 +0530
Message-ID: <b84bb921d4bb8c258966c77406cc795b@mail.gmail.com>
References: <20110406162334.8dcb5a7d.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00151747849e67ff6f04a0507370
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:52995 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751832Ab1DGJIX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Apr 2011 05:08:23 -0400
Received: by mail-fx0-f49.google.com with SMTP id 14so1821337fxm.8
        for <linux-omap@vger.kernel.org>; Thu, 07 Apr 2011 02:08:21 -0700 (PDT)
In-Reply-To: <20110406162334.8dcb5a7d.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>, OMAP Linux discussion <linux-omap@vger.kernel.org>
Cc: Felipe Balbi <balbi@ti.com>

--00151747849e67ff6f04a0507370
Content-Type: text/plain; charset=ISO-8859-1

Hi,

>-----Original Message-----
>From: Jarkko Nikula [mailto:jhnikula@gmail.com]
>Sent: Wednesday, April 06, 2011 6:54 PM
>To: OMAP Linux discussion
>Cc: Felipe Balbi; Hema HK
>Subject: What is missing from musb - linux-omap merge?
>
>Hi
>
>I've been trying to hunt why the OMAP3 retention on Nokia N900 went
>broken in 2.6.39-rc and reason is somewhere around musb code merge with
>linux-omap code or vise versa.
>
I tried the core retention with v2.6.39-rc1 with OMAP3630Zoom3 board
and don't observe any issues. Core is transitioning to retention without
any issue,
with or without musb driver loaded.

But on OMAP3430SDP I am observing the crash when try to do
echo mem > /sys/power/state.

Attached is the fix for this issue and core transitions to retention.

When you say retention is not working can you please carify what is
happening?
are you trying in idle path retention or suspend/resume?

Regards,
Hema

>I bisected this into:
>
>commit 0df0914d414a504b975f3cc66ace0c16ef55b7f3
>Merge: 6899608 05f6894
>Author: Linus Torvalds <torvalds@linux-foundation.org>
>Date:   Thu Mar 17 19:28:15 2011 -0700
>
>    Merge branch 'omap-for-linus' of
>git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6
>
>Yep, there were conflicts resolved by Linus but those didn't look that
>they explain the problem.
>
>So then I went to check the linux-omap branch omap-for-linus that got
>pulled to vanilla. Top commit was:
>
>commit 05f689400ea5fa3d71af82f910c8b140f87ad1f3
>Merge: 17fe12c 02b7b94
>Author: Tony Lindgren <tony@atomide.com>
>Date:   Mon Mar 14 11:22:22 2011 -0700
>
>    Merge branches 'devel-mux' and 'devel-misc' into omap-for-linus
>
>Here retention and usb networking are working so all were fine in
>linux-omap in 2.6.38-rc7.
>
>Then back to vanilla and checking the usb pull.
>
>commit 971f115a50afbe409825c9f3399d5a3b9aca4381
>Merge: 2e270d8 500132a
>Author: Linus Torvalds <torvalds@linux-foundation.org>
>Date:   Wed Mar 16 15:04:26 2011 -0700
>
>    Merge branch 'usb-next' of
>git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb-2.6
>
>Yes, musb doesn't compile here... trivial build fix attached as it's
>not our interest now (but will bother all bisecters). Here retention
>works but usb networking doesn't.
>
>Then I went testing patches from linux-omap/omap-for-linus on top of
>vanilla commit that precedes the omap-for-linus pull:
>
>commit 6899608533410557e6698cb9d4ff6df553916e98
>Merge: 411f5c7 92c260f
>Author: Linus Torvalds <torvalds@linux-foundation.org>
>Date:   Thu Mar 17 19:13:18 2011 -0700
>
>    Merge branch 'for-linus' of
>git://codeaurora.org/quic/kernel/davidb/linux-ms
>
>Some amount of conflict resolving, mostly trivial, some testing and
>came around these commits (note local commit ids):
>
>commit 5cd15f0ba7594e4cd1dd01a100dc94013930a6a9
>Author: Hema HK <hemahk@ti.com>
>Date:   Thu Feb 17 12:07:17 2011 +0530
>
>    OMAP2430: hwmod data: Add USBOTG
>
>-> Retention ok
>
>commit 2d982bb2593ab64151c4a01758735e67d7db5d36
>Author: Hema HK <hemahk@ti.com>
>Date:   Thu Feb 17 12:07:18 2011 +0530
>
>    OMAP3xxx: hwmod data: Add USBOTG
>
>commit 6dc0c8ee8bdaac3ad11c4313431d8d7b3c886ede
>Author: Hema HK <hemahk@ti.com>
>Date:   Thu Feb 17 12:07:19 2011 +0530
>
>    AM35xx: hwmod data: Add USBOTG
>
>-> These don't boot
>
>commit 4bd3924ed10bef872e1fbfbb590fb7132df7dd4c
>Author: Hema HK <hemahk@ti.com>
>Date:   Thu Feb 17 12:07:21 2011 +0530
>
>    OMAP2+: musb: hwmod adaptation for musb registration
>
>-> Boots, usb networking works and but no retention
>
>
>Then arch/arm/mach-omap2 diff between
>
>vanilla 0df0914d414a504b975f3cc66ace0c16ef55b7f3 (l-o pull)
>and
>l-o 05f689400ea5fa3d71af82f910c8b140f87ad1f3 (for linus)
>
>doesn't show any suspicious to me. E.g. no differences in
>omap_hwmod_3xxx_data.c and clock3xxx_data.c changes are just those
>clock name changes that Linus complained. Rest seems to be unrelated.
>
> Kconfig                        |    1
> Makefile                       |    2
> board-3430sdp.c                |   10
> board-3630sdp.c                |   10
> board-4430sdp.c                |    1
> board-am3517crane.c            |   10
> board-am3517evm.c              |   12
> board-cm-t35.c                 |   10
> board-cm-t3517.c               |   10
> board-devkit8000.c             |   10
> board-igep0020.c               |   10
> board-igep0030.c               |   10
> board-omap3beagle.c            |   10
> board-omap3evm.c               |   14 -
> board-omap3pandora.c           |   10
> board-omap3stalker.c           |   10
> board-omap3touchbook.c         |   10
> board-omap4panda.c             |   11
> board-overo.c                  |   10
> board-zoom.c                   |   10
> clock3xxx_data.c               |   19 +
> clock44xx_data.c               |   10
> include/mach/board-zoom.h.orig |   11
> include/mach/debug-macro.S     |   13
> omap4-common.c                 |    7
> omap_phy_internal.c            |   29 +-
> pm.h                           |    2
> sleep24xx.S                    |    2
> sleep34xx.S                    |    2
> sram242x.S                     |    3
> sram243x.S                     |    3
> sram34xx.S                     |    1
> usb-ehci.c                     |  522
>-------------------------------------
> usb-host.c                     |  574
>+++++++++++++++++++++++++++++++++++++++++
> usb-musb.c                     |    3
> 35 files changed, 737 insertions(+), 645 deletions(-)
>
>These findings made me thinking are there some patch or patchset
>missing for musb as there are these musb build breakages and usb
>networking not working in mainline issues, retention breaks only when
>applying patches from linux-omap/omap-for-linus but what are ok in
>linux-omap 2.6.38-rc7?
>
>--
>Jarkko
>

--00151747849e67ff6f04a0507370
Content-Type: application/octet-stream; name="suspend-3430.patch"
Content-Disposition: attachment; filename="suspend-3430.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: 12973a8db2b61cde_0.1

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL211c2IvbXVzYl9jb3JlLmMgYi9kcml2ZXJzL3VzYi9t
dXNiL211c2JfY29yZS5jCmluZGV4IDYzMGFlN2YuLjJhZjQ1ZjAgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvdXNiL211c2IvbXVzYl9jb3JlLmMKKysrIGIvZHJpdmVycy91c2IvbXVzYi9tdXNiX2NvcmUu
YwpAQCAtMjM2Nyw3ICsyMzY3LDggQEAgc3RhdGljIGludCBtdXNiX3N1c3BlbmQoc3RydWN0IGRl
dmljZSAqZGV2KQogCQkgKi8KIAl9CiAKLQltdXNiX3NhdmVfY29udGV4dChtdXNiKTsKKwlpZiAo
IXBtX3J1bnRpbWVfc3VzcGVuZGVkKGRldikpCisJCW11c2Jfc2F2ZV9jb250ZXh0KG11c2IpOwog
CiAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmbXVzYi0+bG9jaywgZmxhZ3MpOwogCXJldHVybiAw
OwpAQCAtMjM3OCw3ICsyMzc5LDggQEAgc3RhdGljIGludCBtdXNiX3Jlc3VtZV9ub2lycShzdHJ1
Y3QgZGV2aWNlICpkZXYpCiAJc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiA9IHRvX3BsYXRm
b3JtX2RldmljZShkZXYpOwogCXN0cnVjdCBtdXNiCSptdXNiID0gZGV2X3RvX211c2IoJnBkZXYt
PmRldik7CiAKLQltdXNiX3Jlc3RvcmVfY29udGV4dChtdXNiKTsKKwlpZiAoIXBtX3J1bnRpbWVf
c3VzcGVuZGVkKGRldikpCisJCW11c2JfcmVzdG9yZV9jb250ZXh0KG11c2IpOwogCiAJLyogZm9y
IHN0YXRpYyBjbW9zIGxpa2UgRGFWaW5jaSwgcmVnaXN0ZXIgdmFsdWVzIHdlcmUgcHJlc2VydmVk
CiAJICogdW5sZXNzIGZvciBzb21lIHJlYXNvbiB0aGUgd2hvbGUgc29jIHBvd2VyZWQgZG93biBv
ciB0aGUgVVNCCg==
--00151747849e67ff6f04a0507370--
