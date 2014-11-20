From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 2/2] omap prcm clean-up for v3.19
Date: Thu, 20 Nov 2014 12:08:02 +0100
Message-ID: <201411201208.02398.arnd@arndb.de>
References: <pull-1415725783-562282> <pull-1415725783-562282-2>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:64983 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbaKTLIh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Nov 2014 06:08:37 -0500
In-Reply-To: <pull-1415725783-562282-2>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: arm@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tuesday 11 November 2014, Tony Lindgren wrote:
> Clean-up series for omap PRCM (Power Reset Clock Module) from
> Tero Kristo to move things a bit closer to becoming a proper
> device driver.

Pulled into next/soc, as some of the changes seem slightly more invasive
than what I'd expect from a pure cleanup branch.

Please let me know if this needs to be put into cleanup instead because
some other patches are based on top.

Thanks,

	Arnd
