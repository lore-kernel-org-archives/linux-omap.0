From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/1]  Patch for I2C transmit overflow error
Date: Fri, 8 Aug 2008 01:01:53 -0700
Message-ID: <200808080101.53446.david-b@pacbell.net>
References: <54576.192.168.10.89.1218118251.squirrel@dbdmail.itg.ti.com> <200808071638.58130.david-b@pacbell.net> <20080808061945.GC24923@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:46076 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753206AbYHHS1I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Aug 2008 14:27:08 -0400
In-Reply-To: <20080808061945.GC24923@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: chandra shekhar <x0044955@ti.com>, linux-omap@vger.kernel.org

On Thursday 07 August 2008, Tony Lindgren wrote:
> * David Brownell <david-b@pacbell.net> [080808 03:37]:
> > On Thursday 07 August 2008, chandra shekhar wrote:
> > > This patch is to fix I2C transmit overflow error.
> > > I guess it should fix the OSK5912 error. I dont have the board to test it.
> > 
> > Yes, it makes those error reports go away.
> > I'd say to merge this patch.
> 
> Great, pushing today.

Further update:

 - I'm thinking it was either audio or USB that caused the boot
   problem, maybe old IDE code.  Disable a bunch of drivers and it
   booted enough for the watchdog thing to vanish.

 - I'm getting some i2c *underflow* errors reported, and it claimed
   write errors for one of the tps65010 registers at startup time.

