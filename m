From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH/RFC 2/4] OMAP2: PM debug: remove register dumping
Date: Mon, 30 May 2011 10:05:10 +0200
Message-ID: <BANLkTikG1yExnfKGH6RsXU99MfTxGgiXww@mail.gmail.com>
References: <1306450971-27732-1-git-send-email-khilman@ti.com>
	<1306450971-27732-3-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:47068 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538Ab1E3IFL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 May 2011 04:05:11 -0400
Received: by qyg14 with SMTP id 14so1822510qyg.19
        for <linux-omap@vger.kernel.org>; Mon, 30 May 2011 01:05:10 -0700 (PDT)
In-Reply-To: <1306450971-27732-3-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, p-titiano@ti.com

On Fri, May 27, 2011 at 1:02 AM, Kevin Hilman <khilman@ti.com> wrote:
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> =A0arch/arm/mach-omap2/pm-debug.c | =A0119 --------------------------=
--------------
> =A0arch/arm/mach-omap2/pm.h =A0 =A0 =A0 | =A0 =A04 -
> =A0arch/arm/mach-omap2/pm24xx.c =A0 | =A0 =A06 +-
> =A03 files changed, 2 insertions(+), 127 deletions(-)
>
=2E..

OK for this change. Is it the intention to use the omapconf tool as
the replacement for the regs dump code?

Acked-by: Jean Pihet <j-pihet@ti.com>

Regards,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
