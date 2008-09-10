From: Tony Lindgren <tony@atomide.com>
Subject: Re: testers wanted: isp1301_omap conversion to new-style i2c driver
Date: Wed, 10 Sep 2008 15:31:50 -0700
Message-ID: <20080910223148.GO21163@atomide.com>
References: <20080617204300.77c8e516@hyperion.delvare> <20080807183416.115c67ba@hyperion.delvare> <200808071651.43297.david-b@pacbell.net> <20080808072954.GH24923@atomide.com> <20080808111751.494702cc@hyperion.delvare> <20080808094551.GP24923@atomide.com> <20080808094853.GW30719@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63694 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168AbYIJWcD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 18:32:03 -0400
Content-Disposition: inline
In-Reply-To: <20080808094853.GW30719@gandalf.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Jean Delvare <khali@linux-fr.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

Hi,

* Felipe Balbi <felipe.balbi@nokia.com> [080821 07:47]:
> On Fri, Aug 08, 2008 at 12:45:52PM +0300, Tony Lindgren wrote:
> > Yeah, I will add it to linux-omap for testing for sure. This should be
> > easy to test though, it either works or does not.. But we need to find
> > somebody to boot it and connect USB cable to it :)
> 
> Hi Carlos,
> 
> could you test it for us on H2 ??
> 
> Do you guys still have H2 boards there ?

Jean, sorry for the long delay on getting this tested. Here's what
happens on H2 after Felipe's and your isp_1301.c patches:

# otg: b_idle, SWITCH to gadget, ctrl 018021                          
otg: a_idle, SWITCH to host, ctrl 080021       
otg: a_vbus_err, VBUS_ERR 2000 ctrl 140821       
hub 1-0:1.0: unable to enumerate USB device on port 2

So things work the same as before them.

Here's my ack for the following patches:

i2c/isp1301_omap: Convert to a new-style i2c driver, part 1
i2c/isp1301_omap: Convert to a new-style i2c driver, part 2

Acked-by: Tony Lindgren <tony@atomide.com>

Regards,

Tony
