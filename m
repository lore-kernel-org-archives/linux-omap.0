From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: omap: drop unused IRQ defines
Date: Sun, 10 Jun 2012 23:42:28 -0700
Message-ID: <20120611064228.GV12766@atomide.com>
References: <1339164612-24402-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:16769 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933Ab2FKGmc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jun 2012 02:42:32 -0400
Content-Disposition: inline
In-Reply-To: <1339164612-24402-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

* Felipe Balbi <balbi@ti.com> [120608 07:16]:
> twl[46]030 have been converted to sparse IRQ
> already, so we can remove the unused defines
> and drop some code from board-files.

Nice :)

> drivers/mtd/chips/cfi_cmdset_0001.c: In function 'cfi_intelext_write_words':
> include/linux/mtd/map.h:331:11: warning: 'r$x$0' may be used uninitialized in this function

This one I don't know if it's been fixed.

> WARNING: drivers/mmc/host/built-in.o(.devinit.text+0x2fc): Section mismatch in reference from the function mmc_omap_probe() to the function .init.text:mmc_omap_new_slot()
> The function __devinit mmc_omap_probe() references
> a function __init mmc_omap_new_slot().
> If mmc_omap_new_slot is only used by mmc_omap_probe then
> annotate mmc_omap_new_slot with a matching annotation.

The MMC related should be fixed and queued up.
 
> fs/ubifs/dir.c: In function 'ubifs_rename':
> fs/ubifs/dir.c:972:15: warning: 'saved_nlink' may be used uninitialized in this function
> net/mac80211/mlme.c: In function 'ieee80211_prep_connection':
> net/mac80211/mlme.c:3017:19: warning: 'sta' may be used uninitialized in this function

No idea about these.

Regards,

Tony
