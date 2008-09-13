From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 7/7][OMAP 3/4+] BRIDGE: set 0 for phys_mempool_* as
 default
Date: Sat, 13 Sep 2008 12:53:42 +0300 (EEST)
Message-ID: <20080913.125342.137248158.Hiroshi.DOYU@nokia.com>
References: <27F9C60D11D683428E133F85D2BB4A5344A4F051@dlee03.ent.ti.com>
	<20080913.074844.161898930.Hiroshi.DOYU@nokia.com>
	<20080913084740.GA7007@frodo>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:53672 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754946AbYIMJx7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 13 Sep 2008 05:53:59 -0400
In-Reply-To: <20080913084740.GA7007@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: x00omar@ti.com, linux-omap@vger.kernel.org

Hi Felipe,

From: "ext Felipe Balbi" <me@felipebalbi.com>
Subject: Re: [PATCH 7/7][OMAP 3/4+] BRIDGE: set 0 for phys_mempool_* as default
Date: Sat, 13 Sep 2008 11:47:40 +0300

> Hi Hiroshi,
> 
> On Sat, Sep 13, 2008 at 07:48:44AM +0300, Hiroshi DOYU wrote:
> > I think that this configuration name "FB_OMAP_CONSISTENT_DMA_SIZE"
> > sounds a bit strange because it is not specific to framebuffer.
> 
> I agree here, it's really not fb specific.
> 
> > So how about renaming this more generic name like
> > "OMAP_CONSISTENT_DMA_SIZE"? Or making "CONSISTENT_DMA_SIZE" itself
> > configurable in menuconfig?
> 
> For me it sounds like that value would change depending on the board, no?

Hm...this can be considered as a board specific, yes.

> So maybe that size should be set up during board init. Maybe bundled
> inside omapX_globals ??

This sounds reasonable to me. Since FB and IVA are the only modules
which depend on this size so far, expanding flexibility in menuconfig
may no be necessary.

    Hiroshi DOYU

