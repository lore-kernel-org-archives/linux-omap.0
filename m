From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [GIT PULL 6/6] omap soc changes for v3.13 merge window
Date: Mon, 14 Oct 2013 15:45:12 -0700
Message-ID: <8761sz4glj.fsf@linaro.org>
References: <5258a9ab.e703310a.12ff.2a82SMTPIN_ADDED_MISSING@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:52242 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757846Ab3JNWpP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Oct 2013 18:45:15 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz1so8139778pad.2
        for <linux-omap@vger.kernel.org>; Mon, 14 Oct 2013 15:45:15 -0700 (PDT)
In-Reply-To: <5258a9ab.e703310a.12ff.2a82SMTPIN_ADDED_MISSING@mx.google.com>
	(Tony Lindgren's message of "Fri, 11 Oct 2013 18:44:59 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: arm@kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> The following changes since commit d0e639c9e06d44e713170031fe05fb60ebe680af:
>
>   Linux 3.12-rc4 (2013-10-06 14:00:20 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.13/soc-take2
>
> for you to fetch changes up to d5da94b88efebc375bfcbab6bb0e59a6e8a6571e:
>
>   ARM: OMAP2+: Fix build error for realtime counter init if not enabled (2013-10-11 17:28:04 -0700)
>
> ----------------------------------------------------------------
> SoC related changes for omaps to support the realtime
> counter on newer omaps, and to fail early for omap5 es1.0
> SoCs that don't have any support merged for them in the
> mainline tree.
>
> ----------------------------------------------------------------

Pulled into next/soc,

Thanks,

Kevin
