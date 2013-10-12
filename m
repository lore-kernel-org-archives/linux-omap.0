From: Afzal Mohammed <afzal@ti.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: hwmod changes for v3.13
Date: Sat, 12 Oct 2013 15:48:02 +0530
Message-ID: <525921DA.8000708@ti.com>
References: <alpine.DEB.2.02.1310111659500.27397@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57922 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800Ab3JLKS1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 12 Oct 2013 06:18:27 -0400
In-Reply-To: <alpine.DEB.2.02.1310111659500.27397@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Paul,

On Friday 11 October 2013 10:30 PM, Paul Walmsley wrote:

> The following changes since commit d0e639c9e06d44e713170031fe05fb60ebe680af:
> 
>   Linux 3.12-rc4 (2013-10-06 14:00:20 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.13/hwmod
> 
> for you to fetch changes up to ace1e3ec4a2540c783e65884bb7be9cd45a0a295:
> 
>   ARM: AM33xx: hwmod: Add RNG module data (2013-10-09 09:02:51 -0600)
> 
> - ----------------------------------------------------------------
> Some OMAP hwmod changes for 3.13.  Significant changes here include:
> 
> - - support for moving some of the hwmod flags to DT data
> 
> - - support for the SSI, hardware spinlock, USB host/TLL, and RNG IP
>   blocks for various OMAPs
> 
> - - a fix that again decouples hwmod data changes from unrelated DT data
>   patchsets
> 
> Basic test logs are available at:
> 
> http://www.pwsan.com/omap/testlogs/prcm_fixes_v3.13/20131009094936/
> 
> The summary reports that the 4460varsomom boots are failing, but this looks
> incorrect - it's probably a bug in the validation scripts here.
> 
> - ----------------------------------------------------------------

Can you please consider AM43x PRCM basic support also for the coming
merge window. I have rebased the AM43x PRCM series over your
"for-v3.13/hwmod" tag and posted as v6. The series has been Acked-by
Tony and Rajendra. New version has been tested on real silicon in AM43x
EPOS EVM (previous versions were tested on presilicon platform).

Regards
Afzal
