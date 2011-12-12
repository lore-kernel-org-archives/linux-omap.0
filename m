From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 01/10] GPIO: gpio-generic: Move initialization up to
 postcore
Date: Mon, 12 Dec 2011 15:55:44 -0800
Message-ID: <20111212235544.GM32251@atomide.com>
References: <1323634328-856-1-git-send-email-jkrzyszt@tis.icnet.pl>
 <201112130005.35386.jkrzyszt@tis.icnet.pl>
 <20111212231519.GK32251@atomide.com>
 <201112130044.02007.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201112130044.02007.jkrzyszt@tis.icnet.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [111212 15:13]:
> On Tuesday 13 of December 2011 at 00:15:20, Tony Lindgren wrote:
> > 
> > Might be worth checking if some board specific __initcall helps here
> > too?
> 
> If I only knew how I could insert a board specific __initcall between 
> two points from where the generic-gpio first, then the 8250 driver, are 
> called.
> 
> Any hints?

Hmm, can't you do all that in the order you want in
ams_delta_modem_init()?  Or make that into a late_initcall so
you have generic-gpio available?

It seems that the pieces of code you're talking about don't need
to be initialized early, just needs to be done in the right
order to get things working.

Regards,

Tony
