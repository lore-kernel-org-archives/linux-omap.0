From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] pinctrl: Remove duplicate code in
 pinctrl_pm_select_state functions
Date: Tue, 16 Jul 2013 06:41:18 -0700
Message-ID: <20130716134118.GC7656@atomide.com>
References: <20130716090310.5541.36777.stgit@localhost>
 <20130716090529.5541.54331.stgit@localhost>
 <51E5475B.1050900@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51E5475B.1050900@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: linus.walleij@linaro.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Stephen Warren <swarren@wwwdotorg.org>
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [130716 06:22]:
> Hi Tony,
> 
> This patch causes boot failure when I've applied my patch
> "[RFC] ARM: OMAP2+: omap_device: add pinctrl handling"
> https://lkml.org/lkml/2013/6/21/309
>
> on top of it:

Hmm this patch alone removes duplicate code and if it causes
issues I must have made a typo somewhere.

I cannot see a typo though, but in your dmesg I see something..

> [    0.610565] PC is at pinctrl_pm_select_active_state+0x4/0xc

..looks like you have something applied for the active_state
that only gets introduced later on in this series.

Maybe you have the earlier version of drivers/base/pinctrl.c
active_state patch that was in linux next for a while but
got reverted as we noticed we had to rework some things?

So maybe try with v3.11-rc1 + these four patches + your
omap_device patch?

Regards,

Tony
