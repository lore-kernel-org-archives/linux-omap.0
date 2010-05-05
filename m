From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] omap: rx51: Add supplies for the tlv320aic3x codec
 driver
Date: Wed, 5 May 2010 08:15:39 -0700
Message-ID: <20100505151539.GU29604@atomide.com>
References: <1272902176-21033-1-git-send-email-jhnikula@gmail.com>
 <1272902176-21033-3-git-send-email-jhnikula@gmail.com>
 <20100505172011.c57044f0.jhnikula@gmail.com>
 <20100505142513.GA11441@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:62029 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555Ab0EEPPm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 11:15:42 -0400
Content-Disposition: inline
In-Reply-To: <20100505142513.GA11441@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@nokia.com>

* Mark Brown <broonie@opensource.wolfsonmicro.com> [100505 07:20]:
> On Wed, May 05, 2010 at 05:20:11PM +0300, Jarkko Nikula wrote:
> 
> > I have one patch more to this set but it cannot be applied before this
> > tlv320aic3x patch hits into mainline:
> 
> > http://mailman.alsa-project.org/pipermail/alsa-devel/2010-May/027408.html
> 
> Seems sensible to merge this along with the CODEC driver patch it
> depends on if everyone else is happy (assuming no merge issues)?

Sounds good to me. I'll take the other ones, if there are merge issues
then we can move some of the other patches into your tree too.

Acked-by: Tony Lindgren <tony@atomide.com>
