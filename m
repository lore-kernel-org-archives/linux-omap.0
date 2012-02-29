From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 1/5] non-critical fixes for v3.4 merge window
Date: Wed, 29 Feb 2012 20:55:19 +0000
Message-ID: <201202292055.19803.arnd@arndb.de>
References: <pull-1330546506-268554>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:59765 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755959Ab2B2UzZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Feb 2012 15:55:25 -0500
In-Reply-To: <pull-1330546506-268554>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wednesday 29 February 2012, Tony Lindgren wrote:
> This contains fixes for MMC platform init to allow marking
> functions that should be __init as __init. Also included are
> some randconfig fixes.
> 
> Regards,
> 
> Tony
> 
> 
> The following changes since commit 6b21d18ed50c7d145220b0724ea7f2613abf0f95:
>   Linus Torvalds (1):
>         Linux 3.3-rc5
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes-non-critical
> 

Applied to next/fixes-non-critical

Thanks,

	Arnd
