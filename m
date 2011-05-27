From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2] GPIO: OMAP: move to drivers/gpio
Date: Fri, 27 May 2011 02:25:33 -0600
Message-ID: <BANLkTinqEM-iDhgSMAnMB5uehkt=V1Qq+w@mail.gmail.com>
References: <1305898868-9188-1-git-send-email-khilman@ti.com>
 <1305898868-9188-3-git-send-email-khilman@ti.com> <20110527073529.GF31953@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:58680 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602Ab1E0IZx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 May 2011 04:25:53 -0400
Received: by pwi15 with SMTP id 15so703141pwi.19
        for <linux-omap@vger.kernel.org>; Fri, 27 May 2011 01:25:53 -0700 (PDT)
In-Reply-To: <20110527073529.GF31953@ponder.secretlab.ca>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>, linux-arm-kernel@lists.infradead.org

On Fri, May 27, 2011 at 1:35 AM, Grant Likely <grant.likely@secretlab.c=
a> wrote:
> On Fri, May 20, 2011 at 03:41:08PM +0200, Kevin Hilman wrote:
>> Move OMAP GPIO driver to drivers/gpio. =A0Builds whenever
>> CONFIG_ARCH_OMAP=3Dy.
>>
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>
> Patch unfortunately doesn't apply cleanly to Linus' tree. =A0There's
> been some changes to gpio.c compared to the tree this patch was
> prepared against.
>
> Also, if you use the -M flag when preparing the patch, then I'll be
> able to see what the changes are during the move, and fix things up
> intelligently if anything breaks.
>
> Can you respin and repost the series quickly?

While you're at it, can you name the moved file
drivers/gpio/gpio-omap.c?  ('-' instead of '_'.  Why, yes, I am a
nitpicker.)

g.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
