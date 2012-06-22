From: Tony Lindgren <tony@atomide.com>
Subject: Re: N800 MMC broken on v3.5-rc3
Date: Fri, 22 Jun 2012 01:08:57 -0700
Message-ID: <20120622080857.GX12766@atomide.com>
References: <alpine.DEB.2.00.1206211216590.10198@utopia.booyaka.com>
 <alpine.DEB.2.00.1206211307120.10198@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64398 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754190Ab2FVIJA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Jun 2012 04:09:00 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1206211307120.10198@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [120621 12:12]:
> On Thu, 21 Jun 2012, Paul Walmsley wrote:
> 
> > 
> > N800 no longer mounts MMC on v3.5-rc3:
> > 
> > http://www.pwsan.com/omap/bootlogs/20120620/omap_cleanup_a_3.6__07b3a13957aa250ff5b5409b8ed756b113544112/n800_bootlog.txt
> > 
> > This broke at some point between v3.4-rc2 and v3.5-rc3.
> 
> Hmm looks like Tony has some fixes for this that will hopefully resolve 
> this problem as of -rc4.

Yes works now, those are already in mainline since last week.

Tony
