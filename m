From: Tony Lindgren <tony@atomide.com>
Subject: Re: testers wanted: isp1301_omap conversion to new-style i2c
	driver
Date: Fri, 8 Aug 2008 10:29:55 +0300
Message-ID: <20080808072954.GH24923@atomide.com>
References: <20080617204300.77c8e516@hyperion.delvare> <20080807183416.115c67ba@hyperion.delvare> <200808071651.43297.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56045 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753532AbYHHHaL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Aug 2008 03:30:11 -0400
Content-Disposition: inline
In-Reply-To: <200808071651.43297.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Jean Delvare <khali@linux-fr.org>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Deepak Saxena <dsaxena@plexity.net>

* David Brownell <david-b@pacbell.net> [080808 02:51]:
> On Thursday 07 August 2008, Jean Delvare wrote:
> > Still no testers for these patches? 
> 
> Right now I don't seem to be able to boot OMAP1 in mainline,
> so pulling that H2 out of its box would be futile.  :(

Grr, looks like I can't access my H2 remotely right now as my
remote power switch is hung, and would need to be remote rebooted..

So I can't access H2 for few more weeks, can somebody else test
on H2 meanwhile?

BTW, this patch should OK to apply as we've had it in the
linux-omap tree since December, and I've occasionally boot tested
H2, last time I think was when I removed the __REG macros few
months ago.

Regards,

Tony
