From: Luciano Coelho <coelho@ti.com>
Subject: Re: [PATCH 2.6.39] omap: board-4430sdp: revert hsmmc_info
 reordering
Date: Fri, 01 Apr 2011 11:20:40 +0300
Message-ID: <1301646040.1988.421.camel@cumari>
References: <1301640748-17161-1-git-send-email-coelho@ti.com>
	 <AANLkTikPawWg8Wt8F4oeEBbvUOziPNrH+7A3MyXkx8Lw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:51639 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754701Ab1DAIUF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Apr 2011 04:20:05 -0400
Received: by eyf5 with SMTP id 5so1179390eyf.15
        for <linux-omap@vger.kernel.org>; Fri, 01 Apr 2011 01:20:03 -0700 (PDT)
In-Reply-To: <AANLkTikPawWg8Wt8F4oeEBbvUOziPNrH+7A3MyXkx8Lw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishore Kadiyala <kishorek.kadiyala@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Kishore Kadiyala <kishore.kadiyala@ti.com>, Benoit Cousson <b-cousson@ti.com>

On Fri, 2011-04-01 at 12:46 +0530, Kishore Kadiyala wrote:
> On Fri, Apr 1, 2011 at 12:22 PM, Luciano Coelho <coelho@ti.com> wrote:
> > The order in which the MMC cards are defined in the the 4430sdp board
> > file seems to have been mistakenly reorderded as part of an unrelated
> > patch.  In commit 0005ae73cfe44ee42d0be12a12cc82bf982f518e, where only
> > the dev_name was supposed to be changed, the mmc order was changed as
> > well.  This caused the external SD card reader not to be recognized,
> > at least on Blaze.
> 
> Both OMAP4 SDP & Blaze boards have internal eMMC as storage.
> 
> Just think of some scenario as below with FS in  eMMC
> [with external card recognized as mmcblk0 and eMMC as mmcblk1]:
> Booting with both external card on MMC1 and eMMC on MMC2 and having
> bootargs set to root=/dev/mmcblk1px [x= parition number].
> Removing the external card from slot makes eMMC recognized as mmcblk0 and
> in this case kernel can't pick the file system as passed above in the bootargs.

Yes, this makes sense.  The internal eMMC should be mapped first, I
agree.


> So, making the permanent storage on the boards registered as first
> block device gets
> rid of the problem.

Yes, but there is something wrong that causes the external MMC not to be
recognized at all if you map the internal MMC first.  There is a bug
elsewhere that needs to be fixed before this change can be made.

As I said, I don't know much about the OMAP MMC subsystem and I don't
have the time right now to investigate what really is wrong.  That's why
I sent this patch, as quick fix (or rather getting rid of a regression).

Another thing is that this is a crosspatch change.  It shouldn't be part
of the same patch that changes the name of the driver, since this is
totally unrelated.  If you really think this needs to be done, it should
have been done in a separate patch.

-- 
Cheers,
Luca.

