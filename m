From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: hwmod code and data changes for early
 v3.16-rc
Date: Mon, 16 Jun 2014 01:29:48 -0700
Message-ID: <20140616082948.GY17845@atomide.com>
References: <alpine.DEB.2.02.1406160317120.659@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:52429 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754525AbaFPI3u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Jun 2014 04:29:50 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1406160317120.659@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [140615 20:19]:
> Hi Tony,
> 
> The following changes since commit abf04af74a9f27a65172a43b43ccabcbc2bbdc39:
> 
>   Merge tag 'scsi-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi (2014-06-14 19:49:48 -0500)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.16-rc/omap-fixes-a
> 
> for you to fetch changes up to bf32c4ad9924e2d60a23de4a3c074f806bf2ef05:
> 
>   ARM: OMAP5: hwmod: Add ocp2scp3 and sata hwmods (2014-06-15 20:12:52 -0600)
> 
> ----------------------------------------------------------------
> Two OMAP hwmod patches for early v3.16-rc kernels.
> 
> There's one OMAP SoC integration fix for the AM43xx SoC, without
> which, IP blocks can't be placed into hard-reset.
> 
> There is also one OMAP5 SoC data addition patch that should have gone
> in for v3.16. Normally I wouldn't send this as part of an -rc series,
> since it's not technically a fix. But I'd like to make an exception in
> this case because:
> 
> - it's intended to go in very early in the v3.16-rc series (or even
> pre-rc1);
> 
> - it's a fairly small change;
> 
> - the impact is limited to a single SoC and a single device;
> 
> - the only reason that it didn't go in earlier is because it "slipped
> through the cracks," rather than for any technical reason.
> 
> Basic build, boot, and PM test logs are available here:
> 
> http://www.pwsan.com/omap/testlogs/hwmod-a-v3.16-rc/20140615201307/

Thanks, pulling into omap-for-v3.16/fixes. BTW, starting with -rc2
your off-idle tests should finally start working for some DT based
boards.

Regards,

Tony
