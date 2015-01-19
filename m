From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP: hwmod fixes for v3.19-rc
Date: Mon, 19 Jan 2015 11:43:06 -0800
Message-ID: <20150119194305.GE18552@atomide.com>
References: <alpine.DEB.2.02.1501042334250.28771@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:47055 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751630AbbASTqe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jan 2015 14:46:34 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1501042334250.28771@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [150104 15:38]:
> Hi Tony
> 
> The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:
> 
>   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.19-rc/omap-fixes-a
> 
> for you to fetch changes up to 99d076b747455449b2eec9e37f3fb0bfdf51af32:
> 
>   MAINTAINERS: add maintainer for OMAP hwmod data (2015-01-02 16:24:27 -0700)
> 
> ----------------------------------------------------------------
> For v3.19-rc, fix some hwmod structure details for the OMAP DSS modules
> for DRA7xx and AM43xx.  Also update the MAINTAINERS file to encourage
> folks to cc me on hwmod data patches.
> 
> Basic build, boot, and PM testlogs are available here:
> 
> http://www.pwsan.com/omap/testlogs/omap-fixes-a-for-v3.19-rc/20150103144242/

Paul, got any updates on this? Anyways, I'll just untag this email as
you asked me to wait on pulling this.

Regards,

Tony
 
> ----------------------------------------------------------------
> Paul Walmsley (1):
>       MAINTAINERS: add maintainer for OMAP hwmod data
> 
> Tomi Valkeinen (2):
>       ARM: AM43xx: hwmod: set DSS submodule parent hwmods
>       ARM: DRA7xx: hwmod: set DSS submodule parent hwmods
> 
>  MAINTAINERS                                | 6 ++++++
>  arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 2 ++
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c  | 2 ++
>  3 files changed, 10 insertions(+)
> 
