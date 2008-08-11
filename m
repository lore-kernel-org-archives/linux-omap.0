From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] Fix isp1301_omap compile (Re: testers wanted:
 isp1301_omap conversion to new-style i2c driver)
Date: Mon, 11 Aug 2008 11:46:16 -0700
Message-ID: <20080811184616.D9422209F67@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <20080617204300.77c8e516@hyperion.delvare>
 <20080807183416.115c67ba@hyperion.delvare>
 <200808071651.43297.david-b@pacbell.net>
 <20080808072954.GH24923@atomide.com>
 <20080808111751.494702cc@hyperion.delvare>
 <20080808094551.GP24923@atomide.com>
 <20080808094853.GW30719@gandalf.research.nokia.com>
 <20080811152410.GN25784@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp122.sbc.mail.sp1.yahoo.com ([69.147.64.95]:26549 "HELO
	smtp122.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751626AbYHKSkv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Aug 2008 14:40:51 -0400
In-Reply-To: <20080811152410.GN25784@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, felipe.balbi@nokia.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, khali@linux-fr.org, dsaxena@plexity.net, carlos.aguiar@indt.org.br

> > Do you guys still have H2 boards there ?
>
> Also H4 needs to be tested.

H2 needs to be tested with upstream kernels and OTG ... as I recall,
the linux-OMAP kernel has patches that made OTG work on H3 (and I'd
assume H4 too) but broke it completely on H2.

- Dave

