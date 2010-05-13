From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH v3 0/2] McBSP changes for OMAP4 platform
Date: Thu, 13 May 2010 10:29:30 +0100
Message-ID: <1273742970.3316.14.camel@odin>
References: <1273684720-16619-1-git-send-email-jorge.candelaria@ti.com>
	 <20100513081947.GB19774@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60886 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752915Ab0EMJ3f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 05:29:35 -0400
Received: by wyb32 with SMTP id 32so722581wyb.19
        for <linux-omap@vger.kernel.org>; Thu, 13 May 2010 02:29:34 -0700 (PDT)
In-Reply-To: <20100513081947.GB19774@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>, linux-omap@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>, alsa-devel <alsa-devel@alsa-project.org>

On Thu, 2010-05-13 at 09:19 +0100, Mark Brown wrote:
> On Wed, May 12, 2010 at 12:18:38PM -0500, Jorge Eduardo Candelaria wrote:
> > The following patches enable McBSP driver to be used along with the
> > audio driver in SDP4430 and other OMAP4 based boards.
> 
> Both
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Tony, do we have you ack/sob to upstream via ASoC ?

We do have a lot pending with mcbsp dependencies for ASoC atm and this
would simplify upstreaming.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk

