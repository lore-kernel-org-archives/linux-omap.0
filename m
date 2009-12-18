From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/8] OMAP3: clock: add clockdomains for UART1 & 2
Date: Thu, 17 Dec 2009 19:32:58 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912171932150.12561@utopia.booyaka.com>
References: <1258506313-17115-1-git-send-email-khilman@deeprootsystems.com> <1258506313-17115-2-git-send-email-khilman@deeprootsystems.com> <alpine.DEB.2.00.0911180357440.25515@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58473 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003AbZLRCc7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 21:32:59 -0500
In-Reply-To: <alpine.DEB.2.00.0911180357440.25515@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

Hi Kevin,

On Wed, 18 Nov 2009, Paul Walmsley wrote:

> On Tue, 17 Nov 2009, Kevin Hilman wrote:
> 
> > UART1 & 2 were missing clockdomains resulting in broken omap_hwmod
> > init for these devices.
> 
> also looks good, will add this to the fixes series.

My apologies, looks like I missed this one.  Will requeue for .33-rc2.


- Paul
