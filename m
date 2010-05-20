From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] omap4: Fix multi-omap boot with reset un-used clocks
Date: Wed, 19 May 2010 18:06:23 -0700
Message-ID: <20100520010622.GM5818@atomide.com>
References: <1274287087-4049-1-git-send-email-santosh.shilimkar@ti.com>
 <4BF44384.40901@ti.com>
 <20100520010046.GL5818@atomide.com>
 <4BF48A4E.7040208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51129 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753918Ab0ETBG0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 May 2010 21:06:26 -0400
Content-Disposition: inline
In-Reply-To: <4BF48A4E.7040208@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>

* Nishanth Menon <nm@ti.com> [100519 17:58]:
> Tony Lindgren had written, on 05/19/2010 08:00 PM, the following:
> >* Nishanth Menon <nm@ti.com> [100519 12:56]:
> >>looks like network is still not functional on SDP4430. different issue
> >
> >Oh so Ethernet does not work either? What's wrong with that?
> I was told offline that the driver is somewhere in the net ML on the
> way I believe in parallel.. I dont have collaborative links though
> :(
> 
> Santosh,
> Can you point out the status?

I thought I have those in omap-testing and merged into the master
branch in linux-omap:

ks8851: Add caching of CCR register
ks8851: Low level functions for read/write to companion eeprom
ks8851: companion eeprom access through ethtool

Regards,

Tony
