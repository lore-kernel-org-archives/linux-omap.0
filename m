From: David Brownell <david-b@pacbell.net>
Subject: Re: OMAP3430: MUSB host and hot-plugging
Date: Thu, 20 Mar 2008 13:25:28 -0700
Message-ID: <200803201325.28818.david-b@pacbell.net>
References: <87d4pqqmj2.fsf@paris.hilman.org> <200803201230.03729.david-b@pacbell.net> <20080320200000.GI4772@kedavra.cpe.vivax.com.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:37509 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758118AbYCTUZb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Mar 2008 16:25:31 -0400
In-Reply-To: <20080320200000.GI4772@kedavra.cpe.vivax.com.br>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: Kevin Hilman <khilman@mvista.com>, linux-omap@vger.kernel.org

On Thursday 20 March 2008, Felipe Balbi wrote:
> Could it be some
> problem in the ULPI support for omap3 that's preventing musb to wake up
> and switch to host role ?

Your theory is as good as mine; I don't have that hardware.

I was just pointing out that this specific area has always
been a significant PITA for the MUSB silicon ... I'm not the
only developer who's ended up losing weeks of time chasing
(undocumented) bogosity in the area of host-side startup.

The thing is that making it "switch to host role" is the
very black magic that regularly misbehaved.  ISTR there was
a chicken/egg thing going on:  it couldn't know it needed to
switch to "host role" unless the oddball Mentor "session"
was already active, but it couldn't be activated unless you
somehow knew it should be in host role...


