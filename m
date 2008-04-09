From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: source.mvista links are broken
Date: Wed, 9 Apr 2008 18:40:53 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D91302742903FFCC5D@dlee13.ent.ti.com>
References: <87myo9a3kf.fsf@paris.hilman.org> <010C7BAE6783F34D9AC336EE5A01A08805C303DA@dbde01.ent.ti.com> <010C7BAE6783F34D9AC336EE5A01A08805C30581@dbde01.ent.ti.com> <20080408200839.GA31071@atomide.com> <5d5443650804090008l553e4773i259126743df6b49e@mail.gmail.com> <3B6D69C3A9EBCA4BA5DA60D91302742903F9941B@dlee13.ent.ti.com> <9c9fda240804091623x30c10550r7a174c0f78c3b481@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38861 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752175AbYDIXmE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Apr 2008 19:42:04 -0400
Content-class: urn:content-classes:message
In-Reply-To: <9c9fda240804091623x30c10550r7a174c0f78c3b481@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: Trilok Soni <soni.trilok@gmail.com>, Tony Lindgren <tony@atomide.com>, "Gadiyar, Anand" <gadiyar@ti.com>, Kevin Hilman <khilman@mvista.com>, linux-omap@vger.kernel.org

> Yes, I added it to u-boot to make a OneNAND boot image by using one
> compile.
> Of course, you can use the 1KiB boot image separately with other
> bootloaders.
> It has separate directory and can build it.
> 
> See reference board, apollon in u-boot tree.

Yes I took note when you added this.  Generally we try and follow your
work.

Does your integration also work for raw NAND and not just OneNAND?  I
was wondering how much of this relies on XIP in first blocks.

> >         - TI has versions with 3430 and other board support on our
web
> >  site.
> 
> Do you have a plan to push it to u-boot tree?

Yes it will happen.  I'm not sure about the timing.  We have a lot of
boards not in the tree.  The code could stand a re-organizing also as
there is some level of duplication.

Now that u-boot merges are taking place at a decent rate it is feasible
to try again.

Regards,
Richard W.
