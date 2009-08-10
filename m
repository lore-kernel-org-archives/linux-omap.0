From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Audio on OMAP3
Date: Mon, 10 Aug 2009 15:49:33 +0100
Message-ID: <20090810144933.GA30046@rakim.wolfsonmicro.main>
References: <4A7F068D.6090407@mlbassoc.com>
 <20090809190452.GC4390@sirena.org.uk>
 <4A7F32CA.8000108@mlbassoc.com>
 <20090810095156.GA24947@sirena.org.uk>
 <4A801E65.8030305@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:54373 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750777AbZHJOte (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Aug 2009 10:49:34 -0400
Content-Disposition: inline
In-Reply-To: <4A801E65.8030305@mlbassoc.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>
Cc: linux-omap@vger.kernel.org

On Mon, Aug 10, 2009 at 07:19:33AM -0600, Gary Thomas wrote:

> Sorry for being dense, but I'm just trying to understand how to
> get this going.  I turned on the SOC+ALSA support (there didn't
> seem to be an easy way to configure just the TWL4030 driver) and

You need to provide a machine-specific driver which tells the McBSP and
TWL4030 drivers how they are connected together on your particular
board.  There are several examples of this for standard reference boards
in the OMAP directory - if your audio hardware is based closely enough
on one of those then you should be able to just use the same driver.
