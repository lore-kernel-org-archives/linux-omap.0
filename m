From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 26/30] ARM: omap: add board autoselection
Date: Mon, 3 Oct 2011 11:26:49 -0700
Message-ID: <20111003182649.GC6324@atomide.com>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
 <3656685.pM1zNST8gQ@wuerfel>
 <4E898010.80208@ti.com>
 <5055144.Y0IUdMEWXQ@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:57025 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932429Ab1JCS0y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Oct 2011 14:26:54 -0400
Content-Disposition: inline
In-Reply-To: <5055144.Y0IUdMEWXQ@wuerfel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

* Arnd Bergmann <arnd@arndb.de> [111003 02:20]:
> On Monday 03 October 2011 11:27:44 Cousson, Benoit wrote:
> > >
> > > In the long run, I'd hope we can just get rid of these for subarchitectures
> > > that support device tree probing and make the device tree based machine
> > > description unconditional.
> > 
> > This is really our goal, we will have soon the board-generic.c for that, 
> > someone will just have to migrate these ~30 board files to device tree 
> > DTS files 
> 
> For the purpose of build-time validation using randconfig, there is no
> problem in keeping some board files forever, as long as the generic board
> file is always built-in.

Yes please leave out the list so we don't need to constantly update it.
Let's just always build in MACH_OMAP_GENERIC.

Regards,

Tony
