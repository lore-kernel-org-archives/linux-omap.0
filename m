From: David Brownell <david-b@pacbell.net>
Subject: those twl and regulator patches I just sent ...
Date: Sat, 15 Nov 2008 12:54:04 -0800
Message-ID: <200811151254.04244.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:20786 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752049AbYKOUyN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 15 Nov 2008 15:54:13 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Of the first four, I suggest merging all but the last into the OMAP
tree.  (The last is for folk who want to experiment.)

Of the second three, don't merge any into the OMAP tree; I expect at
least the first two will eventually merge via mainline.

If you want to poke at the regulator stuff, I encourage you to apply
all of these.    The point of the second set of patches is to make
the sysfs entries be less crufty ... only show the few attributes
that are relevant for any given regulator, and show hardware state
("opmode") without assuming only Linux can affect it.  (On TWL4030
family chips, that state results from P1/P2/P3 group votes...)

- dave
