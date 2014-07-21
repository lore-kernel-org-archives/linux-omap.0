From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: clock cleanup for 3.17
Date: Mon, 21 Jul 2014 00:58:03 -0700
Message-ID: <20140721075803.GQ18374@atomide.com>
References: <alpine.DEB.2.02.1407171817440.22427@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:19091 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752050AbaGUH73 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jul 2014 03:59:29 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1407171817440.22427@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [140717 11:20]:
> Hi Tony,
> 
> The following changes since commit a497c3ba1d97fc69c1e78e7b96435ba8c2cb42ee:
> 
>   Linux 3.16-rc2 (2014-06-21 19:02:54 -1000)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.17/omap-clock-a
> 
> for you to fetch changes up to acd052bb8119dd9117e0af48ff0ac6e56e61b6b4:
> 
>   ARM: OMAP2+: clock/interface: remove some headers from clkt_iclk.c file (2014-07-15 14:09:24 -0600)
> 
> ----------------------------------------------------------------
> An OMAP clock cleanup series for 3.17 from Tero Kristo.
> This is in preparation for moving this code into drivers/clk/ti.
> 
> Basic build, boot, and PM test logs are here:
> 
> http://www.pwsan.com/omap/testlogs/clock-a-v3.17/20140717034329/

Thanks pulling into omap-for-v3.17/soc.

Regards,

Tony
