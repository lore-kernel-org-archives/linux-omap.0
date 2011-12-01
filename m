From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH 0/2 v2] ARM: OMAP1: Fix dpll1 reprogramming related issues
Date: Thu,  1 Dec 2011 21:13:00 +0100
Message-ID: <1322770382-30718-1-git-send-email-jkrzyszt@tis.icnet.pl>
References: <201112012023.04635.jkrzyszt@tis.icnet.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201112012023.04635.jkrzyszt@tis.icnet.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
List-Id: linux-omap@vger.kernel.org

After dpll1 reprogramming has been moved from setup_arch() to
kernel_init(), I've been observing several issues, resulting in
undesired system behaviour on my Amstrad Delta. This series fixes
those most important (2/5 and 5/5 v2 previously), with a "stuck at 60MHz
rate" issue going to be fixed with Tony's proposed solution instead of
my previous 3/5.

Janusz Krzysztofik (2):
  ARM: OMAP1: Fix ckctl value used for dpll1 defualt rate
  ARM: OMAP1: recalculate loops per jiffy after dpll1 reprogram

 arch/arm/mach-omap1/clock_data.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

-- 
1.7.3.4
