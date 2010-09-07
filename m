From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH 0/6] ARM: l2x0: kexex, cleanup and optimisation
Date: Tue, 7 Sep 2010 20:18:59 +0200
Message-ID: <AANLkTi=chtedwbDDJnZOe5yTqobUeXz=aZYUNNUDpQQm@mail.gmail.com>
References: <1283846243-11600-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:40519 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756862Ab0IGSTA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Sep 2010 14:19:00 -0400
Received: by qyk33 with SMTP id 33so5617051qyk.19
        for <linux-omap@vger.kernel.org>; Tue, 07 Sep 2010 11:19:00 -0700 (PDT)
In-Reply-To: <1283846243-11600-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, tglx@linutronix.de, linux-omap@vger.kernel.org, per.xx.fransson@stericsson.com

2010/9/7 Santosh Shilimkar <santosh.shilimkar@ti.com>:

> This series is just repost adding Catalin's ack to the patches and
> combining Thomas's two rebased kexec patches.
> It's generated against the mainline 2.6.36-rc3 + Catalin's
> "[PATCH 0/9] Various patches for 2.6.37-rc1" series.
>
> Santosh Shilimkar (4):
> =A0omap4: l2x0: Override the default l2x0_disable
> =A0ARM: l2x0: Fix coding-style in the cache-l2x0.h
> =A0ARM: l2x0: Determine the cache size
> =A0ARM: l2x0: Optimise the range based operations
>
> Thomas Gleixner (2):
> =A0arm: Disable outer (L2) cache in kexec
> =A0arm: Implement l2x0 cache disable functions

=46WIW:
Acked-by: Linus Walleij <linus.walleij@stericsson.com>

Can you also include the patch by Per Fransson I sent off to
Thomas and the list just a few days ago with the subject
"[PATCH] ARM: ux500 specific L2 cache code"
in this patch series?

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
