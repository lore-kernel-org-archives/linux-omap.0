From: Jean Delvare <khali@linux-fr.org>
Subject: Re: testers wanted: isp1301_omap conversion to new-style i2c driver
Date: Thu, 11 Sep 2008 09:15:51 +0200
Message-ID: <20080911091551.09a09c10@hyperion.delvare>
References: <20080617204300.77c8e516@hyperion.delvare>
	<20080807183416.115c67ba@hyperion.delvare>
	<200808071651.43297.david-b@pacbell.net>
	<20080808072954.GH24923@atomide.com>
	<20080808111751.494702cc@hyperion.delvare>
	<20080808094551.GP24923@atomide.com>
	<20080808094853.GW30719@gandalf.research.nokia.com>
	<20080910223148.GO21163@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:9896 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbYIKHQE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 03:16:04 -0400
In-Reply-To: <20080910223148.GO21163@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

Hi Tony,

On Wed, 10 Sep 2008 15:31:50 -0700, Tony Lindgren wrote:
> Hi,
> 
> * Felipe Balbi <felipe.balbi@nokia.com> [080821 07:47]:
> > On Fri, Aug 08, 2008 at 12:45:52PM +0300, Tony Lindgren wrote:
> > > Yeah, I will add it to linux-omap for testing for sure. This should be
> > > easy to test though, it either works or does not.. But we need to find
> > > somebody to boot it and connect USB cable to it :)
> > 
> > Hi Carlos,
> > 
> > could you test it for us on H2 ??
> > 
> > Do you guys still have H2 boards there ?
> 
> Jean, sorry for the long delay on getting this tested. Here's what
> happens on H2 after Felipe's and your isp_1301.c patches:
> 
> # otg: b_idle, SWITCH to gadget, ctrl 018021                          
> otg: a_idle, SWITCH to host, ctrl 080021       
> otg: a_vbus_err, VBUS_ERR 2000 ctrl 140821       
> hub 1-0:1.0: unable to enumerate USB device on port 2
> 
> So things work the same as before them.
> 
> Here's my ack for the following patches:
> 
> i2c/isp1301_omap: Convert to a new-style i2c driver, part 1
> i2c/isp1301_omap: Convert to a new-style i2c driver, part 2
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Thanks for testing and reporting! Both patches are in my i2c tree and
scheduled to be send to Linus for kernel 2.6.28.

-- 
Jean Delvare
