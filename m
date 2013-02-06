From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.8-rc5
Date: Wed, 6 Feb 2013 23:19:05 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1302062318450.12769@utopia.booyaka.com>
References: <alpine.DEB.2.00.1301260838300.19277@utopia.booyaka.com> <20130126084604.GB8754@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38745 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755163Ab3BFXTG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Feb 2013 18:19:06 -0500
In-Reply-To: <20130126084604.GB8754@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, 26 Jan 2013, Felipe Balbi wrote:

> Hi,
> 
> On Sat, Jan 26, 2013 at 08:40:07AM +0000, Paul Walmsley wrote:
> > Boot tests:
> > 
> > * am335xbone: hangs after "Starting kernel"
> >   - Cause unknown; may be due to CONFIG_EARLY_PRINTK=y?
> >   - http://www.mail-archive.com/linux-omap@vger.kernel.org/msg82297.html
> >   - http://marc.info/?l=linux-omap&m=135903184512238&w=2
> 
> FYI, I don't think it's related to CONFIG_EARLY_PRINTK. Tested with and
> without it, also removed CONFIG_DEBUG_LL completely and nothing seemed
> to help my bone, no matter if I had appended DTB or not.

Thanks, I've adjusted the (upcoming) message for v3.8-rc6 accordingly.


- Paul
