From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 0/2] McBSP changes for OMAP4 platform
Date: Thu, 13 May 2010 17:14:57 -0700
Message-ID: <20100514001456.GR3428@atomide.com>
References: <1273684720-16619-1-git-send-email-jorge.candelaria@ti.com>
 <20100513081947.GB19774@opensource.wolfsonmicro.com>
 <1273742970.3316.14.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:65379 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373Ab0ENAPH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 20:15:07 -0400
Content-Disposition: inline
In-Reply-To: <1273742970.3316.14.camel@odin>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>, linux-omap@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>, alsa-devel <alsa-devel@alsa-project.org>

* Liam Girdwood <lrg@slimlogic.co.uk> [100513 02:24]:
> On Thu, 2010-05-13 at 09:19 +0100, Mark Brown wrote:
> > On Wed, May 12, 2010 at 12:18:38PM -0500, Jorge Eduardo Candelaria wrote:
> > > The following patches enable McBSP driver to be used along with the
> > > audio driver in SDP4430 and other OMAP4 based boards.
> > 
> > Both
> > 
> > Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> Tony, do we have you ack/sob to upstream via ASoC ?

No problem with me, both of them:

Acked-by: Tony Lindgren <tony@atomide.com>
 
> We do have a lot pending with mcbsp dependencies for ASoC atm and this
> would simplify upstreaming.

Sure, I agree. It's best to keep the patchsets toghether.

One request I have for the long run is to set some features
flag during init and only use the cpu_is_omapxxxx tests once
during init. That way the driver is more future proof and
should not require adding cpu_is_omapxxxx all over the place.

Regards,

Tony
