From: David Brownell <david-b@pacbell.net>
Subject: twl4030 - drivers/regulator framework support?
Date: Fri, 17 Oct 2008 14:01:09 -0700
Message-ID: <200810171401.09608.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:38494 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752569AbYJQVBL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Oct 2008 17:01:11 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I'm curious ... has anyone signed up to make the twl4030 code
plug into the drivers/regulator framework?

I noticed that for example on Beagle, most of the regulators
are unneeded and should probably be disabled.  (I'll guess
the same is true on Overo, but less so on Labrador and so on.)

Doing that would be a good way to clean up more of the
arch/arm/mach-omap2/hsmmc.c glue ...

- dave
