From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 26/30] ARM: omap: add board autoselection
Date: Tue, 4 Oct 2011 08:57:52 -0700
Message-ID: <20111004155752.GT6324@atomide.com>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
 <5055144.Y0IUdMEWXQ@wuerfel>
 <20111003182649.GC6324@atomide.com>
 <201110040944.13205.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201110040944.13205.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [111004 00:10]:
> On Monday 03 October 2011, Tony Lindgren wrote:
> > * Arnd Bergmann <arnd@arndb.de> [111003 02:20]:
> > > On Monday 03 October 2011 11:27:44 Cousson, Benoit wrote:
> > > > >
> > > > > In the long run, I'd hope we can just get rid of these for subarchitectures
> > > > > that support device tree probing and make the device tree based machine
> > > > > description unconditional.
> > > > 
> > > > This is really our goal, we will have soon the board-generic.c for that, 
> > > > someone will just have to migrate these ~30 board files to device tree 
> > > > DTS files 
> > > 
> > > For the purpose of build-time validation using randconfig, there is no
> > > problem in keeping some board files forever, as long as the generic board
> > > file is always built-in.
> > 
> > Yes please leave out the list so we don't need to constantly update it.
> > Let's just always build in MACH_OMAP_GENERIC.
> 
> That's what I had initially, but now that board file has become
> omap2-specific and no longer works on omap3-only or omap4-only
> configurations.

Will send a pull request for basic DT bootstrap support from Benoit
that fixes that. So maybe let's sort that out first, then always
select it?

Regards,

Tony
