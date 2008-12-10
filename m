From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: status of USB on omap35xx ?
Date: Wed, 10 Dec 2008 16:46:04 +0200
Message-ID: <20081210144604.GD13287@gandalf.research.nokia.com>
References: <1228870250.32014.148.camel@localhost.localdomain>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:51456 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbYLJOqn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Dec 2008 09:46:43 -0500
Content-Disposition: inline
In-Reply-To: <1228870250.32014.148.camel@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Jeff Steele <jsteele@coloradocollege.edu>
Cc: linux-omap@vger.kernel.org

On Tue, Dec 09, 2008 at 05:50:50PM -0700, ext Jeff Steele wrote:
> 1) Is the USB OTG port working for HS bulk transfers when operating as a
> device("gadget") ? For example, is there a version
> of /drivers/usb/gadget/zero.c that works on 35xx processors ?

yes.

> 2) Is it possible to use the USB Host port and the OTG port
> simultaneously ?

should be possible, they're different controllers.

> One scenario I'm envisioning is to read bulk data from a device via the
> host port, process it, and then feed it out the OTG port to a "real"
> host computer.
> 
> 3) Is the Host port working pretty reliably, or are there any issues
> still to be resolved ?

ehci driver still needs some work. You can help

> I don't mind if I need to apply patches or edit/re-compile a few lines
> of kernel code, but I don't want to get stranded too deep in
> un-supported territory...

-- 
balbi
