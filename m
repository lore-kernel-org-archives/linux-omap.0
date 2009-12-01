From: Alexander Shishkin <virtuoso@slind.org>
Subject: Re: [PATCH v3 1/2] arm: a driver for on-chip ETM and ETB
Date: Tue, 1 Dec 2009 15:07:00 +0200
Message-ID: <20091201130700.GA27669@shisha.kicks-ass.net>
References: <1256230315-22340-1-git-send-email-virtuoso@slind.org>
 <20091030121024.GB15200@shisha.kicks-ass.net>
 <1257767290.21596.307.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp6.welho.com ([213.243.153.40]:53116 "EHLO smtp6.welho.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753676AbZLANH2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Dec 2009 08:07:28 -0500
Content-Disposition: inline
In-Reply-To: <1257767290.21596.307.camel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Nov 09, 2009 at 01:48:10 +0200, Artem Bityutskiy wrote:
> On Fri, 2009-10-30 at 14:10 +0200, Alexander Shishkin wrote:
> > On Thu, Oct 22, 2009 at 07:51:54PM +0300, Alexander Shishkin wrote:
> > > Changes:
> > > v3 -- major update:
> > >       * switched from platform device to AMBA device
> > >       * started using clk API in a more proper way
> > >       * changed omap3 Kconfig part to select the driver instead of depending
> > >         on it
> > 
> > Russell, I believe this one addresses your concerns about my previous patches.
> > Shall I wait for more comments from you or do you want me to upload them to
> > your patch tracker?
> 
> Alex, I suggest you to:
> 
> 1. Double check that you really addressed _everything_ Russel and others
> pointed - may be this is the reason why your patch is stuck.
> 
> 2. If you have addressed everything, upload the patch to the patch
> system. My (very limited) experience was that I re-sent a patch several
> times, got no response for long time, but then Russel simply asked me to
> upload it, and it was merged. Thus, the silence may simply mean "upload
> to the patch system".

Thanks for the hint. I've double checked the patches and I'm fairly sure I
have addressed all of the concerns expressed to the best of my ability. So
I did as you said: uploaded the patches to the patch tracker.

Regards,
--
Alex
