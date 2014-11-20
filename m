From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 2/3] omap gpmc changes for v3.19
Date: Thu, 20 Nov 2014 12:02:41 +0100
Message-ID: <201411201202.41698.arnd@arndb.de>
References: <pull-1415814409-868361> <pull-1415814409-868361-2>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:50083 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbaKTLDC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Nov 2014 06:03:02 -0500
In-Reply-To: <pull-1415814409-868361-2>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: arm@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wednesday 12 November 2014, Tony Lindgren wrote:
> GPMC (General Purpose Memory Controller) changes for omaps. These
> changes allow us to drop dependencies to bootloader timings now
> that the known device tree entries have been fixed. So we can now
> require proper timings to be configured and get rid of the legacy
> smsc91x code.
> 
> Note that this branch has a dependency to the related device tree
> branch sent in a separate pull request as timings are now required.

Does this mean you are breaking compatibility with old dtb files?

Can you be more specific which machines are affected?

	Arnd
