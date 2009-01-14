From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/1] OMAP3 EVM MMC1 support for TPS based PR785 power modules
Date: Tue, 13 Jan 2009 16:23:07 -0800
Message-ID: <200901131623.08101.david-b@pacbell.net>
References: <1229513610-17386-1-git-send-email-mani.pillai@ti.com> <19F8576C6E063C45BE387C64729E739403ECEDD316@dbde02.ent.ti.com> <20090108152659.GS27566@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:47264 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1759559AbZANAXK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Jan 2009 19:23:10 -0500
In-Reply-To: <20090108152659.GS27566@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Pillai, Manikandan" <mani.pillai@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thursday 08 January 2009, Tony Lindgren wrote:
> How about try to figure out a way to share the common code with
> mmc-twl4030.c?

Some of that should be a bit easier once the regulator stuff is
working sanely.  At that point I think the hsmmc.c driver will
be the best place to have code that updates PBIAS and then pokes
the regulators.

Right now MMC configuration is ... overly complex ...

- Dave
