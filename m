From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap2plus: Remove auto selection on PMICs
Date: Fri, 25 Feb 2011 10:16:40 -0800
Message-ID: <20110225181640.GA20560@atomide.com>
References: <1298463072-19891-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61242 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753577Ab1BYSQn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Feb 2011 13:16:43 -0500
Content-Disposition: inline
In-Reply-To: <1298463072-19891-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

* Sanjeev Premi <premi@ti.com> [110223 04:11]:
> The current implementation almost assumes that only
> TWL4030/TWL5030/TWl6030 are (or can be) used with the
> OMAP processors. This is, however, not true.

If selecting these on platforms that don't have twl
causes problems the problem should be fixed.

You can disable CONFIG_ARCH_OMAP2PLUS_TYPICAL, and
then these don't get selected.
 
> This patch removes the automatic selection of the PMIC
> from Kconfig. Current defaults are chosen in default
> configuration omap2plus_defconfig and can easily be
> added to configuration for any board, there should be
> no compile/run-time impact.

The reason for CONFIG_ARCH_OMAP2PLUS_TYPICAL is to
produce a booting kernel if you do the following:

$ echo CONFIG_ARCH_OMAP=y > .config
$ yes "" | ARCH=arm make oldconfig
$ ARCH=arm CROSS_COMPILE=mycompiler uImage

So I'd rather keep it around for now. In the long run
omap2plus_defconfig should build a working kernel with
everything as modules though..

BTW, looks like small patch is needed with the patches queued
in omap-for-linus to make the above compile. Will post
as a reply to this mail.

Regards,

Tony

