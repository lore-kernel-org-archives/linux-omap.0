From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] OMAP: PM: voltage layer updates for v3.8
Date: Tue, 6 Nov 2012 17:08:10 -0800
Message-ID: <20121107010809.GX6801@atomide.com>
References: <87bofa1e11.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:30042 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753314Ab2KGBIM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Nov 2012 20:08:12 -0500
Content-Disposition: inline
In-Reply-To: <87bofa1e11.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>

* Kevin Hilman <khilman@deeprootsystems.com> [121106 15:58]:
> Tony,
> 
> Here's a set of voltage layer updates for v3.8.
> 
> This implements all the framework changes necessary to get
> auto-ret/auto-off working, but the main change to enable
> auto-ret/auto-off is awaiting the functional power state changes that
> are still under review/rework.
> 
> Also, this fixes that pesky VC warning about I2C config not matching
> other channels that was reported by Russell.
> 
> Kevin
> 
> 
> The following changes since commit 3d70f8c617a436c7146ecb81df2265b4626dfe89:
> 
>   Linux 3.7-rc4 (2012-11-04 11:07:39 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git tags/for_3.8-pm-voltage
> 
> for you to fetch changes up to df7cded30ced539d3b4e6bae9f3011d98c069d41:
> 
>   ARM: OMAP4: OPP: add OMAP4460 definitions (2012-11-05 15:31:49 -0800)
> 
> ----------------------------------------------------------------
> OMAP voltage layer updates towards supporting auto-retention/auto-off

Thanks pulling into omap-for-v3.8/pm.

Regards,

Tony

