From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2 v2] ARM: OMAP1: Fix dpll1 reprogramming related
 issues
Date: Thu, 1 Dec 2011 18:09:37 -0800
Message-ID: <20111202020936.GY31337@atomide.com>
References: <201112012023.04635.jkrzyszt@tis.icnet.pl>
 <1322770382-30718-1-git-send-email-jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1322770382-30718-1-git-send-email-jkrzyszt@tis.icnet.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [111201 11:38]:
> After dpll1 reprogramming has been moved from setup_arch() to
> kernel_init(), I've been observing several issues, resulting in
> undesired system behaviour on my Amstrad Delta. This series fixes
> those most important (2/5 and 5/5 v2 previously), with a "stuck at 60MHz
> rate" issue going to be fixed with Tony's proposed solution instead of
> my previous 3/5.
> 
> Janusz Krzysztofik (2):
>   ARM: OMAP1: Fix ckctl value used for dpll1 defualt rate
>   ARM: OMAP1: recalculate loops per jiffy after dpll1 reprogram
> 
>  arch/arm/mach-omap1/clock_data.c |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)

Thanks, got these three patches now applied into fixes on top of -rc4.

Can you please try it out to make sure it's all working for you now?

Tony
