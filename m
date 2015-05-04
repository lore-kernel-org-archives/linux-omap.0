From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] one n900 audio regression fix for v4.0-rc cycle
Date: Mon, 4 May 2015 13:35:56 -0700
Message-ID: <20150504203555.GA4810@atomide.com>
References: <20150403230344.GA18048@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:49064 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752431AbbEDUf6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 May 2015 16:35:58 -0400
Content-Disposition: inline
In-Reply-To: <20150403230344.GA18048@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [150403 16:08]:
> The following changes since commit 599c376c49323127c9bdbb0fa61a3d4743819bc2:
> 
>   ARM: dts: Fix gpio interrupts for dm816x (2015-03-18 13:41:34 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/oamp-for-v4.0/fix-audio
> 
> for you to fetch changes up to 6f7cedbdac1278e1bacfb9ef79769178fcd6a0b3:
> 
>   ARM: dts: OMAP3-N900: Add microphone bias voltages (2015-04-01 12:32:40 -0700)
> 
> ----------------------------------------------------------------
> One audio regression fix for n900 that would be good to get
> into v4.0 as people are already playing with audio call support
> for n900 using mainline kernel.

Looks like this did not make it so please just ignore this one.
I'll send a new pull request for fixes with this patch in it.

Regards,

Tony
