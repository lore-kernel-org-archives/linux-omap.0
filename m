From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 22/31] ARM: amba: integrator: use common amba device
 initializers
Date: Tue, 24 Jan 2012 16:13:33 +0000
Message-ID: <20120124161332.GN19798@mudshark.cambridge.arm.com>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
 <E1RoAn8-0005Fk-Hc@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:44448 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754684Ab2AXQNw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jan 2012 11:13:52 -0500
Content-Disposition: inline
In-Reply-To: <E1RoAn8-0005Fk-Hc@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, STEricsson <STEricsson_nomadik_linux@list.st.com>

On Fri, Jan 20, 2012 at 09:29:50AM +0000, Russell King - ARM Linux wrote:
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/mach-integrator/core.c          |   70 ++++++------------------------
>  arch/arm/mach-integrator/integrator_cp.c |   49 ++++-----------------
>  2 files changed, 22 insertions(+), 97 deletions(-)

Seems happy enough on my Integrator-CP w/ 1136 core tile.

Tested-by: Will Deacon <will.deacon@arm.com>

Will
