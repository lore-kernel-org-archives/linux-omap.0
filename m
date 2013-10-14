From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [GIT PULL 1/6] omap non-urgent fixes for v3.13 merge window
Date: Mon, 14 Oct 2013 15:27:18 -0700
Message-ID: <87mwmb4hfd.fsf@linaro.org>
References: <5258a9a0.0325310a.6fb0.ffffa19cSMTPIN_ADDED_BROKEN@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57622 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757728Ab3JNW1V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Oct 2013 18:27:21 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so7944918pbb.33
        for <linux-omap@vger.kernel.org>; Mon, 14 Oct 2013 15:27:21 -0700 (PDT)
In-Reply-To: <5258a9a0.0325310a.6fb0.ffffa19cSMTPIN_ADDED_BROKEN@mx.google.com>
	(Tony Lindgren's message of "Fri, 11 Oct 2013 18:44:57 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: arm@kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> The following changes since commit 15c03dd4859ab16f9212238f29dd315654aa94f6:
>
>   Linux 3.12-rc3 (2013-09-29 15:02:38 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.13/fixes-not-urgent-signed
>
> for you to fetch changes up to 8ff875e7f93e900e7a7e78f1c9c05a22b33c27cf:
>
>   ARM: mach-omap1: Fix omap1510_fpga_init_irq() implicit declarations. (2013-10-08 11:04:22 -0700)
>
> ----------------------------------------------------------------
> Fixes for omaps that were not considered urgent for the -rc series.
> Just minor build fixes, removal of dead code, and a patch to
> use the die ID for increasing boot time entropy.
>
> ----------------------------------------------------------------

Thanks, pulled into fixes-non-critical.

Kevin
