From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [GIT PULL] ARM: OMAP: more hwmod/PRCM fixes for 3.7-rc
Date: Wed, 31 Oct 2012 10:58:05 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210311057041.4160@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210311050040.4160@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:51218 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711Ab2JaK6G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Oct 2012 06:58:06 -0400
In-Reply-To: <alpine.DEB.2.00.1210311050040.4160@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony

On Wed, 31 Oct 2012, Paul Walmsley wrote:

> The following changes since commit 8f0d8163b50e01f398b14bcd4dc039ac5ab18d64:
> 
>   Linux 3.7-rc3 (2012-10-28 12:24:48 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-fixes-b-for-3.7-rc
> 
> for you to fetch changes up to 945365c4da8c29bbb0109a728e6dca691d78a5de:
> 
>   ARM: OMAP4: hwmod data: do not enable or reset the McPDM during kernel init (2012-10-29 22:13:44 -0600)

Kevin just alerted me that I missed one of the comments on one of these 
patches.  So, will update it, re-test, and send a new pull request.


- Paul
