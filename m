From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap fixes for v3.9-rc1
Date: Tue, 5 Mar 2013 22:28:24 +0000
Message-ID: <201303052228.24821.arnd@arndb.de>
References: <20130305172313.GB11806@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:61439 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755326Ab3CEW2b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Mar 2013 17:28:31 -0500
In-Reply-To: <20130305172313.GB11806@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Tuesday 05 March 2013, Tony Lindgren wrote:
> The following changes since commit 6dbe51c251a327e012439c4772097a13df43c5b8:
> 
>   Linux 3.9-rc1 (2013-03-03 15:11:05 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.9-rc1/fixes-signed
> 
> for you to fetch changes up to b0ad0995e92fdf6b25056da76c906c51bb06d6a5:
> 
>   ARM: OMAP: RX-51: add missing USB phy binding (2013-03-05 08:24:56 -0800)
> 
> ----------------------------------------------------------------
> Fix few regressions, omap3 pm init with device tree, and some
> issues with the legacy mux code.

Pulled into fixes branch, thanks!

	Arnd
