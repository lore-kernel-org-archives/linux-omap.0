From: Henry Chan <enli.chan@gmail.com>
Subject: Incorrect Register Offsets in OMAP Mailbox
Date: Tue, 07 Feb 2012 09:57:04 -0800
Message-ID: <4F3165F0.2010306@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020506030906000801080304"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:53359 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752276Ab2BGR47 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Feb 2012 12:56:59 -0500
Received: by daed14 with SMTP id d14so590727dae.19
        for <linux-omap@vger.kernel.org>; Tue, 07 Feb 2012 09:56:59 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------020506030906000801080304
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

Looks like the register offsets are incorrect in the OMAP mailbox code
(arch/arm/mach-omap2/mailbox.c) for the OMAP4_MAILBOX_IRQ* macros. The
discrepancy is with p.224 of TI document SPRUGX9 and p3891 of SWPU231K.
Patch attached.

My hardware hasn't come in yet, so I would appreciate it if anyone can
share their experience using this code.

Thanks.
-H
-- 
Henry Chan

--------------020506030906000801080304
Content-Type: text/x-patch;
 name="0001-Fix-mailbox-IRQ-offsets.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Fix-mailbox-IRQ-offsets.patch"

 arch/arm/mach-omap2/mailbox.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 609ea2d..4801e01 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -26,9 +26,9 @@
 #define MAILBOX_IRQSTATUS(u)		(0x100 + 8 * (u))
 #define MAILBOX_IRQENABLE(u)		(0x104 + 8 * (u))
 
-#define OMAP4_MAILBOX_IRQSTATUS(u)	(0x104 + 10 * (u))
-#define OMAP4_MAILBOX_IRQENABLE(u)	(0x108 + 10 * (u))
-#define OMAP4_MAILBOX_IRQENABLE_CLR(u)	(0x10c + 10 * (u))
+#define OMAP4_MAILBOX_IRQSTATUS(u)	(0x104 + 0x10 * (u))
+#define OMAP4_MAILBOX_IRQENABLE(u)	(0x108 + 0x10 * (u))
+#define OMAP4_MAILBOX_IRQENABLE_CLR(u)	(0x10c + 0x10 * (u))
 
 #define MAILBOX_IRQ_NEWMSG(m)		(1 << (2 * (m)))
 #define MAILBOX_IRQ_NOTFULL(m)		(1 << (2 * (m) + 1))


--------------020506030906000801080304
Content-Type: text/x-vcard; charset=utf-8;
 name="enli_chan.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="enli_chan.vcf"

begin:vcard
fn:Henry Chan
n:Chan;Henry
email;internet:enli.chan@gmail.com
tel;cell:(315) 834-2426
x-mozilla-html:FALSE
version:2.1
end:vcard


--------------020506030906000801080304--
