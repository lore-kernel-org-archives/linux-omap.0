From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 19:52:59 +0200
Message-ID: <1274982779.27810.5708.camel@twins>
References: <Pine.LNX.4.44L0.1005271344040.3239-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:42235 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759331Ab0E0RxM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 May 2010 13:53:12 -0400
In-Reply-To: <Pine.LNX.4.44L0.1005271344040.3239-100000@iolanthe.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Gleixner <tglx@linutronix.de>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Thu, 2010-05-27 at 13:44 -0400, Alan Stern wrote:

> You close your laptop's lid and throw the machine into a backpack.  At 
> that time you want it to suspend even though it may not be idle.
> 
> > We've been trying to tell you you don't need that.
> 
> And I'm trying to tell you that you do.

Shall we henceforth stop confusing forced suspend for laptops and
powersaving a running system?
