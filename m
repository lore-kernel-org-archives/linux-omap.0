From: Tony Lindgren <tony@atomide.com>
Subject: Re: Stable version and repository loc
Date: Mon, 30 Apr 2012 12:44:17 -0700
Message-ID: <20120430194417.GE3739@atomide.com>
References: <565579833.8864.1335810041069.JavaMail.vpopmail@webmail.networksolutionsemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:17139 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755999Ab2D3ToT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Apr 2012 15:44:19 -0400
Content-Disposition: inline
In-Reply-To: <565579833.8864.1335810041069.JavaMail.vpopmail@webmail.networksolutionsemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "alan@alanlee.org" <alan@alanlee.org>
Cc: linux-omap@vger.kernel.org

Hi,

* alan@alanlee.org <alan@alanlee.org> [120430 11:24]:
> 
> What is the latest version of the Linux kernel OMAP tree that is considered
> stable?  I'm in the middle of bringing up a bare-metal roll of Linux on a
> derivative of the AM3517 family (Jacinto 3) on a commercial automotive radio.
>  I'm new to Linux on OMAP but old to Linux kernel development itself (since
> pre-1.0).  It appears the latest PSP from TI contains a version of 2.6.37 but
> it's main line cousin is more than a year old now.  And from lurking here on the
> very active Linux OMAP list, that's likely a enormous number of changes.  I'm
> just looking for the most current stable starting point and working up from
> there as technical problems dictate.

The stable version is most recent mainline Linux kernel tree, that is
v3.3 currently. All the other branches are development branches for the
upcoming merge window, or some legacy patches that we still carry around
that are not ready to be merged yet.

Regards,

Tony
