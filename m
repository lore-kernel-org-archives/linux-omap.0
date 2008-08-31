From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [patch 2.6.27-rc3-omap1] omap2_nand updates
Date: Mon, 1 Sep 2008 00:54:08 +0300
Message-ID: <20080831215405.GM9887@frodo>
References: <200808311419.05598.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:51711 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333AbYHaVya (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 31 Aug 2008 17:54:30 -0400
Content-Disposition: inline
In-Reply-To: <200808311419.05598.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

On Sun, Aug 31, 2008 at 02:19:05PM -0700, David Brownell wrote:
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Minor updates to the OMAP{2,3} NAND driver:
> 
>  - Rename those buffer PIO routines as *_buf16()
>  - Get rid of pointless LE16 data conversions; OMAP is always LE
>  - Speed up buffer reads by switching to __raw_readsl()
> 
> Right now this driver only handles 16-bit NAND, but eventually it
> should handle 8-bit too.  Moreover it may be worth using DMA...
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Thanks Dave, I'll melded it up in my queue.

-- 
balbi
