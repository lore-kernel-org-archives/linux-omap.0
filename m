From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] i2c: omap: highspeed only over 1000mhz
Date: Mon, 20 Oct 2008 16:22:00 +0300
Message-ID: <20081020132200.GE31599@gandalf.research.nokia.com>
References: <1224277795-17143-1-git-send-email-felipe.balbi@nokia.com> <20081020102659.GA31599@gandalf.research.nokia.com> <48FC7CA9.4040102@gmail.com> <20081020125355.GC31599@gandalf.research.nokia.com> <48FC851C.3040506@gmail.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:30870 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715AbYJTNWe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Oct 2008 09:22:34 -0400
Content-Disposition: inline
In-Reply-To: <48FC851C.3040506@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Nishanth Menon <menon.nishanth@gmail.com>
Cc: felipe.balbi@nokia.com, linux-omap@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, Tony Lindgren <tony@atomide.com>

On Mon, Oct 20, 2008 at 08:18:20AM -0500, ext Nishanth Menon wrote:

hehe, please don't send html mails,

That was a nice catch. Didn't see that in the TRM. Let's drop this patch
then, or at least until someone test a FM+ device with omap3.

-- 
balbi
