From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 01/11] OMAP2/3: PM: push core PM code from linux-omap
Date: Tue, 19 May 2009 11:55:41 -0700
Message-ID: <87r5yk6hxu.fsf@deeprootsystems.com>
References: <1242412851-16606-1-git-send-email-khilman@deeprootsystems.com>
	<1242412851-16606-2-git-send-email-khilman@deeprootsystems.com>
	<20090518133241.GH3067@n2100.arm.linux.org.uk>
	<87my9a8hxf.fsf@deeprootsystems.com>
	<20090518170656.GJ7042@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f191.google.com ([209.85.216.191]:32844 "EHLO
	mail-px0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753050AbZESSzn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 14:55:43 -0400
Received: by pxi29 with SMTP id 29so2566090pxi.33
        for <linux-omap@vger.kernel.org>; Tue, 19 May 2009 11:55:43 -0700 (PDT)
In-Reply-To: <20090518170656.GJ7042@n2100.arm.linux.org.uk> (Russell King's message of "Mon\, 18 May 2009 18\:06\:56 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Jouni Hogander <jouni.hogander@nokia.com>, Paul Walmsley <paul@pwsan.com>

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Mon, May 18, 2009 at 10:00:44AM -0700, Kevin Hilman wrote:
>> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
>> 
>> > On Fri, May 15, 2009 at 11:40:41AM -0700, Kevin Hilman wrote:
>> >> This patch is to sync the core linux-omap PM code with mainline.  This
>> >> code has evolved and been used for a while the linux-omap tree, but
>> >> the attempt here is to finally get this into mainline.
>> >> 
>> >> Following this will be a series of patches from the 'PM branch' of the
>> >> linux-omap tree to add full PM hardware support from the linux-omap
>> >> tree.
>> >> 
>> >> Much of this PM core code was written by Jouni Hogander with
>> >> significant contributions from Paul Walmsley as well as many others
>> >> from Nokia, Texas Instruments and linux-omap community.
>> >
>> > Overall comment, I think we need to rework the idle support code so
>> > that enable_hlt/disable_hlt can be used even when pm_idle has been
>> > overridden, rather than OMAP going off and inventing its own mechanisms.
>> 
>> Would adding:
>> 
>> 	if (hlt_counter)
>> 		cpu_relax();
>> 
>> to the beginning of omap*_pm_idle functions be sufficient?  That will
>> at least allow the hlt stuff to behave as expected.
>
> Yes, but the comment was also directed at the other functions which
> increment/decrement that atomic_t variable to enable/disable sleep mode.
>

Russell,

Do you have a preference in how to export the hlt_counter to
platform-specific code?

The patch below creates a can_hlt() function that can be called from
platform-specific idle code.

Kevin

>From 23c802a0a1e9bb24ca51af9cf18b972590f8d1dc Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@deeprootsystems.com>
Date: Tue, 19 May 2009 11:34:12 -0700
Subject: [PATCH] ARM: add can_hlt() for platform PM code to check before idling

When platform-specific code overrides pm_idle, the hlt_counter
is no longer used.  Create a can_hlt() check which returns
the hlt_counter so platform code can check it and thus
honor the requests of enable_hlt()/disable_hlt() users.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/include/asm/system.h |    1 +
 arch/arm/kernel/process.c     |    7 +++++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index bd4dc8e..ff9e2dd 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -313,6 +313,7 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
 
 extern void disable_hlt(void);
 extern void enable_hlt(void);
+extern int can_hlt(void);
 
 #include <asm-generic/cmpxchg-local.h>
 
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index c3265a2..1b414b8 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -68,6 +68,13 @@ void enable_hlt(void)
 
 EXPORT_SYMBOL(enable_hlt);
 
+int can_hlt(void)
+{
+	return !hlt_counter;
+}
+
+EXPORT_SYMBOL(can_hlt);
+
 static int __init nohlt_setup(char *__unused)
 {
 	hlt_counter = 1;
-- 
1.6.2.2

