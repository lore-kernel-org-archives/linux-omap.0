From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 7/8] OMAP2PLUS:GPIO:Move gpio_init from board files to
 init_common_hw
Date: Thu, 1 Apr 2010 02:32:54 -0700
Message-ID: <20100401093253.GH31200@atomide.com>
References: <1270038239-1090-1-git-send-email-charu@ti.com>
 <1270038239-1090-2-git-send-email-charu@ti.com>
 <1270038239-1090-3-git-send-email-charu@ti.com>
 <1270038239-1090-4-git-send-email-charu@ti.com>
 <1270038239-1090-5-git-send-email-charu@ti.com>
 <1270038239-1090-6-git-send-email-charu@ti.com>
 <1270038239-1090-7-git-send-email-charu@ti.com>
 <1270038239-1090-8-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:54502 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754785Ab0DAJbB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Apr 2010 05:31:01 -0400
Content-Disposition: inline
In-Reply-To: <1270038239-1090-8-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charulatha V <charu@ti.com>
Cc: linux-omap@vger.kernel.org, rnayak@ti.com, paul@pwsan.com

* Charulatha V <charu@ti.com> [100331 05:15]:
> This is preparation for early platform device implementation
> for GPIO in OMAP2PLUS. This patch moves initialization of gpio
> from board files to omap2_init_common_hw API in io.c
> 
> Init_irq needs to be done before gpio_init, the init_irq
> is called before omap2_init_common_hw in board files

Nope. We want to call omap2_init_common_hw as early as
possible, otherwise the cpu detection won't work.

What omaps have you tested this series on?

Tony

