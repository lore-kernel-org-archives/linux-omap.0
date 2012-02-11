From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH] arm: omap4: allow disabling MPU local timer if 32K timer
 is enabled
Date: Sat, 11 Feb 2012 20:42:22 +0800
Message-ID: <CACVXFVPzbSodv35RT_+ykRgDN8hQrhdCfiTFqfspJwSgOiWv3w@mail.gmail.com>
References: <1328949085-4452-1-git-send-email-tom.leiming@gmail.com>
	<20120211100351.GB13587@n2100.arm.linux.org.uk>
	<CACVXFVNJ=L_H_whTm6AyEc++B=Tw_Jfnzmn-QRYwbbBqiH7H1g@mail.gmail.com>
	<20120211102644.GD13587@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:50922 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754996Ab2BKMmX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 11 Feb 2012 07:42:23 -0500
Received: by pbcun15 with SMTP id un15so3206867pbc.19
        for <linux-omap@vger.kernel.org>; Sat, 11 Feb 2012 04:42:22 -0800 (PST)
In-Reply-To: <20120211102644.GD13587@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, Feb 11, 2012 at 6:26 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Have you actually checked the tick rate of your timer in /proc/interrupts?
> Have you checked /proc/timer_list to see what mode the system is in?

After checking, the system works at periodic mode, but I still don't know why
it can't be in one shot mode.

Seems a single clock_event_device can't work well at system with more than
one CPU, so the patch doesn't make sense, please ignore it.


thanks,
-- 
Ming Lei
