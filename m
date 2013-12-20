From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [GIT PULL] omap display regression fix against v3.13-rc4
Date: Fri, 20 Dec 2013 08:33:26 -0800
Message-ID: <8761qjiisp.fsf@linaro.org>
References: <20131218175057.GF27438@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:43431 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753342Ab3LTQd3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Dec 2013 11:33:29 -0500
Received: by mail-pd0-f174.google.com with SMTP id x10so2697421pdj.5
        for <linux-omap@vger.kernel.org>; Fri, 20 Dec 2013 08:33:28 -0800 (PST)
In-Reply-To: <20131218175057.GF27438@atomide.com> (Tony Lindgren's message of
	"Wed, 18 Dec 2013 09:50:58 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> The following changes since commit 319e2e3f63c348a9b66db4667efa73178e18b17d:
>
>   Linux 3.13-rc4 (2013-12-15 12:31:33 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.13/display-fix
>
> for you to fetch changes up to 130f769e81fc472beb2211320777e26050e3fa15:
>
>   Revert "ARM: OMAP2+: Remove legacy mux code for display.c" (2013-12-17 16:28:34 -0800)
>
> ----------------------------------------------------------------
> I accidentally removed some mux code for omap4 that I thought was
> dead code as omap4 has been booting with device tree only since
> v3.10. Turns out I also removed some display related mux code,
> so let's revert that except for the dead code parts.
>
> ----------------------------------------------------------------

Pulled into fixes,

Thanks,

Kevin
