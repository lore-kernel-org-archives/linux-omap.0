From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH 01/10] GPIO: gpio-generic: Move initialization up to postcore
Date: Wed, 14 Dec 2011 14:10:53 +0100
Message-ID: <201112141410.53522.jkrzyszt@tis.icnet.pl>
References: <1323634328-856-1-git-send-email-jkrzyszt@tis.icnet.pl> <201112130044.02007.jkrzyszt@tis.icnet.pl> <20111212235544.GM32251@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20111212235544.GM32251@atomide.com>
Sender: linux-serial-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 13 of December 2011 at 00:55:44, Tony Lindgren wrote:
> * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [111212 15:13]:
> > On Tuesday 13 of December 2011 at 00:15:20, Tony Lindgren wrote:
> > > 
> > > Might be worth checking if some board specific __initcall helps here
> > > too?
> > 
> > If I only knew how I could insert a board specific __initcall between 
> > two points from where the generic-gpio first, then the 8250 driver, are 
> > called.
> > 
> > Any hints?
> 
> Hmm, can't you do all that in the order you want in
> ams_delta_modem_init()?  Or make that into a late_initcall so
> you have generic-gpio available?
> 
> It seems that the pieces of code you're talking about don't need
> to be initialized early, just needs to be done in the right
> order to get things working.

Hi,
I'm almost done with moving registration of all latch dependent devices 
down to a late_initcall hook, however while working on this, I've found 
still another arrangement, yet better in my opinion:
1) generic-gpio driver registration moved from device_initcall up to 
   subsys_initcall,
2) latch dependent device registration left at arch_initcall, as it is 
   now,
3) a temporary hack, removed with the last patch in the series, that 
   requests GPIO pins on behalf of device drivers before those are 
   updated, placed between subsys_initcall and device_initcall, i.e., at 
   fs_initcall or rootfs_initcall; both look ugly, but this is only for 
   a while, in order to keep things working while in the transition,
4) the modem init hook, once updated with extra GPIO setup that must be 
   done on behalf of the 8250 driver, which is not prepared for 
   accepting any extra init hooks passed with the device platform data, 
   moved down to late_initcall, as suggested,
5) once all drivers are updated, the hack is removed, and an 
   initialization of unused pins added to that late_initcall modem hook, 
   perhaps renamed in order to not suggest it is still modem only 
   related.

What do you think?

Thanks,
Janusz
