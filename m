From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] suppress needless timer reprogramming {tick-sched.c} -
	test/comment
Date: Tue, 5 Aug 2008 07:22:17 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE89671620361EE1AA9@dlee02.ent.ti.com>
References: <13B9B4C6EF24D648824FF11BE8967162035B9BE166@dlee02.ent.ti.com>
 <C2CB0AC6-3065-469C-AAAF-F78F3DEFFFB8@student.utwente.nl>
 <20080805121435.GZ7193@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48639 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758442AbYHEMW0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Aug 2008 08:22:26 -0400
In-Reply-To: <20080805121435.GZ7193@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Koen Kooi <k.kooi@student.utwente.nl>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> This needs to go in via LKML, I think Thomas Gleixner is looking into
> it.

* Today it is in Andrew Morton's tree.

* Thomas has been in copy and Andrew has ack'ed it.  So far Thomas hasn't had much interest.  I haven't bugged him since Andrew picked it up as I guess it will flow in from his tree.

I have locally one more change to this code which also makes a good performance difference dealing with the soft-irq task.  I wanted more testing before pushing that.

Regards,
Richard W.

