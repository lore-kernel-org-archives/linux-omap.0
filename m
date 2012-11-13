From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 1/6] omap cleanup fixes for v3.8 merge window
Date: Mon, 12 Nov 2012 17:05:40 -0800
Message-ID: <20121113010539.GZ6801@atomide.com>
References: <pull-1352768345-815774>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:45292 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754213Ab2KMBFq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Nov 2012 20:05:46 -0500
Content-Disposition: inline
In-Reply-To: <pull-1352768345-815774>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <ton@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Tony Lindgren <ton@atomide.com> [121112 17:01]:
> The following changes since commit edf8dde393f879fc2d8c22d4bc01ff8d37b80e1a:
> 
>   Merge branch 'linus' into omap-for-v3.8/cleanup-headers-prepare-multiplatform-v3 (2012-11-09 14:58:01 -0800)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8/cleanup-fixes-signed
> 
> for you to fetch changes up to e05cf58d50e3ce3601ebf753728eee0df759e38f:
> 
>   ARM: OMAP2+: remove duplicated include from board-overo.c (2012-11-12 14:02:48 -0800)
> 
> ----------------------------------------------------------------
> Minor fixes to the clean-up done for ARM common multi-platform
> support for omaps.

FYI, some of the pull requests after this one may break
compile for omap2plus_defconfig when merging them in.

I suggest you pull requests 2 - 6 with --no-commit option and
make sure it builds after each pull if you have a chance.
Or I can follow up with fixes if needed.

If in doubt, I've pushded omap-for-v3.8/tmp-merge that's a
merge of v3.7-rc5 + recently pulled omap fixes + these pull
requests merged together for reference.

Cheers,

Tony
