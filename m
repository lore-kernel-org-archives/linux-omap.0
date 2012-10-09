From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv2 1/3] OMAP: VRFB: convert vrfb to platform device
Date: Tue, 09 Oct 2012 13:37:34 -0700
Message-ID: <87fw5n1iwh.fsf@deeprootsystems.com>
References: <1349785827-27055-1-git-send-email-tomi.valkeinen@ti.com>
	<1349785827-27055-2-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:38802 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391Ab2JIUhf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Oct 2012 16:37:35 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so5588697pad.19
        for <linux-omap@vger.kernel.org>; Tue, 09 Oct 2012 13:37:35 -0700 (PDT)
In-Reply-To: <1349785827-27055-2-git-send-email-tomi.valkeinen@ti.com> (Tomi
	Valkeinen's message of "Tue, 9 Oct 2012 15:30:24 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Archit Taneja <archit@ti.com>

Hi Tomi,

Tomi Valkeinen <tomi.valkeinen@ti.com> writes:

> This patch converts vrfb library into a platform device, in an effort to
> remove omap dependencies.
>
> The platform device is registered in arch/arm/plat-omap/fb.c and
> assigned resources depending on whether running on omap2 or omap3.
>
> The vrfb driver will parse those resources and use them to access vrfb
> configuration registers and the vrfb virtual rotation areas.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>

[...]

I was having a quick look at this for the context save/restore piece in
order to understand how this driver's context is being saved/restored.

Looking at mainline, I don't see where omap_vrfb_restore_context() is
being called currently.  Am I missing something?

Kevin



