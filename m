From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] usb: musb: adding support for registering nop xceiv
Date: Fri, 20 Feb 2009 14:06:18 -0800
Message-ID: <200902201406.18739.david-b@pacbell.net>
References: <1231412036-7371-1-git-send-email-ajay.gupta@ti.com> <19F8576C6E063C45BE387C64729E739403ECF7156B@dbde02.ent.ti.com> <20090220164139.GM7414@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp122.sbc.mail.sp1.yahoo.com ([69.147.64.95]:32211 "HELO
	smtp122.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754881AbZBTWGU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Feb 2009 17:06:20 -0500
In-Reply-To: <20090220164139.GM7414@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "me@felipebalbi.com" <me@felipebalbi.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>

On Friday 20 February 2009, Tony Lindgren wrote:
> > 
> > Please review this one too.
> 
> According to Felipe this is in Greg's queue, so I'll apply this to
> linux-omap to wait for it to fall down from mainline.

Yeah, I had some issues with it but it looks like the
simplest approach for now is to add patches on top of this.

- Dave
