From: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Subject: RE: [patch twl] twl4030-core -- more cleanups
Date: Fri, 3 Oct 2008 14:43:23 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB028C5402D4@dbde02.ent.ti.com>
References: <200810021221.20286.david-b@pacbell.net>
 <EAF47CD23C76F840A9E7FCE10091EFAB028C5400D3@dbde02.ent.ti.com>
 <200810030115.54197.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38214 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619AbYJCJNf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 05:13:35 -0400
In-Reply-To: <200810030115.54197.david-b@pacbell.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> The general policy on comments is that they should not
> be translating the C code into English.  Not only are
> such comments pointless (the C code says the same thing,
> more precisely) but they also are more likely to become
> obsolete as the code changes.  (That's a well known
> problem:  comments usually don't get updated when the
> code changes.)

Thanks for the info and point noted. :)
> 
> So in my opinion we "should" not have this comment
> just paraphrase (in English) what the code does,
> one sentence per code block.
> 

And now, I do agree.


> (And then there's the way every SIH handler seems to
> be getting its own irq_chip and handler thread.  I'm
> sure that can be done much better.)

So, is there going to be a change in the current way,
of spawning a separate thread, for power and gpio irqs?

--
Jagadeesh
