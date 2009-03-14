From: David Brownell <david-b@pacbell.net>
Subject: Re: Hi David Brownell. I have a question for twl4030 driver.
Date: Fri, 13 Mar 2009 17:51:49 -0700
Message-ID: <200903131751.49733.david-b@pacbell.net>
References: <90b950fc0902121906kdf51637v21b90a2aba94a93f@mail.gmail.com> <200902131235.55502.david-b@pacbell.net> <9c9fda240902132029o20db190bnb289649c7d097fa3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp128.sbc.mail.sp1.yahoo.com ([69.147.65.187]:45015 "HELO
	smtp128.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1762912AbZCNAwE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Mar 2009 20:52:04 -0400
In-Reply-To: <9c9fda240902132029o20db190bnb289649c7d097fa3@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: =?utf-8?q?=EB=8C=80=EC=9D=B8=EA=B8=B0?= <daeinki@gmail.com>, linux-omap@vger.kernel.org

On Friday 13 February 2009, Kyungmin Park wrote:
> >> So I could use VPLL2 after I get rid of those annotations.
> >> I wonder why did you annotate for VPLL2.
> >> Does using VPLL2 has some problems?
> >
> > I didn't have any use case for managing VPLL2 in Linux
> > software at runtime, except maybe in conjunction with
> > the power management code.
> >
> > What's your use case?
> 
> It's used for graphics power. Without it. we can only see the limited colors.
> Yes there's too much example related with it. so we want to know exact usage.
> Now workaround we simply enable it at bootloader.

Right, I seem to have overlooked that.  Even Beagle boards
use VPLL2 to power the digital video (LCD, DVI) output.

So I'm sending a patch to let it be manipulated using the
regulator framework.

- Dave

