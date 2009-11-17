From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: Is the OMAP patch process badly flawed?
Date: Tue, 17 Nov 2009 20:21:37 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A8C916A@dbde02.ent.ti.com>
References: <20091116160402.deb0cc82.sfr@canb.auug.org.au>
 <4B0213AC.6050502@blueyonder.co.uk> <4B02A583.8090602@blueyonder.co.uk>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A8C911F@dbde02.ent.ti.com>
 <4B02AC98.8030507@blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59958 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753673AbZKQOvh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 09:51:37 -0500
In-Reply-To: <4B02AC98.8030507@blueyonder.co.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "sboyce@blueyonder.co.uk" <sboyce@blueyonder.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Sid Boyce wrote:

<snip>

> >>
> >> I would expect patches sent upstream would result in all the basics for
> >> long established platforms to be fully covered. Appreciating that
> >> development is quite fast paced with mods and supporting new platforms.
> >> Could someone please enlighten me?
> > 
> > Sid,
> > 
> > Speaking purely for EHCI, this is now queued up in Greg's USB queue
> > for upstream and will get merged in the next cycle.
> > 
> > Until then, the linux-omap code does have working EHCI support
> > on beagle, evm and the other boards. If you're cloning from
> > gitorious, you're probably picking the wrong tree.
> > 
> > - Anand
> > 
> > 
> 
> Thanks, that explains a lot as I can't remember seeing those patches on
> the linux-usb list for submission upstream.
> What tree is best to clone?


Not sure which is best - I suppose that depends on what all you need.
The canonical linux-omap tree maintained by Tony is at [1].

For EHCI, Felipe sent the driver to Greg who queued it up for .33 [2].
Tony lined up the board files and mach-omap2/usb-ehci.c in the for-next
branch.



[1] git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
[2] http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-07-usb-2.6.32-rc6.patch
 