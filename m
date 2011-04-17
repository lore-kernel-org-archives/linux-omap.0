From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH] Consolidate SRAM support
Date: Sun, 17 Apr 2011 19:47:37 +0200
Message-ID: <201104171947.38048.arnd@arndb.de>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk> <BANLkTinDwH9G1zW784t=QnNR7kZkgfKA8w@mail.gmail.com> <20110415154113.GE4423@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:61026 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752727Ab1DQRrn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 17 Apr 2011 13:47:43 -0400
In-Reply-To: <20110415154113.GE4423@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Grant Likely <grant.likely@secretlab.ca>, Kevin Hilman <khilman@ti.com>, davinci-linux-open-source@linux.davincidsp.com, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Friday 15 April 2011, Russell King - ARM Linux wrote:
> On Fri, Apr 15, 2011 at 09:32:01AM -0600, Grant Likely wrote:
> > Yes, once the infrastructure is in place, powerpc can do its own
> > migration to the new code.  I vote for putting it in lib at the
> > outset.
> 
> I don't agree with stuffing non-arch directories with code which people
> haven't already agreed should be shared.  As I've already said, in my
> experience it's hard to get agreement in the first place and even when
> you can the API generally needs to be changed from what you first think
> would be reasonable.

I believe we should be much more aggressive about putting code into generic
locations, especially when there is nothing hardware specific to it.

As we can see from all the mess regarding interrupt controllers, PCI busses
or dma mapping, most of the smaller architectures get it wrong when they
have to deal with these things, so when we have a common implementation,
it's much easier to make sure we only have the bugs once and don't get
incompatible interfaces.

	Arnd
