From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] drop unused omap defines for v3.12 merge window
Date: Sun, 11 Aug 2013 16:39:10 -0700
Message-ID: <20130811233910.GG26757@quad.lixom.net>
References: <20130807110812.GK7656@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:54707 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755149Ab3HKXjy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 11 Aug 2013 19:39:54 -0400
Received: by mail-pb0-f52.google.com with SMTP id wz12so6194878pbc.25
        for <linux-omap@vger.kernel.org>; Sun, 11 Aug 2013 16:39:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130807110812.GK7656@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, khilman@linaro.org

[+khilman]

Since Kevin is stepping up and helping out with arm-soc, please restart
sending these to arm@kernel.org. I probably don't favor that behavior
by handling the pull requests in my inbox first though...


On Wed, Aug 07, 2013 at 04:08:12AM -0700, Tony Lindgren wrote:
> The following changes since commit 3b2f64d00c46e1e4e9bd0bb9bb12619adac27a4b:
> 
>   Linux 3.11-rc2 (2013-07-21 12:05:29 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.12/cleanup-unused-defines
> 
> for you to fetch changes up to dc46c79043a85624c78993919615abf743565ff5:
> 
>   Merge tag 'for-v3.11-rc/omap-fixes-a' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.12/cleanup (2013-07-31 01:12:49 -0700)

[...]

> So, for the few, the masochistic, out there who wish to continue
> developing TI PRCM code, I would ask that you resurrect any
> additionally-needed macros from these commits, rather than writing
> them manually.  Purely for the sake of a pleasant atavism, perhaps; the
> way one appreciates a used bookstore, or a video rental store...

Betamax or Video 2000?

But yes, very much available as a revert or in older checkouts if needed
in the future.

>  12 files changed, 10853 deletions(-)

beer_credit++;

Nice cleanup. Pulled.


-Olof
