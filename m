From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 12/12] ARM: OMAP3: MUSB initialization for omap hw
Date: Sun, 15 Mar 2009 11:46:01 -0700
Message-ID: <200903151146.02132.david-b@pacbell.net>
References: <20090310205824.16425.97745.stgit@localhost> <20090310211628.16425.55120.stgit@localhost> <20090315161446.GG10786@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n26.bullet.mail.mud.yahoo.com ([68.142.206.221]:32977 "HELO
	n26.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751935AbZCOSqH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 15 Mar 2009 14:46:07 -0400
In-Reply-To: <20090315161446.GG10786@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.arm.linux.org.uk, Ajay Kumar Gupta <ajay.gupta@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

On Sunday 15 March 2009, Russell King - ARM Linux wrote:
> clkdev removes the need for this sort of crap.

And once it, or its equivalent, works on all the platforms
supportihg the musb_hdrc driver, then the driver can switch.


