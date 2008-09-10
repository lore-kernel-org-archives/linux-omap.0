From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH]Add 3430 SDP board level support for HSMMC2
Date: Wed, 10 Sep 2008 16:59:14 -0700
Message-ID: <20080910235913.GW21163@atomide.com>
References: <33259.192.168.10.89.1218608332.squirrel@dbdmail.itg.ti.com> <20080813085433.D5C2F363253@adsl-69-226-248-13.dsl.pltn13.pacbell.net> <00cf01c8fd26$cfc751b0$LocalHost@wipultra1303> <200809081226.18098.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64009 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248AbYIJX7Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 19:59:16 -0400
Content-Disposition: inline
In-Reply-To: <200809081226.18098.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [080908 12:26]:
> On Wednesday 13 August 2008, Madhusudhan Chikkature wrote:
> > > A better way to do this would be to let the boards say exactly
> > > what the hardware configuration is, rather than requiring all
> > > OMAP3 boards to be set up exactly like the SDP...
> >
> > I think the initial version was written specific to SDP. Later
> > on it was changed to hsmmc.c and the platforms which required
> > simillar setup as SDP started using it.
> 
> Right ...
> 
> 
> > Now, if support for a new board is required which is unlike SDP a  
> > new file can still be added for that perticular board, right?
> 
> Each board already gets a board-XYZ.c file.  So the clean way
> to do this is to have that file set up its hsmmc config ... NOT
> to clone versions of hsmmc.c for each board!

Madhu, are you planning to abstract hsmmc.c further so various boards
can use it?

Tony
