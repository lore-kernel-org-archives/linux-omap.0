From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] omap: rx51: Add supplies for the tlv320aic3x codec
	driver
Date: Wed, 5 May 2010 15:25:14 +0100
Message-ID: <20100505142513.GA11441@sirena.org.uk>
References: <1272902176-21033-1-git-send-email-jhnikula@gmail.com> <1272902176-21033-3-git-send-email-jhnikula@gmail.com> <20100505172011.c57044f0.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:57473 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760271Ab0EEOZP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 10:25:15 -0400
Content-Disposition: inline
In-Reply-To: <20100505172011.c57044f0.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Eduardo Valentin <eduardo.valentin@nokia.com>

On Wed, May 05, 2010 at 05:20:11PM +0300, Jarkko Nikula wrote:

> I have one patch more to this set but it cannot be applied before this
> tlv320aic3x patch hits into mainline:

> http://mailman.alsa-project.org/pipermail/alsa-devel/2010-May/027408.html

Seems sensible to merge this along with the CODEC driver patch it
depends on if everyone else is happy (assuming no merge issues)?
