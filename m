From: Paul Walmsley <paul@pwsan.com>
Subject: Re: N800 MMC broken on v3.5-rc3
Date: Thu, 21 Jun 2012 13:07:40 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206211307120.10198@utopia.booyaka.com>
References: <alpine.DEB.2.00.1206211216590.10198@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53956 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759961Ab2FUTHl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jun 2012 15:07:41 -0400
In-Reply-To: <alpine.DEB.2.00.1206211216590.10198@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

On Thu, 21 Jun 2012, Paul Walmsley wrote:

> 
> N800 no longer mounts MMC on v3.5-rc3:
> 
> http://www.pwsan.com/omap/bootlogs/20120620/omap_cleanup_a_3.6__07b3a13957aa250ff5b5409b8ed756b113544112/n800_bootlog.txt
> 
> This broke at some point between v3.4-rc2 and v3.5-rc3.

Hmm looks like Tony has some fixes for this that will hopefully resolve 
this problem as of -rc4.


- Paul
