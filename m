From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: How to enable sys_clkout1 for use by brf6300
Date: Mon, 20 Sep 2010 11:04:38 -0700
Message-ID: <874odkxpe1.fsf@deeprootsystems.com>
References: <AANLkTim9o3XdNAK5shVm8u6wa8_0rV7i9PkR3-qgskYK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57311 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755881Ab0ITSEk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Sep 2010 14:04:40 -0400
Received: by iwn5 with SMTP id 5so4400188iwn.19
        for <linux-omap@vger.kernel.org>; Mon, 20 Sep 2010 11:04:40 -0700 (PDT)
In-Reply-To: <AANLkTim9o3XdNAK5shVm8u6wa8_0rV7i9PkR3-qgskYK@mail.gmail.com>
	(Peter Barada's message of "Sun, 19 Sep 2010 12:46:27 -0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peter.barada@gmail.com>
Cc: linux-omap@vger.kernel.org

Hi Peter,

Peter Barada <peter.barada@gmail.com> writes:

> I have a brf6300 that requires sys_clkout1, and I have it working fine
> right now, but if I enable CONFIG_OMAP_RESET_CLOCKS, then
> sys_clkou1 is disabled.

Yes, any unused clocks will be disabled.  Where "unused" means it has a
zero use-count (nobody has called clk_enable)

> How do I tell the system that I need sys_clkout1 enabled for the
> brf6300 chip to work?  Should I use "clk = clk_get(NULL,
> "sys_clkout1"); clk_enable(clk)'"?

Yes.

Did that not work for you?

Kevin
