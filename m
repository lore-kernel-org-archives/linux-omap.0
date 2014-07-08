From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: more fixes for v3.16-rc
Date: Tue, 8 Jul 2014 01:07:56 -0700
Message-ID: <20140708080755.GY28884@atomide.com>
References: <alpine.DEB.2.02.1407071550570.28318@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:10203 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610AbaGHIH4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jul 2014 04:07:56 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1407071550570.28318@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [140707 08:54]:
> Hi Tony
> 
> The following changes since commit a497c3ba1d97fc69c1e78e7b96435ba8c2cb42ee:
> 
>   Linux 3.16-rc2 (2014-06-21 19:02:54 -1000)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.16-rc/omap-fixes-b
> 
> for you to fetch changes up to 6340c8720ce34f35b41a2e15d69fe3d755cb2104:
> 
>   ARM: OMAP2+: clock/dpll: fix _dpll_test_fint arithmetics overflow (2014-07-06 15:58:38 -0600)
> 
> ----------------------------------------------------------------
> Some miscellaneous fixes for OMAP clock code, DRA7xx device data, and
> PRCM code (when DSPBridge is used) for v3.16-rc.
> 
> Basic build, boot, and PM test logs are available here:
> 
> http://www.pwsan.com/omap/testlogs/prcm-a-v3.16-rc/20140706174258/

Thanks pulling into omap-for-v3.16/fixes.

Regards,

Tony
