From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/5] ARM: OMAP2+: gpmc: Error out if timings fail in
 gpmc_probe_generic_child()
Date: Tue, 4 Nov 2014 07:51:29 -0800
Message-ID: <20141104155128.GR31454@atomide.com>
References: <1413895309-9152-1-git-send-email-rogerq@ti.com>
 <1413895309-9152-3-git-send-email-rogerq@ti.com>
 <20141104004530.GM31454@atomide.com>
 <20141104011417.GN31454@atomide.com>
 <54589659.4090300@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:19390 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753432AbaKDPwb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Nov 2014 10:52:31 -0500
Content-Disposition: inline
In-Reply-To: <54589659.4090300@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: pekon@pek-sem.com, javier@dowhile0.org, linux-omap@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>

* Roger Quadros <rogerq@ti.com> [141104 01:04]:
> On 11/04/2014 03:14 AM, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [141103 16:48]:
> >> --- a/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi
> >> +++ b/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi
> >> +		gpmc,device-width = <1>;
> >> +		gpmc,burst-length = <4>;
> > 
> > I've left out the gpmc,burst-length as that produces now
> > warnings about not being used and does not seem to work if
> > enabled.
> 
> OK. Seems like it must be used together with either 'gpmc,burst-read'
> or/and 'gpmc,burst-write'

Yes I did a quick test trying to enable both or one of those,
but that won't for smsc911x.

Regards,

Tony
