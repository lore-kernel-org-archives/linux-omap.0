From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] omap4: pandaboard: fix up mmc card detect logic
Date: Sat, 16 Oct 2010 11:12:06 +0300
Message-ID: <20101016111206.a361e0a7.jhnikula@gmail.com>
References: <1287149087-16656-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:64883 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752459Ab0JPILq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Oct 2010 04:11:46 -0400
Received: by ewy20 with SMTP id 20so2244856ewy.19
        for <linux-omap@vger.kernel.org>; Sat, 16 Oct 2010 01:11:45 -0700 (PDT)
In-Reply-To: <1287149087-16656-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: l-o <linux-omap@vger.kernel.org>, Dave <x0132446@ti.com>, Tony Lindgren <tony@atomide.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, Adrian Hunter <adrian.hunter@nokia.com>, Samuel Ortiz <sameo@linux.intel.com>

On Fri, 15 Oct 2010 08:24:47 -0500
Nishanth Menon <nm@ti.com> wrote:

> For MMC1 Controller, card detect interrupt source is
> twl6030 which is non-gpio. The card detect call back function provides
> card present/absent status by reading MMC Control register present
> on twl6030. This functionality was introduced in mfd tree on
> track to kernel.org
> 
> Sync pandaboard to the same and make mmc work.
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Madhusudhan Chikkature <madhu.cr@ti.com>
> Cc: Adrian Hunter <adrian.hunter@nokia.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> 
> Acked-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 
> Depends on 
> http://git.kernel.org/?p=linux/kernel/git/sameo/mfd-2.6.git;a=commitdiff;h=1bf5197061a4aec99e9fd4f92d4a543310f83585;hp=0c9b33e5a23e2053165c9e30ffff3b3a3cf1b2b8
> This patch probably should be squashed to that.
> 
>  arch/arm/mach-omap2/board-omap4panda.c |   15 ++++++++++++---
>  1 files changed, 12 insertions(+), 3 deletions(-)
> 
FWIW,

With the reference patch above and this I can mount the mmc root on
Panda EA1.

Tested-by: Jarkko Nikula <jhnikula@gmail.com>
