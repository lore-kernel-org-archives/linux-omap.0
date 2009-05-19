From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: MMC card corruption during suspend/resume operation
Date: Tue, 19 May 2009 07:52:42 -0700
Message-ID: <87k54d87r9.fsf@deeprootsystems.com>
References: <B9DAA81F-383F-4DCE-88BD-E20F13F22EC1@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f202.google.com ([209.85.222.202]:43086 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228AbZESOwn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 10:52:43 -0400
Received: by pzk40 with SMTP id 40so249844pzk.33
        for <linux-omap@vger.kernel.org>; Tue, 19 May 2009 07:52:44 -0700 (PDT)
In-Reply-To: <B9DAA81F-383F-4DCE-88BD-E20F13F22EC1@mac.com> (Elvis Dowson's message of "Tue\, 19 May 2009 09\:03\:11 +0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: Linux OMAP Users <linux-omap@vger.kernel.org>

Elvis Dowson <elvis.dowson@mac.com> writes:

> Hi,
>         I have a problem with my TI OMAP 3503 platform, where the
> microSD card that I have, gets corrupted during a suspend/resume
> operation. Do the existing power management drivers, cleanly unmount/
> mount the mmc card during a suspend/resume operation?

Is your rootfs on MMC?  If so, be sure you have 
CONFIG_MMC_UNSAFE_RESUME=y in your .config.

MMC on rootfs on PM branch works fine for me on OMAP3 Beagle.

Kevin


> I am using the TI OMAP linux 2.6.29 kernel version, with the
> android-2.6.29 kernel updates. I have installed
>
> Doing a search for the mmc card corruption issues, it would appear
> that a lot of people are facing the same issues on other platforms as
> well. It appears to be a platform issue for both the older 1.1 and 1.5
> android versions.
>
> http://forum.xda-developers.com/archive/index.php/t-495899.html
>
> http://androidforums.com/updates-cupcakes/5202-did-cupcake-eat-my-sd-card.html
>
> http://forums.t-mobile.com/tmbl/board/message?board.id=Android3&message.id=10928
>
> The problem might be because of the application or system not cleanly
> un-mounting the mmc card, thus causing it to get corrupted, e.g during
> a suspend/resume operation.
>
> So, I thought I'd ask if the existing power management drivers do a
> clean mount/unmount when it does a suspend/resume operation.
>
> Best regards,
>
> Elvis
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
