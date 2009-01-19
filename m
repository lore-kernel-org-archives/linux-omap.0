From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: ioremap()/iounmap() problem
Date: Mon, 19 Jan 2009 07:34:47 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE8967162036D6A19F2@dlee02.ent.ti.com>
References: <1232360583.6481.92.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54673 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753409AbZASNfJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jan 2009 08:35:09 -0500
In-Reply-To: <1232360583.6481.92.camel@tubuntu>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> Running with latest linux-omap kernel on OMAP3 SDP board, I have problem
> with iounmap(). It looks like iounmap() does not properly free large
> areas. Below is a test which fails for me in 6-7 loops.
>
> OMAP spesific ioremap code doesn't do much, so I think it's somewhere in
> generic ARM code. I looked at the ioremap code and for larger areas the
> code uses area sections, and I believe the bug is somewhere there.
>
> Does this work on other processors?

If you wait around a bit using some kind of schedule() + jiffy wait after free will it work longer?

Every now and then I've seen some deferred resource releases cause failures of such loops.  Usually they are more obvious like if your really malloc/free'ing direct memory, but there are indirect allocations which might add up.

Anyway, it's a behavioral question to help isolate.

Regards,
Richard W.



