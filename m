From: Paul Bolle <pebolle@tiscali.nl>
Subject: ARM: OMAP3: MACH_OMAP3517EVM?
Date: Tue, 20 Jan 2015 10:03:17 +0100
Message-ID: <1421744597.9655.92.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cpsmtpb-ews01.kpnxchange.com ([213.75.39.4]:50801 "EHLO
	cpsmtpb-ews01.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750777AbbATJDU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Jan 2015 04:03:20 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Valentin Rothberg <valentinrothberg@gmail.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Tony,

Your commit 4d62dbda8561 ("ARM: OMAP3: Remove legacy support for
am3517-evm") is included in today's linux-next (ie, next-20150120). I
noticed because a script I use to check linux-next spotted a problem
caused by it.

See, your commit removes the Kconfig symbol MACH_OMAP3517EVM. But
there's still a reference to that symbol in sound/soc/omap/Kconfig. This
means that in linux-next a symbol, SND_OMAP_SOC_AM3517EVM, cannot be set
anymore.

I assume a patch that address this (either by removing
SND_OMAP_SOC_AM3517EVM or by updating its dependencies) is queued
somewhere. Is that correct?

Thanks,


Paul Bolle

