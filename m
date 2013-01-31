From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Failure to boot...
Date: Thu, 31 Jan 2013 16:18:23 +0000
Message-ID: <20130131161823.GT2637@n2100.arm.linux.org.uk>
References: <20130131092024.GN2637@n2100.arm.linux.org.uk> <20130131104044.GO2637@n2100.arm.linux.org.uk> <510A6877.9080307@ti.com> <20130131130437.GP2637@n2100.arm.linux.org.uk> <510A78E1.8010308@ti.com> <20130131141320.GQ2637@n2100.arm.linux.org.uk> <20130131141635.GR2637@n2100.arm.linux.org.uk> <510A7D9F.7040507@ti.com> <20130131142758.GS2637@n2100.arm.linux.org.uk> <CAOMZO5BrGcffzd2YBrF6YQTs7X38RuniYhm010fpLMnigecnTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60332 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753695Ab3AaQSk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Jan 2013 11:18:40 -0500
Content-Disposition: inline
In-Reply-To: <CAOMZO5BrGcffzd2YBrF6YQTs7X38RuniYhm010fpLMnigecnTw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, arm@kernel.org, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Jan 31, 2013 at 02:01:14PM -0200, Fabio Estevam wrote:
> On Thu, Jan 31, 2013 at 12:27 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> 
> > too.  It also looks like Versatile Express support _can't_ be disabled in
> > a multiplatform kernel, which is ludicrous.
> 
> Should we go with this approach?
> https://patchwork.kernel.org/patch/1774521/

We need to go with an approach which isn't going to break allnoconfig
and randconfig.

I've suggested that we should have a basic, minimalist platform always
built in for DT supporting kernels.  I've actually suggested that we
should end up not having a machine_desc at all once the DT conversion
is complete.  Either of those solves the problem of us ending up with
no platform support built with these configurations.

The alternative is we end up with quite a long disgusting Kconfig
option which becomes enabled when everything but Versatile Express
is disabled...
