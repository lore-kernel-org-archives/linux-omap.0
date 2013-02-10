From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [GIT PULL] ARM: OMAP4: PM fixes and AESS integration for 3.9
Date: Sun, 10 Feb 2013 19:16:27 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1302101915220.2672@utopia.booyaka.com>
References: <alpine.DEB.2.00.1302081812040.28008@utopia.booyaka.com> <20130210170849.GM4801@atomide.com> <alpine.DEB.2.00.1302101814390.2672@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:58033 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096Ab3BJTQ2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Feb 2013 14:16:28 -0500
In-Reply-To: <alpine.DEB.2.00.1302101814390.2672@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Sun, 10 Feb 2013, Paul Walmsley wrote:

> Thanks.  Looks like the AESS hwmod used a leaf clock that was removed by 
> one of the earlier cleanup patches.  Will fix and send a new pull request 
> for this series based on what's now in the arm-soc omap/pm branch 
> (0e084c9c843320995b0e219f02880f910d439b37).

Just sent the updated pull request.  Turns out that it was possible to 
base it on v3.8-rc6.  Hopefully that should fix the boot regression; 
please let me know if that turns out not to be the case.


- Paul
