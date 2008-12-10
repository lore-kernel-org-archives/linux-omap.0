From: Jeff Steele <jsteele@coloradocollege.edu>
Subject: status of USB on omap35xx ?
Date: Tue, 09 Dec 2008 17:50:50 -0700
Message-ID: <1228870250.32014.148.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from exchange-fe1.coloradocollege.edu ([198.59.5.40]:25902 "EHLO
	exchange-fe1.ColoradoCollege.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752017AbYLJBGB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Dec 2008 20:06:01 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi All,

I'm hoping to use a Gumstix Overo (OMAP 3503 chip) for a new project,
but I'm a little confused about what USB features are currently working
in the omap-git tree kernel.


Can someone tell me :


1) Is the USB OTG port working for HS bulk transfers when operating as a
device("gadget") ? For example, is there a version
of /drivers/usb/gadget/zero.c that works on 35xx processors ?


2) Is it possible to use the USB Host port and the OTG port
simultaneously ?

One scenario I'm envisioning is to read bulk data from a device via the
host port, process it, and then feed it out the OTG port to a "real"
host computer.

3) Is the Host port working pretty reliably, or are there any issues
still to be resolved ?


I don't mind if I need to apply patches or edit/re-compile a few lines
of kernel code, but I don't want to get stranded too deep in
un-supported territory...


Thanks,

Jeff


