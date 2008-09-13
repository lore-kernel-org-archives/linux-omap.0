From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 7/7][OMAP 3/4+] BRIDGE: set 0 for phys_mempool_* as
	default
Date: Sat, 13 Sep 2008 11:47:40 +0300
Message-ID: <20080913084740.GA7007@frodo>
References: <27F9C60D11D683428E133F85D2BB4A5344A4F050@dlee03.ent.ti.com> <27F9C60D11D683428E133F85D2BB4A5344A4F051@dlee03.ent.ti.com> <20080913.074844.161898930.Hiroshi.DOYU@nokia.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:48144 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755203AbYIMIry (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 13 Sep 2008 04:47:54 -0400
Content-Disposition: inline
In-Reply-To: <20080913.074844.161898930.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: x00omar@ti.com, linux-omap@vger.kernel.org

Hi Hiroshi,

On Sat, Sep 13, 2008 at 07:48:44AM +0300, Hiroshi DOYU wrote:
> I think that this configuration name "FB_OMAP_CONSISTENT_DMA_SIZE"
> sounds a bit strange because it is not specific to framebuffer.

I agree here, it's really not fb specific.

> So how about renaming this more generic name like
> "OMAP_CONSISTENT_DMA_SIZE"? Or making "CONSISTENT_DMA_SIZE" itself
> configurable in menuconfig?

For me it sounds like that value would change depending on the board, no?
So maybe that size should be set up during board init. Maybe bundled
inside omapX_globals ??

-- 
balbi
