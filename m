From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 13/14] ARM: v6k: allow swp emulation again when ARMv7
 is enabled
Date: Mon, 17 Jan 2011 15:24:50 -0800
Message-ID: <20110117232450.GL4957@atomide.com>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
 <E1Peuhh-0003T5-2n@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:43508 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784Ab1AQXY4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 18:24:56 -0500
Content-Disposition: inline
In-Reply-To: <E1Peuhh-0003T5-2n@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110117 11:26]:
> Now that we build a v6+v6k+v7 kernel with -march=armv6k for everything,
> we don't need to disable swp emulation to work around the build problem
> with OMAP.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Glad to see this issue sorted out.

Tested-by: Tony Lindgren <tony@atomide.com>
