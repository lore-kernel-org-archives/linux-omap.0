From: Kim Kyuwon <chammoru@gmail.com>
Subject: Question about OABI_COMPAT feature in do_signal() function
Date: Tue, 28 Apr 2009 17:23:19 +0900
Message-ID: <4d34a0a70904280123y6d0d95b6if5ddfdc3d2c09ca6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.226]:51542 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963AbZD1IXj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Apr 2009 04:23:39 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1708107rvb.5
        for <linux-omap@vger.kernel.org>; Tue, 28 Apr 2009 01:23:39 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, OMAP <linux-omap@vger.kernel.org>, =?EUC-KR?B?udqw5rnO?= <kyungmin.park@samsung.com>, Kevin Hilman <khilman@deeprootsystems.com>

Hello Russell,

It's an honor to mail you. I'm writing this mail to ask you about the
OABI_COMPAT feature in do_signal() function.
After freezing and thawing user processes for Suspend-To-Ram, I found
that some user processes(e.g. daemon processes) make prefetch abort
continuously. And finally, I found that the following code in
do_signal() was the root cause:

	/* arch/arm/kernel/signal.c: near 677 line */

	put_user(regs->ARM_pc, &usp[0]);
	/* swi __NR_restart_syscall */
	put_user(0xef000000 | swival, &usp[1]);
	/* ldr  pc, [sp], #12 */
	put_user(0xe49df00c, &usp[2]);

It seems that this code makes processes execute in stack area to
re-enter kernel area. However, when PC is in stack area, I saw that it
*continuously* make data abort exception. (Process stack area is in
general non executable area)

I'm using OMAP3430 board whose core is Cotex-A8 and with enabling both
CONFIG_AEABI and CONFIG_OABI_COMPAT.

Can I ask your comments or idea about this problem?

Regards,
Kyuwon (=B1=D4=BF=F8)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
