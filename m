From: David Brownell <david-b@pacbell.net>
Subject: Re: status of USB on omap35xx ?
Date: Thu, 11 Dec 2008 14:32:46 -0800
Message-ID: <200812111432.46936.david-b@pacbell.net>
References: <1228870250.32014.148.camel@localhost.localdomain> <6ed0b2680812111241u5da7abd5r10094bf79ea9c299@mail.gmail.com> <5e088bd90812111354w7633e2a3p1365ab35d43277b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:37350 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756531AbYLKWc7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Dec 2008 17:32:59 -0500
In-Reply-To: <5e088bd90812111354w7633e2a3p1365ab35d43277b9@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, Paul Walmsley <paul@booyaka.com>, Tony Lindgren <tony@atomide.com>, me@felipebalbi.com, Jeff Steele <jsteele@coloradocollege.edu>, linux-omap <linux-omap@vger.kernel.org>

On Thursday 11 December 2008, Steve Sakoman wrote:
> Sadly my ehci port still goes into auto suspend.

And that's a problem ... why?  It's not supposed to
do that unless all the child devices are either
gone, or suspended.  The log you showed had them
all suspended, I believe...

- Dave

