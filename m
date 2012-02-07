From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP34xx
Date: Tue, 7 Feb 2012 08:46:03 +0000
Message-ID: <20120207084603.GQ1275@n2100.arm.linux.org.uk>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk> <20120204190109.GL20333@atomide.com> <20120204203453.GD17309@n2100.arm.linux.org.uk> <20120205012556.GG1426@atomide.com> <20120205125904.GB11372@n2100.arm.linux.org.uk> <20120205172925.GS20333@atomide.com> <4F306016.9010203@ti.com> <20120207002405.GA18209@n2100.arm.linux.org.uk> <CACxGe6t0-10DOwrh_auvUtOUZ3SCgiz8vFrf35LejT+Py8q0zA@mail.gmail.com> <4F30B61C.3020801@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41236 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756572Ab2BGIqP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Feb 2012 03:46:15 -0500
Content-Disposition: inline
In-Reply-To: <4F30B61C.3020801@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>

On Tue, Feb 07, 2012 at 06:26:52AM +0100, Cousson, Benoit wrote:
> Moreover, with Rob latest series, IRQ_DOMAIN will be enabled on every  
> ARM platform, so the "depend IRQ_DOMAIN" that "fix" is removing right  
> now will have to be added again once we will move that code to use  
> genirq domain support.

Please, get a clue and realise that the current code, even with IRQ_DOMAIN
set, OOPSes on boot, as I've already reported, and as I've now said several
times now.  The code is fucked.  Therefore code needs fixing.
