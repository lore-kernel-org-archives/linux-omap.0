From: Arno Steffen <arno.steffen@googlemail.com>
Subject: Re: Omap3 omap3_clk_lock_dpll5() problem
Date: Fri, 16 Jul 2010 13:49:37 +0200
Message-ID: <AANLkTil8CGy02pVDEClqblLtQCZnLlo5LJXbdjhpUK6W@mail.gmail.com>
References: <AANLkTinHudaXyhk3qc1sFydzZaGs3PZKW6DObw_acxOc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46934 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965214Ab0GPLti (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jul 2010 07:49:38 -0400
Received: by mail-bw0-f46.google.com with SMTP id 1so1166779bwz.19
        for <linux-omap@vger.kernel.org>; Fri, 16 Jul 2010 04:49:37 -0700 (PDT)
In-Reply-To: <AANLkTinHudaXyhk3qc1sFydzZaGs3PZKW6DObw_acxOc@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

> Reprogramming SDRC clock to 266000000 Hz
> dpll3_m2_clk rate change failed: -22
>
> Why I cant't let it run only on 322 MHz?

For this I could found an answer.
There is no entry for this frequency in

omap_sdrc_params mt46h32m32lf6_sdrc_params
(in arch/arm/mach-omap2/sdram-micron ....)
