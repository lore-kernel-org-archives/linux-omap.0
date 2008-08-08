From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1]  Patch for I2C transmit overflow error
Date: Fri, 8 Aug 2008 09:19:45 +0300
Message-ID: <20080808061945.GC24923@atomide.com>
References: <54576.192.168.10.89.1218118251.squirrel@dbdmail.itg.ti.com> <200808071638.58130.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49627 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753790AbYHHGTt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Aug 2008 02:19:49 -0400
Content-Disposition: inline
In-Reply-To: <200808071638.58130.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: chandra shekhar <x0044955@ti.com>, linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [080808 03:37]:
> On Thursday 07 August 2008, chandra shekhar wrote:
> > This patch is to fix I2C transmit overflow error.
> > I guess it should fix the OSK5912 error. I dont have the board to test it.
> 
> Yes, it makes those error reports go away.
> I'd say to merge this patch.

Great, pushing today.

Tony
