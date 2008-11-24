From: David Brownell <david-b@pacbell.net>
Subject: Re: gpio_expander_omap removal?
Date: Mon, 24 Nov 2008 10:26:00 -0800
Message-ID: <200811241026.01901.david-b@pacbell.net>
References: <5d5443650811240917q1215d424sdaec82889dbe2b49@mail.gmail.com> <20081124174247.GB4927@atomide.com> <5d5443650811241010h675dd7f4y9a9be7828f0e552@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:39993 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750704AbYKXS0F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Nov 2008 13:26:05 -0500
In-Reply-To: <5d5443650811241010h675dd7f4y9a9be7828f0e552@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Monday 24 November 2008, Trilok Soni wrote:
> > Yes, let's get rid of that.
> >
> 
> Attached the patch, just check.

I suggest the two patches I'll send in a moment, instead.
The reason it was still around was because the H3 board
support still used it...

- Dave
