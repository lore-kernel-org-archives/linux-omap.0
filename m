From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] OMAP5: fix voltage domains, remove wrong data
Date: Wed, 26 Jun 2013 20:09:11 +0200
Message-ID: <201306262009.11317.arnd@arndb.de>
References: <87fvw4sya2.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:49217 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813Ab3FZSJp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Jun 2013 14:09:45 -0400
In-Reply-To: <87fvw4sya2.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Olof Johansson <olof@lixom.net>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Wednesday 26 June 2013, Kevin Hilman wrote:
> Arnd,
> 
> Below is a pull request with a patch that fixes the build breakage you reported
> related to voltage domains on OMAP5-only builds: https://patchwork.kernel.org/patch/2764191/
> 
> This applies on top of arm-soc/omap/omap5

Ok, pulled into next/soc (as already mentioned in the other thread, just for completeness here).

	Arnd
