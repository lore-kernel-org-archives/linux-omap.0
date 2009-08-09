From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Audio on OMAP3
Date: Sun, 9 Aug 2009 20:04:53 +0100
Message-ID: <20090809190452.GC4390@sirena.org.uk>
References: <4A7F068D.6090407@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:47794 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464AbZHITE6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 Aug 2009 15:04:58 -0400
Content-Disposition: inline
In-Reply-To: <4A7F068D.6090407@mlbassoc.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>
Cc: linux-omap@vger.kernel.org

On Sun, Aug 09, 2009 at 11:25:33AM -0600, Gary Thomas wrote:

> How is audio supported on OMAP3?  In particular via the
> TWL4030/TPS659x0 chip?  Is anyone working on this?

This is supported in the ASoC subsystem - see sound/soc/omap for the
OMAP specific stuff and sound/soc/codecs/twl4030.c for the TWL4030
specifics.
