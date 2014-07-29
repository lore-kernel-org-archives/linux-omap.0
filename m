From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap n900 regression fix for v3.16 rc series
Date: Tue, 29 Jul 2014 13:06:05 +0200
Message-ID: <3734846.Lhxg9X6PO8@wuerfel>
References: <20140729103223.GK29045@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:51723 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859AbaG2LGh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jul 2014 07:06:37 -0400
In-Reply-To: <20140729103223.GK29045@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, arm@kernel.org, linux-omap@vger.kernel.org

On Tuesday 29 July 2014 03:32:24 Tony Lindgren wrote:
> The following changes since commit 33753cd2ba41c72a0756edc5dc094d91602deda5:
> 
>   ARM: OMAP2+: gpmc: fix gpmc_hwecc_bch_capable() (2014-07-23 01:48:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.16/n900-regression
> 
> for you to fetch changes up to d937678ab625b0f63ce54b2b9b3e1cbd1b4a1b15:
> 
>   ARM: dts: Revert enabling of twl configuration for n900 (2014-07-29 00:16:25 -0700)
> 
> ----------------------------------------------------------------
> Minimal regression fix for n900 display that got broken with
> enabling of twl4030 PM features. Turns out more work is needed
> before we can enable twl4030 PM on n900.
> 
> I did not notice this earlier as I have my n900 in a rack
> and the display did not get enabled for device tree based booting
> until for v3.16.
> 
> 

Pulled into fixes branch, which I expect to send out later today.

Thanks,

	Arnd
