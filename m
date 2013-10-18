From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [GIT PULL 2/2] omap changes for am43xx hwmod for v3.13 merge window
Date: Fri, 18 Oct 2013 07:53:22 -0700
Message-ID: <87d2n2wrz1.fsf@linaro.org>
References: <526041df.4740e50a.3954.5084SMTPIN_ADDED_MISSING@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:60375 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755632Ab3JROx1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Oct 2013 10:53:27 -0400
Received: by mail-pd0-f170.google.com with SMTP id x10so4779222pdj.15
        for <linux-omap@vger.kernel.org>; Fri, 18 Oct 2013 07:53:25 -0700 (PDT)
In-Reply-To: <526041df.4740e50a.3954.5084SMTPIN_ADDED_MISSING@mx.google.com>
	(Tony Lindgren's message of "Thu, 17 Oct 2013 13:00:21 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: arm@kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> The following changes since commit 254f57a92987b6cde6004f58d6b847813dfb9e0e:
>
>   ARM: OMAP5: hwmod: add missing ocp2scp hwmod data (2013-10-11 15:37:05 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.13/am43xx-hwmod-signed
>
> for you to fetch changes up to 811e7c87340b75dce5c488d9496075b00853942b:
>
>   Merge tag 'for-v3.13/am43xx-support' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.13/hwmod (2013-10-17 10:37:27 -0700)
>
> ----------------------------------------------------------------
>
> Changes needed for am43xx for the hwmod data.
>
> This will be the last new set of hwmod data for any SoC
> as future SoCs will use a driver and device tree based
> approach. But before that can be dealt with, we need to
> first sort out the pending driver/clk issues.
>
> Queued by Paul Walmsley <paul@pwsan.com>:
>
> Add hwmod and PRCM data for the TI AM43xx family of SoCs.
>
> Under normal circumstances, these patches would not be merged.
> The hwmod and PRCM data should be moved out either to DT data or
> to drivers/.  Also, the current implementation trades off lines
> of diff by dynamically rewriting static data at runtime, which is
> a bad practice - it causes future maintenance headaches.
> However, after speaking with my upstream, it sounds like it's
> better to merge these patches in their current state, due to long
> term considerations.
>
> Basic test logs are here:
>
> http://www.pwsan.com/omap/testlogs/am43xx_support_v3.13/20131015213706/
>
> Due to the lack of an AM43xx board and any available public
> documentation, it's impossible for me to review or test that
> platform in any meaningful way.  But at least the tests above
> verify that the patches don't affect existing platforms -
> particularly AM33xx.
>
> ----------------------------------------------------------------

Pulled into next/soc.

Thanks,

Kevin
