From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP2-only kernel compile broken
Date: Mon, 11 Jul 2011 00:31:30 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107110030120.18599@utopia.booyaka.com>
References: <alpine.DEB.2.00.1107091955040.15984@utopia.booyaka.com> <20110710095216.GN31978@legolas.emea.dhcp.ti.com> <alpine.DEB.2.00.1107100541110.15984@utopia.booyaka.com> <20110711062112.GA2680@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52209 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756588Ab1GKGbb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jul 2011 02:31:31 -0400
In-Reply-To: <20110711062112.GA2680@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: hemahk@ti.com, tony@atomide.com, linux-omap@vger.kernel.org

On Mon, 11 Jul 2011, Felipe Balbi wrote:

> What on earth is arm-soc omap/cleanup branch ? I generally base my
> patches off of Linus' tags. This one in particular was based off of
> 3.0-rc6 (or -rc5, can't quite remember). Where is this particular branch
> I should base off ?

git://git.kernel.org/pub/scm/linux/kernel/git/arm/linux-arm-soc.git 

This is Tony's new upstream tree.

Branch is 'omap/cleanup' in this case.


- Paul
