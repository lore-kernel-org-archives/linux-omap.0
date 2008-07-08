From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 0/9] OMAP2/3 SDRC/clock: control CORE M2 divider, clean
 up SDRC
Date: Tue, 8 Jul 2008 18:12:31 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162035BD67429@dlee02.ent.ti.com>
References: <20080708025225.11646.55912.stgit@localhost.localdomain>
 <02aa01c8e0b4$5c09a450$68bf18ac@ent.ti.com>
 <alpine.DEB.1.00.0807081611500.12684@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:35493 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754469AbYGHXMr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jul 2008 19:12:47 -0400
In-Reply-To: <alpine.DEB.1.00.0807081611500.12684@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, 'Igor Stoppa' <igor.stoppa@nokia.com>

Hi Paul,

> > SRAM being mapped as cacheable could be a possible reason for this.

Second this.

> Certainly possible, and that change needs to be included.  But why
> would
> it only happen on the M2  2 -> 1 transition?

Can you ping the board by chance when you are locked?  Is only user space locked out or is the board dead.

The SRAM thing resulted in a dead lock where MPU was done.

I've also hit other paths in development where the networking device fails and the system gets caught in kernel space in some kind of livelock trying to get nfs root information.

Regards,
Richard W.
