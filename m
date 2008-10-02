From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] omap-keypad fixes for OMAP2
Date: Thu, 2 Oct 2008 09:12:39 +0300
Message-ID: <20081002061237.GB7942@atomide.com>
References: <1222925329-28117-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63448 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359AbYJBGJq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Oct 2008 02:09:46 -0400
Content-Disposition: inline
In-Reply-To: <1222925329-28117-1-git-send-email-peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@nokia.com> [081002 08:29]:
> Fixes for the omap-keypad driver on OMAP2
> 
> Peter Ujfalusi (2)
>   OMAP2: omap-keypad: interrupt disable fix
>   OMAP2: omap-keypad: Enable more than 6 rows
> 
>  drivers/input/keyboard/omap-keypad.c |    6 +-----
>  1 files changed, 1 insertions(+), 5 deletions(-)

Looks good to me, here's my ack:

Acked-by: Tony Lindgren <tony@atomide.com>

Can you please send your series to linux-input@vger.kernel.org
for inclusion into the mainline kernel? Also cc linux-omap list.

You might also want to also include other pending patches sitting in
linux-omap into your series so we get this driver into sync with
mainline too.

Thanks,

Tony
