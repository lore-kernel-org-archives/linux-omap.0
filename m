From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: 4430SDP boot failure
Date: Fri, 7 Jan 2011 13:58:41 +0000
Message-ID: <20110107135841.GN1198@n2100.arm.linux.org.uk>
References: <20110106195225.GX7771@atomide.com> <20110106203431.GZ7771@atomide.com> <20110106205107.GI1198@n2100.arm.linux.org.uk> <20110106235203.GA14425@n2100.arm.linux.org.uk> <d540408e2df154cf13932e79d3a11ceb@mail.gmail.com> <20110107092800.GJ1198@n2100.arm.linux.org.uk> <86f60bc5418ca1d3e87db960e5e2c48f@mail.gmail.com> <729152acd9ee0c3e3e3cd505e84f8865@mail.gmail.com> <20110107125132.GM1198@n2100.arm.linux.org.uk> <21BAFE00-CDAF-4DDB-9DC1-C42F0D61DC0E@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56523 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371Ab1AGN6y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 08:58:54 -0500
Content-Disposition: inline
In-Reply-To: <21BAFE00-CDAF-4DDB-9DC1-C42F0D61DC0E@dominion.thruhere.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Fri, Jan 07, 2011 at 02:07:53PM +0100, Koen Kooi wrote:
> Op 7 jan 2011, om 13:51 heeft Russell King - ARM Linux het volgende geschreven:
> > This is the command line I've been giving it:
> > 
> > setenv bootargs 'root=/dev/mmcblk0p2 rw mem=512M vmalloc=1G console=ttyO2,115200n8 rootdelay=2'
> 
> Why are people still using rootdelay? 'rootwait' is vastly superior and doesn't need tweaking for every card/controller combo.

Does it matter if the effect it produces works?
