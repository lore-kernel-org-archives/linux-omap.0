From: Luciano Coelho <coelho@ti.com>
Subject: Re: [PATCH 2.6.39] omap: board-4430sdp: revert hsmmc_info
 reordering
Date: Fri, 01 Apr 2011 11:24:14 +0300
Message-ID: <1301646254.1988.423.camel@cumari>
References: <1301640748-17161-1-git-send-email-coelho@ti.com>
	 <4D957C46.9020402@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:37434 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752123Ab1DAIXj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Apr 2011 04:23:39 -0400
Received: by eydd26 with SMTP id d26so1532494eyd.30
        for <linux-omap@vger.kernel.org>; Fri, 01 Apr 2011 01:23:37 -0700 (PDT)
In-Reply-To: <4D957C46.9020402@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kadiyala, Kishore" <kishore.kadiyala@ti.com>

On Fri, 2011-04-01 at 09:18 +0200, Cousson, Benoit wrote:
> On 4/1/2011 8:52 AM, Coelho, Luciano wrote:
> > The order in which the MMC cards are defined in the the 4430sdp board
> > file seems to have been mistakenly reorderded as part of an unrelated
> > patch.  In commit 0005ae73cfe44ee42d0be12a12cc82bf982f518e, where only
> > the dev_name was supposed to be changed, the mmc order was changed as
> > well.  This caused the external SD card reader not to be recognized,
> > at least on Blaze.
> >
> > This patch reverts this change so that the external SD card is
> > recognized again.
> >
> > Cc: Kishore Kadiyala<kishore.kadiyala@ti.com>
> > Cc: Benoit Cousson<b-cousson@ti.com>
> > Signed-off-by: Luciano Coelho<coelho@ti.com>
> > ---
> >
> > I have started investigating the cause for this problem, because it
> > seems to me that the value in the mmc element is what should matter,
> > but it doesn't seem to be the case.  I believe there is a bug
> > elsewhere, that causes the order of the array to matter, but I'm not
> > very familiar with hsmmc and I don't have much time right now to delve
> > into the problem, so I leave this to the omap people. ;) I can always
> > help testing if necessary.
> 
> I was about to make the same comment. Why does the order matter since we 
> have a .mmc field with that information? There is probably something 
> broken behind that.

That's my impression too.  From a bird's eye view, it seems that this
change should have worked.  But there's a bug somewhere, so it
doesn't. :(

-- 
Cheers,
Luca.

