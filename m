From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] omap fixes for linux next for v3.7 merge window
Date: Mon, 17 Sep 2012 19:37:49 -0700
Message-ID: <CAOesGMjadRQk0=DRZGvE6Lds4+ovFPMA3hQQZGYhe_GemEmycQ@mail.gmail.com>
References: <20120918022856.GN11762@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:41961 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932106Ab2IRChv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Sep 2012 22:37:51 -0400
Received: by wibhi8 with SMTP id hi8so3500398wib.1
        for <linux-omap@vger.kernel.org>; Mon, 17 Sep 2012 19:37:49 -0700 (PDT)
In-Reply-To: <20120918022856.GN11762@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi,

On Mon, Sep 17, 2012 at 7:28 PM, Tony Lindgren <tony@atomide.com> wrote:
> Hi Arnd & Olof,
>
> Here is the fix for the twl-core compile on non-omap
> platforms and few other fixes.
>
> This will probably cause a minor merge conflicts with
> the led changes merged in the arm-soc next/drivers branch
> as both linux/leds.h and linux/platform_data/gpio-omap.h
> now need to be included.
>
> Regards,
>
> Tony
>
>
> The following changes since commit 68cb700c59fae6cd539c9dc1e9f2584f671935a0:
>
>   ARM: OMAP1: Move SoC specific headers from plat to mach for omap1 (2012-09-12 18:06:31 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/cleanup-fixes-for-v3.7

Thanks, pulled in on top of next/cleanup. We might have missed the
-next train for the day though.


-Olof
