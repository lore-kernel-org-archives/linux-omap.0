From: Shahar Lev <shahar@wizery.com>
Subject: Re: [PATCH] omap3evm: Add Mistral WL12XX config support
Date: Tue, 14 Jun 2011 16:26:06 +0300
Message-ID: <BANLkTikE_caRE9uD6KN7h7OcY4nyUoRk9g@mail.gmail.com>
References: <1308053788-25937-1-git-send-email-shahar@wizery.com>
	<20110614123359.GB23145@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:53084 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083Ab1FNN0H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jun 2011 09:26:07 -0400
Received: by eyx24 with SMTP id 24so2006027eyx.19
        for <linux-omap@vger.kernel.org>; Tue, 14 Jun 2011 06:26:06 -0700 (PDT)
In-Reply-To: <20110614123359.GB23145@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm <linux-arm-kernel@lists.infradead.org>

On Tue, Jun 14, 2011 at 3:34 PM, Tony Lindgren <tony@atomide.com> wrote:
>
> This your should try to remove as it won't work nicely for supporting
> various boards with the same kernel as we already do with
> omap2plus_defconfig.
>
> Can you somehow detect the daughter board dynamically and then
> set the flags?
>

We thought about multi-board kernels, but unfortunately have no
better solution, since there is no dynamic way to probe these cards.
Even worse, these cards sometimes come with different clocks in them,
hence the 2nd OMAP3EVM_MISTRAL_WL12XX_REFCLOCK entry we had to
introduce...

Maybe we should add two bootargs with which the user can override this
Kconfig configuration? This should allow using the same kernel binary
with different omap3evm boards.

It's a bit cumbersome though..
