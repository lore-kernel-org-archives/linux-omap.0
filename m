From: David Brownell <david-b@pacbell.net>
Subject: Re: Git tree updated to v2.6.28-rc2, old sound and v4l drivers removed
Date: Tue, 28 Oct 2008 09:31:38 -0700
Message-ID: <200810280931.39199.david-b@pacbell.net>
References: <20081027204323.GA7539@atomide.com> <20081028030754.GC7539@atomide.com> <20081028105715.GE27144@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:40295 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751048AbYJ1Qbw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Oct 2008 12:31:52 -0400
In-Reply-To: <20081028105715.GE27144@gandalf.research.nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: ext Tony Lindgren <tony@atomide.com>, Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org

On Tuesday 28 October 2008, Felipe Balbi wrote:
> 
> > For the cbus support, I think we could possibly expand the drivers/spi
> > to do cbus too..
> 
> in i2c specs, it's said that i2c supports cbus in the lower speed, maybe
> extending i2c core would be another option ??

That makes more sense to me.  Not that I've seen CBUS specs,
you understand..

