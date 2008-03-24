From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: OMAP3430: MUSB host and hot-plugging
Date: Mon, 24 Mar 2008 14:57:21 +0530
Message-ID: <5DF83221BE20114E9C331F665ACBC0800477C63D@dbde01.ent.ti.com>
References: <87d4pqqmj2.fsf@paris.hilman.org> <200803201230.03729.david-b@pacbell.net> <20080320200000.GI4772@kedavra.cpe.vivax.com.br> <200803201325.28818.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48956 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754609AbYCXJ2L convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Mar 2008 05:28:11 -0400
Content-class: urn:content-classes:message
In-Reply-To: <200803201325.28818.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, me@felipebalbi.com
Cc: Kevin Hilman <khilman@mvista.com>, linux-omap@vger.kernel.org



>Sent: Friday, March 21, 2008 1:55 AM
>On Thursday 20 March 2008, Felipe Balbi wrote:
>> Could it be some
>> problem in the ULPI support for omap3 that's preventing musb to wake up
>> and switch to host role ?
>
>Your theory is as good as mine; I don't have that hardware.
>
>I was just pointing out that this specific area has always
>been a significant PITA for the MUSB silicon ... I'm not the
>only developer who's ended up losing weeks of time chasing
>(undocumented) bogosity in the area of host-side startup.
>
>The thing is that making it "switch to host role" is the
>very black magic that regularly misbehaved.  ISTR there was
>a chicken/egg thing going on:  it couldn't know it needed to
>switch to "host role" unless the oddball Mentor "session"
>was already active, but it couldn't be activated unless you
>somehow knew it should be in host role...

The right way then to debug would be to do an LA probe of ULPI signals on re-attach.
To get around this problem, I have heard of implementations having a separate GPIO implemented to wakeup the system on cable attaches. Don't remember which implementation though.
I will see if I get time to work on this and will keep posted.

>
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
