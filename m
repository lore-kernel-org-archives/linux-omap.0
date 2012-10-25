From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap fixes for v3.7-rc2
Date: Thu, 25 Oct 2012 14:26:58 +0000
Message-ID: <201210251426.58856.arnd@arndb.de>
References: <20121024184959.GI5605@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:55880 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759098Ab2JYO1C (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 10:27:02 -0400
In-Reply-To: <20121024184959.GI5605@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Wednesday 24 October 2012, Tony Lindgren wrote:
> 
> The following changes since commit 6f0c0580b70c89094b3422ba81118c7b959c7556:
> 
>   Linux 3.7-rc2 (2012-10-20 12:11:32 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.7-rc2/fixes-signed
> 
> for you to fetch changes up to 12ac7f9e117facfe128d6e569953fa73d2d676b3:
> 
>   ARM: AM33XX: Fix configuration of dmtimer parent clock by dmtimer driverDate:Wed, 17 Oct 2012 13:55:55 -0500 (2012-10-23 18:58:21 -0700)
> 
> ----------------------------------------------------------------
> Timer fix for am33xx, runtime PM fix for UART, audio McBSP fixes,
> mux and pinctrl fixes, and Beagle OPP fix.
> 

Applied to fixes branch, thanks!

	Arnd
