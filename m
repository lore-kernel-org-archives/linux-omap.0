From: twebb <taliaferro62@gmail.com>
Subject: Re: [PATCH 0/0] Add minimal omap34xx support
Date: Fri, 3 Oct 2008 11:52:53 -0400
Message-ID: <dbdb2ea60810030852h67b898a8p13b716f2e6c746e6@mail.gmail.com>
References: <1223035779-26306-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:63022 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754153AbYJCPwx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 11:52:53 -0400
Received: by wa-out-1112.google.com with SMTP id v27so834509wah.21
        for <linux-omap@vger.kernel.org>; Fri, 03 Oct 2008 08:52:53 -0700 (PDT)
In-Reply-To: <1223035779-26306-1-git-send-email-tony@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

> Hi all,
>
> Here are few patches to add minimal omap34xx support, and
> board files for Beagle and Overo boards.
>
> The minimal omap34xx support patch was previously posted here
> with the omap2 patches, this patch has some additions, such
> as sram support.
>
> For folks who are wondering what the Beagle and Overo boards
> are, here are some links:
>
> http://beagleboard.org/
> http://www.gumstix.net/Overo/cat/Overo/115.html
>

Where does the OMAP35x EVM fall into the mix?  I see that most patches
seem to be targeted, or at least tested, on the beagle, overo, or
omap3 sdp boards.  Do TI and/or Mistal (maker of OMAP35x EVM) do any
testing/verification of patches on the 35x EVM?

Thanks,
twebb
