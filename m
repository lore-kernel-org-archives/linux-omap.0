From: "Tim Chen" <tim.chen.86@gmail.com>
Subject: Re: MTD partitions
Date: Thu, 13 Mar 2008 11:34:41 +0800
Message-ID: <9c1eb1b90803122034t199866b6occ07124e5e467b6e@mail.gmail.com>
References: <9c1eb1b90803120306u52ed28cdr4039cd772e901b3@mail.gmail.com>
	 <200803120316.56363.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from po-out-1718.google.com ([72.14.252.159]:31183 "EHLO
	po-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367AbYCMDem (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Mar 2008 23:34:42 -0400
Received: by po-out-1718.google.com with SMTP id b23so2724552poe.1
        for <linux-omap@vger.kernel.org>; Wed, 12 Mar 2008 20:34:41 -0700 (PDT)
In-Reply-To: <200803120316.56363.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: linux-omap@vger.kernel.org

Thanks, David,
I added the MTD partition information to board-($MYBOARD).c,
But kernel didn't show any MTD partition information during booting.
If I have to create the MTD partitions using MTD commands in u-boot first?
My u-boot is old, no MTD support, if that's the case, I'll port the
newer u-boot, then try again.
Thanks.

On Wed, Mar 12, 2008 at 6:16 PM, David Brownell <david-b@pacbell.net> wrote:
> On Wednesday 12 March 2008, Tim Chen wrote:
>  > What file should I add MTD partitions information to?
>  > Files in arch/arm/mach-omap1/ or drivers/mtd/maps?
>
>  Platform data in .../mach-omap1/board-$(MYBOARD).c should
>  give default partition data to the relevant NAND driver.
>
>  - Dave
>
>



-- 
--
Regards,
Tim.
