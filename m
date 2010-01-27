From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5] OMAP UART: Add omap-serial driver support.
Date: Wed, 27 Jan 2010 10:18:50 -0800
Message-ID: <20100127181850.GE23505@atomide.com>
References: <63111.192.168.10.88.1264586216.squirrel@dbdmail.itg.ti.com>
 <20100127172526.GB23505@atomide.com>
 <87y6jjwi9e.fsf@deeprootsystems.com>
 <20100127175737.GD23505@atomide.com>
 <87iqanwhe4.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:54917 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754182Ab0A0SSb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jan 2010 13:18:31 -0500
Content-Disposition: inline
In-Reply-To: <87iqanwhe4.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org

* Kevin Hilman <khilman@deeprootsystems.com> [100127 10:05]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > * Kevin Hilman <khilman@deeprootsystems.com> [100127 09:46]:
> >> Tony Lindgren <tony@atomide.com> writes:
> >> 
> >> [...]
> >> 
> >> >
> >> > Do you have the board related patches somewhere so people can
> >> > actually test this driver?
> >> >
> >> 
> >> Tony, the board/platform related patches are in my pm-wip/uart branch
> >> as part of the conversion of that code to hwmod/omap_device.
> >> 
> >> This patch on top of that branch is working fine, at least for
> >> basic console.
> >
> > OK. What's the dependency to the PM branch with these UART
> > patches?
> 
> The driver itself has no dependencies.
> 
> But the platform changes and conversion to hwmod/omap_device have all
> been done on top of the PM branch + various ongoing hwmod/omap_device
> patches.

Sounds like we should do all the hwmod conversion patches against the
mainline nowadays to cut down the dependencies. If there are some
dependencies still to PM branch, those should be patched away ASAP.

Adding new device drivers should not have any dependencies except
the mainline kernel :)

Tony
