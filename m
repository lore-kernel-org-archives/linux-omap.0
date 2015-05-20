From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] memory: omap-gpmc: Add Kconfig option for debug
Date: Wed, 20 May 2015 15:56:28 -0700
Message-ID: <20150520225628.GO10274@atomide.com>
References: <1432156863-19695-1-git-send-email-tony@atomide.com>
 <1432156863-19695-3-git-send-email-tony@atomide.com>
 <alpine.DEB.2.02.1505202249450.7960@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:52654 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753751AbbETW4b (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 May 2015 18:56:31 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1505202249450.7960@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>, Roger Quadros <rogerq@ti.com>

* Paul Walmsley <paul@pwsan.com> [150520 15:52]:
> On Wed, 20 May 2015, Tony Lindgren wrote:
> 
> > We support decoding the bootloader values if DEBUG is defined.
> > But we also need to change the struct omap_hwmod flags to have
> > HWMOD_INIT_NO_RESET to avoid the GPMC being reset during the
> > boot. Otherwise just the default timings will be displayed
> > instead of the bootloader configured timings.
> > 
> > This also allows us to clean up the various GPMC related
> > hwmod flags. For debugging, we only need HWMOD_INIT_NO_RESET,
> > and HWMOD_INIT_NO_IDLE is not needed.
> > 
> > Cc: Brian Hutchinson <b.hutchman@gmail.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Roger Quadros <rogerq@ti.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Looks good to me, want me to queue it or do you want to?

Feel free to take it if it looks OK to you, I'll just queue
the first patch then. Roger may have other GPMC patches
coming up, but this should not conflict with them, there's
more of a hwmod conflict chance.

Regards,

Tony
