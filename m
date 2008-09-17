From: David Brownell <david-b@pacbell.net>
Subject: Re: OMAP support in mainline?
Date: Tue, 16 Sep 2008 22:55:00 -0700
Message-ID: <200809162255.00918.david-b@pacbell.net>
References: <87tzcgi1gv.fsf@nokia.com> <20080916232505.GC25885@atomide.com> <20080917082043.04c94e2d.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:32551 "HELO
	smtp108.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750856AbYIQFzI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Sep 2008 01:55:08 -0400
In-Reply-To: <20080917082043.04c94e2d.jarkko.nikula@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: ext Tony Lindgren <tony@atomide.com>, Felipe Balbi <me@felipebalbi.com>, Paul Walmsley <paul@pwsan.com>, Kalle Valo <kalle.valo@nokia.com>, linux-omap@vger.kernel.org

On Tuesday 16 September 2008, Jarkko Nikula wrote:
> 
> I think one good measure for this whole work when one can can run
> Beagle or Overo with mainline kernel.

Yes ... ideally for 2.6.28 for both.  The Overo boards handed
out at the kernel summit are a bit visible right now as not
yet booting with mainline code.  :)


> That would require some "spring-cleaning" effort and getting core,
> TWL4030, etc. patches out but then it is much more easier to send
> remaining board files and other drivers to their relevant lists.

My quick audit:

  - core updates
  - board files
  - twl4030 ... converted to new-style, gpiolib, drivers/mfd
  - hsmmc
  - omap2 nand
  - various pending musb updates

FB support would be nice too, but IMO not if that means rushing
the updates discussed lately.  Not all the TWL components would
need to go upstream at once.

- Dave
