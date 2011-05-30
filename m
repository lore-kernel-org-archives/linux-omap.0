From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3.0-rc1] OMAP: fix compilation error
Date: Mon, 30 May 2011 23:21:07 +0100
Message-ID: <20110530222107.GA21753@n2100.arm.linux.org.uk>
References: <201105302344.01530.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37650 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754980Ab1E3WVp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 May 2011 18:21:45 -0400
Content-Disposition: inline
In-Reply-To: <201105302344.01530.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org

On Mon, May 30, 2011 at 11:44:01PM +0200, Janusz Krzysztofik wrote:
> Include <linux/platform_device.h> from 
> arch/arm/plat-omap/include/plat/flash.h, otherwise compilation may break 
> with:
> 
> In file included from arch/arm/mach-omap1/flash.c:15:
> arch/arm/plat-omap/include/plat/flash.h:14: warning: 'struct platform_device' declared inside parameter list
> arch/arm/plat-omap/include/plat/flash.h:14: warning: its scope is only this definition or declaration, which is probably not what you want
> arch/arm/mach-omap1/flash.c:16: warning: 'struct platform_device' declared inside parameter list
> arch/arm/mach-omap1/flash.c:17: error: conflicting types for 'omap1_set_vpp'
> arch/arm/plat-omap/include/plat/flash.h:14: error: previous declaration of 'omap1_set_vpp' was here

Just forward-declare the struct by adding:

struct platform_device;

in this header; there's no need to add to the complexities of header file
inclusion...
