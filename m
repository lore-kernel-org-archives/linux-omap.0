From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH 0/2] Minimal FAPLL clock support for dm816x
Date: Wed, 14 Jan 2015 14:06:49 -0800
Message-ID: <20150114220649.22722.26307@quantum>
References: <1421189488-9657-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:63658 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749AbbANWG5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Jan 2015 17:06:57 -0500
Received: by mail-pd0-f177.google.com with SMTP id ft15so12209819pdb.8
        for <linux-omap@vger.kernel.org>; Wed, 14 Jan 2015 14:06:57 -0800 (PST)
In-Reply-To: <1421189488-9657-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

Quoting Tony Lindgren (2015-01-13 14:51:26)
> Hi all,
> 
> Here's a minimal support for the FAPLL (Flying Adder PLL) on dm816x
> which is a omap variant.

Tony,

Patches look fine to me. I'll give it a few days for Paul or Tero to
comment if they have any concerns.

Also, "flying adder pll" is a pretty badass pll name.

Regards,
Mike

> 
> Regards,
> 
> Tony
> 
> 
> Tony Lindgren (2):
>   clk: ti: Add support for FAPLL on dm816x
>   clk: ti: Initialize clocks for dm816x
> 
>  .../devicetree/bindings/clock/ti/fapll.txt         |  33 ++
>  drivers/clk/ti/Makefile                            |   1 +
>  drivers/clk/ti/clk-3xxx.c                          |   8 +-
>  drivers/clk/ti/clk-816x.c                          |  53 +++
>  drivers/clk/ti/fapll.c                             | 410 +++++++++++++++++++++
>  5 files changed, 498 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/ti/fapll.txt
>  create mode 100644 drivers/clk/ti/clk-816x.c
>  create mode 100644 drivers/clk/ti/fapll.c
> 
> -- 
> 2.1.4
> 
