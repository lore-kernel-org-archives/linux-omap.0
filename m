From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: Issues with ADATA SD cards on OMAP?
Date: Sun, 9 Jan 2011 09:14:46 -0800
Message-ID: <AANLkTik8wTknohEDfNnoYsZt8xuQRb48gUC7T_Xg+afz@mail.gmail.com>
References: <AANLkTinw=ZjiOr1KHNxu1Npq5iLucOPyw0Gumdyq1jjS@mail.gmail.com>
	<AANLkTi=SKb9wCUMyvvT59qYCMm8wViZRAYgtDOJXiLKy@mail.gmail.com>
	<B00BD5DB-31BB-42C8-B360-241173342F86@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:41761 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564Ab1AIROr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 Jan 2011 12:14:47 -0500
Received: by qyj19 with SMTP id 19so916474qyj.19
        for <linux-omap@vger.kernel.org>; Sun, 09 Jan 2011 09:14:46 -0800 (PST)
In-Reply-To: <B00BD5DB-31BB-42C8-B360-241173342F86@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: linux-omap Mailing List <linux-omap@vger.kernel.org>

On Sun, Jan 9, 2011 at 9:07 AM, Elvis Dowson <elvis.dowson@mac.com> wrote:
> Hi Steve,
>
> On Jan 9, 2011, at 9:00 PM, Steve Sakoman wrote:
>
>>> mmcblk0: error -110 sending read/write command, response 0x900, card
>>> status 0xe00
>
> Error -110 is ETIMEOUT.
>
> The card might be getting detected but not powering up, perhaps? something to do with
> voltage regulator setup or probably a bad mmc hardware port?

Not likely to be bad hardware since it fails the same way on multiple
Overo and Beagle boards.

And not likely to be a bad SD card, since the cards work perfectly on
my desktop and laptop.

I suspect something marginal in the mmc interface hw/config.  If you
look at the schematics for most boards the mmc card is directly
connected to the OMAP for signal lines, and the twl4030 for power.

As such, I'm not surprised that these cards fail with every OMAP3
board I've tried.

> I'm using a 2GB class 4 SanDisk microSD card with a custom beagle board, and tried it with
> android-2.6.32 kernel as well as mainline 2.6.37-rc7 kernel, it worked fine.

Sure, I have tons of SanDisk cards that work perfectly (and always
have).  It is the brand new, just out of the box Sandisk that fails.

Steve
