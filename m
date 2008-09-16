From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: OMAP support in mainline?
Date: Tue, 16 Sep 2008 21:41:12 +0300
Message-ID: <20080916184110.GA10733@frodo>
References: <87tzcgi1gv.fsf@nokia.com> <alpine.DEB.1.00.0809160906140.21341@utopia.booyaka.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:42087 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754375AbYIPSll (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2008 14:41:41 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0809160906140.21341@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kalle Valo <kalle.valo@nokia.com>, linux-omap@vger.kernel.org

On Tue, Sep 16, 2008 at 09:13:21AM -0600, Paul Walmsley wrote:
> On Tue, 16 Sep 2008, Kalle Valo wrote:
> 
> > Hello Linux OMAP community,
> > 
> > I have seen a lot of patches going to Russell and general talk about
> > mainline support. What is actually the current situation? Is there
> > hope to have good support in mainline soon? If yes, when?
> > 
> > Unsurprisingly I'm especially interested about N800/N810 support :)
> 
> Parts of N800/N810 are still broken in linux-omap tree.  At least sound 
> did not work as of early September, and MMC still emits errors as 
> described in:
> 
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg02499.html
> 
> Don't recall what the current LM8323 status is.

Bluetooth is also missing on mainline, but the driver needs some rework.

-- 
balbi
