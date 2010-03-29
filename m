From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC][PATCH] Add support for hook switch on ams-delta
Date: Mon, 29 Mar 2010 14:48:21 +0100
Message-ID: <20100329134821.GC13239@sirena.org.uk>
References: <200905262057.21890.jkrzyszt@tis.icnet.pl> <20090602220433.GD31770@earth.li> <20100329134647.GA29369@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:35075 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753Ab0C2NsX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Mar 2010 09:48:23 -0400
Content-Disposition: inline
In-Reply-To: <20100329134647.GA29369@rakim.wolfsonmicro.main>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jonathan McDowell <noodles@earth.li>
Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, linux-omap@vger.kernel.org, linux-input@vger.kernel.org

On Mon, Mar 29, 2010 at 02:46:48PM +0100, Mark Brown wrote:
> On Tue, Jun 02, 2009 at 11:04:33PM +0100, Jonathan McDowell wrote:
> 
> > * The commented out code to include the GPIO status in sysfs shouldn't
> >   be included. Does the input layer not provide a way to obtain the
> >   state of the switch?
> 
> It does, but only via an ioctl().

Sorry, clearly I'm managing to get some extremely old mail dripping
through here :(
