From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH 00/13] ARM: OMAP2+: clock cleanup series for 3.17
Date: Sun, 13 Jul 2014 06:53:31 -0700
Message-ID: <20140713135331.9850.5226@quantum>
References: <1404290867-6768-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:62854 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642AbaGMNxi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 13 Jul 2014 09:53:38 -0400
Received: by mail-pd0-f180.google.com with SMTP id y13so1575390pdi.39
        for <linux-omap@vger.kernel.org>; Sun, 13 Jul 2014 06:53:38 -0700 (PDT)
In-Reply-To: <1404290867-6768-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org

Quoting Tero Kristo (2014-07-02 01:47:34)
> Hi,
> 
> This sets cleans up some of the omap specific clock drivers still residing
> under arch/arm/mach-omap2. This set is done in preparation to migrate
> these drivers eventually under drivers/clk/ti, where we don't have access
> to certain board specific functionality. The basic idea of this set is to
> introduce clk_features struct which contains any SoC specific data / flags
> within it, and this is used runtime instead of the current cpu_is_? checks.

Reviewed-by: Mike Turquette <mturquette@linaro.org>

> 
> There are also a couple of bug fixes introduced in this set:
> - Patch #1 : fix potential overflow in _dpll_test_fint
> - Patch #8 : embeds a fix for checking omap5/dra7 for the bypass modes also
> 
> Set tested on following boards:
> 
> - omap2430-sdp : boot
> - omap3-beagle : boot / suspend
> - omap4-panda-es : boot / suspend
> - omap5-uevm : boot
> - dra7-evm : boot
> 
> Branch also available:
> 
> tree: https://github.com/t-kristo/linux-pm.git
> branch: for-v3.17/omap2-clk-cleanup
> 
> -Tero
> 
