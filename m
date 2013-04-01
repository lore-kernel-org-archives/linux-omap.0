From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: standardize integration for AES &
 SHA/MD5 IP blocks for 3.10
Date: Mon, 1 Apr 2013 10:08:12 -0700
Message-ID: <20130401170811.GL10155@atomide.com>
References: <alpine.DEB.2.00.1303302244540.6436@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:29024 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751Ab3DARIO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Apr 2013 13:08:14 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1303302244540.6436@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [130330 15:51]:
> Hi Tony,
> 
> The following changes since commit 78e52e026d288aad88b46bff0d94b05e145c4583:
> 
>   ARM: OMAP2+: clock data: Remove CK_* flags (2013-03-18 09:57:39 -0600)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-devel-a-for-3.10
> 
> for you to fetch changes up to 1cb804b93f506dfba5fd684a8ea63706aaa8e709:
> 
>   ARM: AM33XX: hwmod: Update and uncomment AES0 module data (2013-03-30 15:52:17 -0600)
> 
> ----------------------------------------------------------------
> For OMAP2+ SoCs, convert the SHA/MD5 and AES accelerator integration
> code and data to use hwmod and omap_device. This is a prerequisite for
> moving the hwmod code out of arch/arm.
> 
> Basic test logs are available at:
> 
>    http://www.pwsan.com/omap/testlogs/sham_aes_integration_devel_3.10/20130330155313/

Thanks pulling into omap-for-v3.10/crypto.

Regards,

Tony
 
