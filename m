From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: Audio on OMAP3
Date: Mon, 10 Aug 2009 15:19:57 -0600
Message-ID: <4A808EFD.6090400@mlbassoc.com>
References: <4A7F068D.6090407@mlbassoc.com> <20090809190452.GC4390@sirena.org.uk> <4A7F32CA.8000108@mlbassoc.com> <20090810095156.GA24947@sirena.org.uk> <4A801E65.8030305@mlbassoc.com> <20090810144933.GA30046@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([76.76.67.137]:4211 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753283AbZHJVT6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Aug 2009 17:19:58 -0400
In-Reply-To: <20090810144933.GA30046@rakim.wolfsonmicro.main>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-omap@vger.kernel.org

Mark Brown wrote:
> On Mon, Aug 10, 2009 at 07:19:33AM -0600, Gary Thomas wrote:
> 
>> Sorry for being dense, but I'm just trying to understand how to
>> get this going.  I turned on the SOC+ALSA support (there didn't
>> seem to be an easy way to configure just the TWL4030 driver) and
> 
> You need to provide a machine-specific driver which tells the McBSP and
> TWL4030 drivers how they are connected together on your particular
> board.  There are several examples of this for standard reference boards
> in the OMAP directory - if your audio hardware is based closely enough
> on one of those then you should be able to just use the same driver.

My hardware is much like the Beagle, so I started with that
driver.  Got it going fine, thanks.

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
