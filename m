From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 1/3] omap non-urgent fixes for v3.20
Date: Wed, 21 Jan 2015 16:49:57 -0800
Message-ID: <20150122004957.GD29014@quad.lixom.net>
References: <54b99dd1.a21a450a.3fbf.25c5SMTPIN_ADDED_BROKEN@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:56354 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531AbbAVAt6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Jan 2015 19:49:58 -0500
Received: by mail-pa0-f41.google.com with SMTP id kq14so4616423pab.0
        for <linux-omap@vger.kernel.org>; Wed, 21 Jan 2015 16:49:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <54b99dd1.a21a450a.3fbf.25c5SMTPIN_ADDED_BROKEN@mx.google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: arm@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Jan 16, 2015 at 03:21:20PM -0800, Tony Lindgren wrote:
> The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:
> 
>   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.20/fixes-not-urgent-pt1
> 
> for you to fetch changes up to 13efcb188984f69e1f97b4d9e7d3663fb782946f:
> 
>   ARM: OMAP2+: Disable omap3 PM init for ti81xx (2015-01-14 17:37:16 -0800)
> 
> ----------------------------------------------------------------
> Non-urgent fixes for omap variant dm816x that has been in a sorry
> broken half merged state for a few years now. This gets us to the
> point where we can boot it properly once the related SoC data is
> added. Note that we've already made dm816x device tree only by
> removing the known broken board file.
> 
> ----------------------------------------------------------------
> Tony Lindgren (6):
>       ARM: OMAP2+: Fix error handling for omap2_clk_enable_init_clocks
>       ARM: OMAP2+: Fix ti81xx devtype
>       ARM: OMAP2+: Fix ti81xx class type
>       ARM: OMAP2+: Fix dm814 and dm816 for clocks and timer init
>       ARM: OMAP2+: Fix reboot for 81xx
>       ARM: OMAP2+: Disable omap3 PM init for ti81xx

Merged, thanks.

-Olof
