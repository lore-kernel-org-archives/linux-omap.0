From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP* Latest build failures
Date: Wed, 14 Nov 2012 17:44:26 +0000
Message-ID: <20121114174426.GC3332@n2100.arm.linux.org.uk>
References: <20121114092643.GG3290@n2100.arm.linux.org.uk> <50A3844B.8040208@ti.com> <20121114164801.GQ6801@atomide.com> <20121114165947.GR6801@atomide.com> <20121114171730.GS6801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42328 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423096Ab2KNRoh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Nov 2012 12:44:37 -0500
Content-Disposition: inline
In-Reply-To: <20121114171730.GS6801@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Wed, Nov 14, 2012 at 09:17:31AM -0800, Tony Lindgren wrote:
> Looks like the way to do this not to use oldnoconfig but to do:
> 
> $ make KCONFIG_ALLCONFIG=../configs/rmk-omap4430-sdp-noconfig allnoconfig
> 
> It seems that oldnoconfig will pick the new options that have default y?

That is the correct way to tell Kconfig to use the seed configuration -
that forces the options in the ALLCONFIG file to the values in there in
the final configuration while setting the rest of the options as desired
by the all*config target.
