From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH RESEND] am33xx: cpsw: default to ethernet hwaddr from efuse if not defined in dt
Date: Thu, 05 Sep 2013 23:38:06 +0200
Message-ID: <87y57b0x1d.fsf@dell.be.48ers.dk>
References: <CAOesGMj7t4WAGtcE+PUau0OhANoGNdokCHpUoNF2t+hs+83iCg@mail.gmail.com>
	<1378415306-28821-1-git-send-email-jacmet@sunsite.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f169.google.com ([209.85.215.169]:49273 "EHLO
	mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753936Ab3IEViL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Sep 2013 17:38:11 -0400
Received: by mail-ea0-f169.google.com with SMTP id k11so1212150eaj.28
        for <linux-omap@vger.kernel.org>; Thu, 05 Sep 2013 14:38:09 -0700 (PDT)
In-Reply-To: <1378415306-28821-1-git-send-email-jacmet@sunsite.dk> (Peter
	Korsgaard's message of "Thu, 5 Sep 2013 23:08:26 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, olof@lixom.net, khilman@linaro.org, tony@atomide.com, mugunthanvnm@ti.com, mpfj-list@newflow.co.uk, koen@dominion.thruhere.net, matt.porter@linaro.org

>>>>> "Peter" == Peter Korsgaard <jacmet@sunsite.dk> writes:

 Peter> When booting with CONFIG_ARM_APPENDED_DTB (either because of using an old
 Peter> U-Boot, not wanting the hassle of 2 files or when using Falcon fast boot
 Peter> mode in U-Boot), nothing updates the ethernet hwaddr specified for the
 Peter> CPSW slaves, causing the driver to use a random hwaddr, which is some times
 Peter> troublesome.

 Peter> The am33xx has unique ethernet hwaddrs programmed in the efuse, so it makes
 Peter> more sense to default to these rather than random ones. Add a fixup step
 Peter> which adds mac-address dt properties using the efuse addresses if the DTB
 Peter> didn't contain valid ones.

 Peter> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
 Peter> Acked-by: Mugunthan V N <mugunthanvnm@ti.com>
 Peter> Tested-by: Mark Jackson <mpfj-list@newflow.co.uk>
 Peter> Tested-by: Koen Kooi <koen@dominion.thruhere.net>
 Peter> Tested-by: Matt Porter <matt.porter@linaro.org>
 Peter> ---
 Peter> Resent without changes.

Argh, this was supposed to have been a resend of v2. Will resend that
one instead.

-- 
Bye, Peter Korsgaard
