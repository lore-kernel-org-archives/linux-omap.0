From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP AM33xx: fixes and IP block integration
 support for 3.9
Date: Sun, 10 Feb 2013 09:07:24 -0800
Message-ID: <20130210170724.GJ4801@atomide.com>
References: <alpine.DEB.2.00.1302081720360.28008@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:45489 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755316Ab3BJRH2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Feb 2013 12:07:28 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1302081720360.28008@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [130208 09:25]:
> Hi Tony,
> 
> The following changes since commit 88b62b915b0b7e25870eb0604ed9a92ba4bfc9f7:
> 
>   Linux 3.8-rc6 (2013-02-01 12:08:14 +1100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-devel-a-for-3.9
> 
> for you to fetch changes up to 169c82a294e3722eb1e82b7dac58b35fe2119b80:
> 
>   ARM: OMAP2: am33xx-hwmod: Fix "register offset NULL check" bug (2013-02-08 08:21:13 -0700)
> 
> ----------------------------------------------------------------
> Fixes and IP block support for the TI AM33xx family of SoCs.  These
> are prerequisites for power management and some PWM driver changes.
> 
> Basic test logs are available from:
> 
>    http://www.pwsan.com/omap/testlogs/am33xx_fixes_a_3.9/20130208084835/
> 
> although it must be noted that I am unable to test these patches on
> AM33xx due to an unknown problem with v3.8-rc kernels:
> 
>    http://www.mail-archive.com/linux-omap@vger.kernel.org/msg83525.html
> 

Thanks pulled into omap-for-v3.9/am33xx.

Tony
