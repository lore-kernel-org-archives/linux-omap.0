From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC/PATCH] OMAP PM: remove OMAP_PM_NONE config option
Date: Fri, 6 May 2011 10:16:44 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1105061016070.30136@utopia.booyaka.com>
References: <1304673087-24643-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60768 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256Ab1EFQQp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 May 2011 12:16:45 -0400
In-Reply-To: <1304673087-24643-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, khilman@ti.com, Jean Pihet <j-pihet@ti.com>

Salut Jean

On Fri, 6 May 2011, Jean Pihet wrote:

> The current code base is not linking with the OMAP_PM_NONE
> option set.
> Since the option OMAP_PM_NOOP provides a no-op/debug layer,
> OMAP_PM_NONE can be removed.
> OMAP_PM_NOOP is enabled by default by Kconfig.
> 
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

I'm okay with this but could you please base it on v2.6.39-rc6 so I can 
merge it here?

thanks


- Paul
